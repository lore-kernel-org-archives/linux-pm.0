From: <rasmit.ranjan@wipro.com>
Subject: Remote wake up not working
Date: Thu, 8 Jun 2006 17:51:32 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1397765560=="
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

--===============1397765560==
Content-Type: multipart/alternative;
    boundary="----------=_1149769319-21674-260"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1149769319-21674-260
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
    I am using ACER Aspire 3003LC laptop. Linux version: 2.6.15.4. I my
Host Controller supports Power Management.I tried selective
suspend/resume and it worked properly.Also my Host Controller supports
remote wake up. So i tried testing remote wake up.But it did not
work.Then i tried the same with the standard ( OHCI controller of my
laptop ).It did not work as wel.=20
Then i changed my laptop and tried testing remote wakeup and it worked
properly with the OHCI controller and also with my Host Controller.=20
=20
So does this mean that there is something wrong with the ACER Aspire
3003LC laptop ?=20
Or is there something on which remote wake up depends on besides the
Host Controller and the device ( supporting remote wake up ) ?
=20
Please suggest.
=20
Thanks,
Rasmit.

------------=_1149769319-21674-260
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
class=3D915422511-07062006>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D915422511-07062006>&nbsp;&nb=
sp;&nbsp; I=20
am using ACER Aspire 3003LC laptop. Linux version: 2.6.15.4. I my Host=20
Controller supports Power Management.I tried selective suspend/resume and i=
t=20
worked properly.Also m</SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D915422511-07062006>y Host Controller supports remote wake up. So i =
tried=20
testing remote wake up.But it did not work.</SPAN></FONT><FONT face=3DArial=
=20
size=3D2><SPAN class=3D915422511-07062006>Then i tried the same with the st=
andard (=20
OHCI controller of my laptop ).It did not work as wel.&nbsp;</SPAN></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D915422511-07062006>Then i ch=
anged my=20
laptop and tried testing remote wakeup and it worked properly with the OHCI=
=20
controller and also with my Host Controller. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D915422511-07062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D915422511-07062006>So does t=
his mean=20
that there is something wrong with the ACER Aspire 3003LC laptop ?=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D915422511-07062006>Or is the=
re=20
something on which remote wake up depends on besides the Host Controller an=
d the=20
device ( supporting remote wake up ) ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D915422511-07062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D915422511-07062006>Please=20
suggest.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D915422511-07062006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D915422511-07062006>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D915422511-07062006>Rasmit.</SPAN></FONT></DIV></BODY></HTML>

------------=_1149769319-21674-260--

--===============1397765560==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1397765560==--
