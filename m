From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Question about hibernation
Date: Fri, 8 Oct 2010 16:02:46 +0530
Message-ID: <BLU102-W129B9481B0793898EF998EB500@phx.gbl>
References: <mailman.23.1286318684.6175.linux-pm@lists.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3434992012592819108=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <mailman.23.1286318684.6175.linux-pm@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

--===============3434992012592819108==
Content-Type: multipart/alternative;
	boundary="_3b86c823-15d6-4507-9fcc-6f7ff3d6259d_"

--_3b86c823-15d6-4507-9fcc-6f7ff3d6259d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Rafael=2C
=20
I am working on device driver whose some part is user space and some part i=
s kernel space. So the user space part
of the driver provides interface to user space applications.=20
1) Now=2C Suppose some user space is application is going on which is acces=
sing the user space driver and user space driver
scheduled some jobs to kernel space=2C Now suppose system hibernation start=
=2C since it freezes all the user space processes
so suppose jobs are not completed yet which are scheduled to kernel space b=
y user space.
=20
when the kernel space device driver completes the jobs and gives the notifi=
cation to user space driver=2C since user space
process is already frozen=2C so there will be problem if we suspend the dri=
ver using suspend and resume.
=20
right?
=20
2) The other point I was seeing=2C when the power management core freezes a=
ll the processes before suspending and resuming
devices=2C it will take some time for freezing and after that if some devic=
e driver refuses to suspend=2C then it will again resume
the whole processes=2C so latency time be more. right?
=20
3) Next question is regarding the kernel space threads=2C when these are fr=
ozen during suspend/hibernation?
=20
Thanks
Raj
=20
=20
=20
=20
=20
=20
> Date: Wed=2C 6 Oct 2010 00:43:30 +0200
> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> Subject: Re: [linux-pm] Question about hibernation
> To: linux-pm@lists.linux-foundation.org
> Message-ID: <201010060043.30489.rjw@sisk.pl>
> Content-Type: Text/Plain=3B charset=3D"iso-8859-2"
>=20
> On Tuesday=2C October 05=2C 2010=2C Raj Kumar wrote:
> >=20
> > Hi Alan=2C
> >=20
> > I have question regarding the hibernation mode in linux.=20
> >=20
> > 1) In normal suspend to ram=2C is freezing of tasks necessary while sus=
pend to ram in current linux power management core?
>=20
> Yes=2C it is.
>=20
> > 2) In hibernation mode=2C is freezing of tasks done before normal suspe=
nd/resumes in order to that hibernation image is in sync?
>=20
> That depends on what you mean by normal "suspend/resumes". Generally spea=
king=2C
> the hibernate code freezes tasks before preallocating image memory.
>=20
> > My issue is because it might be possible that there is some part of dev=
ice driver which is user space and another part is kernel space
> > then in suspend to ram and hibernation mode is freezing of all user spa=
ce part is done before kernel side or it differs while
> > suspend to ram and hibernation mode?
>=20
> User space is always frozen before suspend and hibernation.
>=20
> Thanks=2C
> Rafael
>=20
>=20
 		 	   		  =

--_3b86c823-15d6-4507-9fcc-6f7ff3d6259d_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi Rafael=2C<BR>
&nbsp=3B<BR>
I am working on device driver whose some part is user space and some part i=
s kernel space. So the user space part<BR>
of the driver provides interface to user space applications. <BR>
1) Now=2C Suppose some user space is application is going on which is acces=
sing the user space driver and user space driver<BR>
scheduled some jobs to kernel space=2C Now suppose system hibernation start=
=2C since it freezes all the user space processes<BR>
so suppose jobs are not completed yet which are scheduled to kernel space b=
y user space.<BR>
&nbsp=3B<BR>
when the kernel space device driver completes the jobs and gives the notifi=
cation to user space driver=2C since user space<BR>
process is already frozen=2C so there will be problem if we suspend the dri=
ver using suspend and resume.<BR>
&nbsp=3B<BR>
right?<BR>
&nbsp=3B<BR>
2) The other point I was seeing=2C when the power management core freezes a=
ll the processes before suspending and resuming<BR>
devices=2C it will take some time for freezing and after that if some devic=
e driver refuses to suspend=2C then it will again resume<BR>
the whole processes=2C so latency time be more. right?<BR>
&nbsp=3B<BR>
3) Next question is regarding the kernel space threads=2C when these are fr=
ozen during suspend/hibernation?<BR>
&nbsp=3B<BR>
Thanks<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&gt=3B Date: Wed=2C 6 Oct 2010 00:43:30 +0200<BR>&gt=3B From: "Rafael J. Wy=
socki" &lt=3Brjw@sisk.pl&gt=3B<BR>&gt=3B Subject: Re: [linux-pm] Question a=
bout hibernation<BR>&gt=3B To: linux-pm@lists.linux-foundation.org<BR>&gt=
=3B Message-ID: &lt=3B201010060043.30489.rjw@sisk.pl&gt=3B<BR>&gt=3B Conten=
t-Type: Text/Plain=3B charset=3D"iso-8859-2"<BR>&gt=3B <BR>&gt=3B On Tuesda=
y=2C October 05=2C 2010=2C Raj Kumar wrote:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B Hi Alan=2C<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I have question regarding=
 the hibernation mode in linux. <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B 1) In n=
ormal suspend to ram=2C is freezing of tasks necessary while suspend to ram=
 in current linux power management core?<BR>&gt=3B <BR>&gt=3B Yes=2C it is.=
<BR>&gt=3B <BR>&gt=3B &gt=3B 2) In hibernation mode=2C is freezing of tasks=
 done before normal suspend/resumes in order to that hibernation image is i=
n sync?<BR>&gt=3B <BR>&gt=3B That depends on what you mean by normal "suspe=
nd/resumes". Generally speaking=2C<BR>&gt=3B the hibernate code freezes tas=
ks before preallocating image memory.<BR>&gt=3B <BR>&gt=3B &gt=3B My issue =
is because it might be possible that there is some part of device driver wh=
ich is user space and another part is kernel space<BR>&gt=3B &gt=3B then in=
 suspend to ram and hibernation mode is freezing of all user space part is =
done before kernel side or it differs while<BR>&gt=3B &gt=3B suspend to ram=
 and hibernation mode?<BR>&gt=3B <BR>&gt=3B User space is always frozen bef=
ore suspend and hibernation.<BR>&gt=3B <BR>&gt=3B Thanks=2C<BR>&gt=3B Rafae=
l<BR>&gt=3B <BR>&gt=3B <BR><BR> 		 	   		  </body>
</html>=

--_3b86c823-15d6-4507-9fcc-6f7ff3d6259d_--

--===============3434992012592819108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3434992012592819108==--
