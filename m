From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 0/4] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Wed, 04 Jan 2017 14:25:51 +0900
Message-ID: <ab1080b8-dfa4-77c5-226b-18e11bf557e8@samsung.com>
References: <CGME20161230133344eucas1p21d107e1cf3096916aad1944f7e002bf9@eucas1p2.samsung.com>
 <1483104816-20885-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1483104816-20885-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Dear Marek,

I like these patches because as you already said, the some clocks are included in the specific power domain such as exynos5433. I want to test these patches on Exynos5433-TM2 board. But, this series don't include the Device-Tree binding patches. Could you give the additional patches for test?

Best Regards,
Chanwoo Choi

On 2016년 12월 30일 22:33, Marek Szyprowski wrote:
> Dear All,
> 
> This patchset adds runtime PM support to common clock framework. This is an
> attempt to implement support for clock controllers, which belongs to a power
> domain. This approach works surprisingly well on Exynos 5433 SoC, what allowed
> us to solve various freeze/crash issues related to power management.
> 
> The main idea behind this patchset is to keep clock's controller power domain
> enabled every time when at least one of its clock is enabled or access to its
> registers is being made. Clock controller driver (clock provider) can
> supply a struct device pointer, which is the used by clock core for tracking and
> managing clock's controller runtime pm state. Each clk_prepare() operation will
> first call pm_runtime_get_sync() on the supplied device, while clk_unprepare()
> will do pm_runtime_put() at the end.
> 
> This runtime PM feature has been tested with Exynos4412 (not included in this
> patchset) and Exynos5433 clocks drivers. Both have some clocks, which belongs to
> respective power domains and need special handling during power on/off
> procedures. Till now it wasn't handled at all, what caused various problems.
> 
> Patches for clocks drivers change the way the clock provider is initialized.
> Instead of CLK_OF_DECLARE based initialization, a complete platform device driver
> infrastructure is being used. This is needed to let driver to use runtime PM
> feature and integrate with generic power domains. The side-effect of this change
> is a delay in clock provider registeration during system boot, so early
> initialized drivers might get EPROBEDEFER error when requesting their clocks.
> This is an issue for IOMMU drivers, so this patchset will be fully functional
> once the deferred probe for IOMMU will be merged.
> 
> Patches are based on vanilla v4.10-rc1 kernel.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> Changelog:
> 
> v4:
> - Removed patch for Exynos4412 clocks from the patchset. DT bindings for power
>   domain for ISP sub-controller needs more discussion. It will be handled
>   separately when the runtime PM for clocks feature gets merged.
> - Added patch with runtime PM support for Exynos AudioSS clock controller driver
>   (needed to enable audio power domain on Exynos5 series).
> - Fixes in Exynos5433 driver:
> 	1. added missing clock for Audio CMU
> 	2. added support for FSYS CMU
> 	3. improved support for DISP CMU (thanks to Andrzej Hajda for
> 	   investigating that).
> - Rebased onto v4.10-rc1
> - Waiting for a review...
> 
> v3: http://www.spinics.net/lists/arm-kernel/msg538122.html
> - Removed CLK_RUNTIME_PM flag, core now simply checks if runtime pm is enabled
>   for the provided device during clock registration as suggested by Ulf
> - Simplified code for exynos4412 isp clock driver registration
> - Resolved some other minor issues pointed by Ulf clk core code
> - Rebased onto v4.9-rc1 and new version of IOMMU deferred probe patchset
> 
> v2: https://www.spinics.net/lists/arm-kernel/msg532798.html
> - Simplified clk_pm_runtime_get/put functions, removed workaround for devices
>   with disabled runtime pm. Such workaround is no longer needed since commit
>   4d23a5e84806b202d9231929c9507ef7cf7a0185 ("PM / Domains: Allow runtime PM
>   during system PM phases").
> - Added CLK_RUNTIME_PM flag to indicate clocks, for which clock core should
>   call runtime pm functions. This solves problem with clocks, for which struct
>   device is already registered, but no runtime pm is enabled.
> - Extended commit messages according to Ulf suggestions.
> - Fixed some style issues pointed by Barlomiej.
> 
> v1: http://www.spinics.net/lists/arm-kernel/msg528128.html
> - initial version
> 
> 
> Marek Szyprowski (4):
>   clk: Add support for runtime PM
>   clk: samsung: Add support for runtime PM
>   clk: samsung: exynos5433: Add runtime PM support
>   clk: samsung: exynos-audss: Use runtime PM
> 
>  .../devicetree/bindings/clock/clk-exynos-audss.txt |   6 +
>  .../devicetree/bindings/clock/exynos5433-clock.txt |  16 +
>  drivers/clk/clk.c                                  | 111 +++++-
>  drivers/clk/samsung/clk-exynos-audss.c             |  62 +--
>  drivers/clk/samsung/clk-exynos5433.c               | 415 ++++++++++++++++-----
>  drivers/clk/samsung/clk-pll.c                      |   2 +-
>  drivers/clk/samsung/clk.c                          |  12 +-
>  drivers/clk/samsung/clk.h                          |   7 +
>  8 files changed, 504 insertions(+), 127 deletions(-)
> 
