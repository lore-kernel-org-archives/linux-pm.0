From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Thu, 2 Oct 2014 11:09:10 +0200
Message-ID: <CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
	<1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
	<542C2D9F.8060005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <542C2D9F.8060005@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun
List-Id: linux-pm@vger.kernel.org

On 1 October 2014 18:36, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> On 01/10/14 16:41, Ulf Hansson wrote:
>> There are currently no users of this API, let's remove it.

Hi Sylwester,

Thanks for your reply!

>
> The sad fact is that removal of pm_genpd_dev_need_restore() calls
> from arch/arm/mach-exynos/pm_domains.c introduces regressions in
> multiple exynos drivers (I'm sure it breaks media drivers).

The fact that you need pm_genpd_dev_need_restore() is really worrying.
That indicates that exynos are suffering from this race condition I am
trying to fix in this patchset.

> I think before doing such changes all relevant drivers should be
> updated first. I need to take a closer look again, but it seems
> after dropping the pm_genpd_dev_need_restore() calls, client
> driver's runtime_resume() callback is not being called in response
> to first pm_runtime_get(_sync) call, even if a device is runtime
> pm active.

Why would runtime PM callbacks be invoked when the device are runtime
PM active? That's prevented by the runtime PM core and is the expected
behaviour.

pm_genpd_dev_need_restore() is not the solution, besides that it gives
you the option to lie about device's runtime PM state to genpd. Thus,
if you are really lucky, that might workaround your issues. :-)

I will happily help out in fixing drivers for exynos. Would be nice if
you could provide me with a list of which driver/subsystems that seems
broken. HW, wise I have a exynos 5250 and exynos 5422 on my desk, so
those I can test.

>
> More details can be found in commit ebc35c726298ba3fdebba316a
> 'ARM: EXYNOS: register devices in 'need_restore' state for pm_domains'.
>
> The above only happens when devices are added to an inactive power
> domain, then I guess patch 2/4 is also an attempt to address this
> issue ?

Yes.

I would really appreciate if you could run a test with the complete
patchset and see if that resolves the issues.

Kind regards
Uffe
