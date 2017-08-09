From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v7 0/4] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Wed, 09 Aug 2017 12:45:20 +0200
Message-ID: <29b8504e-e0df-d789-5ccf-e85ee8b1c3ff@samsung.com>
References: <CGME20170804093514eucas1p2b15dbf1879d150c8c40f1696c2109975@eucas1p2.samsung.com>
        <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
        <CAGTfZH35Sc9oOGG6QyhqD2+8fhjUsiykoNsJ0O1C5XstAE0HjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59114 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdHIKp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 06:45:26 -0400
In-reply-to: <CAGTfZH35Sc9oOGG6QyhqD2+8fhjUsiykoNsJ0O1C5XstAE0HjA@mail.gmail.com>
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cwchoi00@gmail.com
Cc: linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Chanwoo,

On 2017-08-04 16:28, Chanwoo Choi wrote:
> On Fri, Aug 4, 2017 at 6:34 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Dear All,
>>
>> This patchset adds runtime PM support to common clock framework. This is an
>> attempt to implement support for clock controllers, which belongs to a power
>> domain. This approach works surprisingly well on Exynos 5433 SoC, what allowed
>> us to solve various freeze/crash issues related to power management.
>>
>> The main idea behind this patchset is to keep clock's controller power domain
>> enabled every time when at least one of its clock is enabled or access to its
>> registers is being made. Clock controller driver (clock provider) can
>> supply a struct device pointer, which is the used by clock core for tracking and
>> managing clock's controller runtime pm state. Each clk_prepare() operation will
>> first call pm_runtime_get_sync() on the supplied device, while clk_unprepare()
>> will do pm_runtime_put() at the end.
>>
>> This runtime PM feature has been tested with Exynos4412 (not included in this
>> patchset) and Exynos5433 clocks drivers. Both have some clocks, which belongs to
>> respective power domains and need special handling during power on/off
>> procedures. Till now it wasn't handled at all, what caused various problems.
>>
>> Patches for clocks drivers change the way the clock provider is initialized.
>> Instead of CLK_OF_DECLARE based initialization, a complete platform device driver
> First of all, I agree this approach absolutely.
>
> Almost clock domains are enough to support the runtime PM with this approach.
> But, the specific clock domain should be handled by CLK_OF_DECLARE
> if the specific clock domain contains the clocks for timer.
> Because some clocks for timer are required on early boot phase.
>
> Maybe, Need to find the further method to support the runtime PM for
> all clock domains.

Timers usually are needed all the time and very early during boot, so 
the clock
providers for them should be registered early too. Typically they are 
always on
(as well as the power domain which they reside) anyway, so runtime pm
infrastructure don't help them much. Having those (usually top-level) clocks
registered with CLK_OF_DECLARE IMHO is not a problem in this case.

>
> Regards,
> Chanwoo Choi
>
>
>> infrastructure is being used. This is needed to let driver to use runtime PM
>> feature and integrate with generic power domains. The side-effect of this change
>> is a delay in clock provider registeration during system boot, so early
>> initialized drivers might get EPROBEDEFER error when requesting their clocks.
>> This is an issue for IOMMU drivers, so this patchset will be fully functional
>> once the deferred probe for IOMMU will be merged. v9 of the IOMMU deferred probe
>> support has been posted a few days ago:
>> https://www.spinics.net/lists/arm-kernel/msg567558.html
>>
>> Patches are based on v4.13-rc3.
>>
>> Stephen: this patchset finally got a review from Ulf (from PM point of
>> view). Is also touches only the Exynos5433 and Exynos Audio Subsystem
>> drivers, which both have separate DT nodes for each clock controllers and
>> each clock controller is entirely only in the one power domain, so everything is
>> clean from the current DT bindings perspective. Would it be okay to merge it?
>>
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
>>
>>
>> Changelog:
>>
>> v7:
>> - rebased onto v4.13-rc3
>> - still waiting for any comments from clk maintainers
>>
>> v6:
>> - addressed comments from Ulf Hanson and added his 'Reviewed-by' tags
>> - simplified exynos 5433 clock driver code a bit
>> - fixes issues pointed by kbuild test robot
>>
>> v5:
>> - rebased onto next-20170125 kernel release
>> - added two more calls to runtime PM in clock's core:
>>          1. clk_recalc() should ensure active runtime pm state, because it might
>>             read registers (in case of dividers) to calculate the rate
>>          2. clk_register() also needs to ensure active runtime pm state to read
>>             initial rate and status of the clocks
>> - more fixes in Exynos5433 clocks drivers:
>>          1. PLL in DISP CMU must be enabled for suspend
>>          2. guard clocks registration with pm_runtime_get_sync/pm_runtime_put to
>>             avoid turning the power domain on and off many times for no good
>>             reason (registering each clock will call pm_runtime_get_sync(), then
>>             pm_runtime_put, what in turn might disable power domain)
>> - still waiting for a review...
>>
>> v4: http://www.spinics.net/lists/arm-kernel/msg550747.html
>> - Removed patch for Exynos4412 clocks from the patchset. DT bindings for power
>>    domain for ISP sub-controller needs more discussion. It will be handled
>>    separately when the runtime PM for clocks feature gets merged.
>> - Added patch with runtime PM support for Exynos AudioSS clock controller driver
>>    (needed to enable audio power domain on Exynos5 series).
>> - Fixes in Exynos5433 driver:
>>          1. added missing clock for Audio CMU
>>          2. added support for FSYS CMU
>>          3. improved support for DISP CMU (thanks to Andrzej Hajda for
>>             investigating that).
>> - Rebased onto v4.10-rc1
>> - Waiting for a review...
>>
>> v3: http://www.spinics.net/lists/arm-kernel/msg538122.html
>> - Removed CLK_RUNTIME_PM flag, core now simply checks if runtime pm is enabled
>>    for the provided device during clock registration as suggested by Ulf
>> - Simplified code for exynos4412 isp clock driver registration
>> - Resolved some other minor issues pointed by Ulf clk core code
>> - Rebased onto v4.9-rc1 and new version of IOMMU deferred probe patchset
>>
>> v2: https://www.spinics.net/lists/arm-kernel/msg532798.html
>> - Simplified clk_pm_runtime_get/put functions, removed workaround for devices
>>    with disabled runtime pm. Such workaround is no longer needed since commit
>>    4d23a5e84806b202d9231929c9507ef7cf7a0185 ("PM / Domains: Allow runtime PM
>>    during system PM phases").
>> - Added CLK_RUNTIME_PM flag to indicate clocks, for which clock core should
>>    call runtime pm functions. This solves problem with clocks, for which struct
>>    device is already registered, but no runtime pm is enabled.
>> - Extended commit messages according to Ulf suggestions.
>> - Fixed some style issues pointed by Barlomiej.
>>
>> v1: http://www.spinics.net/lists/arm-kernel/msg528128.html
>> - initial version
>>
>>
>> Patch summary:
>>
>> Marek Szyprowski (4):
>>    clk: Add support for runtime PM
>>    clk: samsung: Add support for runtime PM
>>    clk: samsung: exynos5433: Add runtime PM support
>>    clk: samsung: exynos-audss: Use runtime PM
>>
>>   .../devicetree/bindings/clock/clk-exynos-audss.txt |   6 +
>>   .../devicetree/bindings/clock/exynos5433-clock.txt |  16 +
>>   drivers/clk/clk.c                                  | 129 ++++++-
>>   drivers/clk/samsung/clk-exynos-audss.c             |  68 ++--
>>   drivers/clk/samsung/clk-exynos5433.c               | 409 ++++++++++++++++-----
>>   drivers/clk/samsung/clk-pll.c                      |   2 +-
>>   drivers/clk/samsung/clk.c                          |  12 +-
>>   drivers/clk/samsung/clk.h                          |   7 +
>>   8 files changed, 513 insertions(+), 136 deletions(-)
>>
>> --
>> 1.9.1

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
