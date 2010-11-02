From: Raj Kumar <rajkumar278@hotmail.com>
Subject: One issue regarding the run time power management
Date: Wed, 3 Nov 2010 02:08:57 +0530
Message-ID: <BLU102-W6F8402163EAD81AFBF321EB490@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7758863283981457435=="
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

--===============7758863283981457435==
Content-Type: multipart/alternative;
	boundary="_80aa1468-e860-42f6-b301-3ba6beb7f44b_"

--_80aa1468-e860-42f6-b301-3ba6beb7f44b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20
Hi=2C
=20
There is a one issue coming regarding the run time power management during =
system suspend=2C Suppose
system suspend is going on and before the suspend callback of driver is exe=
cuted=2C driver issues a runtime resume to run time power management core b=
efore it gets
the system suspend call back but System suspend is going on then how the ru=
n time power management prevents this condition?
=20
As I saw the code during dpm_prepare=2C power usage count is incremented by=
 1 by calling pm_runtime_get_noresume(dev) and then it calls
pm_runtime_barrier=2C
=20
Since During System suspend=2C driver calls pm_runtime_get which will invok=
e=20
=20
atomic_inc(&dev->power.usage_count)=3B
=20
which increments the power usage count and calls pm_request_resume which do=
es not have any check on power usage count=2C
=20
So when System suspend is going on and it has not reached suspend call back=
 of driver and driver submits run time resume request (if
the device is suspended at runtime earlier)
=20
Then How run time power management prevents device run time resume when the=
 system suspend is going on as it does not
check for power usage count?
=20
Regards
Raj  		 	   		  =

--_80aa1468-e860-42f6-b301-3ba6beb7f44b_
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
Hi=2C<BR>
&nbsp=3B<BR>
There is a one issue coming regarding the run time power management during =
system suspend=2C Suppose<BR>
system suspend is going on and before the suspend callback of driver is exe=
cuted=2C driver issues a runtime resume to run time power management core b=
efore it gets<BR>
the system suspend call back but System suspend is going on then how the ru=
n time power management prevents this condition?<BR>
&nbsp=3B<BR>
As I saw the code during dpm_prepare=2C power usage count is incremented by=
 1 by calling pm_runtime_get_noresume(dev) and then it calls<BR>
pm_runtime_barrier=2C<BR>
&nbsp=3B<BR>
Since During System suspend=2C driver calls pm_runtime_get which will invok=
e <BR>
&nbsp=3B<BR>
atomic_inc(&amp=3Bdev-&gt=3Bpower.usage_count)=3B<BR>
&nbsp=3B<BR>
which increments the power usage count and calls pm_request_resume which do=
es not have any check on power usage count=2C<BR>
&nbsp=3B<BR>
So when System suspend is going on and it has not reached suspend call back=
 of driver and driver submits run time resume request (if<BR>
the device is suspended at runtime earlier)<BR>
&nbsp=3B<BR>
Then How run time power management prevents device run time resume when the=
 system suspend is going on as it does not<BR>
check for power usage count?<BR>
&nbsp=3B<BR>
Regards<BR>
Raj&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_80aa1468-e860-42f6-b301-3ba6beb7f44b_--

--===============7758863283981457435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7758863283981457435==--
