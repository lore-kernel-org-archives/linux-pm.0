From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Thu, 2 Oct 2014 15:30:40 +0200
Message-ID: <CAPDyKFozS+J_sTZykF=9tVJsCByby_BDuQmGiMt-Uw-qC4Tzuw@mail.gmail.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
	<1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
	<542C2D9F.8060005@samsung.com>
	<CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
	<542D3E45.5020908@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <542D3E45.5020908@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun
List-Id: linux-pm@vger.kernel.org

On 2 October 2014 14:00, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> Hello Ulf,
>
> On 02/10/14 11:09, Ulf Hansson wrote:
>> On 1 October 2014 18:36, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>> On 01/10/14 16:41, Ulf Hansson wrote:
>>>> There are currently no users of this API, let's remove it.
>>
>> Hi Sylwester,
>>
>> Thanks for your reply!
>>
>>> The sad fact is that removal of pm_genpd_dev_need_restore() calls
>>> from arch/arm/mach-exynos/pm_domains.c introduces regressions in
>>> multiple exynos drivers (I'm sure it breaks media drivers).
>>
>> The fact that you need pm_genpd_dev_need_restore() is really worrying.
>> That indicates that exynos are suffering from this race condition I am
>> trying to fix in this patchset.
>>
>>> I think before doing such changes all relevant drivers should be
>>> updated first. I need to take a closer look again, but it seems
>>> after dropping the pm_genpd_dev_need_restore() calls, client
>>> driver's runtime_resume() callback is not being called in response
>>> to first pm_runtime_get(_sync) call, even if a device is runtime
>>> pm active.
>
> Sorry, I meant to say "inactive" here.

Ahh, now I see the approach.

Correct me if I am wrong, but I think in principle these exynos
drivers don't use pm_runtime_set_active() during ->probe() and are
instead relying on CONFIG_PM_RUNTIME to be enabled.

That's not a good behaviour. If these drivers are build without
CONFIG_PM_RUNTIME - they won't work.

I guess I have pointed out this in earlier discussions around runtime
PM, I have seen quite some driver's getting their support for runtime
PM wrong.

>
>> Why would runtime PM callbacks be invoked when the device are runtime
>> PM active? That's prevented by the runtime PM core and is the expected
>> behaviour.
>>
>> pm_genpd_dev_need_restore() is not the solution, besides that it gives
>> you the option to lie about device's runtime PM state to genpd. Thus,
>> if you are really lucky, that might workaround your issues. :-)
>
> Might be, nevertheless so far it more or less worked for us. At least
> I'm sure without it everything breaks right away.

I see. Obviously we must not break exynos, let's try to figure out the
best way forward.

>
>> I will happily help out in fixing drivers for exynos. Would be nice if
>> you could provide me with a list of which driver/subsystems that seems
>> broken. HW, wise I have a exynos 5250 and exynos 5422 on my desk, so
>> those I can test.
>
> For exynos5 I would check exynos-gsc and s5p-mfc (see kernel logs below).

Thanks, I will have look and run some tests on exynos 5. Let you know soon.

> I could take care of other, exynos4 drivers. But I believe the fix
> belongs in the PM core, I doubt we can solve in the driver a problem
> which only occurs to one instance (first probed) of a device from a set
> of devices in the power domain.
>
>>> More details can be found in commit ebc35c726298ba3fdebba316a
>>> 'ARM: EXYNOS: register devices in 'need_restore' state for pm_domains'.
>>>
>>> The above only happens when devices are added to an inactive power
>>> domain, then I guess patch 2/4 is also an attempt to address this
>>> issue ?
>>
>> Yes.
>>
>> I would really appreciate if you could run a test with the complete
>> patchset and see if that resolves the issues.
>
> Sure, is there a git tree I could fetch all the relevant patches from ?
> I'm not sure what the base tree for this series, I could only apply
> first 2 patches from this thread, on top of the generic OF PM domain
> patches. And that didn't solve issues which are seen in the logs below.

You have two options:

1) Use/build Rafaels tree. Apply my patches on the bleeding edge
branch.That's also what I use a work base.
http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

2) Use/build Stephen Rothwell's linux-next tree. I can confirm the
patches applies on the master branch as of today.
http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

I really appreciate your help here, thanks!

>
> Nevertheless, as Rafael pointed out, enabling all power domains
> unconditionally seems a step backwards. It would be nice to have
> resolved the race in a away the power domains remain in state left
> by the firmware and are being enabled only before any client device
> actually needs it.

You are right, but I am not sure we can do this in one go - since it
depends on if we can fix this on PM core of if we need need
adaptations in drivers/subsystems.

Kind regards
Uffe
