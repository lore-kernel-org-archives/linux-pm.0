From: <rasmit.ranjan@wipro.com>
Subject: suspend/resume of pcmcia
Date: Tue, 28 Feb 2006 16:44:04 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2016FF52A@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27925939901172736=="
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

--===============27925939901172736==
Content-Type: multipart/alternative;
    boundary="----------=_1141125302-9742-105"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1141125302-9742-105
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
    For pci based host controller when we do global suspend it is the PM
sub-system which takes care of the sequence of suspend i.e. PM traverses
the device tree and suspends the child devices first and subsequently
suspends the controller.
I have a pcmcia based host controller what i mean is i have a pcmcia
card which has a usb host controller. Now two things come to picture.
One is the client driver and other is the HCD. The client driver
receives a suspend event when i suspend the card by pccardctl suspend.
In this case ther is no mechanism provided to communicate to the HCD
about the suspned which has to handled by the user i.e. the client
driver and hcd. Now if i do global suspend, is it the PM sub-system
which takes care of the suspend sequence ? Here what i mean is PM will
traverse the device tree, it suspends the child devices, then it
suspends the controller and finally sends the suspend event to the
client driver or only the suspend event is sent to the client driver
with out suspendung the controller.=20
        In case of resume, when i resume the card by pccardctl resume (
not global ), only the resume event of the client driver is getting
called thats all. So here again the user has to take care of resuming
the hcd. So for the global resume does PM sub-system take care of
sending the resume event to the client driver and as well as resuming
the controller ?
=20
Please suggest.
=20
Thanks and regards,
Rasmit.

------------=_1141125302-9742-105
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
class=3D874174110-28022006>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D874174110-28022006>&nbsp;&nb=
sp;&nbsp;=20
For pci based host controller when we do global suspend it is the PM sub-sy=
stem=20
which takes care of the sequence of suspend i.e. PM traverses the device tr=
ee=20
and suspends the child devices first and subsequently suspends the=20
controller.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D874174110-28022006>I&nbsp;ha=
ve a pcmcia=20
based host controller what i mean is i have a pcmcia card which has a usb h=
ost=20
controller. Now two things come to picture. One is the client driver and ot=
her=20
is the HCD. The client driver receives a suspend event when i suspend the c=
ard=20
by pccardctl suspend. In this case ther is no mechanism provided to communi=
cate=20
to the HCD about the suspned which has to handled by the user i.e. the clie=
nt=20
driver and hcd. Now if i do global suspend, is it the PM sub-system which t=
akes=20
care of the suspend sequence ? Here what i mean is PM will traverse the dev=
ice=20
tree, it suspends the child devices, then it suspends the controller and fi=
nally=20
sends the suspend event to the client driver or only the suspend&nbsp;event=
 is=20
sent to the client driver with out suspendung the controller.=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D874174110-28022006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In ca=
se of=20
resume, when i resume the card by pccardctl resume ( not global ), only the=
=20
resume event of the client driver is getting called thats all. So here agai=
n the=20
user has to take care of resuming the hcd. So for the global resume does PM=
=20
sub-system take care of sending the resume event to the client driver and a=
s=20
well as resuming the controller ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D874174110-28022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D874174110-28022006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D874174110-28022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D874174110-28022006>Thanks an=
d=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D874174110-28022006>Rasmit.</SPAN></FONT></DIV></BODY></HTML>

------------=_1141125302-9742-105--

--===============27925939901172736==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27925939901172736==--
