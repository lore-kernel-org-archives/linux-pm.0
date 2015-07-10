From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 0/7] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
Date: Thu, 9 Jul 2015 17:07:04 -0700
Message-ID: <559F0CA8.1060906@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.or>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Bartlomiej,

On Thu, Jul 9, 2015 at 8:43 AM, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
> Hi,
>
> This patch series removes the use of Exynos4x12 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.
>
> In order to preserve support for Exynos4x12 'boost' mode cpufreq-dt
> driver is made aware of cpufreq 'boost' mode infrastructure.  Once
> it is done (+ turbo modes handling is fixed, please see below for
> details) the driver starts to use turbo mode frequencies (defined
> using opp-v2 bindings) as 'boost' mode frequecies.
>
> Patches #1-2 are needed to fix handling of turbo modes in cpufreq
> core and without them cpufreq-dt treats turbo modes as normal modes
> (IOW they are used by default as normal modes even if they are defined
> in DTS file as turbo modes).  Ideally these patches should be added
> into "[PATCH 00/10] OPP: Add code to support operating-points-v2
> bindings" patch series before patch #10 ("[PATCH 10/10] cpufreq-dt:
> Add support for operating-points-v2 bindings").
>
> This patch series has been tested on Exynos4412 based Odroid-U3 and
> Trats2 boards.
>
> Depends on:
> - next-20150629 branch of linux-next kernel tree
> - "[PATCH v3 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
>   platform" (http://lkml.org/lkml/2015/7/1/311)
> - "PATCH 00/10] OPP: Add code to support operating-points-v2 bindings"
>   (http://www.spinics.net/lists/arm-kernel/msg425517.html)
>
> Changes since v1
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/44361):
> - rebased on top of next-20150629 branch of linux-next kernel tree
> - rebased on top of Exynos5250 cpufreq-dt support patch series
> - fixed if-statement in exynos4_clk_init() (noticed by Tobias Jakobi)
> - ported over opp-v2 bindings (requested by Viresh Kumar)
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>
> Bartlomiej Zolnierkiewicz (7):
>   opp: add dev_pm_opp_get_turbo_mode_setting() helper
>   cpufreq: opp: fix handling of turbo modes
>   cpufreq-dt: add turbo modes support
>   clk: samsung: exynos4x12: add cpu clock configuration data and
>     instantiate cpu clock
>   ARM: dts: Exynos4x12: add CPU OPP and regulator supply property
>   ARM: Exynos: switch to using generic cpufreq driver for Exynos4x12
>   cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support
>

I don't have access to an Exynos4x12 board to test but I've reviewed
the patches and they look good to me. So for the complete series:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Sr. Linux Kernel Developer
Open Source Group
Samsung Research America
