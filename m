From: <rasmit.ranjan@wipro.com>
Subject: (no subject)
Date: Tue, 21 Feb 2006 18:11:18 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20169F108@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12151088839729374=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============12151088839729374==
Content-Type: multipart/alternative;
    boundary="----------=_1140525713-6465-546"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1140525713-6465-546
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
   I have a PCMCIA card which has a usb Host Controller (HC) on it. I am
writing Host Controller Driver (HCD) for this. I have pcmcia client
driver which is registering HC as a platform device.i.e. my HCD is a
platform driver. The device representation in linux-2.6.15.4 is given
below.
=20
=20
/sys/class/pcmcia-socket/pcmcia-socket1/device/1.0/myhcd/usb5/5-0:1.0
=20
In my pcmcia client driver i get suspend event when i do selective
suspend of the card (pcmcia-socket1/device in device tree ) .  Platform
driver`s suspend entry point is getting called when i do selective
suspend of myhcd. Now if i do global suspend will Power Management
sub-system follow the device tree to suspend the card ? Which means PM
sub-system will suspend 5-0:1.0 , then it will suspend usb5, then myhcd
and then the pcmcia-socket1/device. So does it mean that in global
suspend platform driver`s suspend entry point will be getting called
before the pcmcia client driver`s suspend event ?
Please suggest.
=20
Thanks and regards,
Rasmit Ranjan swain.

------------=_1140525713-6465-546
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D890351412-21022006>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D890351412-21022006>&nbsp;&nb=
sp; I have=20
a PCMCIA card which has a usb&nbsp;Host Controller (HC)&nbsp;on it. I am=20
writing&nbsp;Host Controller Driver (HCD)&nbsp;for this. I have pcmcia clie=
nt=20
driver which is registering&nbsp;HC as a platform device.</SPAN></FONT><FON=
T=20
face=3DArial size=3D2><SPAN class=3D890351412-21022006>i.e.</SPAN></FONT><F=
ONT=20
face=3DArial size=3D2><SPAN class=3D890351412-21022006>&nbsp;my HCD is a pl=
atform=20
driver. The device representation in linux-2.6.15.4 is given=20
below.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D890351412-21022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D890351412-21022006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<STRONG>/sys/class/pcmcia-socket/pcmcia-socket1/device/1.0/myhcd/usb5/5-0:1=
.0</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D890351412-21022006><STRONG></STRONG></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D890351412-21022006>In my pcm=
cia client=20
driver i get suspend event when i do selective suspend of the card=20
(<STRONG>pcmcia-socket1/device&nbsp;</STRONG>in device=20
tree&nbsp;)&nbsp;.&nbsp;&nbsp;Platform driver`s suspend entry point is gett=
ing=20
called when i do selective suspend of <STRONG>myhcd</STRONG>.&nbsp;Now if i=
 do=20
global suspend will&nbsp;Power Management&nbsp;sub-system follow the device=
 tree=20
to suspend the card ? Which means PM sub-system will suspend=20
<STRONG>5-0:1.0</STRONG> , then it will suspend <STRONG>usb5</STRONG>, then=
=20
<STRONG>myhcd</STRONG> and then the <STRONG>pcmcia-socket1/device</STRONG>.=
 So=20
does it mean that in global suspend platform driver`s&nbsp;suspend entry po=
int=20
will be getting called before the pcmcia client driver`s suspend event=20
?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D890351412-21022006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D890351412-21022006>&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D890351412-21022006>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D890351412-21022006>Rasmit Ra=
njan=20
swain.</SPAN></FONT></DIV></BODY></HTML>

------------=_1140525713-6465-546--

--===============12151088839729374==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12151088839729374==--
