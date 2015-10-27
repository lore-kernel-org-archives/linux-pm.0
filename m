From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v10 1/6] PM / Domains: prepare for multiple states
Date: Tue, 27 Oct 2015 18:04:54 +0100
Message-ID: <CAKXjFTPfOQOZRSk4b6WwaiiKzjTXMy6NO1XNES2_NkPyMme_HQ@mail.gmail.com>
References: <1445347589-5626-1-git-send-email-ahaslam@baylibre.com>
	<1445347589-5626-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFpk+beHDp4JPdNLFb5RqJfBJCu-mKpk5B0OM6WH8-SUPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpk+beHDp4JPdNLFb5RqJfBJCu-mKpk5B0OM6WH8-SUPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, geert@glider.be, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

>
> Hi Axel,
>
> Apologize for the delay in providing feedback.
>

Thanks for the review!

>> ---
>>  arch/arm/mach-exynos/pm_domains.c     |  2 +-
>>  arch/arm/mach-imx/gpc.c               |  2 +-
>>  arch/arm/mach-s3c64xx/pm.c            |  4 ++--
>>  arch/arm/mach-shmobile/pm-rmobile.c   |  2 +-
>>  arch/arm/mach-ux500/pm_domains.c      |  2 +-
>>  arch/arm/mach-zx/zx296702-pm-domain.c |  2 +-
>
> You don't need to make above changes.
>
> Instead of inventing pm_genpd_init_simple(), I would rather see that
> you add a new __pm_genpd_init() API. Let's make it take *only* a
> "struct generic_pm_domain *genpd" parameter.
> Moreover, to prevent code duplication, adopt the code in
> pm_genpd_init() so it can invoke __pm_genpd_init().
>
> Then, piece by piece we can convert users from the legacy
> pm_genpd_init() to the __pm_genpd_init().

Ok, ill do that insted.

>>
>> +struct gpd_cpuidle_data {
>> +       unsigned int saved_exit_latency;
>> +       struct cpuidle_state *idle_state;
>> +};
>
> This is probably some leftover from an old version, right?

yes! this slipped by when i re-based to next, i should have
paid more attention. ill remove it.

>
>> +
>> +struct genpd_power_state {
>> +       char *name;
>
> I am wondering a bit about the char *name. Do we really need it and if
> so, what's do you intend to use it for?
>
>

The *name is allocated and used only when CONFIG_PM_ADVANCED_DEBUG
is enabled, its used to print the status on debugfs, when genpd_summary is read.

for example:

#cat /d/pm_genpd/summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
b3                              OFF
b2                              OFF
b1                              OFF              b2, b3
a3                              OFF
    /devices/platform/D2                                suspended
a4                              RET
    /devices/platform/D1                                suspended
a2                              RET              a4
a1                              RET              a2, a3
cpg_clocks                      on



Regards
Axel.
