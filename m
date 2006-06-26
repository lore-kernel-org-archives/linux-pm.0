From: <rasmit.ranjan@wipro.com>
Subject: How to differentiate between selective suspend and
	global suspend
Date: Mon, 26 Jun 2006 10:33:48 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20214DC0B@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0350233723=="
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

--===============0350233723==
Content-Type: multipart/alternative;
    boundary="----------=_1151298255-32751-781"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1151298255-32751-781
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
    I have implemented bus_suspend entry point of hc_driver of my OHCI
complaint host controller. This entry point is called when i do
selective roothub interface suspend as well as when i do global suspend
( suspend to disk ). So is there any way to differentiate between
selective suspend of roothub interface and global suspend ( suspend to
disk ) for both of which my bus_suspend entry point is getting called ?
Please suggest.
=20
Thanks and regards,
Rasmit.

------------=_1151298255-32751-781
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D749185804-26062006>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D749185804-26062006>&nbsp;&nb=
sp;&nbsp; I=20
have implemented bus_suspend entry point of hc_driver of my OHCI complaint =
host=20
controller. This entry point is called when i do selective roothub interfac=
e=20
suspend as well as when i do global suspend ( suspend to disk ). So is ther=
e any=20
way to differentiate between selective suspend of roothub interface and glo=
bal=20
suspend ( suspend to disk ) for both of which my bus_suspend entry point is=
=20
getting called ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D749185804-26062006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D749185804-26062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D749185804-26062006>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D749185804-26062006>Rasmit.</SPAN></FONT></DIV></BODY></HTML>

------------=_1151298255-32751-781--

--===============0350233723==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0350233723==--
