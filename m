From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: gic: Document Power and Clock Domain optional properties
Date: Wed, 29 Apr 2015 16:09:35 +0200
Message-ID: <CAMuHMdU1T9t8O8J4F0KkhcoeYO9sNLpp+jARaCEP0ZKiVgBqJA@mail.gmail.com>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
	<20150427155427.GB16191@leverpostej>
	<CAMuHMdVT=vzFazUsJtvPsyB8zX-WJqp19RNVYA=UMfWZtHnF=Q@mail.gmail.com>
	<20150427171502.GD16191@leverpostej>
	<CAMuHMdVY5Oh7b9Pme2jiwtV4GBPqK-T5nfxnB9_1ufFzueUjLA@mail.gmail.com>
	<20150429125703.GB11757@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150429125703.GB11757@leverpostej>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Wed, Apr 29, 2015 at 2:57 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> >> To preserve DT stability, we would like to add these properties to the
>> >> >> affected shmobile dtsi files.
>> >> >
>> >> > ... which means that they could be wrong, and will get in the way of
>> >> > stability rather than aiding it.
>> >>
>> >> We do know the GIC is part of the power domain, and has a controllable
>> >> clock (on the affected SoCs).
>> >
>> > ... my concern is that the data we place into the DT will be untested
>> > given that we don't have software relying on it. If said data is not
>> > correct, it is harmful to have, especially for such fundamental
>> > properties.
>>
>> Your statement challenges the viability of Stable DT Requirements, as we
>> can thus never write a DTS until the full software implementation has been
>> completed ;-)
>
> I appreciate this is difficult, but I disagree that it's impossible ;)
>
> If you don't want to do clock management currently, don't describe the
> clock controller, have some FW/loader pre-program the clocks, and list
> fixed-clocks in the DTB. This DTB should continue to work, but a new
> kernel alone won't give you fancy clock management. This is what we
> expect in terms of stable DTBs.
>
> When you add clock controller support, you need a different DT to
> describe the clock controller anyway. You can have it nuke the clock

Currently we have the clock controller in the DTS. It only lacks a few clocks
(like INTC-SYS -> GIC).

> configuration at boot time as a test that everything you need is
> described.

Don't worry, I have early boot code that disables all non-critical clocks.
This already caught many bugs (missing clock handling). It also caused a
bug, as I missed an interrupt storm due to a disabled clock ;-)

>> >> > I'm also concerned that the carving up of clock inputs, power domains,
>> >> > and other physical details is implementation-specific. I imagine that
>> >> > pretty much every user that will care about this is using GIC-400, so
>> >> > could we make this specific to GIC-400?
>> >>
>> >> I have no idea which GIC version is being used.
>> >
>> > This is unfortunate.
>> >
>> >> This is for Renesas R-Mobile APE6 (r8a73a4) and various R-Car Gen2.
>> >> According to the DTS, they're compatible with "arm,cortex-a15-gic" and
>> >> "arm,cortex-a7-gic", and work with that value.
>> >
>> > Who put the DT together in the first place?
>>
>> Magnus (added to CC).
>>
>> > If it's a multi-cluster SoC then we know that we're not using any
>> > built-in distributor...
>>
>> R-Mobile APE6 has 2 clusters (4xCA15 and 4xCA7).
>> R-Car Gen2 has 1 or 2 clusters (2/4xCA15 and/or 2/4xCA7).
>
> It looks like we should be able to read the GICD_IIDR to figure out what
> imlpementation is used. Could you see what GICD_IIDR reports on those
> platforms? There's a patch at the end of the email to do so.

Thanks!

  - R-Mobile APE6 (r8a73a4):        GICD_IIDR reports 0x0200043b
  - R-Car Gen M2-W (r8a7791):       GICD_IIDR reports 0x0200043b

        ProductID = 0x02 (GIC-400)
        Variant = 0x0
        Revision = 0x0
        Implementer = 0x43b (ARM)

So both are GIC-400 (in the mean time I found a reference to GIC-400 in
the APE6 docs).

I also ran it on a few other SoCs:

  - SH-Mobile AG5 (sh73a0):         GICD_IIDR reports 0x0102043b

        Implementation version = 0x01 (Cortex-A9 MPCore)
        Revision number = 0x020
        Implementer = 0x43b (ARM)

    Which GIC is that?

  - R-Mobile A1 (r8a7740):          GICD_IIDR reports 0x0000043b

        ProductID = 0x00 (GIC-500 or Cortex-A15 MPCore or PL390)
        Variant = 0x0
        Revision = 0x0
        Implementer = 0x43b (ARM)

    Seems like 0x0000043b can mean multiple things. Docs say PL390 r0p0.

> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 7b315e3..02c8bb4 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -959,6 +959,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>         irq_hw_number_t hwirq_base;
>         struct gic_chip_data *gic;
>         int gic_irqs, irq_base, i;
> +       unsigned long iidr;
>
>         BUG_ON(gic_nr >= MAX_GIC_NR);
>
> @@ -996,6 +997,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>                 gic_set_base_accessor(gic, gic_get_common_base);
>         }
>
> +       iidr = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_IIDR);
> +       pr_info("GICD_IIDR reports 0x%08lx\n", (unsigned long)iidr);

No need for the cast.

Perhaps just

        pr_debug("GICD_IIDR reports 0x%08lx\n",
                 readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_IIDR));

?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
