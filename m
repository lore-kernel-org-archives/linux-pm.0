From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2 04/11] soc: renesas: rcar: Add DT support for SYSC PM domains
Date: Fri, 26 Feb 2016 18:28:55 +0200
Message-ID: <5625748.8DscGPjtYP@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be> <3535519.g4KL1PCIZy@avalon> <CAMuHMdVo2V7Ez5g8ZW74w-QWiwS8i2mbYeCjOU9brxRzNjMAdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVo2V7Ez5g8ZW74w-QWiwS8i2mbYeCjOU9brxRzNjMAdg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Friday 26 February 2016 16:41:27 Geert Uytterhoeven wrote:
> On Mon, Feb 15, 2016 at 11:51 PM, Laurent Pinchart wrote:
> >>  drivers/soc/renesas/pm-rcar.c | 327 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 327 insertions(+)
> >> 
> >> diff --git a/drivers/soc/renesas/pm-rcar.c
> >> b/drivers/soc/renesas/pm-rcar.c
> >> index cc684e9cc8db5d1c..c0540934126e58eb 100644
> >> --- a/drivers/soc/renesas/pm-rcar.c
> >> +++ b/drivers/soc/renesas/pm-rcar.c
> >> 
> >> +static int __init rcar_init_pm_domains(void)
> >> +{
> >> +     const struct of_device_id *match;
> >> +     struct device_node *np, *pmd;
> >> +     bool scanned = false;
> >> +     void __iomem *base;
> >> +     int ret = 0;
> >> +
> >> +     for_each_matching_node_and_match(np, rcar_sysc_matches, &match) {
> >> +             u32 syscier = 0;
> >> +
> >> +             rcar_gen = (uintptr_t)match->data;
> >> +
> >> +             base = of_iomap(np, 0);
> >> +             if (!base) {
> >> +                     pr_warn("%s cannot map reg 0\n", np->full_name);
> >> +                     continue;
> >> +             }
> >> +
> >> +             rcar_sysc_base = base;  // FIXME conflicts with
> >> rcar_sysc_init() +
> >> +             pmd = of_get_child_by_name(np, "pm-domains");
> >> +             if (!pmd) {
> >> +                     pr_warn("%s lacks pm-domains node\n",
> >> np->full_name);
> > 
> > Shouldn't you call iounmap() here ?
> 
> Yes. Will fix.
> 
> >> +             /*
> >> +              * Enable all interrupt sources, but do not use interrupt
> >> +              * handler
> >> +              */
> >> +             pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
> >> +             iowrite32(syscier, rcar_sysc_base + SYSCIER);
> >> +             iowrite32(0, rcar_sysc_base + SYSCIMR);
> > 
> > Shouldn't the SYSCIMR bits be set to 1 to mask interrupts ?
> 
> That would work, too. It doesn't matter much, as the driver doesn't use
> interrupts, so they stay disabled at the GIC level.

You're right, but as you write to the SYSCIMR register anyway, I'd feel safer 
if interrupts were masked in it too.

-- 
Regards,

Laurent Pinchart
