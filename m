From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ARM: gic: Document Power and Clock Domain optional
 properties
Date: Wed, 29 Apr 2015 13:57:04 +0100
Message-ID: <20150429125703.GB11757@leverpostej>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
 <20150427155427.GB16191@leverpostej>
 <CAMuHMdVT=vzFazUsJtvPsyB8zX-WJqp19RNVYA=UMfWZtHnF=Q@mail.gmail.com>
 <20150427171502.GD16191@leverpostej>
 <CAMuHMdVY5Oh7b9Pme2jiwtV4GBPqK-T5nfxnB9_1ufFzueUjLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVY5Oh7b9Pme2jiwtV4GBPqK-T5nfxnB9_1ufFzueUjLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

> >> >> To preserve DT stability, we would like to add these properties to the
> >> >> affected shmobile dtsi files.
> >> >
> >> > ... which means that they could be wrong, and will get in the way of
> >> > stability rather than aiding it.
> >>
> >> We do know the GIC is part of the power domain, and has a controllable
> >> clock (on the affected SoCs).
> >
> > ... my concern is that the data we place into the DT will be untested
> > given that we don't have software relying on it. If said data is not
> > correct, it is harmful to have, especially for such fundamental
> > properties.
> 
> Your statement challenges the viability of Stable DT Requirements, as we
> can thus never write a DTS until the full software implementation has been
> completed ;-)

I appreciate this is difficult, but I disagree that it's impossible ;)

If you don't want to do clock management currently, don't describe the
clock controller, have some FW/loader pre-program the clocks, and list
fixed-clocks in the DTB. This DTB should continue to work, but a new
kernel alone won't give you fancy clock management. This is what we
expect in terms of stable DTBs.

When you add clock controller support, you need a different DT to
describe the clock controller anyway. You can have it nuke the clock
configuration at boot time as a test that everything you need is
described.

> >> > I'm also concerned that the carving up of clock inputs, power domains,
> >> > and other physical details is implementation-specific. I imagine that
> >> > pretty much every user that will care about this is using GIC-400, so
> >> > could we make this specific to GIC-400?
> >>
> >> I have no idea which GIC version is being used.
> >
> > This is unfortunate.
> >
> >> This is for Renesas R-Mobile APE6 (r8a73a4) and various R-Car Gen2.
> >> According to the DTS, they're compatible with "arm,cortex-a15-gic" and
> >> "arm,cortex-a7-gic", and work with that value.
> >
> > Who put the DT together in the first place?
> 
> Magnus (added to CC).
> 
> > If it's a multi-cluster SoC then we know that we're not using any
> > built-in distributor...
> 
> R-Mobile APE6 has 2 clusters (4xCA15 and 4xCA7).
> R-Car Gen2 has 1 or 2 clusters (2/4xCA15 and/or 2/4xCA7).

It looks like we should be able to read the GICD_IIDR to figure out what
imlpementation is used. Could you see what GICD_IIDR reports on those
platforms? There's a patch at the end of the email to do so.

[...]

> >> >> +- clocks        : A phandle and clock specifier as defined by bindings of
> >> >> +               the clock controller specified by phandle, used when the GIC
> >> >> +               is part of a Clock Domain.
> >> >
> >> > Depending on implementation, a GIC could require multiple clocks, and
> >> > their names would be implementation-specific (that said, GIC-400 has a
> >> > single "CLK" input).
> >>
> >> Documentation/devicetree/bindings/arm/gic.txt doesn't mention any clocks
> >> for GIC-400?
> >
> > I'm going by the TRM. There are other items not in the bindign that are
> > implementation-specific.
> >
> >> > Assuming that you're using GIC-400, could we use clock-names to make
> >> > that explicit?
> >>
> >> You can. But you have to be careful to avoid conflicts, as the controller
> >> for the clock domain needs to know which clock to use.
> >
> > Could you elborate on that? I don't see why a node's clock-names
> > property should be relevant to the clock controller.
> 
> If there are multiple clocks listed, the clock controller needs to know which
> clocks is to be used for power management.
> 
> If we standardize on a name for the clock to be used for power management
> (a platform property), that could conflict with the naming in the binding
> for the device.
> Some device bindings don't mandate clock-names as only a single clock
> is used.
> Other device bindings do mandate clock-names. You mentioned "CLK" for
> GIC-400, others use e.g. "fck", or "ick".

The clock-names should be device-binding specific. Nothing else should
be there. If you want to do fancy maangement of device clocks, the
device drivers should register with the appropriate frameworks to do so,
and nothing else needs to inspect the clock-names for the device itself.

> >> On Renesas SoCs, we always used the first clock for power control.
> >> For the future, we plan to use "fck" if it exists.
> >
> > That's irrelevant from the PoV of the GIC; per the GIC architecture you
> > can't assume anything about the set of input clocks, and GIC-400 happens
> > to have a single clock input called "CLK". It's not IP specific to
> > Renesas.
> >
> >> Yes, this can be complicated, as ideally it needs synchronization between
> >> device DT bindings and platform (clock/power domain) DT bindings.
> >>
> >> Please also note that any device (hardware IP core) can be reused on an
> >> SoC that supports clock and/or power domains, and suddenly starts to rely
> >> on power-domains and clocks properties.
> >
> > Sorry, I don't follow this last part.
> 
> Devices may describe zero, one, or more clocks in the DT bindings. Usually
> these clocks are functional, and they are described because the driver needs
> to control them, and/or needs knowledge about them.
> 
> As all (current) logic is synchronous, there's always a clock that drives the
> logic of the device. Gating this clock can be used for power management.
> This clock may or may not be the one described in the bindings (obviously
> it isn't if the binding doesn't describe any clock, but there can be other
> cases).
> 
> Any IP core for a device may be reused. On some SoCs, the logic may be
> driven by a fixed, non-gateable clock. On others the logic may be driven by
> a gateable clock to save power. Whether or not there is a gateable clock
> is a property of the platform (SoC), not of the IP core.

I agree that the provider of any clock (and it's feature such as
gateability) is not device specific. 

What I am saying is that the set of input lines on an IP block (to which
clocks may be connected) are a property of that IP block. As mentioned
above, GIC-400 always has a clock input line called "CLK", though this
could be wired to arbitrary clock providers, which might call their
output line arbitrary names (e.g. "GIC_CLK").

If bindings are missing functional clocks, those can be added to the
bindings, and we can warn when they are not present. These clocks are
all specific to the particular IP blocks however, so applying an
SoC-specific naming policy to these does not make sense.

Thanks,
Mark.

---->8----
>From 8bd8a5fe42d25b45515ef3152ff921d2180a8120 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Date: Wed, 29 Apr 2015 13:54:03 +0100
Subject: [PATCH] irqchip: gic: report GICD_IIDR

The GICD_IIDR register provides information about the implementer and
revision of the GIC distributor. In some cases this information is
useful for debugging, so log this when probing the GIC.

Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
---
 drivers/irqchip/irq-gic.c       | 4 ++++
 include/linux/irqchip/arm-gic.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 7b315e3..02c8bb4 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -959,6 +959,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
 	int gic_irqs, irq_base, i;
+	unsigned long iidr;
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
@@ -996,6 +997,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_set_base_accessor(gic, gic_get_common_base);
 	}
 
+	iidr = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_IIDR);
+	pr_info("GICD_IIDR reports 0x%08lx\n", (unsigned long)iidr);
+
 	/*
 	 * Initialize the CPU interface map to all CPUs.
 	 * It will be refined as each CPU probes its ID.
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 36ec4ae..c29df66 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -29,6 +29,7 @@
 
 #define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
+#define GIC_DIST_IIDR			0x008
 #define GIC_DIST_IGROUP			0x080
 #define GIC_DIST_ENABLE_SET		0x100
 #define GIC_DIST_ENABLE_CLEAR		0x180
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
