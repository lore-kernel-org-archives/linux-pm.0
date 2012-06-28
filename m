From: "Zhang, QianFeng" <QianFeng.Zhang@amd.com>
Subject: a few questions about Runtime PM
Date: Thu, 28 Jun 2012 03:54:43 +0000
Message-ID: <4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3@SCYBEXDAG03.amd.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_000_4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3SCYBEXDAG03amdc_"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--_000_4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3SCYBEXDAG03amdc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

            I am looking through the IO device Runtime PM implementation on=
 Linux (Fedora 16).  There are some questions that
need you help to clarify for me,  here they are


1)       For those IO devices that could not be waked up through ACPI GPEs =
or native PCI Express PME ,  can  Runtime suspend/resume be used ?



2)       In  rtl8169's implementation of  Runtime suspend/resume, there is =
a  routine rtl8169_check_link_status(), which  always invokes
       pm_schedule_suspend() if the Link line is dis-connected,  pm_request=
_resume() if the Link line is connected.  And rtl8169_check_link_status
      itself is called through the transmit time out handler, which invokes=
 rtl8169_reset_task.     So rtl8169_check_link_status,  as an opportunity p=
oint
       for Runtime PM for its network interface ,  does not require any  wa=
ke-up signaling, right?   The only Hardware Level requirement for rtl1869_c=
heck_link_status
       to work in this way is  that  the  link status register can always b=
e read  no matter the network interface is in  off or on status.


3)      How should the Block IO adapter devices like the SCSI Controller or=
 FC Adapters  should do  Runtime PM ?   In my understand,  these
      Devices should be auto-suspended when there is no IO request pending =
for a predefined duration,  and they should be resumed when
     a new IO request issued by the block layer.  So these devices may use =
a different wake up method that has no dependency on  PCI Express PME or
     ACPI GPE.






n  Qianfeng Zhang









--_000_4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3SCYBEXDAG03amdc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:180172910;
	mso-list-type:hybrid;
	mso-list-template-ids:1916674764 1562297174 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:31.5pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:67.5pt;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:103.5pt;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:139.5pt;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:175.5pt;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:211.5pt;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:247.5pt;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:283.5pt;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:319.5pt;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:495654631;
	mso-list-type:hybrid;
	mso-list-template-ids:-1471886474 -1303220788 67698691 67698693 67698689 6=
7698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-start-at:3;
	mso-level-number-format:bullet;
	mso-level-text:\F06E;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:SimSun;
	mso-bidi-font-family:Calibri;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2
	{mso-list-id:747848732;
	mso-list-type:hybrid;
	mso-list-template-ids:1367406748 1875126936 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-start-at:3;
	mso-level-number-format:bullet;
	mso-level-text:\F06E;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:40.5pt;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:SimSun;
	mso-bidi-font-family:Calibri;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:76.5pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:112.5pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:148.5pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:184.5pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:220.5pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:256.5pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:292.5pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:328.5pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1958902857;
	mso-list-type:hybrid;
	mso-list-template-ids:-782236534 -179656716 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:49.5pt;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:85.5pt;
	text-indent:-.25in;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:121.5pt;
	text-indent:-9.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:157.5pt;
	text-indent:-.25in;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:193.5pt;
	text-indent:-.25in;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:229.5pt;
	text-indent:-9.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:265.5pt;
	text-indent:-.25in;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:301.5pt;
	text-indent:-.25in;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:337.5pt;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; I am looking through the IO device Runtime PM implementation=
 on Linux (Fedora 16).&nbsp; There are some questions that<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">need you help to clar=
ify for me,&nbsp; here they are<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:49.5pt;text-indent:-.25i=
n;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"mso-list:Ignore">1)<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>&nbsp;For those IO devices that could not be waked =
up through ACPI GPEs or native PCI Express PME ,&nbsp; can&nbsp; Runtime su=
spend/resume be used ?<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:49.5pt"><o:p>&nbsp;</o:p=
></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:49.5pt;text-indent:-.25i=
n;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"mso-list:Ignore">2)<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>&nbsp;In &nbsp;rtl8169&#8217;s implementation of&nb=
sp; Runtime suspend/resume, there is a&nbsp; routine rtl8169_check_link_sta=
tus(), which&nbsp; always invokes&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;pm_schedule_suspend() if the Link line is dis-connected,=
&nbsp; pm_request_resume() if the Link line is connected. &nbsp;And rtl8169=
_check_link_status<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;itself is called through the transmit time out handler, which =
invokes rtl8169_reset_task. &nbsp;&nbsp;&nbsp; So rtl8169_check_link_status=
, &nbsp;as an opportunity point<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;for Runtime PM for its network interface , &nbsp;does not req=
uire any&nbsp; wake-up signaling, right?&nbsp;&nbsp; The only Hardware Leve=
l requirement for rtl1869_check_link_status<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;to work in this way is&nbsp; that&nbsp; the&nbsp; link status=
 register can always be read &nbsp;no matter the network interface is in &n=
bsp;off or on status. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:49.5pt;text-indent:-.25i=
n;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"mso-list:Ignore">3)<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>How should the Block IO adapter devices like the SC=
SI Controller or FC Adapters&nbsp; should do&nbsp; Runtime PM ?&nbsp;&nbsp;=
 In my understand,&nbsp; these<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;Devices should be auto-suspended when there is no IO request pendin=
g for a predefined duration,&nbsp; and they should be resumed when<o:p></o:=
p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp; &nbs=
p;a new IO request issued by the block layer.&nbsp; So these devices may us=
e a different wake up method that has no dependency on&nbsp; PCI Express PM=
E or
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;ACPI GPE. &nbsp;&nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:31.5pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:40.5pt;text-indent:-.25i=
n;mso-list:l2 level1 lfo4">
<![if !supportLists]><span style=3D"font-family:Wingdings"><span style=3D"m=
so-list:Ignore">n<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nb=
sp;
</span></span></span><![endif]>Qianfeng Zhang <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3SCYBEXDAG03amdc_--
