From: <purusothaman.ramajothi@wipro.com>
Subject: Need Help to debug resume hangs at schedule() function
Date: Mon, 2 May 2011 19:22:27 +0530
Message-ID: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1624284097292497773=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--===============1624284097292497773==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC08D0.2C7F8FEC"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC08D0.2C7F8FEC
Content-Type: text/plain;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

Hi,

 

                I am using 2.6.27.18 kernel.My machine is powerpc
architecture.I executed the deep sleep operation by executing the
following command:

 

"echo mem > /sys/power/state"

 

The suspend opeartion was successful.All the devices and user level
threads are suspended.

 

But sometimes during resume my machine hangs.This is not happening
regularly.But it occurs after 60 or 70 times of deep sleep operation.So
for debugging this I have added checkpoints in the flow of deep
check.When this issue was produced the kernel hangs around "thaw_tasks"
or "schedule" function of "thaw_processes".These functions are defined
in "kernel/power/process.c".

 

Note: The final printk message "Restarting tasks.....done" was not
displayed when this issue occurred.But all the devices and drivers
resumed back.

 

I was not able to debug this as the reproduciablity rate was too
low.Kindly help me in solving the issue.

 

Regards,

Purusothaman R

 


Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

------_=_NextPart_001_01CC08D0.2C7F8FEC
Content-Type: text/html;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micro=
soft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" xm=
lns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://w=
ww.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I
am using 2.6.27.18 kernel.My machine is powerpc architecture.I executed the
deep sleep operation by executing the following command:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&#8220;echo mem &gt; /sys/power/state&#8221;<o:p></o:p>=
</p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The suspend opeartion was successful.All the devices an=
d
user level threads are suspended.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>But sometimes during resume my machine hangs.This is no=
t
happening regularly.But it occurs after 60 or 70 times of deep sleep
operation.So for debugging this I have added checkpoints in the flow of deep
check.When this issue was produced the kernel hangs around &#8220;thaw_tasks=
&#8221;
or &#8220;schedule&#8221; function of &#8220;thaw_processes&#8221;.These
functions are defined in &#8220;kernel/power/process.c&#8221;.<o:p></o:p></p=
>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Note: The final printk message &#8220;Restarting
tasks.....done&#8221; was not displayed when this issue occurred.But all the
devices and drivers resumed back.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I was not able to debug this as the reproduciablity rat=
e was
too low.Kindly help me in solving the issue.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal>Purusothaman R<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<P><strong><span style=3D'font-size:10.0pt;font-family:=0A=
"Palatino Linotype","serif";color:green'> Please do not print this email unl=
ess it is absolutely necessary. </span></strong><span style=3D'font-family:"=
Arial","sans-serif"'><o:p></o:p></span></p>=0A=
=0A=
=0A=
<p> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies of=
 this message and any attachments. </p>=0A=
=0A=
<p>WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The co=
mpany accepts no liability for any damage caused by any virus transmitted by=
 this email. </p>=0A=
<p>=0A=
www.wipro.com=0A=
</p>
</body>

</html>

------_=_NextPart_001_01CC08D0.2C7F8FEC--

--===============1624284097292497773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1624284097292497773==--
