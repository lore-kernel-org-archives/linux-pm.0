From: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Subject: Power event notification patch
Date: Thu, 5 Jul 2007 17:31:33 +0530
Message-ID: <67670A5CEA5C374B8E7B16D7DC55F953012473FF@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5325123266864555966=="
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

--===============5325123266864555966==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7BEFC.3AFBA81D"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7BEFC.3AFBA81D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Folks,

=20

Here is a simple patch for power event notification to user-space
applications. Basically, what it does is notify the user-space
applications that the system is going to a low power state
(Suspend-to-RAM and Suspend-to-Disk) and resume from that state. This is
useful for the user-space applications to do some significant action
when the system goes to the low power state (like saving an unsaved
file). The user-space objects can form a netlink socket and listen to
these events. It is done through a kobject-netlink socket. For this I
have used the kobject_uevent system call, posting the notification to
user space with standby, hibernate and resume in the action parameter of
the kobject_uevent call (mapped to KOBJ_S3, KOBJ_S4 and KOBJ_RESUME
enums). Appreciate your comments on the patch.

=20

Thanks,

Sankara Narayanan V.

=20


------_=_NextPart_001_01C7BEFC.3AFBA81D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Book Antiqua";
	panose-1:2 4 6 2 5 3 5 3 3 4;}
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
	{color:blue;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Book Antiqua";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'>Hi =
Folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'>Here is a simple patch for power =
event
notification to user-space applications. Basically, what it does is =
notify the user-space
applications that the system is going to a low power state =
(Suspend-to-RAM and
Suspend-to-Disk) and resume from that state. This is useful for the =
user-space
applications to do some significant action when the system goes to the =
low
power state (like saving an unsaved file). The user-space objects can =
form a
netlink socket and listen to these events. It is done through a =
kobject-netlink
socket. For this I have used the kobject_uevent system call, posting the
notification to user space with standby, hibernate and resume in the =
<b><span
style=3D'font-weight:bold'>action </span></b>parameter of the =
kobject_uevent call
(mapped to KOBJ_S3, KOBJ_S4 and KOBJ_RESUME enums). Appreciate your =
comments on
the patch.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><em><b><i><font size=3D3 color=3D"#0099cc" =
face=3D"Book Antiqua"><span
style=3D'font-size:12.0pt;font-family:"Book =
Antiqua";color:#0099CC;font-weight:
bold'>Thanks,</span></font></i></b></em><font color=3D"#0099cc"><span
style=3D'color:#0099CC'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><em><b><i><font size=3D3 color=3D"#0099cc" =
face=3D"Book Antiqua"><span
style=3D'font-size:12.0pt;font-family:"Book =
Antiqua";color:#0099CC;font-weight:
bold'>Sankara Narayanan V.</span></font></i></b></em><font =
color=3D"#0099cc"><span
style=3D'color:#0099CC'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7BEFC.3AFBA81D--

--===============5325123266864555966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5325123266864555966==--
