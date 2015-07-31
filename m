From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 0/5] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
Date: Fri, 31 Jul 2015 20:49:12 +0200
Message-ID: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53896 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbGaSuV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 14:50:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

This patch series removes the use of Exynos4x12 specific support
from cpufreq-exynos driver and enables the use of cpufreq-dt driver
for this platform.

This patch series has been tested on Exynos4412 based Odroid-U3 and
Trats2 boards.

Depends on:
- next-20150730 branch of linux-next kernel tree
- "[PATCH V3 00/16] OPP: Add code to support operating-points-v2 bindings"
  (http://www.spinics.net/lists/arm-kernel/msg435408.html)

Changes since v2
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/46653):
- rebased on top of next-20150730 branch of linux-next kernel tree
- ported over V3 of opp-v2 bindings support patch series
- put cpu0 nodes in alphabetical order in dts files
- added Reviewed-by tags from Javier and Krzysztof
- added Acked-by tag from Sylwester

Changes since v1
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/44361):
- rebased on top of next-20150629 branch of linux-next kernel tree
- rebased on top of Exynos5250 cpufreq-dt support patch series
- fixed if-statement in exynos4_clk_init() (noticed by Tobias Jakobi)
- ported over opp-v2 bindings (requested by Viresh Kumar)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  clk: samsung: exynos4x12: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos4x12: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos4x12
  cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support
  cpufreq: remove no longer needed CPU_FREQ_BOOST_SW config option

 arch/arm/boot/dts/exynos4212.dtsi               |  81 ++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 +
 arch/arm/boot/dts/exynos4412-origen.dts         |   4 +
 arch/arm/boot/dts/exynos4412-trats2.dts         |   4 +
 arch/arm/boot/dts/exynos4412.dtsi               |  83 +++++++++
 arch/arm/mach-exynos/exynos.c                   |   2 +
 drivers/clk/samsung/clk-exynos4.c               |  50 +++++
 drivers/cpufreq/Kconfig                         |   5 +-
 drivers/cpufreq/Kconfig.arm                     |  38 ----
 drivers/cpufreq/Makefile                        |   2 -
 drivers/cpufreq/exynos-cpufreq.c                | 236 ------------------------
 drivers/cpufreq/exynos-cpufreq.h                |  72 --------
 drivers/cpufreq/exynos4x12-cpufreq.c            | 236 ------------------------
 drivers/cpufreq/freq_table.c                    |   2 -
 14 files changed, 229 insertions(+), 590 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

-- 
1.9.1

