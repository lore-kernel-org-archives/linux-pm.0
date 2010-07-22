From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Questions about run time power management
Date: Fri, 23 Jul 2010 02:53:34 +0530
Message-ID: <BLU102-W10EC41B7844B167719657CEBA20@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0807237169780492175=="
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

--===============0807237169780492175==
Content-Type: multipart/alternative;
	boundary="_6333b5bd-38b2-4aec-80e1-7d940c8644f5_"

--_6333b5bd-38b2-4aec-80e1-7d940c8644f5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




Hi=2C


I am implementing the run time power management in my drivers. So i have th=
e following
questions:


1) I am using the work queue approach for run time power management=2C Now =
the thing is
when the device is idle and it notifies the run time power management via h=
elper function
pm_request_idle=2C and at the same time if resume is done then in that case=
 does the runtime power management
cancels the idle and does not invoke any callback like runtime_suspend of d=
river?=20


2) like as mentioned in run time power management document=2C when the usag=
e_count of device
reaches zero=2C is there any run time power management thread in background=
 that will immediately suspends
the device or it is again via helper functions. It seems from the code that=
 usage_count is zero and suspended
via helper functions. Is it correct?


3) The third question is more specific about platform bus usage? can the ch=
ar device driver use platform bus?
can char device register as platform device?


Regards
raj




    =20
=20
 		 	   		  =

--_6333b5bd-38b2-4aec-80e1-7d940c8644f5_
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
<br><BR>Hi=2C<BR><br><BR>I am implementing the run time power management in=
 my drivers. So i have the following<BR>questions:<BR><br><BR>1) I am using=
 the work queue approach for run time power management=2C Now the thing is<=
BR>when the device is idle and it notifies the run time power management vi=
a helper function<BR>pm_request_idle=2C and at the same time if resume is d=
one then in that case does the runtime power management<BR>cancels the idle=
 and does not invoke any callback like runtime_suspend of driver? <BR><br><=
BR>2) like as mentioned in run time power management document=2C when the u=
sage_count of device<BR>reaches zero=2C is there any run time power managem=
ent thread in background that will immediately suspends<BR>the device or it=
 is again via helper functions. It seems from the code that usage_count is =
zero and suspended<BR>via helper functions. Is it correct?<BR><br><BR>3) Th=
e third question is more specific about platform bus usage? can the char de=
vice driver use platform bus?<BR>can char device register as platform devic=
e?<BR><br><BR>Regards<BR>raj<BR><br><BR><br><BR>=A0 =A0 =A0<BR>=A0<BR> 		 	=
   		  </body>
</html>=

--_6333b5bd-38b2-4aec-80e1-7d940c8644f5_--

--===============0807237169780492175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0807237169780492175==--
