From: <rasmit.ranjan@wipro.com>
Subject: ACPI problem with ACER Aspire 3003LC laptop.
Date: Fri, 2 Jun 2006 09:57:13 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201F0B3CB@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1811840380=="
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
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============1811840380==
Content-Type: multipart/alternative;
    boundary="----------=_1149222520-25170-121"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1149222520-25170-121
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
    I am using ACER Aspire 3003LC laptop for developing a Host
controller driver for kernel version 2.6.15.4.
If i enable Power management support then my ethernet interface doesnot
work. Also i get the message: " Disabling IRQ#3"
This message comes from the kernel. And also i get following messages
from ACPI:
=20
    ACPI-0508: *** Error: Method execution failed[\_SB_.BAT1._BST] (Node
cbd80560), AE_NOT_FOUND
    ACPI-0339: *** Error: Looking uo[Z007] in namespace, AE_NOT_FOUND
=20
I recompiled my kernel without power management support. Now my ethernet
is working properly and obviously i don`t get any message from ACPI.
This is the problem with the laptop. But I need Power management
support. so is there any patch available for this ? Please suggest.
=20
Thanks and regards,
Rasmit.
=20
=20

------------=_1149222520-25170-121
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>&nbsp;&nb=
sp;&nbsp; I=20
am using ACER Aspire 3003LC laptop for developing a Host controller driver =
for=20
kernel version 2.6.15.4.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>If i enab=
le Power=20
management support then my ethernet interface doesnot work. Also i get the=
=20
message: " Disabling IRQ#3"</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>This mess=
age comes=20
from the kernel. And also i get following messages from=20
ACPI:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D640580704-02062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>&nbsp;&nb=
sp;&nbsp;=20
ACPI-0508: *** Error: Method execution failed[\_SB_.BAT1._BST] (Node cbd805=
60),=20
AE_NOT_FOUND</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>&nbsp;&nb=
sp;&nbsp;=20
ACPI-0339: *** Error: Looking uo[Z007] in namespace,=20
AE_NOT_FOUND</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D640580704-02062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>I recompi=
led my=20
kernel without power management support. Now my ethernet is working properl=
y and=20
obviously i don`t get any message from ACPI. This is the problem with the=
=20
laptop. But I need Power management support. so is there any patch availabl=
e for=20
this ? Please suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D640580704-02062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D640580704-02062006>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D640580704-02062006>Rasmit.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D640580704-02062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D640580704-02062006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------------=_1149222520-25170-121--

--===============1811840380==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1811840380==--
