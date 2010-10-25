From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Run time power management
Date: Tue, 26 Oct 2010 01:10:45 +0530
Message-ID: <BLU102-W274185CFA6E3243A728858EB410@phx.gbl>
References: <201010212350.15409.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0210072987897883667=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010212350.15409.rjw@sisk.pl>
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

--===============0210072987897883667==
Content-Type: multipart/alternative;
	boundary="_8b069bed-709b-4752-9010-6902f026eb2b_"

--_8b069bed-709b-4752-9010-6902f026eb2b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20
Hi=2C
=20
I have one more question regarding the run time power management.  Suppose =
a peripheral
has two parts where each part is managed under two power domains. Since run=
 time power
management is based on device node.=20
=20
So in this case=2C there are two power domains. Since power of each part is=
 suspended/resumed
independent of each other.
=20
So In this case should the driver of such peripheral  create two device nod=
es? Since when=20
it issues suspend/resume  requests to run time power management core where =
each part
falls under one device node and also run time power management works on ind=
ividual device node.
=20
So shall device driver create two device nodes in such use cases?
=20
regards
raj  		 	   		  =

--_8b069bed-709b-4752-9010-6902f026eb2b_
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
I have one more question regarding the run time power management.&nbsp=3B S=
uppose a peripheral<BR>
has two parts where each part is managed under two power domains. Since run=
 time power<BR>
management is based on device node. <BR>
&nbsp=3B<BR>
So in this case=2C there are two power domains. Since power of each part is=
 suspended/resumed<BR>
independent of each other.<BR>
&nbsp=3B<BR>
So In this case should the driver of such peripheral&nbsp=3B create two dev=
ice nodes? Since when <BR>
it issues suspend/resume &nbsp=3Brequests to run time power management core=
 where each part<BR>
falls under one device node and also run time power management works on ind=
ividual device node.<BR>
&nbsp=3B<BR>
So shall device driver create two device nodes in such use cases?<BR>
&nbsp=3B<BR>
regards<BR>
raj&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_8b069bed-709b-4752-9010-6902f026eb2b_--

--===============0210072987897883667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0210072987897883667==--
