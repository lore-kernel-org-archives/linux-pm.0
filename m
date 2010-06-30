From: Raj Kumar <rajkumar278@hotmail.com>
Subject: About run time power management in linux
Date: Wed, 30 Jun 2010 17:02:33 +0530
Message-ID: <BLU102-W77098297EEED290634D10EBCC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4032453340315903196=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

--===============4032453340315903196==
Content-Type: multipart/alternative;
	boundary="_a9814412-3d1a-4d49-a558-5b6a15f0c8e3_"

--_a9814412-3d1a-4d49-a558-5b6a15f0c8e3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi=2C

I am working in power management. I have few questions about run time power=
 management which was merged in linux 2.6.32 kernel onwards.=20

=20

Since the run time power management defines that when idle=2C suspend and r=
esume will be scheduled=2C now the thing is from device driver perspective=
=2C=20

=20

it is bus driver that will suspend and resume its devices. but what from dr=
iver perspective driver needs to implement means as run time power manageme=
nt=20

=20

has also helper functions which will tell PM core that when to call various=
 callbacks for suspend and resume for drivers (device=2C bus).=20

=20

But it might be case when the whole bus is not idle and still some drivers =
can be put into low power mode.=20

=20

Then does bus driver will be responsible for invoking the driver's suspend =
and resume (run time) or PM core will do that ?=20

=20

Use cases:

------------

=20

 1) When the bus is idle

=20

2) When the bus is not idle but still some peripherals can be put into low =
power mode......=20

=20

=20

Regards

Raj
 		 	   		  =

--_a9814412-3d1a-4d49-a558-5b6a15f0c8e3_
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
<BR>Hi=2C<BR><BR>I am working in power management. I have few questions abo=
ut run time power management which was merged in linux 2.6.32 kernel onward=
s. <BR>
&nbsp=3B<BR>
Since the run time power management defines that when idle=2C suspend and r=
esume will be scheduled=2C now the thing is from device driver perspective=
=2C <BR>
&nbsp=3B<BR>
it is bus driver that will suspend and resume its devices. but what from dr=
iver perspective driver needs to implement means as run time power manageme=
nt <BR>
&nbsp=3B<BR>
has also helper functions which will tell PM core that when to call various=
 callbacks for suspend and resume for drivers (device=2C bus). <BR>
&nbsp=3B<BR>
But it might be case when the whole bus is not idle and still some drivers =
can be put into low power mode. <BR>
&nbsp=3B<BR>
Then does bus driver will be responsible for invoking the driver's suspend =
and resume (run time) or PM core will do that ? <BR>
&nbsp=3B<BR>
Use cases:<BR>
------------<BR>
&nbsp=3B<BR>
&nbsp=3B1) When the bus is idle<BR>
&nbsp=3B<BR>
2) When the bus is not idle but still some peripherals can be put into low =
power mode...... <BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR> 		 	   		  </body>
</html>=

--_a9814412-3d1a-4d49-a558-5b6a15f0c8e3_--

--===============4032453340315903196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4032453340315903196==--
