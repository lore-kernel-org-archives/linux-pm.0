From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Question about hibernation
Date: Thu, 14 Oct 2010 13:50:20 +0530
Message-ID: <BLU102-W872C7E1EAB60632556F43EB560@phx.gbl>
References: <mailman.23.1286318684.6175.linux-pm@lists.linux-foundation.org>
	<BLU102-W129B9481B0793898EF998EB500@phx.gbl>,
	<201010082131.48152.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8854298935558676338=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010082131.48152.rjw@sisk.pl>
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
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============8854298935558676338==
Content-Type: multipart/alternative;
	boundary="_07cb2958-52d9-429e-a2b6-df724518225a_"

--_07cb2958-52d9-429e-a2b6-df724518225a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20
=20
Hi Rafael=2C
=20
1) I have question on system resume that e.g. in device driver let us say f=
or example structure is defined global=2C
e.g.
=20
struct dev
{
int a=3B
=20
} dev_t=3B
=20
=20
this structure is global. Now during system suspend=2C suppose the value of=
=20
=20
dev_t.a =3D2=3B
=20
So when the resume happens=2C will the dev_t.a will remain the same i.e. 2?
=20
2) During the system suspend=2C if the system hibernates=2C then the messag=
e sent from power management core to all drivers is
PMSG_HIBERNATE and if system suspends to ram=2C then message sent from powe=
r management core to all drivers is PMSG_SUSPEND.
=20
correct me if I am wrong.
=20
Regards
Raj
=20
=20
=20
=20
=20
=20
=20

=20
> From: rjw@sisk.pl
> To: rajkumar278@hotmail.com
> Subject: Re: Question about hibernation
> Date: Fri=2C 8 Oct 2010 21:31:48 +0200
> CC: linux-pm@lists.linux-foundation.org
>=20
> On Friday=2C October 08=2C 2010=2C you wrote:
> >=20
> > Hi Rafael=2C
>=20
> Hi=2C
>=20
> > I am working on device driver whose some part is user space and some pa=
rt is kernel space. So the user space part
> > of the driver provides interface to user space applications.=20
> > 1) Now=2C Suppose some user space is application is going on which is a=
ccessing the user space driver and user space driver
> > scheduled some jobs to kernel space=2C Now suppose system hibernation s=
tart=2C since it freezes all the user space processes
> > so suppose jobs are not completed yet which are scheduled to kernel spa=
ce by user space.
> >=20
> > when the kernel space device driver completes the jobs and gives the no=
tification to user space driver=2C since user space
> > process is already frozen=2C so there will be problem if we suspend the=
 driver using suspend and resume.
> >=20
> > right?
>=20
> Yes=2C there's going to be a problem if the driver is not prepared to han=
dle such situations.
>=20
> Depending of the particular case=2C one possible approach is to use a PM =
notifier
> as described in Documentation/power/notifiers.txt.
>=20
> > 2) The other point I was seeing=2C when the power management core freez=
es all the processes before suspending and resuming
> > devices=2C it will take some time for freezing and after that if some d=
evice driver refuses to suspend=2C then it will again resume
> > the whole processes=2C so latency time be more. right?
>=20
> Yes=2C it works as described.
>=20
> > 3) Next question is regarding the kernel space threads=2C when these ar=
e frozen during suspend/hibernation?
>=20
> They are frozen immediately after user space has been frozen=2C but only =
a
> handful of kernel threads are frozen.
>=20
> Thanks=2C
> Rafael
 		 	   		  =

--_07cb2958-52d9-429e-a2b6-df724518225a_
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
&nbsp=3B<BR>
&nbsp=3B<BR>
Hi Rafael=2C<BR>
&nbsp=3B<BR>
1) I have question on system resume that e.g. in device driver let us say f=
or example structure is defined global=2C<BR>
e.g.<BR>
&nbsp=3B<BR>
struct dev<BR>
{<BR>
int a=3B<BR>
&nbsp=3B<BR>
} dev_t=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
this structure is global. Now during system suspend=2C suppose the value of=
 <BR>
&nbsp=3B<BR>
dev_t.a =3D2=3B<BR>
&nbsp=3B<BR>
So when the resume happens=2C will the dev_t.a will remain the same i.e. 2?=
<BR>
&nbsp=3B<BR>
2) During the system suspend=2C if the system hibernates=2C then the messag=
e sent from power management core to all drivers is<BR>
PMSG_HIBERNATE and if system suspends to ram=2C then message sent from powe=
r management core to all drivers is PMSG_SUSPEND.<BR>
&nbsp=3B<BR>
correct me if I am wrong.<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>
&gt=3B From: rjw@sisk.pl<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=3B Su=
bject: Re: Question about hibernation<BR>&gt=3B Date: Fri=2C 8 Oct 2010 21:=
31:48 +0200<BR>&gt=3B CC: linux-pm@lists.linux-foundation.org<BR>&gt=3B <BR=
>&gt=3B On Friday=2C October 08=2C 2010=2C you wrote:<BR>&gt=3B &gt=3B <BR>=
&gt=3B &gt=3B Hi Rafael=2C<BR>&gt=3B <BR>&gt=3B Hi=2C<BR>&gt=3B <BR>&gt=3B =
&gt=3B I am working on device driver whose some part is user space and some=
 part is kernel space. So the user space part<BR>&gt=3B &gt=3B of the drive=
r provides interface to user space applications. <BR>&gt=3B &gt=3B 1) Now=
=2C Suppose some user space is application is going on which is accessing t=
he user space driver and user space driver<BR>&gt=3B &gt=3B scheduled some =
jobs to kernel space=2C Now suppose system hibernation start=2C since it fr=
eezes all the user space processes<BR>&gt=3B &gt=3B so suppose jobs are not=
 completed yet which are scheduled to kernel space by user space.<BR>&gt=3B=
 &gt=3B <BR>&gt=3B &gt=3B when the kernel space device driver completes the=
 jobs and gives the notification to user space driver=2C since user space<B=
R>&gt=3B &gt=3B process is already frozen=2C so there will be problem if we=
 suspend the driver using suspend and resume.<BR>&gt=3B &gt=3B <BR>&gt=3B &=
gt=3B right?<BR>&gt=3B <BR>&gt=3B Yes=2C there's going to be a problem if t=
he driver is not prepared to handle such situations.<BR>&gt=3B <BR>&gt=3B D=
epending of the particular case=2C one possible approach is to use a PM not=
ifier<BR>&gt=3B as described in Documentation/power/notifiers.txt.<BR>&gt=
=3B <BR>&gt=3B &gt=3B 2) The other point I was seeing=2C when the power man=
agement core freezes all the processes before suspending and resuming<BR>&g=
t=3B &gt=3B devices=2C it will take some time for freezing and after that i=
f some device driver refuses to suspend=2C then it will again resume<BR>&gt=
=3B &gt=3B the whole processes=2C so latency time be more. right?<BR>&gt=3B=
 <BR>&gt=3B Yes=2C it works as described.<BR>&gt=3B <BR>&gt=3B &gt=3B 3) Ne=
xt question is regarding the kernel space threads=2C when these are frozen =
during suspend/hibernation?<BR>&gt=3B <BR>&gt=3B They are frozen immediatel=
y after user space has been frozen=2C but only a<BR>&gt=3B handful of kerne=
l threads are frozen.<BR>&gt=3B <BR>&gt=3B Thanks=2C<BR>&gt=3B Rafael<BR> 	=
	 	   		  </body>
</html>=

--_07cb2958-52d9-429e-a2b6-df724518225a_--

--===============8854298935558676338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8854298935558676338==--
