From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC
 PM domains
Date: Mon, 18 Apr 2016 14:59:43 +0200
Message-ID: <CAMuHMdW+PboSz-u2dV=rmNFkd4qsEhm-O_4Ewdn_-H62gwq7Ng@mail.gmail.com>
References: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
	<1460558672-10290-4-git-send-email-geert+renesas@glider.be>
	<CAPDyKFrQtX3-7GodrXV2zp4wHBgbWBOVKyE0XoeWaaxhZ2kUuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrQtX3-7GodrXV2zp4wHBgbWBOVKyE0XoeWaaxhZ2kUuw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Mon, Apr 18, 2016 at 2:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>> +
>> +static bool rcar_sysc_active_wakeup(struct device *dev)
>> +{
>> +       return true;
>
> I am interested to know why this is always returning true. Perhaps you
> can elaborate a bit on that?

Too many copying from old shmobile PM Domain code?
Honestly, I don't know...

Perhaps Rafael still remembers the original rationale, as git history for
commit e3e0109138376bb2 ("ARM / shmobile: Support for I/O power domains for
SH7372 (v9)") doesn't have it.

Google did find: https://lkml.org/lkml/2011/6/30/471

Do we still need this at all? I.e. aren't PM Domains containing wake-up
devices kept powered automatically during system suspend?

>> +static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
>> +{
>> +       struct generic_pm_domain *genpd = &pd->genpd;
>> +       const char *name = pd->genpd.name;
>> +       struct dev_power_governor *gov = &simple_qos_governor;
>> +
>> +       if (pd->flags & PD_CPU) {
>> +               /*
>> +                * This domain contains a CPU core and therefore it should
>> +                * only be turned off if the CPU is not in use.
>> +                */
>> +               pr_debug("PM domain %s contains %s\n", name, "CPU");
>> +               pd->flags |= PD_BUSY;
>> +               gov = &pm_domain_always_on_gov;
>> +       } else if (pd->flags & PD_SCU) {
>> +               /*
>> +                * This domain contains an SCU and cache-controller, and
>> +                * therefore it should only be turned off if the CPU cores are
>> +                * not in use.
>> +                */
>> +               pr_debug("PM domain %s contains %s\n", name, "SCU");
>> +               pd->flags |= PD_BUSY;
>> +               gov = &pm_domain_always_on_gov;
>> +       } else if (pd->flags & PD_NO_CR) {
>> +               /*
>> +                * This domain cannot be turned off.
>> +                */
>> +               pd->flags |= PD_BUSY;
>> +               gov = &pm_domain_always_on_gov;
>> +       }
>> +
>> +       pm_genpd_init(genpd, gov, false);
>
> This seems weird. I don't think it correct to initialize genpd and
> then continue with the below changes (assigning callbacks and power up
> the domain).

I'm quite sure I wondered the same (for pm-rmobile), but discovered that
pm_genpd_init() overwrote something. Unfortunately I can't find the commit
that changed that...

> I would recommend doing this in the reverse order.
>
>> +       genpd->dev_ops.active_wakeup = rcar_sysc_active_wakeup;
>> +       genpd->power_off = rcar_sysc_pd_power_off;
>> +       genpd->power_on = rcar_sysc_pd_power_on;

OK, will give that a try...

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
