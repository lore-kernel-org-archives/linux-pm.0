From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Questions about run time power management
Date: Wed, 28 Jul 2010 17:05:33 +0530
Message-ID: <BLU102-W87DD2A0042EBCEDB9C141EBA80@phx.gbl>
References: <BLU102-W19F776184395386635AA56EBA40@phx.gbl>,
	<Pine.LNX.4.44L0.1007251147330.31037-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3310501728298240152=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007251147330.31037-100000@netrider.rowland.org>
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
To: stern@rowland.harvard.edu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============3310501728298240152==
Content-Type: multipart/alternative;
	boundary="_d3e2e97a-ef73-4b93-bf9e-624905faac92_"

--_d3e2e97a-ef73-4b93-bf9e-624905faac92_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20

Hi ALan=2C

=20

1) As you mentioned that -EBUSY code is appropriate=2C But if the

device started doing activities during that time then it is not appropriate

to check every time if device is idle.

=20

Because if -EBUSY is returned=2C then workqueue thread will check again and=
 again

that if the device is idle.

=20

        if (notify)
                __pm_runtime_idle(dev)=3B


That is notify flag will be true. right?

=20

2) The 2nd thing is use case of deep sleep state i.e. system suspend.

=20

Suppose device is active and its run time status is active. Now when the sy=
stem suspend=20

happens=2C it will increment usage_counter of device in power management fr=
amework=2C

=20

now at that time since clocks and power are enabled=2C So what will device =
do?

=20

My point is when system suspend comes to device and device is doing activit=
ies at that time=2C

if the device will ask run time power management to shut its clock off and =
make it suspended=2C

=20

and then it respond to system suspend????

=20

Run time power management will not do at the time as its usage counter is a=
lready increased=2C

=20

Right? so what about this use case when this kind of overlapping occurs?

=20

Regards

Raj=20

=20

=20

=20

=20


=20
> Date: Sun=2C 25 Jul 2010 11:48:34 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-pm@lists.linux-foundation.org
> Subject: RE: [linux-pm] Questions about run time power management
>=20
> On Sat=2C 24 Jul 2010=2C Raj Kumar wrote:
>=20
> > Hi Alan=2C
> >=20
> >=20
> >=20
> > Please see my following points:
> >=20
> >=20
> >=20
> > Suppose when device is idle=2C it says to run time power management fra=
mework i am idle
> >=20
> > and run time power management asks the device's bus (if bus is being us=
ed)=2C and=20
> >=20
> > probably the case is if the device does not want to get suspended becau=
se of the starting
> >=20
> > of the activities immediately =2C it will return the error to platform =
bus and platform bus returns this error
> >=20
> > to run time power management framework and run time power management wi=
ll make
> >=20
> > the device status active. In the code of=20
> >=20
> >=20
> >=20
> > int __pm_runtime_suspend(arguments...)
> >=20
> > {
> >=20
> >=20
> >=20
> >=20
> > if (retval) {
> > dev->power.runtime_status =3D RPM_ACTIVE=3B
> > pm_runtime_cancel_pending(dev)=3B
> >=20
> > if (retval =3D=3D -EAGAIN || retval =3D=3D -EBUSY) {
> > notify =3D true=3B
> > dev->power.runtime_error =3D 0=3B
> > }
> > } else {
> >=20
> >=20
> >=20
> >=20
> > }
> >=20
> >=20
> >=20
> > So if the retval is -EAGAIN and -EBUSY=2C so it means it will again try=
 to make it idle but if the device is
> >=20
> > already doing activities =2C since it is started doing activities then =
in that case is this error code
> >=20
> > ECANCELED is appropriate?
>=20
> No. -EBUSY is more appropriate=2C since the device is busy.
>=20
> Alan Stern
>=20
 		 	   		  =

--_d3e2e97a-ef73-4b93-bf9e-624905faac92_
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
Hi ALan=2C<BR>
&nbsp=3B<BR>
1) As you mentioned that -EBUSY code is appropriate=2C But if the<BR>
device started doing activities during that time then it is not appropriate=
<BR>
to check every time if device is idle.<BR>
&nbsp=3B<BR>
Because if -EBUSY is returned=2C then workqueue thread will check again and=
 again<BR>
that if the device is idle.<BR>
&nbsp=3B<BR>
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B if (notify)<BR>&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B __pm_runtime_idle(dev)=3B<BR><B=
R>
That is notify flag will be true. right?<BR>
&nbsp=3B<BR>
2)&nbsp=3BThe&nbsp=3B2nd&nbsp=3Bthing is use case of deep sleep state i.e. =
system suspend.<BR>
&nbsp=3B<BR>
Suppose device is active and its run time status is active. Now when the sy=
stem suspend <BR>
happens=2C it will increment usage_counter of device in power management fr=
amework=2C<BR>
&nbsp=3B<BR>
now at that time since clocks and power are enabled=2C So what will device =
do?<BR>
&nbsp=3B<BR>
My point is when system suspend comes to device and device is doing activit=
ies at that time=2C<BR>
if the device will ask run time power management to shut its clock off and =
make it suspended=2C<BR>
&nbsp=3B<BR>
and then it respond to system suspend????<BR>
&nbsp=3B<BR>
Run time power management will not do at the&nbsp=3Btime as its usage count=
er is already increased=2C<BR>
&nbsp=3B<BR>
Right? so what about this use case when this kind of overlapping occurs?<BR=
>
&nbsp=3B<BR>
Regards<BR>
Raj&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>&gt=3B Date: Sun=2C 25 Jul 2010 11:48:34 -0400<BR>&gt=3B Fr=
om: stern@rowland.harvard.edu<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=
=3B CC: linux-pm@lists.linux-foundation.org<BR>&gt=3B Subject: RE: [linux-p=
m] Questions about run time power management<BR>&gt=3B <BR>&gt=3B On Sat=2C=
 24 Jul 2010=2C Raj Kumar wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B Hi Alan=2C<BR>=
&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Please =
see my following points:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B <BR>&gt=3B &gt=3B Suppose when device is idle=2C it says to run time po=
wer management framework i am idle<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B and r=
un time power management asks the device's bus (if bus is being used)=2C an=
d <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B probably the case is if the device do=
es not want to get suspended because of the starting<BR>&gt=3B &gt=3B <BR>&=
gt=3B &gt=3B of the activities immediately =2C it will return the error to =
platform bus and platform bus returns this error<BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B to run time power management framework and run time power manage=
ment will make<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B the device status active.=
 In the code of <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&=
gt=3B &gt=3B int __pm_runtime_suspend(arguments...)<BR>&gt=3B &gt=3B <BR>&g=
t=3B &gt=3B {<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B <BR>&gt=3B &gt=3B if (retval) {<BR>&gt=3B &gt=3B dev-&gt=3Bpower=
.runtime_status =3D RPM_ACTIVE=3B<BR>&gt=3B &gt=3B pm_runtime_cancel_pendin=
g(dev)=3B<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B if (retval =3D=3D -EAGAIN || r=
etval =3D=3D -EBUSY) {<BR>&gt=3B &gt=3B notify =3D true=3B<BR>&gt=3B &gt=3B=
 dev-&gt=3Bpower.runtime_error =3D 0=3B<BR>&gt=3B &gt=3B }<BR>&gt=3B &gt=3B=
 } else {<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &=
gt=3B <BR>&gt=3B &gt=3B }<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B <BR>&gt=3B &gt=3B So if the retval is -EAGAIN and -EBUSY=2C so it means=
 it will again try to make it idle but if the device is<BR>&gt=3B &gt=3B <B=
R>&gt=3B &gt=3B already doing activities =2C since it is started doing acti=
vities then in that case is this error code<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B ECANCELED is appropriate?<BR>&gt=3B <BR>&gt=3B No. -EBUSY is more appro=
priate=2C since the device is busy.<BR>&gt=3B <BR>&gt=3B Alan Stern<BR>&gt=
=3B <BR> 		 	   		  </body>
</html>=

--_d3e2e97a-ef73-4b93-bf9e-624905faac92_--

--===============3310501728298240152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3310501728298240152==--
