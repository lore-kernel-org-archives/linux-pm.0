From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Thu, 6 Nov 2014 20:05:26 +0100
Message-ID: <CAPDyKFqR6Pu++pGmQ2EM-RvHE4ueeB32OSE_spE+qq3SzH7kQQ@mail.gmail.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
	<1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
	<542C2D9F.8060005@samsung.com>
	<CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
	<542D3E45.5020908@samsung.com>
	<CAPDyKFozS+J_sTZykF=9tVJsCByby_BDuQmGiMt-Uw-qC4Tzuw@mail.gmail.com>
	<542D7525.8000804@samsung.com>
	<CAPDyKFqi=eKYBXSuRPzTZ0vybRfV6oMNt-_vCqT-6+otGiMucQ@mail.gmail.com>
	<545B9A6D.5060206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <545B9A6D.5060206@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>
>> Yes they would, although they require some minor additional adaptations.
>>
>> Those resources that are enabled from the driver's runtime PM resume
>> callback, should also be enabled during ->probe(). The
>> pm_runtime_set_active() will then update the state to reflect this.
>>
>> Then, if CONFIG_PM_RUNTIME is enabled - the device will be scheduled
>> to go inactive from driver core (pm_request_idle()), after ->probe()
>> has completed. Thus saving power if it's unused.
>> If CONFIG_PM_RUNTIME isn't enabled - the driver will still be
>> functional, since all resources are enabled during ->probe().
>
> OK, I suspected you also assumed enabling relevant resources, so the PM
> state matches the hardware state.
>
> Sorry for getting back late to this, now there is a regression on
> Exynos seen in multiple drivers, i.e. affecting all the media and
> video devices.  Is this patch series going to be merged for v3.18 as
> a regression fix ? If so I would need to update remaining drivers to
> enable clocks and use pm_runtime_set_active() in probe().

Urgh!!! Let's see how we can work this out. I will be helping out and
give this the highest prio!

I did post a patchset for exynos 5 media gsc driver, I guess you have
seen it!? Now, that doesn't help us much but still.
https://www.mail-archive.com/linux-media@vger.kernel.org/msg80592.html

>
> I can see two options to fix bugs which appeared in Exynos after
> merging the patch series switching to the OF generic power domain API:
>
> 1. merge this series and update the affected drivers for v3.18,

This version is superseded by a v3. That takes a more solid approach
on how to power on the PM domain from the bus' ->probe(). It's being
discussed currently.

[PATCH v3 0/9] PM / Domains: Fix race conditions during boot

You should be on cc-list of that.

>
> 2. revert for now to the previous behaviour, doing something as
>    the patch below.
>
> 1. seems only a partial solution, since the regression remains for the
> loadable modules which are loaded after late_initcall().  At that point
> power domain may be disabled and the driver attempting to access
> the hardware will hand the system.

That was a limitation which is fixed in v3. I have tested loading
modules and it works nicely.

>
> It's also a bit not clear to me why there is an assumption that when
> a power domain is initially enabled all its corresponding devices are
> already also fully activated ?

That's a very good question! I think the assumption is wrong!

Somehow we need to decouple that dependency. To me, typically the
"need_restore" flag should reflect the current runtime PM status of
the device, which isn't the case right now.

In the v3 version of this patchset, the PM domain will be powered on
from the bus's ->probe(), which also means the "need_restore" flag
will initially always be set to "false" once the device are being
probed by the driver.

That means, those drivers not invoking pm_runtime_set_active() and
manually enable clk/resources during ->probe(), but instead relies on
pm_runtime_get_sync() - will _not_ work. As you stated above for some
of the Exynos drivers.

Even if it's likely that most of these Exynos drivers should be using
pm_runtime_set_active() during ->probe(), the key-problem lies in
genpd's wrong assumption about the device's runtime PM status, which
is stored in the "need restore" flag.

If we would fix the issue in genpd for the need_restore flag, that
should solve the regression for Exynos, don't you think?

I will immediately start working on a patch on genpd, which tries this
approach, I will keep you posted.

>
> int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>                           struct gpd_timing_data *td)
> {
>         ...
>         gpd_data->need_restore = genpd->status == GPD_STATE_POWER_OFF;
>         ...
> }
>
> It seems correct to me to have initially the power domain enabled and some
> devices inactive, e.g. if device's driver manages its clocks and didn't
> turn them on yet.

As stated, I fully agree!

[...]

Kind regards
Uffe
