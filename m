From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: About run time power management in linux
Date: Tue, 6 Jul 2010 21:27:40 +0530
Message-ID: <BLU102-W17D96932C41B4670A7090CEBB20@phx.gbl>
References: <BLU102-W532408CF4DA1EA7664EDAEBB10@phx.gbl>,
	<Pine.LNX.4.44L0.1007050947290.568-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5699321106322403376=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007050947290.568-100000@netrider.rowland.org>
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

--===============5699321106322403376==
Content-Type: multipart/alternative;
	boundary="_a0180e7f-7ff9-49c0-8738-516b250da656_"

--_a0180e7f-7ff9-49c0-8738-516b250da656_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi Alen=2C

This question is regarding the power management in case of battery is low. =
Suppose if the battery is low=2C
how the battery driver notifies the linux power management core to transiti=
on to low power state.

How the linux power management addresses this issue?

Thanks
Raj

> Date: Mon=2C 5 Jul 2010 09:51:55 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-pm@lists.linux-foundation.org
> Subject: RE: [linux-pm] About run time power management in linux
>=20
> On Mon=2C 5 Jul 2010=2C Raj Kumar wrote:
>=20
> >=20
> > Hi Alan=2C
> >=20
> > =20
> >=20
> > I have few more questions about run time power management:
> >=20
> > =20
> >=20
> > 1) Please correct me if i am wrong. If there is a bus driver that is ma=
naging various power domains=2C
> >=20
> > and suppose this domain has some child devices.=20
> >=20
> > =20
> >=20
> > Then child has to inform run time Power management core i am idle and i=
 want to go to get suspended=2C
>=20
> Strictly speaking=2C the child device doesn't do this -- its driver does.
>=20
> > then run time pm core will notify the bus driver of child and then bus =
driver calls the corresponding child's
> >=20
> > =20
> >=20
> > suspend. right?
>=20
> Right.  In fact=2C that's true even when the bus driver manages only a=20
> single power domain.
>=20
> > 2) run time power management can be done at device "type" and "class". =
But what does mean of this device
> >=20
> > type. what use cases are defined for run time power management for devi=
ce "type"?
>=20
> Here are a couple of examples.  In the USB subsystem there are two
> "types": devices and interfaces.  In the SCSI subsystem there are three
> "types": hosts=2C targets=2C and LUNs.  Each type generally needs to do=20
> runtime power management differently.
>=20
> Alan Stern
>=20
 		 	   		  =

--_a0180e7f-7ff9-49c0-8738-516b250da656_
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
<br>Hi Alen=2C<br><br>This question is regarding the power management in ca=
se of battery is low. Suppose if the battery is low=2C<br>how the battery d=
river notifies the linux power management core to transition to low power s=
tate.<br><br>How the linux power management addresses this issue?<br><br>Th=
anks<br>Raj<br><br>&gt=3B Date: Mon=2C 5 Jul 2010 09:51:55 -0400<br>&gt=3B =
From: stern@rowland.harvard.edu<br>&gt=3B To: rajkumar278@hotmail.com<br>&g=
t=3B CC: linux-pm@lists.linux-foundation.org<br>&gt=3B Subject: RE: [linux-=
pm] About run time power management in linux<br>&gt=3B <br>&gt=3B On Mon=2C=
 5 Jul 2010=2C Raj Kumar wrote:<br>&gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=
=3B Hi Alan=2C<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B  <br>&gt=3B &gt=3B <br>&g=
t=3B &gt=3B I have few more questions about run time power management:<br>&=
gt=3B &gt=3B <br>&gt=3B &gt=3B  <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B 1) Plea=
se correct me if i am wrong. If there is a bus driver that is managing vari=
ous power domains=2C<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B and suppose this do=
main has some child devices. <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B  <br>&gt=
=3B &gt=3B <br>&gt=3B &gt=3B Then child has to inform run time Power manage=
ment core i am idle and i want to go to get suspended=2C<br>&gt=3B <br>&gt=
=3B Strictly speaking=2C the child device doesn't do this -- its driver doe=
s.<br>&gt=3B <br>&gt=3B &gt=3B then run time pm core will notify the bus dr=
iver of child and then bus driver calls the corresponding child's<br>&gt=3B=
 &gt=3B <br>&gt=3B &gt=3B  <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B suspend. rig=
ht?<br>&gt=3B <br>&gt=3B Right.  In fact=2C that's true even when the bus d=
river manages only a <br>&gt=3B single power domain.<br>&gt=3B <br>&gt=3B &=
gt=3B 2) run time power management can be done at device "type" and "class"=
. But what does mean of this device<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B type=
. what use cases are defined for run time power management for device "type=
"?<br>&gt=3B <br>&gt=3B Here are a couple of examples.  In the USB subsyste=
m there are two<br>&gt=3B "types": devices and interfaces.  In the SCSI sub=
system there are three<br>&gt=3B "types": hosts=2C targets=2C and LUNs.  Ea=
ch type generally needs to do <br>&gt=3B runtime power management different=
ly.<br>&gt=3B <br>&gt=3B Alan Stern<br>&gt=3B <br> 		 	   		  </body>
</html>=

--_a0180e7f-7ff9-49c0-8738-516b250da656_--

--===============5699321106322403376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5699321106322403376==--
