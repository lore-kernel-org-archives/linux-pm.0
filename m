From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Thu, 02 Oct 2014 17:54:13 +0200
Message-ID: <542D7525.8000804@samsung.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
 <542C2D9F.8060005@samsung.com>
 <CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
 <542D3E45.5020908@samsung.com>
 <CAPDyKFozS+J_sTZykF=9tVJsCByby_BDuQmGiMt-Uw-qC4Tzuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:55267 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbaJBPyg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 11:54:36 -0400
In-reply-to: <CAPDyKFozS+J_sTZykF=9tVJsCByby_BDuQmGiMt-Uw-qC4Tzuw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun

On 02/10/14 15:30, Ulf Hansson wrote:
[...]
> Correct me if I am wrong, but I think in principle these exynos
> drivers don't use pm_runtime_set_active() during ->probe() and are
> instead relying on CONFIG_PM_RUNTIME to be enabled.

Yes, pm_runtime_set_active() is not used in probe(), I believe this
is not required. In case of those IP blocks there is no use of activating
them during probe(). Instead we check if PM_RUNTIME is enabled through
pm_runtime_enabled() helper and enable the device clock(s) if not.
I agree it all doesn't quite work in current mainline for !PM_RUNTIME,
since there is nothing ensuring that the power domains are enabled
in such kernel configuration.

> That's not a good behaviour. If these drivers are build without
> CONFIG_PM_RUNTIME - they won't work.

They wouldn't similarly work with pm_runtime_set_active() call in probe()
with CONFIG_PM_RUNTIME disabled, would they ?

> I guess I have pointed out this in earlier discussions around runtime
> PM, I have seen quite some driver's getting their support for runtime
> PM wrong.
> 
>>> Why would runtime PM callbacks be invoked when the device are runtime
>>> PM active? That's prevented by the runtime PM core and is the expected
>>> behaviour.
>>>
>>> pm_genpd_dev_need_restore() is not the solution, besides that it gives
>>> you the option to lie about device's runtime PM state to genpd. Thus,
>>> if you are really lucky, that might workaround your issues. :-)
>>
>> Might be, nevertheless so far it more or less worked for us. At least
>> I'm sure without it everything breaks right away.
> 
> I see. Obviously we must not break exynos, let's try to figure out the
> best way forward.
> 
>>
>>> I will happily help out in fixing drivers for exynos. Would be nice if
>>> you could provide me with a list of which driver/subsystems that seems
>>> broken. HW, wise I have a exynos 5250 and exynos 5422 on my desk, so
>>> those I can test.
>>
>> For exynos5 I would check exynos-gsc and s5p-mfc (see kernel logs below).
> 
> Thanks, I will have look and run some tests on exynos 5. Let you know soon.

Especially it might be interesting look at gscaler, where there are 
multiple instances of same device handled by one driver.

[...]
>> Sure, is there a git tree I could fetch all the relevant patches from ?
>> I'm not sure what the base tree for this series, I could only apply
>> first 2 patches from this thread, on top of the generic OF PM domain
>> patches. And that didn't solve issues which are seen in the logs below.
> 
> You have two options:
> 
> 1) Use/build Rafaels tree. Apply my patches on the bleeding edge
> branch.That's also what I use a work base.
> http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> 
> 2) Use/build Stephen Rothwell's linux-next tree. I can confirm the
> patches applies on the master branch as of today.
> http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Thanks, I will be able to take a look at this the earliest on Monday. 

> I really appreciate your help here, thanks!
> 
>> Nevertheless, as Rafael pointed out, enabling all power domains
>> unconditionally seems a step backwards. It would be nice to have
>> resolved the race in a away the power domains remain in state left
>> by the firmware and are being enabled only before any client device
>> actually needs it.
> 
> You are right, but I am not sure we can do this in one go - since it
> depends on if we can fix this on PM core of if we need need
> adaptations in drivers/subsystems.

I see, fortunately the genpd API appears not to be wildly used yet.

-- 
Regards,
Sylwester
