From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
 platform
Date: Mon, 29 Jun 2015 19:26:08 +0200
Message-ID: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33806 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbF2R2a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 13:28:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

This patch series removes the use of Exynos5250 specific support
from cpufreq-exynos driver and enables the use of cpufreq-dt driver
for this platform.

This patch series has been tested on Exynos5250 based Arndale board.

Changes since v1 (http://lkml.org/lkml/2015/4/13/611):
- rebased on top of next-20150629 branch of linux-next kernel tree
- dropped dependency on "[PATCH 0/6] cpufreq: use generic cpufreq
  drivers for Exynos4x12 platform" patch series as it needs more
  work (Viresh has requested porting of cpufreq-dt's boost mode
  support over opp-v2 patches)

Depends on:
- next-20150629 branch of linux-next kernel tree

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (1):
  cpufreq: exynos: remove Exynos5250 specific cpufreq driver support

Thomas Abraham (3):
  clk: samsung: exynos5250: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos5250: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos5250

 arch/arm/boot/dts/exynos5250-arndale.dts  |   4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   4 +
 arch/arm/boot/dts/exynos5250-snow.dts     |   4 +
 arch/arm/boot/dts/exynos5250-spring.dts   |   4 +
 arch/arm/boot/dts/exynos5250.dtsi         |  22 ++++
 arch/arm/mach-exynos/exynos.c             |   1 +
 drivers/clk/samsung/clk-exynos5250.c      |  31 +++++
 drivers/cpufreq/Kconfig.arm               |  11 --
 drivers/cpufreq/Makefile                  |   1 -
 drivers/cpufreq/exynos-cpufreq.c          |   3 -
 drivers/cpufreq/exynos-cpufreq.h          |  17 ---
 drivers/cpufreq/exynos5250-cpufreq.c      | 210 ------------------------------
 include/dt-bindings/clock/exynos5250.h    |   1 +
 13 files changed, 71 insertions(+), 242 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.9.1

