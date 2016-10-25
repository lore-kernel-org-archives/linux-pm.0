From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Tue, 25 Oct 2016 10:51:03 +0200
Message-ID: <3b50ab04-74d2-da25-d0a8-63a90ce69d93@samsung.com>
References: <CGME20161024121224eucas1p1070b72308dc9c8d8d2b10fa5bfeaf5ed@eucas1p1.samsung.com>
 <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:19217 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbcJYIvK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 04:51:10 -0400
In-reply-to: <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Dear All,


On 2016-10-24 14:12, Marek Szyprowski wrote:
> This patchset adds runtime PM support to common clock framework. This is an
> attempt to implement support for clock controllers, which belongs to a power
> domain. This approach works surprisingly well on Exynos 4412 and 5433 SoCs,
> what allowed us to solve various freeze/crash issues related to power
> management.
>
> The main idea behind this patchset is to keep clock's controller power domain
> enabled every time when at least one of its clock is enabled or access to its
> registers is being made. Clock controller driver (clock provider) can
> supply a struct device pointer, which is the used by clock core for tracking and
> managing clock's controller runtime pm state. Each clk_prepare() operation will
> first call pm_runtime_get_sync() on the supplied device, while clk_unprepare()
> will do pm_runtime_put() at the end.
>
> This runtime PM feature has been tested with Exynos4412 and Exynos5433 clocks
> drivers. Both have some clocks, which belongs to respective power domains and
> need special handling during power on/off procedures. Till now it wasn't handled
> at all, what caused various problems.
>
> Patches for exynos 4412 and 5433 clocks drivers change the way the clock
> provider is initialized. Instead of CLK_OF_DECLARE based initialization, a
> complete platform device driver infrastructure is being used. This is needed to
> let driver to use runtime pm feature and integrate with generic power domains.
> The side-effect of this change is a delay in clock provider registeration
> during system boot, so early initialized drivers might get EPROBEDEFER error
> when requesting their clocks. This is an issue for IOMMU drivers, so
> this patchset will be fully functional once the deferred probe for IOMMU
> will be merged.
>
> The side-effect of this patchset is the one can finally read
> /sys/kernel/debug/clk/clk_summary on all Exynos4412 boards without any freeze.
>
> If one wants to test this patchset (on Exynos4412 Trats2 device with FIMC-IS
> driver), I've provided a branch with all needed patches (fixes for Exynos,
> FIMC-IS driver and IOMMU deferred probe):
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.9-clocks-pm-v3
>
> Patches are based on vanilla v4.9-rc1 kernel.

If one want to test this patchset together with my recently posted 
Exynos IOMMU
runtime PM patches (V5: 
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253432.html),
I prepared a single branch with both patchsets and all their prerequisites:

https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.9-iommu-pm-v5-clocks-pm-v3


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

