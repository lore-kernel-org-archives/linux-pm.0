From: Divneil Rai WADHAWAN <divneil.wadhawan@st.com>
Subject: Linux power managment for loadable kernel modules
Date: Tue, 27 Jul 2010 12:31:46 +0800
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661165B63D378@EAPEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7403700244601434568=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
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
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============7403700244601434568==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2CC2A0A4A178534D93D5159BF3BCB661165B63D378EAPEX1MAIL1st_"

--_000_2CC2A0A4A178534D93D5159BF3BCB661165B63D378EAPEX1MAIL1st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have started the work on Linux power management, and want to hook my load=
able kernel modules to power management core of kernel.
So, as a beginning point I have gone through the Linux Symposium section of=
 Power management and gone through the code.
I am using kernel 2.6.23.17 at present.

Can you please confirm is the below method to use the device_suspend functi=
onality from kernel correct?
I am using the TTY as an example here.

tty_class =3D class_create(THIS_MODULE, "tty");
struct device *dev=3D device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0)=
, "tty");
dev->class->suspend=3Dmy_suspend_method;
dev->class->resume =3Dmy_resume_method;

Is there any other way for doing that?
If you feel that this question is redundant, please let me know of the earl=
ier post.

Thanks and regards,
Divneil


--_000_2CC2A0A4A178534D93D5159BF3BCB661165B63D378EAPEX1MAIL1st_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

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
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
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

<div class=3DWordSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have started the work on Linux power management, and=
 want
to hook my loadable kernel modules to power management core of kernel.<o:p>=
</o:p></p>

<p class=3DMsoNormal>So, as a beginning point I have gone through the Linux
Symposium section of Power management and gone through the code.<o:p></o:p>=
</p>

<p class=3DMsoNormal>I am using kernel 2.6.23.17 at present.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Can you please confirm is the below method to use the
device_suspend functionality from kernel correct?<o:p></o:p></p>

<p class=3DMsoNormal>I am using the TTY as an example here.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>tty_class =3D class_create(THIS_MODULE, &quot;tty&quot=
;);<o:p></o:p></p>

<p class=3DMsoNormal>struct device *dev=3D device_create(tty_class, NULL,
MKDEV(TTYAUX_MAJOR, 0), &quot;tty&quot;);<o:p></o:p></p>

<p class=3DMsoNormal>dev-&gt;class-&gt;suspend=3Dmy_suspend_method;<o:p></o=
:p></p>

<p class=3DMsoNormal>dev-&gt;class-&gt;resume =3Dmy_resume_method;<o:p></o:=
p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is there any other way for doing that?<o:p></o:p></p>

<p class=3DMsoNormal>If you feel that this question is redundant, please le=
t me
know of the earlier post.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks and regards,<o:p></o:p></p>

<p class=3DMsoNormal>Divneil<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_2CC2A0A4A178534D93D5159BF3BCB661165B63D378EAPEX1MAIL1st_--

--===============7403700244601434568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7403700244601434568==--
