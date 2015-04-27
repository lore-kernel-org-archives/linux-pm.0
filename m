From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: gic: Document Power and Clock Domain optional
 properties
Date: Mon, 27 Apr 2015 18:15:03 +0100
Message-ID: <20150427171502.GD16191@leverpostej>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
 <20150427155427.GB16191@leverpostej>
 <CAMuHMdVT=vzFazUsJtvPsyB8zX-WJqp19RNVYA=UMfWZtHnF=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57268 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbbD0RPM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Apr 2015 13:15:12 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVT=vzFazUsJtvPsyB8zX-WJqp19RNVYA=UMfWZtHnF=Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 27, 2015 at 05:43:13PM +0100, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Mon, Apr 27, 2015 at 5:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Apr 27, 2015 at 04:00:11PM +0100, Geert Uytterhoeven wrote:
> >> On some SoCs, the GIC may be part of a PM Domain (hardware Power and/or
> >> Clock Domain).  Document the related optional DT properties.
> >>
> >> Note: As the current GIC driver doesn't support Runtime PM yet, PM
> >> Domain constraints must be handled elsewhere in e.g. platform code.
> >
> > I'm worried that without a current user these properties aren't going to
> > see any testing...
> 
> Still, DT is supposed to describe the hardware. Even if the driver doesn't
> use the description.

I appreciate that...

> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> To preserve DT stability, we would like to add these properties to the
> >> affected shmobile dtsi files.
> >
> > ... which means that they could be wrong, and will get in the way of
> > stability rather than aiding it.
> 
> We do know the GIC is part of the power domain, and has a controllable
> clock (on the affected SoCs).

... my concern is that the data we place into the DT will be untested
given that we don't have software relying on it. If said data is not
correct, it is harmful to have, especially for such fundamental
properties.

> > I'm also concerned that the carving up of clock inputs, power domains,
> > and other physical details is implementation-specific. I imagine that
> > pretty much every user that will care about this is using GIC-400, so
> > could we make this specific to GIC-400?
> 
> I have no idea which GIC version is being used.

This is unfortunate.

> This is for Renesas R-Mobile APE6 (r8a73a4) and various R-Car Gen2.
> According to the DTS, they're compatible with "arm,cortex-a15-gic" and
> "arm,cortex-a7-gic", and work with that value.

Who put the DT together in the first place?

If it's a multi-cluster SoC then we know that we're not using any
built-in distributor...

> >> On Thu, Mar 26, 2015 at 11:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> > On 25/03/15 21:19, Geert Uytterhoeven wrote:
> >> >> I would like to add the clock and GIC dependency on the clock in the DTS now,
> >> >> for reasons of DTS stability. But that means I need a temporary workaround
> >> >> to avoid the clock from being disabled, until the GIC driver handles this.
> >> >>
> >> >> I don't expect a fix for the GIC code to just show up magically. I just wanted
> >> >> you to be aware of the problem. GIC is not the only problematic module here,
> >> >> there are others, cfr. the last slide of [2].
> >> >
> >> > As long as there is an agreement from the DT people on the presence of
> >> > that extra property in the GIC node, I'm happy with that. I'd like it to
> >> > be documented though.
> >>
> >> Full thread at
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331876.html
> >>
> >>  Documentation/devicetree/bindings/arm/gic.txt | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> >> index 2da059a4790cb3c6..b21113b35f085f27 100644
> >> --- a/Documentation/devicetree/bindings/arm/gic.txt
> >> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> >> @@ -58,6 +58,14 @@ Optional
> >>    regions, used when the GIC doesn't have banked registers. The offset is
> >>    cpu-offset * cpu-nr.
> >>
> >> +- power-domains : A phandle and PM domain specifier as defined by bindings of
> >> +               the power controller specified by phandle, used when the GIC
> >> +               is part of a Power or Clock Domain.
> >
> > I imagine that it's possible for the distributor and CPU interfaces to
> > be in separate power domains in some implementaitons.
> 
> Possibly (then we're gonna need subnodes, each with their own
> power-domains properties?).

Potentially for such implementations, yes. To the best of my knowledge a
GIC-400 is a single block, which is one reason why it would be nice to
focus on that particular implementation if that's applicable.

> > Which components of the GIC does the apply to? The whole thing? Just the
> > GICD?
> 
> Unfortunately that's not documented...

That worries me somewhat, given my comments above, though I'd very much
suspect this is a GIC-400.

> >> +- clocks        : A phandle and clock specifier as defined by bindings of
> >> +               the clock controller specified by phandle, used when the GIC
> >> +               is part of a Clock Domain.
> >
> > Depending on implementation, a GIC could require multiple clocks, and
> > their names would be implementation-specific (that said, GIC-400 has a
> > single "CLK" input).
> 
> Documentation/devicetree/bindings/arm/gic.txt doesn't mention any clocks
> for GIC-400?

I'm going by the TRM. There are other items not in the bindign that are
implementation-specific.

> > Assuming that you're using GIC-400, could we use clock-names to make
> > that explicit?
> 
> You can. But you have to be careful to avoid conflicts, as the controller
> for the clock domain needs to know which clock to use.

Could you elborate on that? I don't see why a node's clock-names
property should be relevant to the clock controller.

> On Renesas SoCs, we always used the first clock for power control.
> For the future, we plan to use "fck" if it exists.

That's irrelevant from the PoV of the GIC; per the GIC architecture you
can't assume anything about the set of input clocks, and GIC-400 happens
to have a single clock input called "CLK". It's not IP specific to
Renesas.

> Yes, this can be complicated, as ideally it needs synchronization between
> device DT bindings and platform (clock/power domain) DT bindings.
> 
> Please also note that any device (hardware IP core) can be reused on an
> SoC that supports clock and/or power domains, and suddenly starts to rely
> on power-domains and clocks properties.

Sorry, I don't follow this last part.

Mark.
