From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Question about hibernation
Date: Fri, 18 Mar 2011 19:15:24 +0530
Message-ID: <SNT117-W3213A3C4E358A6A690C09BEBB00@phx.gbl>
References: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>
	<201101050005.42914.rjw@sisk.pl>
	<BLU102-W11E15CD0A639C1DE2097CAEB080@phx.gbl>,
	<201101050927.53977.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1479390644609038224=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101050927.53977.rjw@sisk.pl>
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

--===============1479390644609038224==
Content-Type: multipart/alternative;
	boundary="_4a65a21c-020a-43a3-94de-282c8e4fe9b1_"

--_4a65a21c-020a-43a3-94de-282c8e4fe9b1_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi=2C

I have following question regarding the hibernation. If a device driver use=
s dedicated memory (dedicated memory in linux which is not OS addressable e=
.g. device driver is using some pages from dedicated memory)=2C When the sy=
stem hibernates=2C will this be responsibility of device driver to save thi=
s area=20
or=20
OS hibernation procedure save this area of ram (dedicated memory area) into=
 swap image?

Thanks
Raj =20
 		 	   		  =

--_4a65a21c-020a-43a3-94de-282c8e4fe9b1_
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
<br>Hi=2C<br><br>I have following question regarding the hibernation. If a =
device driver uses dedicated memory (dedicated memory in linux which is not=
 OS addressable e.g. device driver is using some pages from dedicated memor=
y)=2C When the system hibernates=2C will this be responsibility of device d=
river to save this area <br>or <br>OS hibernation procedure save this area =
of ram (dedicated memory area) into swap image?<br><br>Thanks<br>Raj&nbsp=
=3B <br> 		 	   		  </body>
</html>=

--_4a65a21c-020a-43a3-94de-282c8e4fe9b1_--

--===============1479390644609038224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1479390644609038224==--
