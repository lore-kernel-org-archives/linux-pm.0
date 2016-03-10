From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 05/11] soc: renesas: rcar-sysc: Enable Clock Domain for
 r8a7795 I/O devices
Date: Thu, 10 Mar 2016 10:51:22 +0100
Message-ID: <CAMuHMdUBVBRHrWT9hLH1V23LbBGrM=a5hGGVrv_F5cjPT4+TVw@mail.gmail.com>
References: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
	<1457551127-21934-6-git-send-email-geert+renesas@glider.be>
	<2523920.fzA0Elmkzz@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2523920.fzA0Elmkzz@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Thu, Mar 10, 2016 at 10:40 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 09 March 2016 20:18:41 Geert Uytterhoeven wrote:
>> On R-Car H3, some power areas (e.g. A3VP) contain I/O devices, which are
>> also part of the CPG/MSSR Clock Domain.  Hook up the CPG/MSSR Clock
>> Domain attach/detach callbacks to enable power management using module
>> clocks.
>>
>> This also allows to support the Clock Domain for devices in the
>> "always-on" power area.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> --- a/drivers/soc/renesas/rcar-sysc.c
>> +++ b/drivers/soc/renesas/rcar-sysc.c

>> @@ -251,6 +252,15 @@ static void __init rcar_sysc_pd_setup(struct
>> device_node *np, gov = &pm_domain_always_on_gov;
>>       }
>>
>> +#ifdef CONFIG_ARCH_R8A7795
>
> This is fine for now as the R8A7795 is the only ARM64 model in the R-Car
> family, but how do you plan to move forward on this ? Will it be enabled for
> ARM64 SoCs straight away, and for ARM32 SoCs when switching from the cpg to
> the always-on power domain ?
>
>> +     if (!(pd->flags & (PD_CPU | PD_SCU))) {
>> +             /* Enable Clock Domain for I/O devices */
>> +             genpd->flags = GENPD_FLAG_PM_CLK;
>> +             genpd->attach_dev = cpg_mssr_attach_dev;
>> +             genpd->detach_dev = cpg_mssr_detach_dev;
>> +     }
>> +#endif

When enabling the always-on power domain for R-Car H1 and Gen2, this
should become:

        if (!(pd->flags & (PD_CPU | PD_SCU))) {
                /* Enable Clock Domain for I/O devices */
                genpd->flags = GENPD_FLAG_PM_CLK;
#ifdef CONFIG_ARCH_R8A7795 /* or CONFIG_ARM64 */
                genpd->attach_dev = cpg_mssr_attach_dev;
                genpd->detach_dev = cpg_mssr_detach_dev;
#else
                genpd->attach_dev = cpg_mstp_attach_dev;
                genpd->detach_dev = cpg_mstp_detach_dev;
#endif

It becomes more gory when migrating R-Car H1 and Gen2 to CPG/MSSR, and
maintaining backwards compatibility, as which callbacks to choose will depend
on the presence of "renesas,cpg-mstp-clocks" device nodes in DT, and a new
CONFIG_CLK_RENESAS_LEGACY option.
Needless to say, it'll be more complex if not all SoCs migrate at once...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
