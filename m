From: Raj Kumar <rajkumar278@hotmail.com>
Subject: (no subject)
Date: Sat, 18 Sep 2010 17:19:42 +0530
Message-ID: <BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
References: <BLU102-W1030ED196ED7B94722F2A7EB830@phx.gbl>,
	<Pine.LNX.4.44L0.1008241029000.1652-100000@iolanthe.rowland.org>,
	<BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>,
	<BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>,
	<BLU102-W283ED7848BB0495FBACF0BEB850@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5471817964010586065=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W283ED7848BB0495FBACF0BEB850@phx.gbl>
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

--===============5471817964010586065==
Content-Type: multipart/alternative;
	boundary="_8e5ce047-4651-4add-a1ef-122e806b0d48_"

--_8e5ce047-4651-4add-a1ef-122e806b0d48_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Alan=2C

=20

I have question regarding the CPU frequency subsystem through which the fre=
quency of the CPU is scaled.

e.g. If we have device driver (X device contains processor) that wants to s=
cale its own processor based

upon the workload=2C (DVFS driver for this processor is implemented and reg=
istered with cpufreq subsystem)

then X device driver when detects waorkload=2C  Can this X device driver ca=
ll policy governor APIS for scaling clock or

this X device driver can directly calls DVFS driver APIs directly?

I just want to know from our device driver how do call DVFS driver if DVFS =
driver is registered with cpu frequency subsystem?

=20

=20

=20

Regards

Raj=20

=20
 		 	   		  =

--_8e5ce047-4651-4add-a1ef-122e806b0d48_
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
Hi Alan=2C<BR>
&nbsp=3B<BR>
I have question regarding the CPU frequency subsystem through which the fre=
quency of the CPU is scaled.<BR>
e.g. If we have device driver (X device contains processor) that wants to s=
cale its own processor based<BR>
upon the workload=2C (DVFS driver for this processor is&nbsp=3Bimplemented&=
nbsp=3Band registered with&nbsp=3Bcpufreq subsystem)<BR>
then X device driver when detects waorkload=2C&nbsp=3B Can this X device dr=
iver&nbsp=3Bcall policy governor&nbsp=3BAPIS for scaling clock or<BR>
this X device&nbsp=3Bdriver can directly calls DVFS driver APIs directly?<B=
R>
I just want to know from our device driver how do call DVFS driver if DVFS =
driver is registered with cpu frequency subsystem?<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
Regards<BR>
Raj&nbsp=3B<BR>
&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_8e5ce047-4651-4add-a1ef-122e806b0d48_--

--===============5471817964010586065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5471817964010586065==--
