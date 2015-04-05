From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
Date: Sun, 5 Apr 2015 10:55:06 +0200
Message-ID: <CAMuHMdWmuh5f9QAaJdp_W2oVpGgJM1TX3AUntYtkTkVJnhFg5A@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
	<1428064923-24950-6-git-send-email-geert+renesas@glider.be>
	<20150403125727.GT10964@mwanda>
	<20150403170407.GA13898@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150403170407.GA13898-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, driverdevel <devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Russell,

On Fri, Apr 3, 2015 at 7:04 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Fri, Apr 03, 2015 at 03:57:27PM +0300, Dan Carpenter wrote:
>> On Fri, Apr 03, 2015 at 02:42:02PM +0200, Geert Uytterhoeven wrote:
>> > +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
>> > +{
>> > +   struct clk *clk;
>> > +   int error;
>> > +
>> > +   pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
>> > +            bsc->con_id, bsc->dev_id);
>> > +   clk = clk_get(NULL, bsc->clk);
>> > +   if (IS_ERR(clk)) {
>> > +           error = PTR_ERR(clk);
>> > +           pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
>> > +           return error;
>> > +   }
>> > +
>> > +   error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
>> > +   if (error)
>> > +           pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
>> > +           return error;
>>
>> Missing curly braces.  Also it's weird that don't we need a clk_put()
>> on the error patch as well as the success path?
>
> What's also concerning is that this is an abuse of this.
>
> clk_register_clkdev() is supposed to be used with clocks created with
> the CCF functions, it's not for creating aliases.
>
> We have clk_add_alias() which does *everything* that this function does,
> only in a less buggy way.

Thanks, I didn't know about clk_add_alias(). I had based the above on long gone
code under arch/arm/mach-shmobile to use platform devices with CCF.

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
