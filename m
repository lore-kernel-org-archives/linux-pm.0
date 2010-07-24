From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Questions about run time power management
Date: Sat, 24 Jul 2010 19:56:45 +0530
Message-ID: <BLU102-W19F776184395386635AA56EBA40@phx.gbl>
References: <BLU102-W10EC41B7844B167719657CEBA20@phx.gbl>,
	<Pine.LNX.4.44L0.1007231022120.1823-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6101379631808505462=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007231022120.1823-100000@iolanthe.rowland.org>
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
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============6101379631808505462==
Content-Type: multipart/alternative;
	boundary="_7057c46e-0556-48e1-a726-c721fd6f4639_"

--_7057c46e-0556-48e1-a726-c721fd6f4639_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Alan=2C

=20

Please see my following points:

=20

 Suppose when device is idle=2C it says to run time power management framew=
ork i am idle

and run time power management asks the device's bus (if bus is being used)=
=2C and=20

probably the case is if the device does not want to get suspended because o=
f the starting

of the activities immediately =2C it will return the error to platform bus =
and platform bus returns this error

to run time power management framework and run time power management will m=
ake

the device status active. In the code of=20

=20

int  __pm_runtime_suspend(arguments...)

{


=20

  if (retval) {
                dev->power.runtime_status =3D RPM_ACTIVE=3B
                pm_runtime_cancel_pending(dev)=3B

                if (retval =3D=3D -EAGAIN || retval =3D=3D -EBUSY) {
                        notify =3D true=3B
                        dev->power.runtime_error =3D 0=3B
                }
        } else {


=20

}

=20

So if the retval is -EAGAIN and -EBUSY=2C  so it means it will again try to=
 make it idle but if the device is

already doing activities =2C since it is started doing activities then in t=
hat case is this error code

ECANCELED is appropriate?

=20

Regards

Raj

=20

=20

=20

=20

=20

=20
> Date: Fri=2C 23 Jul 2010 10:26:07 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] Questions about run time power management
>=20
> On Fri=2C 23 Jul 2010=2C Raj Kumar wrote:
>=20
> > Hi=2C
> >=20
> >=20
> > I am implementing the run time power management in my drivers. So i hav=
e the following
> > questions:
> >=20
> >=20
> > 1) I am using the work queue approach for run time power management=2C =
Now the thing is
> > when the device is idle and it notifies the run time power management v=
ia helper function
> > pm_request_idle=2C and at the same time if resume is done then in that =
case does the runtime power management
> > cancels the idle and does not invoke any callback like runtime_suspend =
of driver?=20
>=20
> How can a resume occur while the device is idle? Idle means that the=20
> device isn't suspended -- it's at full power but not doing anything.=20
> Hence a resume cannot occur at the same time.
>=20
> > 2) like as mentioned in run time power management document=2C when the =
usage_count of device
> > reaches zero=2C is there any run time power management thread in backgr=
ound that will immediately suspends
> > the device or it is again via helper functions. It seems from the code =
that usage_count is zero and suspended
> > via helper functions. Is it correct?
>=20
> All suspends occur via the helper functions=2C whether a background=20
> thread is involved or not.
>=20
> > 3) The third question is more specific about platform bus usage? can th=
e char device driver use platform bus?
> > can char device register as platform device?
>=20
> Yes. Devices can be registered on any bus.
>=20
> Alan Stern
>=20
 		 	   		  =

--_7057c46e-0556-48e1-a726-c721fd6f4639_
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
Hi Alan=2C<BR>
&nbsp=3B<BR>
Please see my following points:<BR>
&nbsp=3B<BR>
&nbsp=3BSuppose when device is idle=2C it says to run time power management=
 framework i am idle<BR>
and run time power management asks the device's bus (if bus is being used)=
=2C and <BR>
probably the case is if the device does not want to get suspended because o=
f the starting<BR>
of the activities immediately&nbsp=3B=2C it will return the error to platfo=
rm bus and platform bus returns this error<BR>
to run time power management framework and run time power management will m=
ake<BR>
the device status active. In the code of <BR>
&nbsp=3B<BR>
int&nbsp=3B __pm_runtime_suspend(arguments...)<BR>
{<BR>
<BR>&nbsp=3B<BR>
&nbsp=3B if (retval) {<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B dev=
-&gt=3Bpower.runtime_status =3D RPM_ACTIVE=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B pm_runtime_cancel_pending(dev)=3B<BR>
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B if (retval =3D=3D -EAGAIN || =
retval =3D=3D -EBUSY) {<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B notify =3D tr=
ue=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B dev-&gt=3Bpower.runtime_error =
=3D 0=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B }<BR>&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B } else {<BR><BR>
&nbsp=3B<BR>
}<BR>
&nbsp=3B<BR>
So if the retval is -EAGAIN and -EBUSY=2C&nbsp=3B so it means it will again=
 try to make it idle but if the device is<BR>
already doing activities =2C since it is started doing activities then in t=
hat case is this error code<BR>
ECANCELED is appropriate?<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>&gt=3B Date: Fri=2C 23 Jul 2010 10:26:07 -0400<BR>&gt=3B From: =
stern@rowland.harvard.edu<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=3B C=
C: linux-pm@lists.linux-foundation.org<BR>&gt=3B Subject: Re: [linux-pm] Qu=
estions about run time power management<BR>&gt=3B <BR>&gt=3B On Fri=2C 23 J=
ul 2010=2C Raj Kumar wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B Hi=2C<BR>&gt=3B &gt=
=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I am implementing the run time powe=
r management in my drivers. So i have the following<BR>&gt=3B &gt=3B questi=
ons:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B 1) I am using the=
 work queue approach for run time power management=2C Now the thing is<BR>&=
gt=3B &gt=3B when the device is idle and it notifies the run time power man=
agement via helper function<BR>&gt=3B &gt=3B pm_request_idle=2C and at the =
same time if resume is done then in that case does the runtime power manage=
ment<BR>&gt=3B &gt=3B cancels the idle and does not invoke any callback lik=
e runtime_suspend of driver? <BR>&gt=3B <BR>&gt=3B How can a resume occur w=
hile the device is idle? Idle means that the <BR>&gt=3B device isn't suspen=
ded -- it's at full power but not doing anything. <BR>&gt=3B Hence a resume=
 cannot occur at the same time.<BR>&gt=3B <BR>&gt=3B &gt=3B 2) like as ment=
ioned in run time power management document=2C when the usage_count of devi=
ce<BR>&gt=3B &gt=3B reaches zero=2C is there any run time power management =
thread in background that will immediately suspends<BR>&gt=3B &gt=3B the de=
vice or it is again via helper functions. It seems from the code that usage=
_count is zero and suspended<BR>&gt=3B &gt=3B via helper functions. Is it c=
orrect?<BR>&gt=3B <BR>&gt=3B All suspends occur via the helper functions=2C=
 whether a background <BR>&gt=3B thread is involved or not.<BR>&gt=3B <BR>&=
gt=3B &gt=3B 3) The third question is more specific about platform bus usag=
e? can the char device driver use platform bus?<BR>&gt=3B &gt=3B can char d=
evice register as platform device?<BR>&gt=3B <BR>&gt=3B Yes. Devices can be=
 registered on any bus.<BR>&gt=3B <BR>&gt=3B Alan Stern<BR>&gt=3B <BR> 		 	=
   		  </body>
</html>=

--_7057c46e-0556-48e1-a726-c721fd6f4639_--

--===============6101379631808505462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6101379631808505462==--
