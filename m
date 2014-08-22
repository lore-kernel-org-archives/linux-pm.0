From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/24] PM / Domains: Generic OF-based support and cleanups
Date: Fri, 22 Aug 2014 17:56:25 +0200
Message-ID: <CAPDyKFpXPO+BZu4g0uDwmS7h+QjpiXYVpSz2Yt1F4Ro6UBTJTg@mail.gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
	<CAMuHMdWLLcWvgvY_nC4doEGnHxNJEQfx5RYbJqZfjm0UT=J47Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:50455 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbaHVP41 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 11:56:27 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so10317623lab.35
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2014 08:56:25 -0700 (PDT)
In-Reply-To: <CAMuHMdWLLcWvgvY_nC4doEGnHxNJEQfx5RYbJqZfjm0UT=J47Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>

On 22 August 2014 14:15, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf, Tomasz,
>
> On Tue, Jun 10, 2014 at 12:51 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Parts of this patchset has been posted earlier. To be able to smoothly continue
>> my work in re-factoring genpd I have collected patches into this patchset.
>>
>> The complete patchset is available at the linux-pm_linux-next_genpd branch at:
>> git.linaro.org/people/ulf.hansson/linux-2.6.git
>> This branch is based upon Rafael's linux-pm tree's linux-next branch.
>>
>> And important note. There are dependencies througout this patchset, which means
>> the all need to go together. I suggest we use Rafael's tree, thus I seek for
>> acks from the affected ARM SoC maintainers.
>>
>> Tomasz Figa (3):
>>   base: power: Add generic OF-based power domain look-up
>>   drivercore: Bind/unbind power domain on probe/remove
>>   ARM: exynos: Move to generic power domain bindings
>>
>> Ulf Hansson (21):
>>   PM / Domains: Ignore callbacks for subsys generic_pm_domain_data
>>   PM / Domains: Remove the pm_genpd_add|remove_callbacks APIs
>>   PM / Domains: Remove system PM callbacks from gpd_dev_ops
>>   ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd config
>>   ARM: shmobile: Drop dev_irq_safe from R-mobile genpd config
>>   PM / Domains: Remove dev_irq_safe from genpd config
>>   PM / Domains: Remove redundant check for CONFIG_PM
>>   PM / Domains: Remove legacy API for adding devices through DT
>>   PM / Domains: Remove pm_genpd_syscore_switch() API
>>   PM / Domains: Remove genpd_queue_power_off_work() API
>>   PM / Domains: Add late_initcall to disable unused domains
>>   ARM: exynos: Leave disabling of unused pm domains to genpd
>>   ARM: s3c64xx: Leave disabling of unused pm domains to genpd
>>   drivers: sh: Leave disabling of unused pm domains to genpd
>>   PM / Domains: Remove default_stop_ok() API
>>   dt: bindings: ux500: Add documentation for power domains
>>   dt: bindings: ux500: Add header for power domains specifiers
>>   ARM: ux500: Initial support for power domains
>>   ARM: ux500: Enable Kconfig for the generic power domain
>>   ARM: ux500: Add DT node for ux500 power domains
>>   ARM: ux500: Add sdi[n] devices to VAPE power domain
>
> What are your plans with this patch series?
>
> Thanks!

I have been working on the generic power domain DT parts. It needs
some more tests, but will for sure post and new patchset early next
week.

Then there are two more separate series:
1.. "The genpd cleanup/small-fixes" - I will also post this soon,
re-based and separate from the other series.
2. "Genpd support for ux500" - I will keep this one on hold, until the
generic power domain DT patchset has been accepted.

Kind regards
Uffe

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
