From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 00/11] thermal: add new flag irq-mode for trip point
Date: Tue, 16 Oct 2018 16:56:11 +0200
Message-ID: <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

This patch set adds new flag and mechanism in thermal trip point in DT.
The current situation with 'passive' (passive cooling - DVFS)
trip point is that it enables polling mode in thermal framework.
If the device supports irqs fired when the desired temerature is met,
thermal framwork should be notifed from driver's irq routine.
This is sufficent and there is no need of polling.
As a workaround, people declare trip point as 'active'
(active cooling, i.e. fan) to bypass polling mode setup in thermal
framework.

With this patch set trip point 'passive' declared in DT with explicit flag:
'irq-mode;' will not register itself as polling mode.

A good example is Exynos4 SoC family, where there is 4 HW supported
trip points and there is a need of 6. The rest 2 are declared as 'passive'
without 'irq-mode;' flag, thus polling needed.

It does not break existing design for trip points which do not have 'irq-mode'
flag - they will use polling.

For consistency this flag should be added to all trip point types('active',
'passive', 'hot', 'critical') when need (meaning, when irq will notify thermal
framework).

Regards,
Lukasz Luba

Lukasz Luba (11):
  thermal: remove unused function parameter
  thermal: add irq-mode configuration for trip point
  thermal: add new sysfs file for irq-mode
  Doc: thermal: new irq-mode for trip point
  Doc: DT: thermal: new irq-mode for trip point
  DT: arm64: exynos: add support for thermal trip irq-mode
  DT: arm64: exynos7: add support for thermal trip irq-mode
  DT: arm: exynos4: add support for thermal trip irq-mode
  DT: arm: exynos: add support for thermal trip irq-mode
  DT: arm: exynos: add support for thermal trip irq-mode
  DT: arm: exynos: add support for thermal trip irq-mode

 .../devicetree/bindings/thermal/thermal.txt        |   7 ++
 Documentation/thermal/sysfs-api.txt                |   9 ++
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105 ++++++++++++++-------
 .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
 drivers/thermal/of-thermal.c                       |  17 ++++
 drivers/thermal/thermal_core.c                     |  16 ++--
 drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
 include/linux/thermal.h                            |   5 +
 12 files changed, 226 insertions(+), 64 deletions(-)

-- 
2.7.4
