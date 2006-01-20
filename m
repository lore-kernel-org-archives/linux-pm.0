From: <rasmit.ranjan@wipro.com>
Subject: problem in swsusp with usb-serial convertor attached
Date: Fri, 20 Jan 2006 12:30:36 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2014368BB@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75653020962520068=="
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

--===============75653020962520068==
Content-Type: multipart/alternative;
    boundary="----------=_1137740544-1666-432"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1137740544-1666-432
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,
    In my system Linux-2.6.13.3 swsusp works properly.
Now one usb-serial convertor device is attached to my system. I manually
loaded the driver for the device and attached the device to my system.At
this stage swsusp works properly. But my device is not in use. So resume
works properly.
Now i opened minicom terminal for ttyUSB0 and ttyS0 ( now my device is
in use ) and suspend my system. My system got suspended but did not get
resumed and showed the follwing messages on screen.
=20
usb 1-1: USB disconnect,address 4
usb 1-1: usb_disable_device nuking all URBs
usb 1-1: unregistering interface 1-1:1.0
rasmit 1-1:1.0 device disconnected
usb 1-1:1.0 : hot plug
=20
My device was connected to 1-1:1.0
The driver for usb-serial convertor does not have suspend/resume
functions.
Is it happening because of the driver does not handle suspend/resume or
for any other reason ?
=20
Please suggest.
=20
=20
Thanks and regards,
Rasmit.
=20

------------=_1137740544-1666-432
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006>hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>&nbsp;&nb=
sp;&nbsp;=20
In my system Linux-2.6.13.3 swsusp works properly.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>Now one u=
sb-serial=20
convertor device is attached to my system. I manually loaded the driver for=
 the=20
device and attached the device to my system.At this stage swsusp works prop=
erly.=20
But my device is not in use. So resume works properly.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>Now i ope=
ned minicom=20
terminal for ttyUSB0 and ttyS0 ( now my device is in use ) and suspend my=
=20
system. My system got suspended but did not get resumed and&nbsp;showed=20
the&nbsp;follwing messages on screen.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006><STRONG>u=
sb 1-1: USB=20
disconnect,address 4</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006><STRONG>u=
sb 1-1:=20
usb_disable_device nuking all URBs</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006><STRONG>u=
sb 1-1:=20
unregistering interface 1-1:1.0</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006><STRONG>r=
asmit=20
1-1:1.0 device disconnected</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006><STRONG>u=
sb 1-1:1.0=20
: hot plug</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006><STRONG></STRONG></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>My device=
 was=20
connected to 1-1:1.0</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>The drive=
r for=20
usb-serial convertor does not have suspend/resume functions.</SPAN></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>Is it hap=
pening=20
because of the driver does not handle suspend/resume or for any other reaso=
n=20
?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D074194806-20012006>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006>Rasmit.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D074194806-20012006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------------=_1137740544-1666-432--

--===============75653020962520068==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75653020962520068==--
