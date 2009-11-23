From: "edwin.rong" <edwin.rong@infomax.com.tw>
Subject: =?gb2312?b?tPC4tDogIHdha2V1cCB3YWtlbG9jayBpc3N1ZXM=?=
Date: Mon, 23 Nov 2009 09:25:03 +0800
Message-ID: <22390.2850797915$1258939472@news.gmane.org>
References: <8bf247760911210837y3f089eaegd57fcec21d93681b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7939807734117544547=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8bf247760911210837y3f089eaegd57fcec21d93681b@mail.gmail.com>
Content-Language: zh-cn
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
To: 'Sriram V' <vshrirama@gmail.com>, android-porting@googlegroups.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

UbJGR;7b MIME 8qJ=5D6`2?7VSJ<~!#

--===============7939807734117544547==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0027_01CA6C1E.D9A15C90"
Content-Language: zh-cn

UbJGR;7b MIME 8qJ=5D6`2?7VSJ<~!#

------=_NextPart_000_0027_01CA6C1E.D9A15C90
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Sriram,

=20

>From the log, the system doesn=A1=AFt enter suspend state actually, namely,
during the suspend process, it encounters some errors, which make your
system execute resume operations,  in your case,=20

Maybe iva2_pwrdm and core_pwrdm drivers reject to =A1=B0sleep=A1=B1, also a=
dding
=A1=B0no_console_suspend=A1=B1 option in bootargs may make the console prin=
t more
message.

To check whether your drivers are implemented properly for PM, you can try
following commands in order:

=20

Prepare the testing to your drivers:

Echo core > /sys/power/pm_test

Enter the testing:

Echo mem > /sys/power/state

Terminate the testing:

Echo on > /sys/power/state

=20

This will test the freezing of processer, suspending of devices, platform
global control methods

The disabling of nonboot CPUs and suspending of platform/system devices.

=20

For more details, please refer to:

http://lxr.linux.no/#linux+v2.6.31/Documentation/power/basic-pm-debugging.tx
t

=20

=20

BRs

Edwin

=20

=20

=B7=A2=BC=FE=C8=CB: linux-pm-bounces@lists.linux-foundation.org
[mailto:linux-pm-bounces@lists.linux-foundation.org] =B4=FA=B1=ED Sriram V
=B7=A2=CB=CD=CA=B1=BC=E4: 2009=C4=EA11=D4=C222=C8=D5 0:38
=CA=D5=BC=FE=C8=CB: android-porting@googlegroups.com
=B3=AD=CB=CD: linux-pm@lists.linux-foundation.org
=D6=F7=CC=E2: [linux-pm] wakeup wakelock issues

=20

Hi,
  I am trying to test pm on a custom board with android.

  Whats happening:
   1) Android is putting the system to sleep - calling system wide suspend
   2) During suspend, kernel resume immediately - I get "wakeup wake lock:
omap-8250-serial". and again puts it back to suspend.
   3) This keeps happening, There is no serial activity except for printing
the messages (transmission from the board) - No serial inputs from the host
pc.
   4) Is there any way to disable this?
=20=20=20

Regards,
sriram



# PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
Powerdomain (iva2_pwrdm) didn't enter target state 1
Powerdomain (core_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
wakeup wake lock: omap-8250-serial
usb 1-2: reset high speed USB device using ehci-omap and address 2
Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
done.
suspend: exit suspend, ret =3D 0 (2000-01-01 03:42:06.047454761 UTC)
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
Powerdomain (iva2_pwrdm) didn't enter target state 1
Powerdomain (core_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
wakeup wake lock: omap-8250-serial
usb 1-2: reset high speed USB device using ehci-omap and address 2
Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
done.
suspend: exit suspend, ret =3D 0 (2000-01-01 03:42:16.157318042 UTC)
PM: Syncing filesystems ... done.

No virus found in this incoming message.
Checked by AVG - www.avg.com
Version: 8.5.425 / Virus Database: 270.14.77/2520 - Release Date: 11/22/09
19:40:00


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CONFIDENTIALITY NOTE:
This e-mail and any attachments may contain confidential information and may
be protected by legal privilege. If you are not the intended addressee (or=
=20
authorized to receive for the addressee), be aware that any disclosure,
copying, distribution or use of this e-mail or any attachment is prohibited.
If you have received this e-mail in error, please notify us immediately by
returning it to the sender and delete this copy from your system. Thank you
for your cooperation.
Infomax Communication Co., Ltd.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


------=_NextPart_000_0027_01CA6C1E.D9A15C90
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dgb2312">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>

<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Hi Sriram,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>From the log, the system doesn=A1=
=AFt enter
suspend state actually, namely, during the suspend process, it encounters s=
ome
errors, which make your system execute resume operations, &nbsp;in your cas=
e, <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Maybe <b>iva2_pwrdm</b> and <b>core=
_pwrdm</b>
drivers reject to =A1=B0sleep=A1=B1, also adding =A1=B0no_console_suspend=
=A1=B1 option in bootargs
may make the console print more message.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>To check whether your drivers are
implemented properly for PM, you can try following commands in order:<o:p><=
/o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><b><span lang=3DEN-US>Prepare the testing to your driv=
ers:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><span lang=3DEN-US>Echo core &gt; /sys/power/pm_test<o=
:p></o:p></span></p>

<p class=3DMsoNormal><b><span lang=3DEN-US>Enter the testing:<o:p></o:p></s=
pan></b></p>

<p class=3DMsoNormal><span lang=3DEN-US>Echo mem &gt; /sys/power/state<o:p>=
</o:p></span></p>

<p class=3DMsoNormal><b><span lang=3DEN-US>Terminate the testing:<o:p></o:p=
></span></b></p>

<p class=3DMsoNormal><span lang=3DEN-US>Echo on &gt; /sys/power/state<o:p><=
/o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>This will test the freezing of proc=
esser,
suspending of devices, platform global control methods<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>The disabling of nonboot CPUs and
suspending of platform/system devices.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>For more details, please refer to:<=
o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><a
href=3D"http://lxr.linux.no/#linux+v2.6.31/Documentation/power/basic-pm-deb=
ugging.txt">http://lxr.linux.no/#linux+v2.6.31/Documentation/power/basic-pm=
-debugging.txt</a><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>BRs<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Edwin<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-fami=
ly:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-fami=
ly:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:SimSun'=
>=B7=A2=BC=FE=C8=CB<span
lang=3DEN-US>:</span></span></b><span lang=3DEN-US style=3D'font-size:10.0p=
t;
font-family:SimSun'> linux-pm-bounces@lists.linux-foundation.org
[mailto:linux-pm-bounces@lists.linux-foundation.org] </span><b><span
style=3D'font-size:10.0pt;font-family:SimSun'>=B4=FA=B1=ED </span></b><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:SimSun'>Sriram V<br>
</span><b><span style=3D'font-size:10.0pt;font-family:SimSun'>=B7=A2=CB=CD=
=CA=B1=BC=E4<span
lang=3DEN-US>:</span></span></b><span lang=3DEN-US style=3D'font-size:10.0p=
t;
font-family:SimSun'> 2009</span><span style=3D'font-size:10.0pt;font-family=
:SimSun'>=C4=EA<span
lang=3DEN-US>11</span>=D4=C2<span lang=3DEN-US>22</span>=C8=D5<span lang=3D=
EN-US>
0:38<br>
</span><b>=CA=D5=BC=FE=C8=CB<span lang=3DEN-US>:</span></b><span
lang=3DEN-US> android-porting@googlegroups.com<br>
</span><b>=B3=AD=CB=CD<span lang=3DEN-US>:</span></b><span lang=3DEN-US>
linux-pm@lists.linux-foundation.org<br>
</span><b>=D6=F7=CC=E2<span lang=3DEN-US>:</span></b><span lang=3DEN-US>
[linux-pm] wakeup wakelock issues<o:p></o:p></span></span></p>

</div>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span lang=3DEN-US>Hi,<=
br>
&nbsp; I am trying to test pm on a custom board with android.<br>
<br>
&nbsp; Whats happening:<br>
&nbsp;&nbsp; 1) Android is putting the system to sleep - calling system wide
suspend<br>
&nbsp;&nbsp; 2) During suspend, kernel resume immediately - I get &quot;wak=
eup
wake lock: omap-8250-serial&quot;. and again puts it back to suspend.<b><br>
&nbsp;&nbsp; </b>3) This keeps happening, There is no serial activity except
for printing the messages (transmission from the board) - No serial inputs =
from
the host pc.<br>
&nbsp;&nbsp; 4) Is there any way to disable this?<br>
&nbsp;&nbsp; <br>
<br>
Regards,<br>
sriram<br>
<br>
<br>
<br>
# PM: Syncing filesystems ... done.<br>
Freezing user space processes ... (elapsed 0.01 seconds) done.<br>
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.<br>
Suspending console(s) (use no_console_suspend to debug)<br>
Powerdomain (iva2_pwrdm) didn't enter target state 1<br>
Powerdomain (core_pwrdm) didn't enter target state 1<br>
Could not enter target state in pm_suspend<br>
<b>wakeup wake lock: omap-8250-serial</b><br>
usb 1-2: reset high speed USB device using ehci-omap and address 2<br>
Restarting tasks ... &lt;7&gt;hub 1-0:1.0: state 7 ports 3 chg 0004 evt 000=
0<br>
done.<br>
suspend: exit suspend, ret =3D 0 (2000-01-01 03:42:06.047454761 UTC)<br>
PM: Syncing filesystems ... done.<br>
Freezing user space processes ... (elapsed 0.00 seconds) done.<br>
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.<br>
Suspending console(s) (use no_console_suspend to debug)<br>
Powerdomain (iva2_pwrdm) didn't enter target state 1<br>
Powerdomain (core_pwrdm) didn't enter target state 1<br>
Could not enter target state in pm_suspend<br>
wakeup wake lock: omap-8250-serial<br>
usb 1-2: reset high speed USB device using ehci-omap and address 2<br>
Restarting tasks ... &lt;7&gt;hub 1-0:1.0: state 7 ports 3 chg 0004 evt 000=
0<br>
done.<br>
suspend: exit suspend, ret =3D 0 (2000-01-01 03:42:16.157318042 UTC)<br>
PM: Syncing filesystems ... done.<o:p></o:p></span></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:SimSun'>No viru=
s found
in this incoming message.<br>
Checked by AVG - www.avg.com<br>
Version: 8.5.425 / Virus Database: 270.14.77/2520 - Release Date: 11/22/09
19:40:00</span><span lang=3DEN-US><o:p></o:p></span></p>

</div>

</body>

<br />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<br />CONFIDENTIALITY NOTE:
<br />This e-mail and any attachments may contain confidential information =
and may
<br />be protected by legal privilege. If you are not the intended addresse=
e (or
<br />authorized to receive for the addressee), be aware that any disclosur=
e,
<br />copying, distribution or use of this e-mail or any attachment is proh=
ibited.
<br />If you have received this e-mail in error, please notify us immediate=
ly by
<br />returning it to the sender and delete this copy from your system. Tha=
nk you
<br />for your cooperation.
<br />Infomax Communication Co., Ltd.
<br />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<br />--=20
<br />This message has been scanned for viruses and
<br />dangerous content by
<a href=3D"http://www.mailscanner.info/"><b>MailScanner</b></a>, and is
<br />believed to be clean.
</html>

------=_NextPart_000_0027_01CA6C1E.D9A15C90--


--===============7939807734117544547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7939807734117544547==--
