From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM/runtime issue: Device cannot runtime resume because power
 domain is off during system resume
Date: Wed, 29 Oct 2014 14:01:20 +0100
Message-ID: <CAPDyKFpy98h-BYnvhPSJy+p5=ynpXkhnjABYG4gMc+X1BCQSYA@mail.gmail.com>
References: <1413468302.5605.9.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413468302.5605.9.camel@AMDC1943>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16 October 2014 16:05, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> Hi,
>
> I encounter issues with DRM/panel driver for Exynos after resuming from
> suspend to RAM. This is reproduced on 3.16 but I think it is applicable
> also to mainline.
>
> The scenario:
> 0. DRM DSI is in LCD power domain. Power domain is OFF before
> suspending.
> 1. System suspends.
> 2. System resumes.
> 3. DRM driver:resume().
> 4. pm_runtime_get() for DRM DSI driver.
> 5. This should enable LCD power domain.
> 6. but __pm_genpd_poweron() exits early because:
>    genpd->prepared_count = 3

I am getting to this soonish in my genpd work. Currently I am working
on the boot issues. :-)

At a first glance, I think the genpd->prepare_count variable shouldn't
exist at all, but I need to dig into this in more detail to be sure.

In principle I think genpd should rely _more_ on the PM core during
system PM transitions. For example the PM core invokes a
pm_runtime_get_noresume() (and for some reason genpd as well) at the
->prepare() phase. Shouldn't that be enough!?

>    genpd->suspend_power_off = 1
>   in domain.c:183
>
> 7. The domain is not powered on but it is marked as active.
> 8. The DRM driver thinks everything is OK and proceeds with resume...
> but it fails because whole power domain is OFF.
>
> The question: Shouldn't the power domain be powered up EARLY?

Good question, I would like us to strive towards these goals:

For CONFIG_PM_RUNTIME, I think the PM domain should be powered up at
the first time a runtime PM resume callbacks gets invoked.
For !CONFIG_PM_RUNTIME, I think we should restore the state the PM
domain had prior we went to system PM sleep.

Kind regards
Uffe
