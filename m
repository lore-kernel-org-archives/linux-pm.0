From: Mike <zangetsudo@gmail.com>
Subject: Pressed the power button and then Hold for 2(or 3,
	less then 4) 	seconds to power off the system
Date: Mon, 13 Jul 2009 02:06:53 +0800
Message-ID: <b3f7b1ad0907121106h5796addk1bd2cb626aafda3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1708706347584052953=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.osdl.org, linux-pm-devel-request@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============1708706347584052953==
Content-Type: multipart/alternative; boundary=001636e911f703abd2046e8612e3

--001636e911f703abd2046e8612e3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all, i had read a lots of result in google with the key words "hold power
button linux",but found just a little useful info:



http://lkml.org/lkml/2008/9/18/121



When you push the power button, *the BIOS is invoked*. If you release

> within 4 seconds, the BIOS sends an ACPI event to the running OS,

> telling it that the power button has been pushed.


So i did know it is very default for me to implement this function for my
clients' requirements since i'm a newbie in acpi,

but i just want to konw is it possibly to implment this function describe by
the subject??



By the way, i had implement the common use of acpi on my  NOVA-ATOM board pc
with the power button by press it within 4s then the system is poweroff
cleanly.


sorry for my pool English...
Best Regards,Mike. +_+

--001636e911f703abd2046e8612e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-line-height-alt: 0pt=
; mso-pagination: widow-orphan" class=3D"MsoNormal" align=3D"left">
<p style=3D"TEXT-ALIGN: left; TEXT-INDENT: 54pt; MARGIN: 0cm 0cm 0pt 105pt;=
 mso-line-height-alt: 0pt; mso-pagination: widow-orphan" class=3D"MsoNormal=
" align=3D"left"><span style=3D"FONT-FAMILY: Arial; FONT-SIZE: 12pt; mso-fo=
nt-kerning: 0pt" lang=3D"EN-US"></span></p>
<span style=3D"FONT-FAMILY: =E5=AE=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-k=
erning: 0pt; mso-bidi-font-family: =E5=AE=8B=E4=BD=93" lang=3D"EN-US">Hi al=
l, i had read=C2=A0a lots of result in google with the key words &quot;hold=
 power button linux&quot;,but found just a little useful info:</span>
<p></p>
<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US">=C2=A0</span></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: Arial;=
 FONT-SIZE: 12pt; mso-font-kerning: 0pt" lang=3D"EN-US"><a href=3D"http://l=
kml.org/lkml/2008/9/18/121">http://lkml.org/lkml/2008/9/18/121</a></span><s=
pan style=3D"FONT-FAMILY: =E5=AE=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-ker=
ning: 0pt; mso-bidi-font-family: =E5=AE=8B=E4=BD=93" lang=3D"EN-US"></span>=
</p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US">=C2=A0</span></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-line-height-alt: 0pt=
; mso-pagination: widow-orphan" class=3D"MsoNormal" align=3D"left"><span st=
yle=3D"FONT-FAMILY: Arial; COLOR: red; FONT-SIZE: 12pt; mso-font-kerning: 0=
pt" lang=3D"EN-US">When you push the power button</span><span style=3D"FONT=
-FAMILY: Arial; COLOR: black; FONT-SIZE: 12pt; mso-font-kerning: 0pt" lang=
=3D"EN-US">, </span><b style=3D"mso-bidi-font-weight: normal"><span style=
=3D"FONT-FAMILY: Arial; COLOR: red; FONT-SIZE: 12pt; mso-font-kerning: 0pt"=
 lang=3D"EN-US">the BIOS is invoked</span></b><span style=3D"FONT-FAMILY: A=
rial; COLOR: black; FONT-SIZE: 12pt; mso-font-kerning: 0pt" lang=3D"EN-US">=
. If you release</span></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-line-height-alt: 0pt=
; mso-pagination: widow-orphan; tab-stops: 45.8pt 91.6pt 137.4pt 183.2pt 22=
9.0pt 274.8pt 320.6pt 366.4pt 412.2pt 458.0pt 503.8pt 549.6pt 595.4pt 641.2=
pt 687.0pt 732.8pt" class=3D"MsoNormal" align=3D"left">
<span style=3D"FONT-FAMILY: Arial; COLOR: black; FONT-SIZE: 12pt; mso-font-=
kerning: 0pt" lang=3D"EN-US">&gt; within 4 seconds, </span><span style=3D"F=
ONT-FAMILY: Arial; COLOR: blue; FONT-SIZE: 12pt; mso-font-kerning: 0pt" lan=
g=3D"EN-US">the BIOS sends an ACPI event to the running OS</span><span styl=
e=3D"FONT-FAMILY: Arial; COLOR: black; FONT-SIZE: 12pt; mso-font-kerning: 0=
pt" lang=3D"EN-US">,</span></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><font size=3D"3"><span style=3D"FO=
NT-FAMILY: Arial; COLOR: black" lang=3D"EN-US">&gt; telling it that the pow=
er button has been pushed.</span><span style=3D"FONT-FAMILY: =E5=AE=8B=E4=
=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family: =E5=
=AE=8B=E4=BD=93" lang=3D"EN-US"></span></font></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US"><br clear=3D"all">
So i did know it is very default for me to implement this function for my c=
lients&#39; requirements since i&#39;m a newbie in acpi,</span></p>
<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US">but i just want to konw is it possibly =
to implment this function describe by the=C2=A0subject??</span></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US">=C2=A0</span></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US">By the way, i had implement the common =
use of acpi on my=C2=A0</span><span style=3D"FONT-FAMILY: Arial; FONT-SIZE:=
 12pt; mso-font-kerning: 0pt" lang=3D"EN-US"> NOVA-ATOM board pc with the p=
ower button by press it within 4s then the system is poweroff cleanly.</spa=
n><span style=3D"FONT-FAMILY: =E5=AE=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font=
-kerning: 0pt; mso-bidi-font-family: =E5=AE=8B=E4=BD=93" lang=3D"EN-US"></s=
pan></p>

<p style=3D"TEXT-ALIGN: left; MARGIN: 0cm 0cm 0pt; mso-pagination: widow-or=
phan" class=3D"MsoNormal" align=3D"left"><span style=3D"FONT-FAMILY: =E5=AE=
=8B=E4=BD=93; FONT-SIZE: 12pt; mso-font-kerning: 0pt; mso-bidi-font-family:=
 =E5=AE=8B=E4=BD=93" lang=3D"EN-US"><br>
sorry for my pool English...<br>Best Regards,Mike. +_+ </span></p>
<p style=3D"MARGIN: 0cm 0cm 0pt; mso-line-height-alt: 0pt" class=3D"MsoNorm=
al"><span style=3D"FONT-FAMILY: Arial; FONT-SIZE: 12pt; mso-font-kerning: 0=
pt" lang=3D"EN-US">=C2=A0</span></p></p>

--001636e911f703abd2046e8612e3--

--===============1708706347584052953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1708706347584052953==--
