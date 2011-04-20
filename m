From: Matt Hsu <matt@0xlab.org>
Subject: Re: [TuxOnIce-devel] [RFC PATCH] Current status,
 suspend-to-disk support on ARM
Date: Wed, 20 Apr 2011 15:14:31 +0800
Message-ID: <BANLkTinp1+6Ocmy5LAUEiPwAje+VnrTo9Q__48082.1431185634$1303283740$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
	<alpine.DEB.2.00.1104131020080.29883@localhost6.localdomain6>
	<201104132338.03003.rjw@sisk.pl>
	<alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
	<BANLkTinroLCypX-iG0xGpnyxBk=P5TVtJQ@mail.gmail.com>
	<alpine.DEB.2.00.1104191859260.4937@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2262664623919401888=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1104191859260.4937@localhost6.localdomain6>
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
To: frank.hofmann@tomtom.com
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============2262664623919401888==
Content-Type: multipart/alternative; boundary=bcaec5489e4d42250404a15460b4

--bcaec5489e4d42250404a15460b4
Content-Type: text/plain; charset=ISO-8859-1

>
> Also, I'd like to investigate whether ARM will require a set of
> platform_hibernation_ops - Samsung's patch from last December,
>
> http://www.spinics.net/lists/arm-kernel/msg108565.html
>

    Hi FrankH,

     The patch seems has connection with this

     www.kernel.org/doc/ols/2010/ols2010-pages-9-18.pdf

    You can see the section 4.3 fast device reactivation.
    It does the similar thing  as STR, but drivers status are kept in
hibernation image instead of main memory.
    I guess this is why this patch comes out.

    In the current device driver model, there are no appropriate handling
specific to
    hibernation_suspend/hibernation_resume ops.

    So they make their own interface/platform drivers.


> seems to indicate that they believe it's necessary at least on some ARM
> hardware. OMAP has similar functions to that, it'd be great to unify.
>
>
> FrankH.
>
>
> --
- Matt

--bcaec5489e4d42250404a15460b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddin=
g-left: 1ex;">
<br>
Also, I&#39;d like to investigate whether ARM will require a set of platfor=
m_hibernation_ops - Samsung&#39;s patch from last December,<br>
<br>
<a href=3D"http://www.spinics.net/lists/arm-kernel/msg108565.html" target=
=3D"_blank">http://www.spinics.net/lists/arm-kernel/msg108565.html</a><br><=
/blockquote><div><br>=A0=A0=A0 Hi FrankH,<br><br>=A0=A0=A0=A0 The patch see=
ms has connection with this <br>
<br>=A0=A0=A0=A0 <span class=3D"f"><cite><a href=3D"http://www.kernel.org/d=
oc/ols/2010/ols2010-pages-9-18.pdf">www.kernel.org/doc/ols/2010/ols2010-pag=
es-9-18.pdf</a><br><br></cite></span>=A0 =A0 You can see the section 4.3 fa=
st device reactivation.<br>
=A0 =A0 It does the similar thing=A0 as STR, but drivers status are kept in=
 hibernation image instead of main memory. <br>=A0=A0=A0 I guess this is wh=
y this patch comes out.<br><br>=A0=A0=A0 In the current device driver model=
, there are no appropriate handling specific to <br>
=A0=A0=A0 hibernation_suspend/hibernation_resume ops. <br><br>=A0=A0=A0 So =
they make their own interface/platform drivers.<br><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px so=
lid rgb(204, 204, 204); padding-left: 1ex;">

<br>
seems to indicate that they believe it&#39;s necessary at least on some ARM=
 hardware. OMAP has similar functions to that, it&#39;d be great to unify.<=
br>
<br>
<br>
FrankH.<div><div></div><div class=3D"h5"><br>
<br></div></div></blockquote></div>-- <br>- Matt<br>

--bcaec5489e4d42250404a15460b4--

--===============2262664623919401888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2262664623919401888==--
