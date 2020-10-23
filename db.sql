Create database exam_courses
USE [exam_courses]
GO
/****** Object:  Table [dbo].[answers]    Script Date: 10/23/2020 3:07:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[answers](
	[answer_id] [int] IDENTITY(1,1) NOT NULL,
	[correct_answer] [varchar](500) NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[answer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 10/23/2020 3:07:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[course_name] [varchar](255) NOT NULL,
	[total_marks] [int] NOT NULL,
	[time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exams]    Script Date: 10/23/2020 3:07:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exams](
	[exam_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[course_name] [varchar](255) NOT NULL,
	[total_marks] [int] NOT NULL,
	[obt_marks] [float] NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NULL,
	[exam_time] [time](7) NULL,
	[status] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[questions]    Script Date: 10/23/2020 3:07:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questions](
	[question_id] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [varchar](255) NOT NULL,
	[question] [varchar](255) NOT NULL,
	[opt1] [varchar](500) NULL,
	[opt2] [varchar](500) NULL,
	[opt3] [varchar](500) NULL,
	[opt4] [varchar](500) NULL,
	[answer_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[test]    Script Date: 10/23/2020 3:07:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[name] [varchar](50) NOT NULL,
	[exam_id] [int] NOT NULL,
	[age] [int] NULL,
	[mark] [float] NULL,
 CONSTRAINT [keyTest] PRIMARY KEY CLUSTERED 
(
	[name] ASC,
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/23/2020 3:07:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[username] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[fullName] [varchar](255) NOT NULL,
	[userType] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[answers] ON 

INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (1, N'JFrame', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (2, N'Composition', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (3, N'Aggregation', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (4, N'Inheritance', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (5, N'Association', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (6, N'Both 1 and 2 are true', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (7, N'the session attribute of page directive is set to false.', 1)
INSERT [dbo].[answers] ([answer_id], [correct_answer], [status]) VALUES (8, N'The fully qualified class name of the Java object', 1)
SET IDENTITY_INSERT [dbo].[answers] OFF
GO
INSERT [dbo].[courses] ([course_name], [total_marks], [time]) VALUES (N'OSG202', 3, CAST(N'2019-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[courses] ([course_name], [total_marks], [time]) VALUES (N'PRJ311', 4, CAST(N'2019-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[courses] ([course_name], [total_marks], [time]) VALUES (N'PRJ321', 4, CAST(N'2020-02-04T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[questions] ON 

INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (2, N'PRJ311', N'Which component cannot be added to a container?', N'JPanel', N'JButton', N'JFrame', N'JComponent', 1)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (7, N'PRJ311', N'What is best to describe the relationship between a container and a SWing GUI object in the container?', N'Association', N'Aggregation', N'Composition', N'Inheritance', 2)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (8, N'PRJ311', N'What is best to describe the relationship between a container and a layout manager?', N'Association', N'Aggregation', N'Composition', N'Inheritance', 3)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (10, N'PRJ311', N'What is best to describe the relationship between JComponent and JButton?', N'Association', N'Aggregation', N'Composition', N'Inheritance', 4)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (11, N'PRJ311', N'What is best to describe the relationship between Component and Color?', N'Association', N'Aggregation', N'Composition', N'Inheritance', 5)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (13, N'PRJ321', N'Study the statements:
1) URL rewriting may be used when a browser is disabled cookies.
2) In URL encoding the session id is included as part of the URL
Which is the correct option ?', N'Only statement 1 is true', N'Only statement 2 is true', N'Both 1 and 2 are true', N'Both 1 and 2 are not true', 6)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (14, N'PRJ321', N'A JSP page will not have access to session implicit variable if.', N'the user has closed all his/her browser windows.', N'the request is the first request from the user.', N'the user''s browser does not support URL rewriting.', N'the session attribute of page directive is set to false.', 7)
INSERT [dbo].[questions] ([question_id], [course_name], [question], [opt1], [opt2], [opt3], [opt4], [answer_id]) VALUES (15, N'PRJ321', N'Which statements are BEST describe type attribute of <jsp:useBean type=_.. /> action?', N'The name used to manipulate the Java object with actions <jsp:setProperty> and <jsp:getProperty>. A variable of this name is also declared for use in JSP scripting elements. The name specified here is call..', N'The name of a bean that can be used with method instantiate of class java.beans.Beans to load a JavaBean into memory.', N'The fully qualified class name of the Java object', N'The type ofthe JavaBean. This can be the same type as the class attribute, a superclass ofthattype or an interface implemented', 8)
SET IDENTITY_INSERT [dbo].[questions] OFF
GO
INSERT [dbo].[Users] ([username], [email], [password], [fullName], [userType]) VALUES (N'DE1402228', N'quinvde40228@fpt.edu.vn', N'vanqui123', N'nguyen van qui', N'student')
INSERT [dbo].[Users] ([username], [email], [password], [fullName], [userType]) VALUES (N'DE140289', N'quangnhde140289@fpt.edu.vn', N'quang147', N'nguyen hong quang', N'student')
GO
ALTER TABLE [dbo].[exams] ADD  DEFAULT (NULL) FOR [obt_marks]
GO
ALTER TABLE [dbo].[exams] ADD  DEFAULT (NULL) FOR [end_time]
GO
ALTER TABLE [dbo].[exams] ADD  DEFAULT (NULL) FOR [exam_time]
GO
ALTER TABLE [dbo].[exams] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT (NULL) FOR [age]
GO
ALTER TABLE [dbo].[exams]  WITH CHECK ADD FOREIGN KEY([course_name])
REFERENCES [dbo].[courses] ([course_name])
GO
ALTER TABLE [dbo].[exams]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[questions]  WITH CHECK ADD FOREIGN KEY([answer_id])
REFERENCES [dbo].[answers] ([answer_id])
GO
ALTER TABLE [dbo].[questions]  WITH CHECK ADD FOREIGN KEY([course_name])
REFERENCES [dbo].[courses] ([course_name])
GO
ALTER TABLE [dbo].[test]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[exams] ([exam_id])
GO
ALTER TABLE [dbo].[test]  WITH CHECK ADD FOREIGN KEY([name])
REFERENCES [dbo].[Users] ([username])
GO
