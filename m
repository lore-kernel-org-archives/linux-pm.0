From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCHv2 0/8] devfreq: exynos4: Support dt and use common ppmu
 driver
Date: Fri, 14 Mar 2014 18:58:06 +0100
Message-ID: <5323432E.5060005@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 13.03.2014 09:17, Chanwoo Choi wrote:
> This patchset support devicetree and use common ppmu driver instead of
> individual code of exynos4_bus.c to remove duplicate code. Also this patchset
> get the resources for busfreq from dt data by using DT helper function.
> - PPMU register address
> - PPMU clock
> - Regulator for INT/MIF block
>
> This patchset use SET_SYSTEM_SLEEP_PM_OPS macro intead of legacy method.
> To remove power-leakage in suspend state, before entering suspend state,
> disable ppmu clocks.
>
> Changes from v1:
> - Add exynos4_bus.txt documentation for devicetree guide
> - Fix probe failure if CONFIG_PM_OPP is disabled
> - Fix typo and resource leak(regulator/clock/memory) when happening probe failure
> - Add additionally comment for PPMU usage instead of previous PPC
> - Split separate patch to remove ambiguous of patch
>
> Chanwoo Choi (8):
>    devfreq: exynos4: Support devicetree to get device id of Exynos4 SoC
>    devfreq: exynos4: Use common ppmu driver and get ppmu address from dt data
>    devfreq: exynos4: Add ppmu's clock control and code clean about regulator control
>    devfreq: exynos4: Fix bug of resource leak and code clean on probe()
>    devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro
>    devfreq: exynos4: Fix power-leakage of clock on suspend state
>    devfreq: exynos4: Add CONFIG_PM_OPP dependency to fix probe fail
>    devfreq: exynos4: Add busfreq driver for exynos4210/exynos4x12
>
>   .../devicetree/bindings/devfreq/exynos4_bus.txt    |  49 +++
>   drivers/devfreq/Kconfig                            |   1 +
>   drivers/devfreq/exynos/Makefile                    |   2 +-
>   drivers/devfreq/exynos/exynos4_bus.c               | 415 ++++++++++++++-------
>   4 files changed, 341 insertions(+), 126 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>

I have reviewed this series and there are several comments that I'd like 
to ask you to address. Please see my replies to particular patches.

However, this driver, even after applying your series, is still far from 
a state that would allow it to be enabled. The most important issue is 
direct access to CMU registers, based on static mapping, which is not 
allowed on multiplatform kernels and multiplatform-awareness for drivers 
is currently a must.

To allow this driver to be enabled, it needs to be converted to use 
common clock framework functions to configure all clocks, e.g. 
clk_set_rate(), clk_set_parent(), etc., without accessing CMU registers 
directly.

Of course as long as the driver is effectively unusable, to keep 
development, we can proceed with refactoring it step-by-step and your 
series would be basically the first step, after addressing the review 
comments.

Best regards,
Tomasz
