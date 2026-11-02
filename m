Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639168;
	b=LX3gJOfZs4N2X7ubVCs0DY7XEaL0xv1jGfBv1ncAcn/opiEeQA/ZW/J0rUhpyMjF7BXV
	 ODPfMwWCCe61ZVMbCFQe5NCC/wuf7gEvKra75bP+7sJYO2paGh9Gdfl8YhWgCems2KHwZ
	 /nxhWJ/1GOSehl0QnuLEwWS43ccXSTxhm+KjDrphwmZsqfTe+Za38h6lQ018A1NmsEahr
	 ESfOJOj/l7GRaL0F+8czmUOrWmAj9WTTQd2Os5AN5WXCv70qKG+eNO9B61Ttfsto/Zs+t
	 FsLK7WbxfrDnz7qjoqCNQ4Eluu087IpQ3ZUFzu0O5WULjk9u9G/e9HIB+0g1fbwS/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639168;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=NV5oVtbgjb8nXycAfDcCSiAwFoiTrZdp33YVQFzB20w=;
	b=pFIbKzGX6Tm58FjXGbXPhquWYNLtlhh8FZsQJkUtcmwIZwVduF5rpTgoTsS/1diXJc93
	 Y1dhRWNQSfUMxnd/orVLq8MQZYz+8QPVzGho4VrZ2RyekbP3EjwvY0DwP8vh3SRfB/7Jq
	 Wa45AcNPTqjLbvsFdVcZY+ZQo3+m9i1jjpkdYaqMbrX+KPGVjCo+uimP+doreogWWRulO
	 WCHcdkRRd36TtkYUUmlUEdk674cmfICS6skyxeJXeYFMohlkjbb2eZXGH4oYIvF8OV9bI
	 bRkTJJBFTbXyBYG3V4q6KJ6b4nYKBTgo1XbM2o6HAwGIWbrXShk2x5fYrx4MRC1D3sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56A606A90C
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 17:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A56A606A90C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917aca1aee5so43016986d6.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 09:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639167; x=1794243967;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NV5oVtbgjb8nXycAfDcCSiAwFoiTrZdp33YVQFzB20w=;
        b=wqkHoX34zowGBl2PDBq0weCBCLCpTn1lnkRKc8y+gBf8Fot3MvsLXeOYn8sJW4gE3e
         Lg4JttqoyMKSSMCJZaVnkPDG7DQmETL4ZpBoYhYZR79dnffUJ+QaBFVOw0cut6TLh0U/
         t1xzudQgJ0fYjMQG1TliWu7t5A2NXcdXWDIVrEm1CTjr/9/U32ml9xsh2QAfNRc5HIk4
         R7jCnQldFyRvfmgl9+vhdoSRem2ViLGduaD2RrMpNyHgwNikznjSAp7e8UFUfFatu2Bn
         WDTQWL52jdLnkEAi+fG/6ollVG5IjZZB1wBPO+pMnIZg0uf6JGmrgO8tmxFVC9bGbocs
         wNDg==
X-Forwarded-Encrypted: i=1; AKwUvBxLqGGSxZeTCp8OeA3W1R27DEJEHDXgLukngNPiZGAlsjdSwCsneS9t9x/FEQHavyU41nl+GszMmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/0M026SsD1k9Cy2WCW9WCveWig41tTWbAqS0qinVKpNDNyuo6
	VQgY1IGwU5Sxe/WREMgJt0s1C+wT2q7rBicDhIqyAoX3IWJfXnnfPN7d3gMfK5mUOwE=
X-Gm-Gg: AYBFou3Vnfn4PbgT3N40f0eXjSEhE/6h7QKxPEcYGKQGhKuSg2x/n+JZNs8yC6Ex7Eu
	nD/KobkOlABCsON2c07xYJlhlQ6EmeTceFeY6pp7kkkAH81bm7sEcAVuwoknI0yTx6wj5i7Ycmz
	Pw760T5DIJcG7lzWmf/jN2dpmyVcPuhUPoZwRw5gWl0AjdwTeAph3MIYhh/cMgdfsAlSvEbmQaW
	wXnQq/z0mu6wHSxlrKw4jJ7PfjOhRTSqDuaVDY3idcC+xngEVvMGBfYDmvBO5Lj7Hvgxqzb3quC
	M4AlGw9b4WuoeG1Mv1UNvBq4tzuUQADV/cMkD//SoQ3lQzPx1OO3VVAmOv7+nA0qxEwLrS5WnMn
	VvPHaEMVNaO5rA4tt9v7eKzoh12ohpc3cwRdv4v8tcn0M9AhU9SH0TsvB1t8TcBlZa5w9mckDb0
	bVoRc9XOnnx5Mox+zW671OUIcV7RuVJXoKiiR7dh5UhnT2xEqFflJMDkUhDOi1kz2vD7DtjKZ0E
	X4C3ytHl9GkzJgWW6FyWyZrTyzSRD5nhSf6mtNps+dzoL+1eFGMNQQIc3m1ED3aaRruKxc5QCRi
	StDMEojOsrphPtjpbwW1TzCI3yCRkDr3tVhPD5BMHWDfEKFSU0gs7A1p6FyTed6UJw==
X-Received: by 2002:ac8:5a4a:0:b0:535:84e3:ceef with SMTP id d75a77b69052e-542b781c626mr174817521cf.45.1793639166865;
        Mon, 02 Nov 2026 09:06:06 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498c379989sm2494681cf.19.2026.11.02.09.06.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:06:06 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917aca1aee5so43016596d6.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 09:06:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw3xRvoBOJ6/BYsvbcTDfh8YJQFkqQ6qfYdM4rI32NlkbrU9jviwvJ+vEqVErcc9vHlqKk9xatNVg==@vger.kernel.org
X-Received: by 2002:a67:e70e:0:b0:7b2:f3ff:6b34 with SMTP id
 ada2fe7eead31-7d07277c9e4mr4640224137.1.1793638754741; Mon, 02 Nov 2026
 08:59:14 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793026273.git.geert+renesas@glider.be> <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com> <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
 <20261028163940.GA2673734@killaraus.ideasonboard.com> <CAMuHMdVOT+DTZum525kmYfP+jzzPrxMnEeRAkapxOMGz4XMHBA@mail.gmail.com>
 <20261030112314.GD2587681@killaraus.ideasonboard.com> <CAMuHMdXR=dcooQoKwrycDpTaZjFk2CCueL08dYYFJLE9bP90cg@mail.gmail.com>
 <20261102160945.GH3368923@killaraus.ideasonboard.com>
In-Reply-To: <20261102160945.GH3368923@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Nov 2026 17:59:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHFquHz+OzpHirWENEEQeZbiXx=8eeRDKssvw++jGOUw@mail.gmail.com>
X-Gm-Features: AclHuK8XzCALNwMWvYgXEhUxPQ8US5Vy_FCXa42SavWW1jb9WQFLW8n1gcSHAYs
Message-ID: <CAMuHMdVHFquHz+OzpHirWENEEQeZbiXx=8eeRDKssvw++jGOUw@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Mon, 2 Nov 2026 at 17:09, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Oct 30, 2026 at 02:51:54PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 30 Oct 2026 at 12:23, Laurent Pinchart wrote:
> > > On Thu, Oct 29, 2026 at 10:08:28AM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, 28 Oct 2026 at 17:39, Laurent Pinchart wrote:
> > > > > On Wed, Oct 28, 2026 at 03:43:42PM +0100, Geert Uytterhoeven wrote:
> > > > > > On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart wrote:
> > > > > > > On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > > > > > > > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> > > > > > > >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> > > > > > > >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > > > > > > > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> > > > > > > >
> > > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > >
> > > > > > > > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > > > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > > > @@ -28,5 +28,8 @@
> > > > > > > >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> > > > > > > >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> > > > > > > >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > > > > > > > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > > > > > > > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
> > > > > > >
> > > > > > > Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> > > > > > > R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> > > > > > > dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> > > > > > > R8A78000_CPG_SGD16_PERW_BUS, as well as
> > > > > > > R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.
> > > > > >
> > > > > > I could add them, but do you have any need to refer to them from DT?
> > > > > > So far I only added clocks that are listed as clock supplies of on-SoC
> > > > > > modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
> > > > > > Timer Unit (TMU)).
> > > > >
> > > > > So we have two conflicting goals here. One of them is to only add clocks
> > > > > that we have validated to exist (and ideally work as documented). The
> > > > > other is to keep renesas,r8a78000-cpg.h readable. We won't be able to
> > > > > satisfy them both fully.
> > > > >
> > > > > I think we previously discussed adding whole groups of dividers in one
> > > > > go, as some sort of middle-ground approach. Those are clocks that are
> > > >
> > > > That is what did in this and the previous patch: we need
> > > >   - R8A78000_CPG_SGASYNCDn_PERW_MAIN for n=16, and added the one for
> > > >     n=8, too.
> > >
> > > That's missing n=4 and n=32. While SGASYNCD32 isn't referenced in the
> > > datasheet, SGASYNCD4 is (in SCIF and HSCIF). Maybe that's just an
> > > oversight ?
> >
> > We already have the clocks for (H)SCIF (_BUS, not _MAIN!):
> >
> >     #define R8A78000_CPG_SGASYNCD4_PERW_BUS         0
> >     #define R8A78000_CPG_SGASYNCD8_PERW_BUS         1
>
> Wait... Aren't R8A78000_CPG_SGASYNCD8_PERW_MAIN and
> R8A78000_CPG_SGASYNCD8_PERW_BUS the same clock, just with a different
> name ? The user manual says _BUS, the clock diagram in the spreadsheet
> says _MAIN. The SCP firmware defines both, with the same parent (PLL5)
> and the same frequency. I have a feeling it may "just" be discrepancy
> between the user manual and the spreadsheets.
>
> *sigh*

After my previous comment about "87 SGD4_* clocks" (quoted at the end),
I started wondering if they are really identical and ungateable.
The documentation calls each clock list a "clock hierarchy"
(e.g. the PERW hierarchy), and each sublist another "clock hiearchy"
(e.g. PERW_BUS vs. PERW_MAIN) which sounds like they are different.
I also wouldn't be surprised if each (sub)hierarchy is gateable, too.
So unless we can get clear confirmation, I'd rather be safe than sorry.

> > > >   - R8A78000_CPG_SCPBUSDn_SCP_MAIN for n=16, and added the ones for
> > > >     n=1,2,4,6,8,32, too.
> > > >   - R8A78000_CPG_S0Dn_PERE_MAIN for n=24, and added the ones for
> > > >     n=1,2,3,4,8, too.
> > > >   - R8A78000_CPG_SGDn_PERW_BUS for n=32, and added the ones for n=8,
> > > >     too.
> > > >
> > > > I did not includes clocks with values for n that exist according to
> > > > the documentation, but are not used as suppliers for modules.
> > > > Of course the documentation may be incorrect or incomplete, and we may
> > > > need to add them later. As IDs are ABI and the list is append-only,
> > > > they must be added at the end, which could indeed lead to not all
> > > > clocks of the same group being located together.  From an ABI point
> > > > of view that is OK, but from a human-readability point of view it is
> > > > indeed suboptimal.
> > > >
> > > > Before, we tended to add all clocks from the clock tables listed the
> > > > documentation upfront, ignoring clocks that are clearly internal-only.
> > > > Some of them turned out not to exist later.
> > > > Some new clocks had to be added when the documentation was updated.
> > > > Nothing new here, except that the list of clocks on R-Car X5H is an
> > > > order of magnitude longer.
> > > >
> > > > Note that we don't use a linear array of clocks indexed by clock ID
> > > > in the R-Car X5H CPG driver (yet), so large holes of unused clocks do
> > > > not hurt (they do hurt in the SCMI driver ;-)
> > > >
> > > > > not directly controllable. There's a risk of adding clocks that don't
> > > >
> > > > FTR, the xDn clocks are not directly controllable; clocks like
> > > > R8A78000_CPG_MSO_SCP_MAIN are.  We know the latter exist, as they
> > > > are used.
> > >
> > > Yes, I was talking about the clocks documented in the various
> > > non-PLL "hierarchy" sections.
> > >
> > > > > exist, or clocks that we won't need to reference from DT (because
> > > > > they're only used as parents of the MDLC-controlled module clock). Do
> > > >
> > > > The direct parent of an MDLC-controlled module clock should be in DT.
> > >
> > > An additional difficulty is that we don't actually know what clocks the
> > > MDLC gates :-/
> >
> > This hasn't changed much: on other R-Car generations we also didn't
> > know which clock(s) are gated by a single MSTP (Module SToP) bit.
> > Historically (old SH parts), there was only a single clock supplying
> > each module. Modules on later SoCs gained more clock supplies.
> > Hence we always assumed (at least) the functional clock is gated by
> > the MSTP bit, and modelled the gateable SMTP clocks as a child of the
>
> Sometimes I want to gate everybody's SMTP clocks :D
>
> > functional clock parent.  But it's quite possible other clock inputs
> > to the module are gated, too, depending on the actual module (some
> > modules e.g. need a PHY clock running to be able to process wake-up
> > events).
>
> Yes, it's not new.
>
> /me wants to get a copy of the RTL alongside the user manual
>
> > Comparing older R-Car with R-Car Gen5, I actually like how the new
> > MDLC block combines the power domain functionality of the old SYSC
> > block and the clock domain functionality of the old MSSR (Module Standby
> > and Software Reset) block. It improves upon the now imprecise modelling
> > of MSTP clocks, and maps nicely on the Linux PM Domain abstraction:
> >   - power domain: generic_pm_domain.power_{on,off}(domain),
> >   - clock domain: generic_pm_domain.dev_ops.{start,stop}(device).
>
> I *think* I like the resulting DT better. As the module standby feature
> is now listed in the power-domains property, even if we model it
> internally as a clock, it doesn't appear as a clock any more in DT.
> Clocks the drivers need have to be listed independently, which decouples
> them from the module standby.

Agreed.

> > > > Higher-up parents should not be needed iff the SCMI firmware exposed
> > > > and/or implements the proper clock hierarchy (which it does not at
> > > > the moment).
> > >
> > > A big *iff* :-)
> > >
> > > Even in that case, we'll have (at least) two issues:
> > >
> > > - Some modules may need to know the rate of the functional clock gated
> > >   by the MDLC. As those clocks are controlled through power domains,
> > >   they are only specified as the last cell of the power-domains
> > >   property, and are not listed in the clocks property. How do you
> > >   envision this to work ?
> >
> > The functional clock (or its parent) is still listed in the clocks
> > property.  Compare e.g. the hscif0 nodes on R-Car V4H:
> >
> >     clocks = <&cpg CPG_MOD 514>,
> >              <&cpg CPG_CORE R8A779G0_CLK_SASYNCPERD1>,
> >              <&scif_clk>;
> >     clock-names = "fck", "brg_int", "scif_clk";
> >     power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> >     resets = <&cpg 514>;
> >
> > and R-Car X5H:
> >
> >     clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
> >              <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
> >              <&scif_clk>;
> >     clock-names = "fck", "brg_int", "scif_clk";
> >     power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x54>;
> >     resets = <&mdlc_perw 0x54>;
> >
> > On R-Car V4H, MSTP514 aka "hscif0" is modelled as a gateable MSTP
> > clock with parent R8A779G0_CLK_SASYNCPERD1, and used as "fck".
> > On R-Car X5H, R8A78000_CPG_SGASYNCD4_PERW_BUS is used as "fck" directly.
> > Calling clk_get_rate() on MSTP514 and R8A78000_CPG_SGASYNCD4_PERW_BUS
> > gives similar results.
>
> On Gen5 we will then end up enabling the clock twice, once through the
> power domain, and once through the explicit clk_enable(fck) in the
> driver. I suppose that's fine in theory (there's an extra runtime cost

It depends, and can only be true for drivers that still do explicit
clock management.  Many drivers that don't need to know anything
(e.g. the rate) about the clock have been modified to delegate this
fully to Runtime PM.

On R-Car Gen5, the (now purely internal) module clock used for module
standby is different from the "fck" clock in DT.  So perw 0x54 is
controlled through Runtime PM, and SGASYNCD4_PERW_BUS is
controlled by the SCIF driver directly (but it is a no-op as the bus clock is
always-on).

On previous R-Car generations, "fck" is the module clock, and is
enabled twice.

> though) as clocks are reference-counted. However, the current SCP
> firmware reference-counts the clocks based on their SCMI ID, and the
> MDLC clock (perw 0x54) and its parent (R8A78000_CPG_SGASYNCD4_PERW_BUS)
> have different IDs. This can cause the clock to be disabled at an
> unexpected point. In this specific case, however, given that
> R8A78000_CPG_SGASYNCD4_PERW_BUS isn't controllable, it won't cause an
> issue, but in the generic case it can fail badly.

Current SCP firmware indeed doesn't handle parent-child relations:
e.g. perw 0x54 has a clock rate of zero, and is not a child of
SGASYNCD4_PERW_BUS.  So the MDLC remapping driver ended up becoming
responsible for controlling the parent clock if it is gateable, which
is the case for e.g. MSIOF (see mod_map_in.fw_fck_parent).

> > > - When multiple clocks derive from the same PLL, it's common for the PLL
> > >   rate to be specified through assigned-clock-rates. If we want to
> > >   continue doing that, we need to to make the whole clock hierarchy
> > >   available to DT.
> >
> > Yes, you need a public ID to refer to a clock from DT.
> > Do you have an example where we would assigned-clock-rates it for a PLL?
>
> Not on Renesas platforms so far. I can imagine this being used to
> control for instance the whole VIO hierarchy. Depending on the bandwidth
> used by image sensors, system integrators may want to tweak the PLL
> frequency.

A definition can be added when needed. Note that SCMI does not expose
the PLLs to any agent anyway...

> > So far all users of assigned-clock-rates on Renesas SoCs use it
> > on clocks that are already public as they are also needed as clock
> > supplies in clocks properties (e.g. CAN-FD and SPI reference clocks).
> >
> > > > Still, they can be internal enum, starting after the last
> > > > DT clock, like we did in other R-Car clock drivers.
> > > >
> > > > > you think that's an issue, could it cause ABI problems in the future ?
> > > >
> > > > An ABI problem appears only when you refer in DT to a clock that does
> > > > not exist in hardware.  This should be caught by testing before the
> > > > DT user is added.
> > >
> > > So we could add e.g. SGASYNCD32 already, as long as we don't reference
> > > it in DT without testing.
> >
> > We could, but which one: "_PERW_BUS" or "_PERW_MAIN"? Or both?
>
> See above :-)
>
> > And what's the point if there are no users?
>
> Future-proofing, to avoid adding the SGASYNCD32 clock later with a
> non-consecutive ID.

Then perhaps we should add all clocks from the spreadsheet upfront?

> > BTW, there are 87 SGD4_* clocks listed in the documentation.  They are
> > all sourced from the same PLL, and have all the same clock rate.
> > I don't think any of these can be gated.  Hence if I would write a
> > bare metal clock driver, I would just expose and instantiate a single
> > SGD4 clock.  But the current SCMI implementation exposes 87 different
> > clocks (and didn't make them usable by Linux until recently)...
> >
> > Perhaps we should drop the domain suffixes from the definitions? Even
> > e.g. MSOCK_PERW_BUS and MSOCK_PERW_MAIN seem to be the same clock...
>
> I think we should also ask for names to be double-checked and fixed in
> the next version of the documentation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
