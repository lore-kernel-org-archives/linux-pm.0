From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Regarding the dedicated memory for hibernation
Date: Tue, 22 Mar 2011 15:01:52 +0530
Message-ID: <SNT117-W368129D3EED2DAB17547BFEBB40@phx.gbl>
References: <BLU102-W6F8402163EAD81AFBF321EB490@phx.gbl>,
	<201011030418.02830.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4218096497380891094=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011030418.02830.rjw@sisk.pl>
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
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============4218096497380891094==
Content-Type: multipart/alternative;
	boundary="_e6834c0a-c1b4-496e-8e67-9676a212a695_"

--_e6834c0a-c1b4-496e-8e67-9676a212a695_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Rafael=2C

I have one question regarding the dedicated memory(the memory that is not O=
S addressable). But when userspace does mmap=2C I am creating mapping for V=
MA to physical addresses that are in dedicated memory.
The question is when system hibernates=2C will the OS kernel take care of t=
his when creating hibernation image as mmap creates a virtual address space=
 or device driver should explicity swap this memory(dedicated memory) in hi=
bernation image?

Regards
Raj
 		 	   		  =

--_e6834c0a-c1b4-496e-8e67-9676a212a695_
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
Hi Rafael=2C<br><br>I have one question regarding the dedicated memory(the =
memory that is not OS addressable). But when userspace does mmap=2C I am cr=
eating mapping for VMA to physical addresses that are in dedicated memory.<=
br>The question is when system hibernates=2C will the OS kernel take care o=
f this when creating hibernation image as mmap creates a virtual address sp=
ace or device driver should explicity swap this memory(dedicated memory) in=
 hibernation image?<br><br>Regards<br>Raj<br> 		 	   		  </body>
</html>=

--_e6834c0a-c1b4-496e-8e67-9676a212a695_--

--===============4218096497380891094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4218096497380891094==--
