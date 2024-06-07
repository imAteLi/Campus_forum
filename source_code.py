import pymysql
import tkinter as tk
from tkinter import messagebox


class SwitchFrame(object):
    def __init__(self, root, uid):
        self.root = root
        self.uid = uid
        root.title('%s号用户，欢迎来到在线论坛'%uid)
        root.geometry('800x600')
        root.resizable(width=False, height=False)  # 阻止Python GUI的大小调整

        L1 = tk.Label(root)
        L1.pack()  # L1用pack布局，用于切换按钮居中显示
        tk.Button(L1, text='论坛导航', command=self.firstpage).grid(row=1, column=1, padx=10, pady=10)
        tk.Button(L1, text='个人中心', command=self.secondpage).grid(row=1, column=2, padx=10, pady=10)

        # frame1
        frame1 = tk.Frame(root, bg='gray')  # 界面1
        self.frame1 = frame1
        tk.Button(frame1, text='校园公告', command=self.to_f11).place(x=90, y=90)
        tk.Button(frame1, text='生活平台').place(x=90, y=190)
        tk.Button(frame1, text='学生交流').place(x=90, y=290)
        tk.Button(frame1, text='待开发版块1').place(x=240, y=90)
        tk.Button(frame1, text='待开发版块2').place(x=240, y=190)
        tk.Button(frame1, text='待开发版块3').place(x=240, y=290)

        # frame2
        frame2 = tk.Frame(root, bg='gray')  # 界面2
        self.frame2 = frame2

        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='bbs',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            sql = 'select * from Users, realUsers where Users.realID = realUsers.realID and userId=%s'
            cursor.execute(sql, (self.uid,))
            row = cursor.fetchone()
            password = row['userPassword']
            name = row['userName']
            realid = row['realID']
            identity = row['identity']
        connection.close()

        tk.Label(frame2, text='我的用户ID为：'+ self.uid).grid(row=1, column=1, padx=10, pady=10)
        tk.Label(frame2, text='我的用户名为：' + name).grid(row=2, column=1, padx=10, pady=10)
        tk.Label(frame2, text='我的用户密码为：' + password).grid(row=3, column=1, padx=10, pady=10)
        tk.Label(frame2, text='我的学工号为：' + str(realid)).grid(row=4, column=1, padx=10, pady=10)
        tk.Label(frame2, text='我的身份为：' + identity).grid(row=5, column=1, padx=10, pady=10)

        self.currentpage = frame1
        self.currentpage.pack(ipadx=200, ipady=200)  # 默认显示界面1，并记录当前界面
        self.currentpage.pack_propagate(0)

        # 管理员模块
        # 添加管理中心按钮
        tk.Button(L1, text='管理中心', command=self.open_management_center).grid(row=1, column=3, padx=10, pady=10)
        # 初始化管理员信息
        self.is_manager = False  # 默认不是管理员
        self.manager_info = None  # 保存管理员信息

        # 检查用户是否是某个版块的管理员
        self.check_manager_info()

    def check_manager_info(self):
        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='BBS',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            sql = 'SELECT * FROM Managements WHERE managerID=%s'
            cursor.execute(sql, (self.uid,))
            result = cursor.fetchone()
            if result:
                self.is_manager = True
                self.manager_info = result
                # 获取对应版块的名称
                borad_name_sql = 'SELECT boradName FROM Borads WHERE boradID=%s'
                cursor.execute(borad_name_sql, (result["boradID"],))
                borad_name_result = cursor.fetchone()
                if borad_name_result:
                    self.manager_info["boradName"] = borad_name_result["boradName"]

        connection.close()

    def open_management_center(self):
        if self.is_manager:
            # 如果是管理员，打开管理中心窗口
            management_center_window = tk.Toplevel(self.root)
            management_center_window.geometry('400x300')
            management_center_window.title('管理中心')

            # 在这里显示管理员信息，你可以根据需要调整显示的内容
            tk.Label(management_center_window, text=f'您是 {self.manager_info["boradName"]} 版块的管理员').pack()
            tk.Label(management_center_window, text=f'权限ID: {self.manager_info["managementID"]}').pack()

            # 添加输入框和按钮
            tk.Label(management_center_window, text="用户ID:").pack()
            user_id_entry = tk.Entry(management_center_window)
            user_id_entry.pack()

            tk.Label(management_center_window, text="封禁时长（小时）:").pack()
            duration_entry = tk.Entry(management_center_window)
            duration_entry.pack()

            tk.Label(management_center_window, text="封禁理由:").pack()
            reason_entry = tk.Entry(management_center_window)
            reason_entry.pack()

            # 定义封禁操作函数
            def ban_user():
                ban_user_id = user_id_entry.get()
                ban_duration = duration_entry.get()
                ban_reason = reason_entry.get()

                connection = pymysql.connect(
                    host='localhost',
                    port=3306,
                    user='root',
                    password='123456',
                    db='BBS',
                    charset='utf8mb4',
                    cursorclass=pymysql.cursors.DictCursor
                )

                with connection.cursor() as cursor:
                    try:
                        # 调用存储过程封禁用户
                        cursor.callproc('proc_banUser',
                                        args=(self.manager_info['managementID'], ban_user_id, ban_duration, ban_reason))
                        connection.commit()
                        messagebox.showinfo('提示', '用户封禁成功')

                    except pymysql.MySQLError as e:
                        # 获取 MySQL 错误信息
                        error_code = e.args[0]
                        error_message = e.args[1]
                        messagebox.showerror('MySQL 错误', f'Error Code: {error_code}\nError Message: {error_message}')

            # 添加封禁按钮
            ban_button = tk.Button(management_center_window, text="封禁用户", command=ban_user)
            ban_button.pack()



    def firstpage(self):
        if self.currentpage != self.frame1:
            self.currentpage.pack_forget()  # 取消显示当前界面，并不是销毁
            self.currentpage = self.frame1
            self.currentpage.pack(ipadx=200, ipady=200)  # 显示界面1
            self.currentpage.pack_propagate(0)

    def secondpage(self):
        if self.currentpage != self.frame2:
            self.currentpage.pack_forget()  # 取消显示当前界面，并不是销毁
            self.currentpage = self.frame2
            self.currentpage.pack(ipadx=200, ipady=200)  # 显示界面2
            self.currentpage.pack_propagate(0)

    # 前往11号板块
    def to_f11(self):
        f11 = tk.Toplevel(self.root)
        f11.geometry('800x600')
        f11.config(bg='#6fb765')
        f11.title('校园公告')
        self.f11 = f11

        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='bbs',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            sql = 'select * from Posts,Users,realUsers where posterID = userID and Users.realID=realUsers.realID and boradID=%s order by postTime DESC'
            cursor.execute(sql, (11,))
            rows = cursor.fetchall()
        connection.close()

        tk.Label(f11, text='校园公告',font=('中华行楷', 20), fg='white', bg='#6fb765').pack()
        tk.Button(f11, text='发贴', font=('中华行楷', 10), fg='white', bg='#6fb765', command=lambda: self.getpost(11)).pack()
        tk.Button(f11, text='加载更多', font=('中华行楷', 10), fg='white', bg='#6fb765').pack(side='bottom')

        for i in range(0,len(rows)):
            tk.Label(f11, text=rows[i]['postName'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=50, y=80+60*i)
            tk.Label(f11, text=rows[i]['userName'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=130, y=105+60*i)
            tk.Label(f11, text=rows[i]['identity'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=70, y=105 + 60 * i)
            tk.Label(f11, text=rows[i]['postTime'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=300, y=105+60*i)
            tk.Button(f11, text='进入帖子', font=('中华行楷', 10), fg='white', bg='#6fb765', command=lambda i=i: self.topost(rows[i]['postID'])).place(x=300, y=80+60*i)

        f11.mainloop

    # 查看帖子
    def topost(self, postid):
        self.f11.destroy()
        postnow = tk.Toplevel(self.root)
        postnow.geometry('800x600')
        postnow.config(bg='#6fb765')
        postnow.title('浏览贴中：' + str(postid) + '号贴')
        self.postnow = postnow

        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='bbs',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            sql = 'select * from Statements,Posts,Users,realUsers where Statements.postID=Posts.postID and speakerID = userID and Users.realID = realUsers.realID and Statements.postID=%s order by statementTime DESC'
            cursor.execute(sql, (postid,))
            statements = cursor.fetchall()
        connection.close()

        tk.Label(postnow, text=statements[0]['postName'], font=('中华行楷', 20), fg='white', bg='#6fb765').pack()
        tk.Button(postnow, text='发言', font=('中华行楷', 10), fg='white', bg='#6fb765', command=lambda: self.getstatement(postid)).pack()
        tk.Button(postnow, text='加载更多', font=('中华行楷', 10), fg='white', bg='#6fb765').pack(side='bottom')

        for i in range(0, len(statements)):
            tk.Label(postnow, text=statements[i]['userName'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=50, y=80+60*i)
            tk.Label(postnow, text=statements[i]['identity'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=220, y=80 + 60 * i)
            tk.Label(postnow, text=statements[i]['statementTime'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=300, y=80+60*i)
            tk.Label(postnow, text=statements[i]['statement'], font=('中华行楷', 15), fg='white', bg='#6fb765').place(x=70, y=105+60*i)

    # 发帖窗口
    def getpost(self, boradid):
        postwindow = tk.Toplevel(self.root)
        postwindow.geometry('200x150')
        postwindow.config(bg='#6fb765')
        postwindow.title('发贴中')
        self.postwindow = postwindow
        tk.Button(postwindow, text='发布贴子', font=('中华行楷', 10), fg='white', bg='#6fb765',
                  command=lambda: self.submitpost(boradid)).pack(side='bottom')
        postput = tk.Text(postwindow, height=100, width=50)
        postput.pack(side='top')
        self.postput = postput

    # 提交发帖
    def submitpost(self, boradid):
        pst = self.postput.get(1.0, 'end')
        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='bbs',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            cursor.callproc('proc_createPost', args=(int(self.uid), str(pst), int(boradid), 0))
            connection.commit()
        connection.close()
        self.postwindow.destroy()

    # 发言窗口
    def getstatement(self, postid):
        statementwindow = tk.Toplevel(self.root)
        statementwindow.geometry('400x300')
        statementwindow.config(bg='#6fb765')
        statementwindow.title('留言中')
        self.statementwindow = statementwindow
        tk.Button(statementwindow, text='发布留言', font=('中华行楷', 10), fg='white', bg='#6fb765', command=lambda: self.submitstatement(postid)).pack(side='bottom')
        statementput = tk.Text(statementwindow, height=300, width=200)
        statementput.pack(side='top')
        self.statementput = statementput

    # 提交发言
    def submitstatement(self, postid):
        stm = self.statementput.get(1.0, 'end')

        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='bbs',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            cursor.callproc('proc_createStatement', args=(int(self.uid), str(stm), int(postid), 0))
            connection.commit()
        connection.close()
        self.statementwindow.destroy()
        self.postnow.destroy()
        self.topost(postid)


def new_window(uid):

    wmain = tk.Tk()
    SwitchFrame(wmain, uid)
    wmain.mainloop()

def account_login(aid, password):
    connection = pymysql.connect(
        host='localhost',
        port=3306,
        user='root',
        password='123456',
        db='bbs',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

    with connection.cursor() as cursor:
        sql = 'select * from Users where userId=%s'
        cursor.execute(sql, (aid,))
        row = cursor.fetchone()
        if row is None:
            return False
        Id = str(row['userID'])
        Password = row['userPassword']
    connection.close()
    if (Id == aid and Password == password):
        return True
    else:
        return False


# 创建验证函数
def login():
    userid = entry1.get()
    userpw = entry2.get()

    if account_login(userid, userpw):
        messagebox.showinfo(title="登陆成功", message='欢迎，'+userid)
        win.destroy()
        new_window(userid)
        return True
    else:
        messagebox.showwarning(title='登陆失败', message="账号或密码错误或输入为空")
        entry1.delete(0,tk.END)
        entry2.delete(0, tk.END)
        return False


def signup_window():
    def account_signup(aid, apw, aun):
        connection = pymysql.connect(
            host='localhost',
            port=3306,
            user='root',
            password='123456',
            db='bbs',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )

        with connection.cursor() as cursor:
            sql = 'select * from realUsers where realID=%s'
            cursor.execute(sql, (aid,))
            row = cursor.fetchone()
            if row is None:
                return 0
            else:
                sql2 = 'select * from Users where realID=%s'
                cursor.execute(sql2, (aid,))
                row2 = cursor.fetchone()
                if row2 is None:
                    rid = row['realID']
                    sql3 = 'select max(userID) mu from users'
                    cursor.execute(sql3)
                    result = cursor.fetchone()
                    nid = result['mu'] + 1
                    sql4 = "insert into Users(userID,userName,userPassword,realID) values(%d,'%s','%s',%d)"%(nid, aun, apw, rid)
                    cursor.execute(sql4)
                    connection.commit()
                    connection.close()
                    return nid
                else:
                    connection.close()
                    return 0
    def signup():
        userids = entrys1.get()
        userpws = entrys2.get()
        userpwr = entrys3.get()
        username = entrys4.get()

        if (userids == '' or userpws == '' or userpwr == '' or username == ''):
            messagebox.showwarning(title='注册失败', message="所填信息不能为空")
            return False
        elif userpws != userpwr:
            messagebox.showwarning(title='注册失败', message="两次密码不一致")
            return False
        else:
            flag = account_signup(userids, userpwr, username)
            if flag:
                messagebox.showinfo(title='注册成功', message="您的学工号已注册成功\n欢迎："+str(flag))
                return True
            else:
                messagebox.showwarning(title='注册失败', message="请重新注册")
                return False

    window_signup = tk.Toplevel(win)
    window_signup.geometry('350x200')
    window_signup.title('注册界面')
    labes1 = tk.Label(window_signup, text="学工号：").place(x=50, y=30)
    labes2 = tk.Label(window_signup, text="密码：").place(x=50, y=60)
    labes3 = tk.Label(window_signup, text="确认密码：").place(x=50, y=90)
    labes4 = tk.Label(window_signup, text="用户名：").place(x=50, y=120)

    # 创建动字符串
    Id_Strings = tk.StringVar()
    Pw_Strings = tk.StringVar()
    Pw_String_r = tk.StringVar()
    Un_String = tk.StringVar()
    entrys1 = tk.Entry(window_signup, textvariable=Id_Strings)
    entrys1.place(x=120, y=30)
    entrys2 = tk.Entry(window_signup, textvariable=Pw_Strings, show='*')
    entrys2.place(x=120, y=60)
    entrys3 = tk.Entry(window_signup, textvariable=Pw_String_r, show='*')
    entrys3.place(x=120, y=90)
    entrys4 = tk.Entry(window_signup, textvariable=Un_String)
    entrys4.place(x=120, y=120)

    button = tk.Button(window_signup, text='确认注册', command=signup)
    button.place(x=150, y=150)






# 设置主窗口
win = tk.Tk()
win.geometry('450x300')
win.title("欢迎来到北师大论坛")
win.config(background="#6fb765")

label = tk.Label(win, text="北师大论坛欢迎您",font=('宋体',20, 'bold italic'),bg="#6fb765",
                 width=30,height=5,
                 padx=10, pady=15, borderwidth=10)
label.pack()

# 新建文本标签
labe1 = tk.Label(win, text="账号：").place(x=100, y=150)
labe2 = tk.Label(win, text="密码：").place(x=100, y=190)

# 创建动字符串
Id_String = tk.StringVar()
Pw_String = tk.StringVar()
entry1 = tk.Entry(win, textvariable=Id_String)
entry1.place(x=160, y=150)
entry2 = tk.Entry(win, textvariable=Pw_String, show='*')
entry2.place(x=160, y=190)

button1 = tk.Button(win, text='登录', command=login)
button1.place(x=160, y=230)
button2 = tk.Button(win, text='注册', command=signup_window)
button2.place(x=260, y=230)
win.mainloop()



