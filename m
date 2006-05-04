From: <rasmit.ranjan@wipro.com>
Subject: Using memcpy() in kernel space( driver)
Date: Thu, 4 May 2006 11:35:13 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201CCBC72@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77742710916984592=="
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
To: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, linux-kernel-digest@lists.us.dell.com
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============77742710916984592==
Content-Type: multipart/alternative;
    boundary="----------=_1146722777-27044-533"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1146722777-27044-533
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
    I am using memcpy() in my driver.
I am taking a spinlock and calling this function memcpy().
Is it safe to call memcpy() inside a lock?
If memcpy() fails, then will it create any problem in releasing the
spinlock ?
Please suggest.
=20
Thanks and regards,
Rasmit.
=20

------------=_1146722777-27044-533
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>&nbsp;&nb=
sp;&nbsp; I=20
am using memcpy() in my driver.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>I am taki=
ng a=20
spinlock and calling this function memcpy().</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>Is it saf=
e to call=20
memcpy() inside a lock?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>If memcpy=
() fails,=20
then will it create any problem in releasing the spinlock ?</SPAN></FONT></=
DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D424254305-04052006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D424254305-04052006>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D424254305-04052006>Rasmit.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D424254305-04052006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------------=_1146722777-27044-533--

--===============77742710916984592==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77742710916984592==--
