From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: About run time power management in linux
Date: Wed, 30 Jun 2010 20:37:22 +0530
Message-ID: <BLU102-W15580CBC32130E58FED981EBCC0@phx.gbl>
References: <BLU102-W77098297EEED290634D10EBCC0@phx.gbl>,
	<Pine.LNX.4.44L0.1006301019140.1707-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0481825756994543458=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006301019140.1707-100000@iolanthe.rowland.org>
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

--===============0481825756994543458==
Content-Type: multipart/alternative;
	boundary="_e6e7d12c-a7c0-4cf2-b444-05dc36a2150d_"

--_e6e7d12c-a7c0-4cf2-b444-05dc36a2150d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20

Hi Alan=2C

=20

First thanks for reply.  ok as also seems to be in runtime.c=2C if device w=
ants to suspend and resume

=20

then device will call helper functions for pm core like pm_runtime_suspend =
and pm_runtime_resume=2C

=20

which internally calls the runtime_resume of the bus and which in turn call=
s the runtime_resume of the driver.

=20

correct ?

=20

Regards

Raj

=20

=20


=20
> Date: Wed=2C 30 Jun 2010 10:23:41 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] About run time power management in linux
>=20
> Please fix your email client to wrap lines after about 72 columns and=20
> not to insert excess blank lines.
>=20
> On Wed=2C 30 Jun 2010=2C Raj Kumar wrote:
>=20
> > Hi=2C
> >=20
> > I am working in power management. I have few questions about run time p=
ower management which was merged in linux 2.6.32 kernel onwards.=20
> >=20
> >=20
> >=20
> > Since the run time power management defines that when idle=2C suspend a=
nd resume will be scheduled=2C now the thing is from device driver perspect=
ive=2C=20
> >=20
> >=20
> >=20
> > it is bus driver that will suspend and resume its devices. but what fro=
m driver perspective driver needs to implement means as run time power mana=
gement=20
> >=20
> >=20
> >=20
> > has also helper functions which will tell PM core that when to call var=
ious callbacks for suspend and resume for drivers (device=2C bus).=20
> >=20
> >=20
> >=20
> > But it might be case when the whole bus is not idle and still some driv=
ers can be put into low power mode.=20
> >=20
> >=20
> >=20
> > Then does bus driver will be responsible for invoking the driver's susp=
end and resume (run time) or PM core will do that ?=20
>=20
> The PM core will invoke the bus driver's runtime_idle=2C runtime_suspend=
=2C
> and runtime_resume callback functions. These functions are then
> responsible for invoking the device driver's suspend and resume=20
> routines.
>=20
> Alan Stern
>=20
 		 	   		  =

--_e6e7d12c-a7c0-4cf2-b444-05dc36a2150d_
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
Hi Alan=2C<BR>
&nbsp=3B<BR>
First thanks for reply.&nbsp=3B ok as also seems to&nbsp=3Bbe in runtime.c=
=2C if device wants&nbsp=3Bto suspend and resume<BR>
&nbsp=3B<BR>
then device will call helper functions for pm core like pm_runtime_suspend =
and pm_runtime_resume=2C<BR>
&nbsp=3B<BR>
which internally calls the runtime_resume of the bus and which in turn call=
s the runtime_resume of the driver.<BR>
&nbsp=3B<BR>
correct ?<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>&gt=3B Date: Wed=2C 30 Jun 2010 10:23:41 -0400<BR>&gt=3B Fr=
om: stern@rowland.harvard.edu<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=
=3B CC: linux-pm@lists.linux-foundation.org<BR>&gt=3B Subject: Re: [linux-p=
m] About run time power management in linux<BR>&gt=3B <BR>&gt=3B Please fix=
 your email client to wrap lines after about 72 columns and <BR>&gt=3B not =
to insert excess blank lines.<BR>&gt=3B <BR>&gt=3B On Wed=2C 30 Jun 2010=2C=
 Raj Kumar wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B Hi=2C<BR>&gt=3B &gt=3B <BR>&g=
t=3B &gt=3B I am working in power management. I have few questions about ru=
n time power management which was merged in linux 2.6.32 kernel onwards. <B=
R>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Since=
 the run time power management defines that when idle=2C suspend and resume=
 will be scheduled=2C now the thing is from device driver perspective=2C <B=
R>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B it is=
 bus driver that will suspend and resume its devices. but what from driver =
perspective driver needs to implement means as run time power management <B=
R>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B has a=
lso helper functions which will tell PM core that when to call various call=
backs for suspend and resume for drivers (device=2C bus). <BR>&gt=3B &gt=3B=
 <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B But it might be case=
 when the whole bus is not idle and still some drivers can be put into low =
power mode. <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B Then does bus driver will be responsible for invoking the driver=
's suspend and resume (run time) or PM core will do that ? <BR>&gt=3B <BR>&=
gt=3B The PM core will invoke the bus driver's runtime_idle=2C runtime_susp=
end=2C<BR>&gt=3B and runtime_resume callback functions. These functions are=
 then<BR>&gt=3B responsible for invoking the device driver's suspend and re=
sume <BR>&gt=3B routines.<BR>&gt=3B <BR>&gt=3B Alan Stern<BR>&gt=3B <BR> 		=
 	   		  </body>
</html>=

--_e6e7d12c-a7c0-4cf2-b444-05dc36a2150d_--

--===============0481825756994543458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0481825756994543458==--
