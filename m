From: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Subject: Method for Powering of device
Date: Tue, 13 Mar 2007 21:23:12 +0530
Message-ID: <200703131551.CHB14521@tataelxsi.co.in>
Reply-To: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1390560359=="
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

--===============1390560359==
Content-Type: multipart/alternative;
    boundary="----------=_1173801128-11548-331"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1173801128-11548-331
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

How do we power down a device. 

I detect the power off button pressed, which will be intimated to the
application.

I am confused on to what is the correct way of powering down the system.

As of now I thought of implementing as follows. 

The application sends an ioctl to a driver stub, which will call
pxa_pm_enter () function.

I see the pxa_pm_enter() is a static function. Is it the right way to make
it global and call it.

Can any one shed some light on the subject.

 

Regards,

Sridhar.


------------=_1173801128-11548-331
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
font-family:Garamond">How do we power down a device. <o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I detect the power off button pressed, which will be
intimated to the application.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I am confused on to what is the correct way of poweri=
ng
down the system.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">As of now I thought of implementing as follows. <o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">The application sends an ioctl to a driver stub, which
will call pxa_pm_enter () function.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">I see the pxa_pm_enter() is a static function. Is it =
the
right way to make it global and call it.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Can any one shed some light on the subject.<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DGaramond><span DEFANGED_style=3D=
"font-size:12.0pt;
font-family:Garamond">Sridhar.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------------=_1173801128-11548-331--

--===============1390560359==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1390560359==--
