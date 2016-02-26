From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC v2 04/11] soc: renesas: rcar: Add DT support for SYSC
 PM domains
Date: Fri, 26 Feb 2016 16:41:27 +0100
Message-ID: <CAMuHMdVo2V7Ez5g8ZW74w-QWiwS8i2mbYeCjOU9brxRzNjMAdg@mail.gmail.com>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
	<1455571020-18968-5-git-send-email-geert+renesas@glider.be>
	<3535519.g4KL1PCIZy@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3535519.g4KL1PCIZy@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Mon, Feb 15, 2016 at 11:51 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>>  drivers/soc/renesas/pm-rcar.c | 327 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 327 insertions(+)
>>
>> diff --git a/drivers/soc/renesas/pm-rcar.c b/drivers/soc/renesas/pm-rcar.c
>> index cc684e9cc8db5d1c..c0540934126e58eb 100644
>> --- a/drivers/soc/renesas/pm-rcar.c
>> +++ b/drivers/soc/renesas/pm-rcar.c

>> +static int __init rcar_init_pm_domains(void)
>> +{
>> +     const struct of_device_id *match;
>> +     struct device_node *np, *pmd;
>> +     bool scanned = false;
>> +     void __iomem *base;
>> +     int ret = 0;
>> +
>> +     for_each_matching_node_and_match(np, rcar_sysc_matches, &match) {
>> +             u32 syscier = 0;
>> +
>> +             rcar_gen = (uintptr_t)match->data;
>> +
>> +             base = of_iomap(np, 0);
>> +             if (!base) {
>> +                     pr_warn("%s cannot map reg 0\n", np->full_name);
>> +                     continue;
>> +             }
>> +
>> +             rcar_sysc_base = base;  // FIXME conflicts with rcar_sysc_init()
>> +
>> +             pmd = of_get_child_by_name(np, "pm-domains");
>> +             if (!pmd) {
>> +                     pr_warn("%s lacks pm-domains node\n", np->full_name);
>
> Shouldn't you call iounmap() here ?

Yes. Will fix.

>> +             /*
>> +              * Enable all interrupt sources, but do not use interrupt
>> +              * handler
>> +              */
>> +             pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
>> +             iowrite32(syscier, rcar_sysc_base + SYSCIER);
>> +             iowrite32(0, rcar_sysc_base + SYSCIMR);
>
> Shouldn't the SYSCIMR bits be set to 1 to mask interrupts ?

That would work, too. It doesn't matter much, as the driver doesn't use
interrupts, so they stay disabled at the GIC level.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
