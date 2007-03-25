From: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Subject: [Linux-pm][standby mode - S0/D2/C4] Wake up sources in
	standby
Date: Sun, 25 Mar 2007 15:05:33 +0530
Message-ID: <200703250934.CHL31961@tataelxsi.co.in>
Reply-To: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0102412514=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============0102412514==
Content-Type: multipart/alternative;
    boundary="----------=_1174815279-4697-459"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1174815279-4697-459
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

 

I am facing a problem of wake up after entering the standby mode(S0/D2/C4)

In standby mode, my understanding is that, the processor is in state
retaining mode.

Most of the power domains are still powered on. 

The context need not be saved for retaining the state prior to entering
standby mode.

 

I have set up the wake up source as external wake up (power on/off switch).

But processor never wakes up once it is entered standby mode. Even it does
not respond to the JTAG debugger.

 

What is the normal wake up procedure for standby mode.

 

Is there any difference between Idle mode and standby mode.

 

Thanks and Regards,

Sridhar.


------------=_1174815279-4697-459
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html DEFANGED_xmlns:o=3D"urn:schemas-microsoft-com:office:office" DEFANGED=
_xmlns:w=3D"urn:schemas-microsoft-com:office:word" DEFANGED_xmlns=3D"http:/=
/www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Garamond;
	panose-1:2 2 4 4 3 3 1 1 8 3;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Garamond;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:1.0in 1.2in 1.0in 1.2in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I am facing a problem of wake up after entering the
standby mode(S0/D2/C4)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">In standby mode, my understanding is that, the proces=
sor
is in state retaining mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Most of the power domains are still powered on. <o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">The context need not be saved for retaining the state
prior to entering standby mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I have set up the wake up source as external wake up
(power on/off switch).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">But processor never wakes up once it is entered stand=
by
mode. Even it does not respond to the JTAG debugger.<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">What is the normal wake up procedure for standby mode=
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Is there any difference between Idle mode and standby
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Thanks and Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Sridhar.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------------=_1174815279-4697-459--

--===============0102412514==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0102412514==--
