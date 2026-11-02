Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660775;
	b=Zyvt+WM7wk0CTbABaStnlBbLwEjWibQ1pkYZ3LGS5nDqD3MEK28BPk0Fmjhl5FOky/lv
	 BFlwaQpSvp8iZvEgMfcvLN3IdobvFmPkrgZ7MgOXBfdrtsAuybv80DsXZ2u1whUgMH49x
	 yqj2iUAy9+NCJflwstWBo9gBgyRz/UX9rSki93S6BGEfGFncSab7uBSqsRZU9D4VlRDF8
	 sA+yqxYd8qQRjpXh+wQO9i+Utgu49TIXYtRL4Kqum4TAEQ6T6d9Wiq/tGakuGmCXdRVrm
	 AQ3uIwh95gBxC6KEOGYflEfiqFRGwLQwRW6sVTBoK1DgkFticgZafRq89OYJKngzZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660775;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=P1UmFa71qVwzXmh4FTJpuqgeeWfto6XzMT/Krewt34k=;
	b=uBw3VCBh+6PyeRVwTstlWsY6OQzkqvo8Ab5iR1YQDDbSWceYRZ32gd6BLaWR8jz3NcTQ
	 WYhW5+I+1CX0yAJyGlFbkRhyxFB/eQkRhi711piFhFHtksQz4InXFaM21VJBzcNEtaVKf
	 kTRVczS8x0iCyh4DeTyRj38IgL6F6HvrGj399YyWlbPHdnxcRXm46JfNh5ApDiTDlc9Me
	 3VeXlYqkz43qzy1Y3D99ezuEhMvWxOnXNPL2r5gum/P85q4ZNCVYaOQxxaQVxOEgjx2mF
	 wS+rGN3L2v0X/+Rxw/L9vRZBNuoXF7saaf1ypTbYuzyxXdrk3pctFVxj0nXPBc8tTkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b="W6MGK/7Q";
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC606A324;
	Mon,  2 Nov 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AAC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=W6MGK/7Q
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 69A5D5E;
	Tue,  3 Nov 2026 00:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793660635;
	bh=2byjm4k+A5rsgICC1mRH3xTUZkTfMTmI5jO1ag3NyPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6MGK/7Qt2JUslewlTuaJUR41ENOWS4FgcUPwW9gbz7vIQTmQu9ZDkEToU94UkCmD
	 pTHAlf9KWc70gmZHItC/0V/w8EDmU5YnK63bs29WMLSIG5T0f8O6U4ntRM4KlLflxP
	 QUFXxFDbOBZf1qdVDMMz2z3GpHwwc1h+DSLyB6CA=
Date: Tue, 3 Nov 2026 01:06:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM
 clocks
Message-ID: <20261102230610.GC3548113@killaraus.ideasonboard.com>
References: <cover.1793026273.git.geert+renesas@glider.be>
 <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com>
 <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
 <20261028163940.GA2673734@killaraus.ideasonboard.com>
 <CAMuHMdVOT+DTZum525kmYfP+jzzPrxMnEeRAkapxOMGz4XMHBA@mail.gmail.com>
 <20261030112314.GD2587681@killaraus.ideasonboard.com>
 <CAMuHMdXR=dcooQoKwrycDpTaZjFk2CCueL08dYYFJLE9bP90cg@mail.gmail.com>
 <20261102160945.GH3368923@killaraus.ideasonboard.com>
 <CAMuHMdVHFquHz+OzpHirWENEEQeZbiXx=8eeRDKssvw++jGOUw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVHFquHz+OzpHirWENEEQeZbiXx=8eeRDKssvw++jGOUw@mail.gmail.com>

On Mon, Nov 02, 2026 at 05:59:02PM +0100, Geert Uytterhoeven wrote:
> On Mon, 2 Nov 2026 at 17:09, Laurent Pinchart wrote:
> > On Fri, Oct 30, 2026 at 02:51:54PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 30 Oct 2026 at 12:23, Laurent Pinchart wrote:
> > > > On Thu, Oct 29, 2026 at 10:08:28AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, 28 Oct 2026 at 17:39, Laurent Pinchart wrote:
> > > > > > On Wed, Oct 28, 2026 at 03:43:42PM +0100, Geert Uytterhoeven wrote:
> > > > > > > On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart wrote:
> > > > > > > > On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > > > > > > > > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> > > > > > > > >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> > > > > > > > >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > > > > > > > > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > >
> > > > > > > > > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > > > > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > > > > @@ -28,5 +28,8 @@
> > > > > > > > >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> > > > > > > > >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> > > > > > > > >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > > > > > > > > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > > > > > > > > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
> > > > > > > >
> > > > > > > > Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> > > > > > > > R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> > > > > > > > dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> > > > > > > > R8A78000_CPG_SGD16_PERW_BUS, as well as
> > > > > > > > R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.
> > > > > > >
> > > > > > > I could add them, but do you have any need to refer to them from DT?
> > > > > > > So far I only added clocks that are listed as clock supplies of on-SoC
> > > > > > > modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
> > > > > > > Timer Unit (TMU)).
> > > > > >
> > > > > > So we have two conflicting goals here. One of them is to only add clocks
> > > > > > that we have validated to exist (and ideally work as documented). The
> > > > > > other is to keep renesas,r8a78000-cpg.h readable. We won't be able to
> > > > > > satisfy them both fully.
> > > > > >
> > > > > > I think we previously discussed adding whole groups of dividers in one
> > > > > > go, as some sort of middle-ground approach. Those are clocks that are
> > > > >
> > > > > That is what did in this and the previous patch: we need
> > > > >   - R8A78000_CPG_SGASYNCDn_PERW_MAIN for n=16, and added the one for
> > > > >     n=8, too.
> > > >
> > > > That's missing n=4 and n=32. While SGASYNCD32 isn't referenced in the
> > > > datasheet, SGASYNCD4 is (in SCIF and HSCIF). Maybe that's just an
> > > > oversight ?
> > >
> > > We already have the clocks for (H)SCIF (_BUS, not _MAIN!):
> > >
> > >     #define R8A78000_CPG_SGASYNCD4_PERW_BUS         0
> > >     #define R8A78000_CPG_SGASYNCD8_PERW_BUS         1
> >
> > Wait... Aren't R8A78000_CPG_SGASYNCD8_PERW_MAIN and
> > R8A78000_CPG_SGASYNCD8_PERW_BUS the same clock, just with a different
> > name ? The user manual says _BUS, the clock diagram in the spreadsheet
> > says _MAIN. The SCP firmware defines both, with the same parent (PLL5)
> > and the same frequency. I have a feeling it may "just" be discrepancy
> > between the user manual and the spreadsheets.
> >
> > *sigh*
> 
> After my previous comment about "87 SGD4_* clocks" (quoted at the end),
> I started wondering if they are really identical and ungateable.
> The documentation calls each clock list a "clock hierarchy"
> (e.g. the PERW hierarchy), and each sublist another "clock hiearchy"
> (e.g. PERW_BUS vs. PERW_MAIN) which sounds like they are different.

I only see PERW_MAIN, not PERW_BUS. There's a PERW_MAIN_MP sub-hierarchy
though. And I'm fairly sure there are errors in the diagrams (at least
in the VIO hierarchy).

> I also wouldn't be surprised if each (sub)hierarchy is gateable, too.
> So unless we can get clear confirmation, I'd rather be safe than sorry.

I haven't found any sign neither in the documentation nor in the SCP
firmware sources that those would be gateable. If they are, they are not
gated by default.

In any case, I think it would make sense to model in DT all the clocks
listed in the diagrams. That should make it possible to properly handle
gates after the fact, should there be any.

> > > > >   - R8A78000_CPG_SCPBUSDn_SCP_MAIN for n=16, and added the ones for
> > > > >     n=1,2,4,6,8,32, too.
> > > > >   - R8A78000_CPG_S0Dn_PERE_MAIN for n=24, and added the ones for
> > > > >     n=1,2,3,4,8, too.
> > > > >   - R8A78000_CPG_SGDn_PERW_BUS for n=32, and added the ones for n=8,
> > > > >     too.
> > > > >
> > > > > I did not includes clocks with values for n that exist according to
> > > > > the documentation, but are not used as suppliers for modules.
> > > > > Of course the documentation may be incorrect or incomplete, and we may
> > > > > need to add them later. As IDs are ABI and the list is append-only,
> > > > > they must be added at the end, which could indeed lead to not all
> > > > > clocks of the same group being located together.  From an ABI point
> > > > > of view that is OK, but from a human-readability point of view it is
> > > > > indeed suboptimal.
> > > > >
> > > > > Before, we tended to add all clocks from the clock tables listed the
> > > > > documentation upfront, ignoring clocks that are clearly internal-only.
> > > > > Some of them turned out not to exist later.
> > > > > Some new clocks had to be added when the documentation was updated.
> > > > > Nothing new here, except that the list of clocks on R-Car X5H is an
> > > > > order of magnitude longer.
> > > > >
> > > > > Note that we don't use a linear array of clocks indexed by clock ID
> > > > > in the R-Car X5H CPG driver (yet), so large holes of unused clocks do
> > > > > not hurt (they do hurt in the SCMI driver ;-)
> > > > >
> > > > > > not directly controllable. There's a risk of adding clocks that don't
> > > > >
> > > > > FTR, the xDn clocks are not directly controllable; clocks like
> > > > > R8A78000_CPG_MSO_SCP_MAIN are.  We know the latter exist, as they
> > > > > are used.
> > > >
> > > > Yes, I was talking about the clocks documented in the various
> > > > non-PLL "hierarchy" sections.
> > > >
> > > > > > exist, or clocks that we won't need to reference from DT (because
> > > > > > they're only used as parents of the MDLC-controlled module clock). Do
> > > > >
> > > > > The direct parent of an MDLC-controlled module clock should be in DT.
> > > >
> > > > An additional difficulty is that we don't actually know what clocks the
> > > > MDLC gates :-/
> > >
> > > This hasn't changed much: on other R-Car generations we also didn't
> > > know which clock(s) are gated by a single MSTP (Module SToP) bit.
> > > Historically (old SH parts), there was only a single clock supplying
> > > each module. Modules on later SoCs gained more clock supplies.
> > > Hence we always assumed (at least) the functional clock is gated by
> > > the MSTP bit, and modelled the gateable SMTP clocks as a child of the
> >
> > Sometimes I want to gate everybody's SMTP clocks :D
> >
> > > functional clock parent.  But it's quite possible other clock inputs
> > > to the module are gated, too, depending on the actual module (some
> > > modules e.g. need a PHY clock running to be able to process wake-up
> > > events).
> >
> > Yes, it's not new.
> >
> > /me wants to get a copy of the RTL alongside the user manual
> >
> > > Comparing older R-Car with R-Car Gen5, I actually like how the new
> > > MDLC block combines the power domain functionality of the old SYSC
> > > block and the clock domain functionality of the old MSSR (Module Standby
> > > and Software Reset) block. It improves upon the now imprecise modelling
> > > of MSTP clocks, and maps nicely on the Linux PM Domain abstraction:
> > >   - power domain: generic_pm_domain.power_{on,off}(domain),
> > >   - clock domain: generic_pm_domain.dev_ops.{start,stop}(device).
> >
> > I *think* I like the resulting DT better. As the module standby feature
> > is now listed in the power-domains property, even if we model it
> > internally as a clock, it doesn't appear as a clock any more in DT.
> > Clocks the drivers need have to be listed independently, which decouples
> > them from the module standby.
> 
> Agreed.
> 
> > > > > Higher-up parents should not be needed iff the SCMI firmware exposed
> > > > > and/or implements the proper clock hierarchy (which it does not at
> > > > > the moment).
> > > >
> > > > A big *iff* :-)
> > > >
> > > > Even in that case, we'll have (at least) two issues:
> > > >
> > > > - Some modules may need to know the rate of the functional clock gated
> > > >   by the MDLC. As those clocks are controlled through power domains,
> > > >   they are only specified as the last cell of the power-domains
> > > >   property, and are not listed in the clocks property. How do you
> > > >   envision this to work ?
> > >
> > > The functional clock (or its parent) is still listed in the clocks
> > > property.  Compare e.g. the hscif0 nodes on R-Car V4H:
> > >
> > >     clocks = <&cpg CPG_MOD 514>,
> > >              <&cpg CPG_CORE R8A779G0_CLK_SASYNCPERD1>,
> > >              <&scif_clk>;
> > >     clock-names = "fck", "brg_int", "scif_clk";
> > >     power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> > >     resets = <&cpg 514>;
> > >
> > > and R-Car X5H:
> > >
> > >     clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
> > >              <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
> > >              <&scif_clk>;
> > >     clock-names = "fck", "brg_int", "scif_clk";
> > >     power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x54>;
> > >     resets = <&mdlc_perw 0x54>;
> > >
> > > On R-Car V4H, MSTP514 aka "hscif0" is modelled as a gateable MSTP
> > > clock with parent R8A779G0_CLK_SASYNCPERD1, and used as "fck".
> > > On R-Car X5H, R8A78000_CPG_SGASYNCD4_PERW_BUS is used as "fck" directly.
> > > Calling clk_get_rate() on MSTP514 and R8A78000_CPG_SGASYNCD4_PERW_BUS
> > > gives similar results.
> >
> > On Gen5 we will then end up enabling the clock twice, once through the
> > power domain, and once through the explicit clk_enable(fck) in the
> > driver. I suppose that's fine in theory (there's an extra runtime cost
> 
> It depends, and can only be true for drivers that still do explicit
> clock management.

Yes, I forgot to mention that.

> Many drivers that don't need to know anything
> (e.g. the rate) about the clock have been modified to delegate this
> fully to Runtime PM.
> 
> On R-Car Gen5, the (now purely internal) module clock used for module
> standby is different from the "fck" clock in DT.  So perw 0x54 is
> controlled through Runtime PM, and SGASYNCD4_PERW_BUS is
> controlled by the SCIF driver directly (but it is a no-op as the bus clock is
> always-on).

I expect the FCK input of the IP core to be connected to the clock gated
by the MDLC. Using SGASYNCD4_PERW_BUS in DT is likely inaccurate. It
should work fine for now as the SCP firmware doesn't make the clock
controllable, but I'm not sure that the bus clock is really always on.
The dividers listed in the CPGMA* diagrams typically have clock gating
capability.

> On previous R-Car generations, "fck" is the module clock, and is
> enabled twice.
> 
> > though) as clocks are reference-counted. However, the current SCP
> > firmware reference-counts the clocks based on their SCMI ID, and the
> > MDLC clock (perw 0x54) and its parent (R8A78000_CPG_SGASYNCD4_PERW_BUS)
> > have different IDs. This can cause the clock to be disabled at an
> > unexpected point. In this specific case, however, given that
> > R8A78000_CPG_SGASYNCD4_PERW_BUS isn't controllable, it won't cause an
> > issue, but in the generic case it can fail badly.
> 
> Current SCP firmware indeed doesn't handle parent-child relations:
> e.g. perw 0x54 has a clock rate of zero, and is not a child of
> SGASYNCD4_PERW_BUS.  So the MDLC remapping driver ended up becoming
> responsible for controlling the parent clock if it is gateable, which
> is the case for e.g. MSIOF (see mod_map_in.fw_fck_parent).

It's worse than that. The firmware doesn't implement parent-child
relationships, but sometimes it tries to control the parent
independently from different children :-(

Look for instance at the DPCKCR register. bit CKSTP is documented as
gating the DP_EXT_VIO_DP[012] clocks. I expect that bit to actually gate
the parent clock, DP_EXT_VIO (from CPGMA1). However, the three separate
DP_EXT_VIO_DP[012] clocks exposed by the SCMI firmware (and named
SCP_CLOCK_ID_CLK_DP_EXT_OTHER[012] because consistent names wouldn't be
confusing enough) all map to the DPCKCR.CKSTP bit in the backend, and
are reference-counted separately. 

> > > > - When multiple clocks derive from the same PLL, it's common for the PLL
> > > >   rate to be specified through assigned-clock-rates. If we want to
> > > >   continue doing that, we need to to make the whole clock hierarchy
> > > >   available to DT.
> > >
> > > Yes, you need a public ID to refer to a clock from DT.
> > > Do you have an example where we would assigned-clock-rates it for a PLL?
> >
> > Not on Renesas platforms so far. I can imagine this being used to
> > control for instance the whole VIO hierarchy. Depending on the bandwidth
> > used by image sensors, system integrators may want to tweak the PLL
> > frequency.
> 
> A definition can be added when needed. Note that SCMI does not expose
> the PLLs to any agent anyway...

*sigh* x2

> > > So far all users of assigned-clock-rates on Renesas SoCs use it
> > > on clocks that are already public as they are also needed as clock
> > > supplies in clocks properties (e.g. CAN-FD and SPI reference clocks).
> > >
> > > > > Still, they can be internal enum, starting after the last
> > > > > DT clock, like we did in other R-Car clock drivers.
> > > > >
> > > > > > you think that's an issue, could it cause ABI problems in the future ?
> > > > >
> > > > > An ABI problem appears only when you refer in DT to a clock that does
> > > > > not exist in hardware.  This should be caught by testing before the
> > > > > DT user is added.
> > > >
> > > > So we could add e.g. SGASYNCD32 already, as long as we don't reference
> > > > it in DT without testing.
> > >
> > > We could, but which one: "_PERW_BUS" or "_PERW_MAIN"? Or both?
> >
> > See above :-)
> >
> > > And what's the point if there are no users?
> >
> > Future-proofing, to avoid adding the SGASYNCD32 clock later with a
> > non-consecutive ID.
> 
> Then perhaps we should add all clocks from the spreadsheet upfront?

It's tempting. Maybe doing it per-hierarchy ? When enabling devices in
the VIO hierachy, I ended up verifying most of the clocks anyway. We can
then try to spot all inconsistencies and ask for confirmation.

> > > BTW, there are 87 SGD4_* clocks listed in the documentation.  They are
> > > all sourced from the same PLL, and have all the same clock rate.
> > > I don't think any of these can be gated.  Hence if I would write a
> > > bare metal clock driver, I would just expose and instantiate a single
> > > SGD4 clock.  But the current SCMI implementation exposes 87 different
> > > clocks (and didn't make them usable by Linux until recently)...
> > >
> > > Perhaps we should drop the domain suffixes from the definitions? Even
> > > e.g. MSOCK_PERW_BUS and MSOCK_PERW_MAIN seem to be the same clock...
> >
> > I think we should also ask for names to be double-checked and fixed in
> > the next version of the documentation.

-- 
Regards,

Laurent Pinchart
