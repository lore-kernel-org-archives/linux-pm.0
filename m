From: <rasmit.ranjan@wipro.com>
Subject: Suspend to disk not working with PCMCIA card
Date: Wed, 21 Jun 2006 19:05:45 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2020F3518@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337926289=="
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

--===============0337926289==
Content-Type: multipart/alternative;
    boundary="----------=_1150896977-8398-390"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1150896977-8398-390
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
    I tried doing suspend to disk.It works properly.
I executed the following command with all prerequisite system
configuration.
=20
echo shutdown > /sys/power/disk
echo disk > /sys/power/state
=20
My laptop goes into suspended state.Then i press the power button and my
laptop resumed properly.
But this does not work while a PCMCIA card is plugged in. In the first
case my laptop does not go into suspended mode. My screen becomes blank
and LCD of the PCMCIA card remains on. To use my laptop i had to reboot
it. What might be the problem ?=20
Please suggest.
=20
Thanks,
Rasmit.

------------=_1150896977-8398-390
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>&nbsp;&nb=
sp;&nbsp; I=20
tried doing suspend to disk.It works properly.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>I&nbsp;ex=
ecuted the=20
following command&nbsp;with all prerequisite system=20
configuration.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D146302613-21062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>echo shut=
down &gt;=20
/sys/power/disk</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>echo disk=
 &gt;=20
/sys/power/state</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D146302613-21062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>My&nbsp;l=
aptop goes=20
into suspended state.Then i press the power button and my laptop resumed=20
properly.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>But this =
does not=20
work while a PCMCIA card is plugged in. In the first case my laptop does no=
t go=20
into suspended mode. My screen becomes blank and LCD of the PCMCIA card rem=
ains=20
on. To use my laptop i had to reboot it. What might be the problem ?=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D146302613-21062006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D146302613-21062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D146302613-21062006>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D146302613-21062006>Rasmit.</SPAN></FONT></DIV></DIV></BODY></HTML>

------------=_1150896977-8398-390--

--===============0337926289==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0337926289==--
