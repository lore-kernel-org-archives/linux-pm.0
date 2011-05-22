From: "Frank Hofmann" <Frank.Hofmann@tomtom.com>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Sun, 22 May 2011 08:39:25 +0200
Message-ID: <2C577202CB5719438D4E9608C565CB2C01B69D7A@NL-EXC-07.intra.local>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<20110520180748.GF7445@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4004460101154973786=="
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--===============4004460101154973786==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC184B.2ED069F3"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC184B.2ED069F3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Russell / Nicolas,

thanks for the clarification on ARM history; there's a lot to learn for =
me about that still.

I'll reply to Rafael regarding state save/restore.

FrankH.



-----Original Message-----
From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
Sent: Fri 20/05/2011 20:07
To: Frank Hofmann
Cc: Dave Martin; linux-pm@lists.linux-foundation.org; =
tuxonice-devel@tuxonice.net; linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk support code
=20
On Fri, May 20, 2011 at 01:39:37PM +0100, Frank Hofmann wrote:
> I've simply done there what the "setmode" macro from <asm/assembler.h> =
=20
> is doing, have chosen not to include that file because it overrides=20
> "push" on a global scale for no good reason and that sort of thing =
makes=20
> me cringe.

"push" was never an ARM instruction until someone decided to make r13
"special".  As our macros there pre-date the invention of the new ARM
instruction neumonics, it takes precident _especially_ as there's
perfectly good alternative ways to say "push" to the assembler.


------_=_NextPart_001_01CC184B.2ED069F3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [RFC PATCH] ARM hibernation / suspend-to-disk support =
code</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Russell / Nicolas,<BR>
<BR>
thanks for the clarification on ARM history; there's a lot to learn for =
me about that still.<BR>
<BR>
I'll reply to Rafael regarding state save/restore.<BR>
<BR>
FrankH.<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Russell King - ARM Linux [<A =
HREF=3D"mailto:linux@arm.linux.org.uk">mailto:linux@arm.linux.org.uk</A>]=
<BR>
Sent: Fri 20/05/2011 20:07<BR>
To: Frank Hofmann<BR>
Cc: Dave Martin; linux-pm@lists.linux-foundation.org; =
tuxonice-devel@tuxonice.net; linux-arm-kernel@lists.infradead.org<BR>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk support =
code<BR>
<BR>
On Fri, May 20, 2011 at 01:39:37PM +0100, Frank Hofmann wrote:<BR>
&gt; I've simply done there what the &quot;setmode&quot; macro from =
&lt;asm/assembler.h&gt;&nbsp;<BR>
&gt; is doing, have chosen not to include that file because it =
overrides<BR>
&gt; &quot;push&quot; on a global scale for no good reason and that sort =
of thing makes<BR>
&gt; me cringe.<BR>
<BR>
&quot;push&quot; was never an ARM instruction until someone decided to =
make r13<BR>
&quot;special&quot;.&nbsp; As our macros there pre-date the invention of =
the new ARM<BR>
instruction neumonics, it takes precident _especially_ as there's<BR>
perfectly good alternative ways to say &quot;push&quot; to the =
assembler.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CC184B.2ED069F3--

--===============4004460101154973786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4004460101154973786==--
