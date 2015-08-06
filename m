From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
Date: Fri, 07 Aug 2015 08:53:18 +0900
Message-ID: <015301d0d0a3$1396c900$3ac45b00$@kernel.org>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Michael Turquette' <mturquette@baylibre.com>, 'Kukjin Kim' <kgene@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>
Cc: 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Heiko Stuebner' <heiko@sntech.de>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Javier Martinez Canillas' <javier@dowhile0.org>, 'Tobias Jakobi' <tjakobi@math.uni-bielefeld.de>, 'Anand Moon' <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
Hi Bart,

> This patch series removes the use of Exynos4x12 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.
> 
Thanks for this series.

> This patch series has been tested on Exynos4412 based Odroid-U3 and
> Trats2 boards.
> 
Sounds good.

> Depends on:
> - next-20150806 branch of linux-next kernel tree
> - "[PATCH V3 00/16] OPP: Add code to support operating-points-v2 bindings"
>   (http://www.spinics.net/lists/arm-kernel/msg435408.html)
> 
BTW, hmm...how can we see this series in v4.3?...to be honest, I don't think it
can be done in v4.3 because of dependencies with PM / OPP series and previous
exynos CPU OPP series in each cross trees...maybe that's why you created based
on linux-next...any idea?

Thanks,
Kukjin

> Changes since v3
> (http://thread.gmane.org/gmane.linux.power-management.general/63464):
> - rebased on top of next-20150806 branch of linux-next kernel tree
> - made ARCH_EXYNOS config option select thermal support
> - made scaling_boost_freqs sysfs attribute available only when boost
>   support is enabled
> - added Acked-by tag from Viresh to patches #3, #4 and #5
> - added Tested-by tag from Tobias to patches #2-5
> - added Reviewed-by tag from Krzysztof to patch #4
> 
> Changes since v2
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/46653):
> - rebased on top of next-20150730 branch of linux-next kernel tree
> - ported over V3 of opp-v2 bindings support patch series
> - put cpu0 nodes in alphabetical order in dts files
> - added Reviewed-by tags from Javier and Krzysztof
> - added Acked-by tag from Sylwester
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
> Bartlomiej Zolnierkiewicz (6):
>   cpufreq: make scaling_boost_freqs sysfs attr available when boost is
>     enabled
>   clk: samsung: exynos4x12: add cpu clock configuration data and
>     instantiate cpu clock
>   ARM: dts: Exynos4x12: add CPU OPP and regulator supply property
>   ARM: Exynos: switch to using generic cpufreq driver for Exynos4x12
>   cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support
>   cpufreq: remove no longer needed CPU_FREQ_BOOST_SW config option
> 
>  arch/arm/boot/dts/exynos4212.dtsi               |  81 ++++++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 +
>  arch/arm/boot/dts/exynos4412-origen.dts         |   4 +
>  arch/arm/boot/dts/exynos4412-trats2.dts         |   4 +
>  arch/arm/boot/dts/exynos4412.dtsi               |  83 +++++++++
>  arch/arm/mach-exynos/Kconfig                    |   2 +
>  arch/arm/mach-exynos/exynos.c                   |   2 +
>  drivers/clk/samsung/clk-exynos4.c               |  50 +++++
>  drivers/cpufreq/Kconfig                         |   4 -
>  drivers/cpufreq/Kconfig.arm                     |  38 ----
>  drivers/cpufreq/Makefile                        |   2 -
>  drivers/cpufreq/cpufreq-dt.c                    |   3 +
>  drivers/cpufreq/exynos-cpufreq.c                | 236 ------------------------
>  drivers/cpufreq/exynos-cpufreq.h                |  72 --------
>  drivers/cpufreq/exynos4x12-cpufreq.c            | 236 ------------------------
>  drivers/cpufreq/freq_table.c                    |  10 +-
>  include/linux/cpufreq.h                         |   1 +
>  17 files changed, 241 insertions(+), 591 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
>  delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
> 
> --
> 1.9.1
