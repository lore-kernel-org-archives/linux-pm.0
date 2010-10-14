From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Question about hibernation
Date: Thu, 14 Oct 2010 17:17:03 +0530
Message-ID: <BLU102-W13CE4234FF4484062541F8EB560@phx.gbl>
References: <mailman.23.1286318684.6175.linux-pm@lists.linux-foundation.org>
	<201010082131.48152.rjw@sisk.pl>
	<BLU102-W872C7E1EAB60632556F43EB560@phx.gbl>,
	<201010141151.05297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8844964534760418496=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010141151.05297.rjw@sisk.pl>
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

--===============8844964534760418496==
Content-Type: multipart/alternative;
	boundary="_6610575e-f9c4-4200-afb4-d943525cd8d7_"

--_6610575e-f9c4-4200-afb4-d943525cd8d7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20
Hi Rafael=2C
=20
Thanks for your quick reply. =20
=20
1) I already implemented this with dev_pm_ops. I used suspend and resume ca=
llbacks
whose prototype is like
=20
struct dev_pm_ops power_mgmt_ops
{
   .suspend =3D  powermanagement_suspend=2C
   .resume =3D  powermanagement_resume
=20
}
=20
int powermanagement_suspend(device *dev)
{
=20
}
=20
In normal suspend to ram mode it will work. But will it work in case of hib=
ernation also?
=20
if yes=2C since in suspend and resume call backs=2C only the device structu=
re is provided=2C so how can
then person can identify it is suspend to ram or hibernation?
=20
or for hibernation=2C poweroff  and restore function should be implemented =
which is similar
to suspend and resume call backs in case of suspend to ram?
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
=20
=20

=20
> From: rjw@sisk.pl
> To: rajkumar278@hotmail.com
> Subject: Re: Question about hibernation
> Date: Thu=2C 14 Oct 2010 11:51:05 +0200
> CC: linux-pm@lists.linux-foundation.org
>=20
> On Thursday=2C October 14=2C 2010=2C Raj Kumar wrote:
> >=20
> > Hi Rafael=2C
> >=20
> > 1) I have question on system resume that e.g. in device driver let us s=
ay for example structure is defined global=2C
> > e.g.
> >=20
> > struct dev
> > {
> > int a=3B
> >=20
> > } dev_t=3B
> >=20
> >=20
> > this structure is global. Now during system suspend=2C suppose the valu=
e of=20
> >=20
> > dev_t.a =3D2=3B
> >=20
> > So when the resume happens=2C will the dev_t.a will remain the same i.e=
. 2?
>=20
> Yes=2C it will. For hibernation=2C the contents of all memory from before=
 the image
> was created is restored during resume.
>=20
> > 2) During the system suspend=2C if the system hibernates=2C then the me=
ssage sent from power management core to all drivers is
> > PMSG_HIBERNATE and if system suspends to ram=2C then message sent from =
power management core to all drivers is PMSG_SUSPEND.
>=20
> That was in the old model=2C which isn't recommended any more.
>=20
> Currently=2C it is recommended that drivers implement callbacks in struct=
 dev_pm_ops=2C
> as described in Documentation/power/devices.txt and Documentation/power/p=
ci.txt.
>=20
> Thanks=2C
> Rafael
>=20
>=20
> > > From: rjw@sisk.pl
> > > To: rajkumar278@hotmail.com
> > > Subject: Re: Question about hibernation
> > > Date: Fri=2C 8 Oct 2010 21:31:48 +0200
> > > CC: linux-pm@lists.linux-foundation.org
> > >=20
> > > On Friday=2C October 08=2C 2010=2C you wrote:
> > > >=20
> > > > Hi Rafael=2C
> > >=20
> > > Hi=2C
> > >=20
> > > > I am working on device driver whose some part is user space and som=
e part is kernel space. So the user space part
> > > > of the driver provides interface to user space applications.=20
> > > > 1) Now=2C Suppose some user space is application is going on which =
is accessing the user space driver and user space driver
> > > > scheduled some jobs to kernel space=2C Now suppose system hibernati=
on start=2C since it freezes all the user space processes
> > > > so suppose jobs are not completed yet which are scheduled to kernel=
 space by user space.
> > > >=20
> > > > when the kernel space device driver completes the jobs and gives th=
e notification to user space driver=2C since user space
> > > > process is already frozen=2C so there will be problem if we suspend=
 the driver using suspend and resume.
> > > >=20
> > > > right?
> > >=20
> > > Yes=2C there's going to be a problem if the driver is not prepared to=
 handle such situations.
> > >=20
> > > Depending of the particular case=2C one possible approach is to use a=
 PM notifier
> > > as described in Documentation/power/notifiers.txt.
> > >=20
> > > > 2) The other point I was seeing=2C when the power management core f=
reezes all the processes before suspending and resuming
> > > > devices=2C it will take some time for freezing and after that if so=
me device driver refuses to suspend=2C then it will again resume
> > > > the whole processes=2C so latency time be more. right?
> > >=20
> > > Yes=2C it works as described.
> > >=20
> > > > 3) Next question is regarding the kernel space threads=2C when thes=
e are frozen during suspend/hibernation?
> > >=20
> > > They are frozen immediately after user space has been frozen=2C but o=
nly a
> > > handful of kernel threads are frozen.
> > >=20
> > > Thanks=2C
> > > Rafael
> >=20
>=20
 		 	   		  =

--_6610575e-f9c4-4200-afb4-d943525cd8d7_
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
Hi Rafael=2C<BR>
&nbsp=3B<BR>
Thanks for your quick reply.&nbsp=3B <BR>
&nbsp=3B<BR>
1) I already implemented this with dev_pm_ops. I used suspend and resume ca=
llbacks<BR>
whose prototype is like<BR>
&nbsp=3B<BR>
struct dev_pm_ops power_mgmt_ops<BR>
{<BR>
&nbsp=3B&nbsp=3B .suspend =3D&nbsp=3B powermanagement_suspend=2C<BR>
&nbsp=3B&nbsp=3B .resume =3D&nbsp=3B powermanagement_resume<BR>
&nbsp=3B<BR>
}<BR>
&nbsp=3B<BR>
int powermanagement_suspend(device *dev)<BR>
{<BR>
&nbsp=3B<BR>
}<BR>
&nbsp=3B<BR>
In normal suspend to ram mode it will work. But will it work in case of hib=
ernation also?<BR>
&nbsp=3B<BR>
if yes=2C since in suspend and resume call backs=2C only the device structu=
re is provided=2C so how can<BR>
then person can identify it is suspend to ram or hibernation?<BR>
&nbsp=3B<BR>
or for hibernation=2C poweroff&nbsp=3B and restore function should be imple=
mented which is similar<BR>
to suspend and resume call backs in case of suspend to ram?<BR>
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
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>
&gt=3B From: rjw@sisk.pl<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=3B Su=
bject: Re: Question about hibernation<BR>&gt=3B Date: Thu=2C 14 Oct 2010 11=
:51:05 +0200<BR>&gt=3B CC: linux-pm@lists.linux-foundation.org<BR>&gt=3B <B=
R>&gt=3B On Thursday=2C October 14=2C 2010=2C Raj Kumar wrote:<BR>&gt=3B &g=
t=3B <BR>&gt=3B &gt=3B Hi Rafael=2C<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B 1) I=
 have question on system resume that e.g. in device driver let us say for e=
xample structure is defined global=2C<BR>&gt=3B &gt=3B e.g.<BR>&gt=3B &gt=
=3B <BR>&gt=3B &gt=3B struct dev<BR>&gt=3B &gt=3B {<BR>&gt=3B &gt=3B int a=
=3B<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B } dev_t=3B<BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B <BR>&gt=3B &gt=3B this structure is global. Now during system su=
spend=2C suppose the value of <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B dev_t.a =
=3D2=3B<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B So when the resume happens=2C wi=
ll the dev_t.a will remain the same i.e. 2?<BR>&gt=3B <BR>&gt=3B Yes=2C it =
will. For hibernation=2C the contents of all memory from before the image<B=
R>&gt=3B was created is restored during resume.<BR>&gt=3B <BR>&gt=3B &gt=3B=
 2) During the system suspend=2C if the system hibernates=2C then the messa=
ge sent from power management core to all drivers is<BR>&gt=3B &gt=3B PMSG_=
HIBERNATE and if system suspends to ram=2C then message sent from power man=
agement core to all drivers is PMSG_SUSPEND.<BR>&gt=3B <BR>&gt=3B That was =
in the old model=2C which isn't recommended any more.<BR>&gt=3B <BR>&gt=3B =
Currently=2C it is recommended that drivers implement callbacks in struct d=
ev_pm_ops=2C<BR>&gt=3B as described in Documentation/power/devices.txt and =
Documentation/power/pci.txt.<BR>&gt=3B <BR>&gt=3B Thanks=2C<BR>&gt=3B Rafae=
l<BR>&gt=3B <BR>&gt=3B <BR>&gt=3B &gt=3B &gt=3B From: rjw@sisk.pl<BR>&gt=3B=
 &gt=3B &gt=3B To: rajkumar278@hotmail.com<BR>&gt=3B &gt=3B &gt=3B Subject:=
 Re: Question about hibernation<BR>&gt=3B &gt=3B &gt=3B Date: Fri=2C 8 Oct =
2010 21:31:48 +0200<BR>&gt=3B &gt=3B &gt=3B CC: linux-pm@lists.linux-founda=
tion.org<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B On Friday=2C Octo=
ber 08=2C 2010=2C you wrote:<BR>&gt=3B &gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=
=3B &gt=3B &gt=3B Hi Rafael=2C<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &g=
t=3B Hi=2C<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B &gt=3B I am wor=
king on device driver whose some part is user space and some part is kernel=
 space. So the user space part<BR>&gt=3B &gt=3B &gt=3B &gt=3B of the driver=
 provides interface to user space applications. <BR>&gt=3B &gt=3B &gt=3B &g=
t=3B 1) Now=2C Suppose some user space is application is going on which is =
accessing the user space driver and user space driver<BR>&gt=3B &gt=3B &gt=
=3B &gt=3B scheduled some jobs to kernel space=2C Now suppose system hibern=
ation start=2C since it freezes all the user space processes<BR>&gt=3B &gt=
=3B &gt=3B &gt=3B so suppose jobs are not completed yet which are scheduled=
 to kernel space by user space.<BR>&gt=3B &gt=3B &gt=3B &gt=3B <BR>&gt=3B &=
gt=3B &gt=3B &gt=3B when the kernel space device driver completes the jobs =
and gives the notification to user space driver=2C since user space<BR>&gt=
=3B &gt=3B &gt=3B &gt=3B process is already frozen=2C so there will be prob=
lem if we suspend the driver using suspend and resume.<BR>&gt=3B &gt=3B &gt=
=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B &gt=3B right?<BR>&gt=3B &gt=3B &gt=3B <=
BR>&gt=3B &gt=3B &gt=3B Yes=2C there's going to be a problem if the driver =
is not prepared to handle such situations.<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=
=3B &gt=3B &gt=3B Depending of the particular case=2C one possible approach=
 is to use a PM notifier<BR>&gt=3B &gt=3B &gt=3B as described in Documentat=
ion/power/notifiers.txt.<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B &=
gt=3B 2) The other point I was seeing=2C when the power management core fre=
ezes all the processes before suspending and resuming<BR>&gt=3B &gt=3B &gt=
=3B &gt=3B devices=2C it will take some time for freezing and after that if=
 some device driver refuses to suspend=2C then it will again resume<BR>&gt=
=3B &gt=3B &gt=3B &gt=3B the whole processes=2C so latency time be more. ri=
ght?<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B Yes=2C it works as de=
scribed.<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B &gt=3B 3) Next qu=
estion is regarding the kernel space threads=2C when these are frozen durin=
g suspend/hibernation?<BR>&gt=3B &gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B The=
y are frozen immediately after user space has been frozen=2C but only a<BR>=
&gt=3B &gt=3B &gt=3B handful of kernel threads are frozen.<BR>&gt=3B &gt=3B=
 &gt=3B <BR>&gt=3B &gt=3B &gt=3B Thanks=2C<BR>&gt=3B &gt=3B &gt=3B Rafael<B=
R>&gt=3B &gt=3B <BR>&gt=3B <BR> 		 	   		  </body>
</html>=

--_6610575e-f9c4-4200-afb4-d943525cd8d7_--

--===============8844964534760418496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8844964534760418496==--
