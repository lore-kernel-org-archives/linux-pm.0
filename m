From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Question about hibernation
Date: Wed, 6 Oct 2010 03:10:31 +0530
Message-ID: <BLU102-W27AEE84EC4B31E9F85FF13EB6D0@phx.gbl>
References: <BLU102-W1030ED196ED7B94722F2A7EB830@phx.gbl>,
	<Pine.LNX.4.44L0.1008241029000.1652-100000@iolanthe.rowland.org>,
	<BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>,
	<BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>,
	<BLU102-W283ED7848BB0495FBACF0BEB850@phx.gbl>,
	<BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0592598620318705088=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
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
To: stern@rowland.harvard.edu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============0592598620318705088==
Content-Type: multipart/alternative;
	boundary="_1ffd2ccb-6026-439d-b69d-b29557c5d1cb_"

--_1ffd2ccb-6026-439d-b69d-b29557c5d1cb_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20
Hi Alan=2C
=20
I have question regarding the hibernation mode in linux.=20
=20
1) In normal suspend to ram=2C is freezing of tasks necessary while suspend=
 to ram in current linux power management core?
2) In hibernation mode=2C is freezing of tasks done before normal suspend/r=
esumes in order to that hibernation image is in sync?
=20
My issue is because it might be possible that there is some part of device =
driver which is user space and another part is kernel space
then in suspend to ram and hibernation mode is freezing of all user space p=
art is done before kernel side or it differs while
suspend to ram and hibernation mode?
=20
Regards
Raj
  		 	   		  =

--_1ffd2ccb-6026-439d-b69d-b29557c5d1cb_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
&nbsp=3B<BR>
Hi Alan=2C<BR>
&nbsp=3B<BR>
I have question regarding the hibernation mode in linux. <BR>
&nbsp=3B<BR>
1) In normal suspend to ram=2C is freezing of tasks necessary while suspend=
 to ram in current linux power management core?<BR>
2) In hibernation mode=2C is freezing of tasks done before normal suspend/r=
esumes in order to that hibernation image is in sync?<BR>
&nbsp=3B<BR>
My issue is because it might be possible that there is some part of device =
driver which is user space and another part is kernel space<BR>
then in suspend to ram and hibernation mode is freezing of all user space p=
art is done before kernel side or it differs while<BR>
suspend to ram and hibernation mode?<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_1ffd2ccb-6026-439d-b69d-b29557c5d1cb_--

--===============0592598620318705088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0592598620318705088==--
