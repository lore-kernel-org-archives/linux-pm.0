From: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Subject: :How do I move the system to idle mode
Date: Sat, 10 Mar 2007 17:25:22 +0530
Message-ID: <200703101154.CGX93234@tataelxsi.co.in>
Reply-To: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1270080870=="
Return-path: <linux-pm-bounces@lists.osdl.org>
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

--===============1270080870==
Content-Type: multipart/alternative;
    boundary="----------=_1173527708-27327-292"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1173527708-27327-292
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

HI,

 

I am working on optimizing the power consumption on the system.

 

I need to detect when the system is idle and move it to standby state.

 

And when there is an interrupt, it needs to be brought back to run state.

 

I have an application which is waiting on a message. When it gets idle
message, it needs to move the system to idle state.

 

I have two questions:

1. How do we detect the idle mode.

2. Can I call the acpi_suspend() function from my driver to move the system
to different states. If not what is the preferred way.

 

Sridhar.

 


------------=_1173527708-27327-292
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
	{mso-style-type:personal;
	font-family:Garamond;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Garamond;
	color:navy;
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
font-family:Garamond">HI,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I am working on optimizing the power consumption on t=
he
system.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I need to detect when the system is idle and move it =
to
standby state.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">And when there is an interrupt, it needs to be brought
back to run state.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I have an application which is waiting on a message. =
When
it gets idle message, it needs to move the system to idle state.<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I have two questions:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">1. How do we detect the idle mode.<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">2. Can I call the acpi_suspend() function from my dri=
ver
to move the system to different states. If not what is the preferred way.<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Sridhar.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------------=_1173527708-27327-292--

--===============1270080870==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1270080870==--
