From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
Date: Fri, 10 Apr 2015 19:58:56 +0200
Message-ID: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series removes the use of Exynos4x12 specific support
from cpufreq-exynos driver and enables the use of cpufreq-dt driver
for this platform.

In order to preserve support for Exynos4x12 'boost' mode cpufreq-dt
driver is made aware of 'boost' mode frequencies and boost-opps
binding is provided.

boost-opps binding is currently limited to cpufreq-dt but once there is
a need for cpufreq wide and/or generic Linux device support for 'boost'
mode cpufreq-dt can be updated to handle the new code without changing
the binding itself.

The decision to make 'boost' mode support limited to cpufreq-dt driver
for now was taken because 'boost' mode is currently a niche feature and
code needed for parsing boost-opps binding is minimal and simple.  More
generic (i.e. separate 'boost' OPPs list in struct device and generic
cpufreq convertion of them to freq_table format) support would need far
more code and effort to make it work.  Doing it without a demonstrated
real need would be on overengineering IMHO.

This patch series has been tested on Exynos4412 based Odroid-U3 and
Trats2 boards.

Depends on:
- next-20150330 branch of linux-next kernel tree
- "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
  platform" [1]

[1] http://www.kernelhub.org/?msg=721136&p=2

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (6):
  cpufreq / OPP: allow allocation of extra table entries in freq_table
  cpufreq-dt: add 'boost' mode frequencies support
  clk: samsung: exynos4x12: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos4x12: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos4x12
  cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support

 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |   14 ++
 arch/arm/boot/dts/exynos4212.dtsi                  |   22 ++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    4 +
 arch/arm/boot/dts/exynos4412-origen.dts            |    5 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |    5 +
 arch/arm/boot/dts/exynos4412.dtsi                  |   22 ++
 arch/arm/mach-exynos/exynos.c                      |   14 ++
 drivers/clk/samsung/clk-exynos4.c                  |   50 +++++
 drivers/cpufreq/Kconfig.arm                        |   13 +-
 drivers/cpufreq/Makefile                           |    1 -
 drivers/cpufreq/cpufreq-dt.c                       |  114 ++++++++--
 drivers/cpufreq/cpufreq_opp.c                      |   18 +-
 drivers/cpufreq/exynos-cpufreq.c                   |   11 +-
 drivers/cpufreq/exynos-cpufreq.h                   |   21 --
 drivers/cpufreq/exynos4x12-cpufreq.c               |  236 --------------------
 include/linux/cpufreq-dt.h                         |    1 +
 include/linux/cpufreq.h                            |    3 +
 17 files changed, 257 insertions(+), 297 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

-- 
1.7.9.5
