From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/8] Power domains support for Exynos5433 SoCs
Date: Wed, 25 Jan 2017 12:55:34 +0100
Message-ID: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170125115558eucas1p18dcb5c4cbab28dcb10bd412b825256b7@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

This patchset is a final step to add support for all power domains
on Exynos5433 SoCs. This patchset contains patches for adding Exynos5433
support to Exynos power domain driver and definitions of all power
domains found in Exynos5433 SoCs.

Patches have been generated on top of linux-next from 25th January 2017.

This is a part of a larger task, which goal is to add support for power
domains on Exynos5433 SoCs / TM2 boards. All patches needed to get it
working have been pushed to the following git repo:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd

To get everything working following patches/patchsets are needed on top
of the linux-next tree:
1. "Add support for the S6E3HA2 panel on TM2 board" v8 patchset:
   http://www.spinics.net/lists/devicetree/msg157859.html
2. "drm/exynos/decon5433: configure sysreg in case of hardware trigger" v2:
   https://patchwork.kernel.org/patch/9493177/
3. "Move pad retention control to Exynos pin controller driver" v3 patchset:
   https://www.spinics.net/lists/arm-kernel/msg556074.html
4. "Pad retentions support for Exynos5433" patchset
   (posted a few minutes ago, no link yet available)
5. "Exynos5433/TM2: add clocks configuration for display subsystem" patchset
   (posted a few minutes ago, no link yet available)
6. "clk: samsung: pll: Add enable/disable support for PLL35XX" patch
   (posted a few minutes ago, no link yet available)
7. "IOMMU probe deferral support" v7 patchset:
   https://www.spinics.net/lists/arm-kernel/msg557110.html
8. "Add runtime PM support for clocks (on Exynos SoC example)" v5 patchset
   (posted a few minutes ago, no link yet available)
9. "Power domains support for Exynos5433 SoCs" patchset
   (this patchset)

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Chanwoo Choi (1):
  soc: samsung: pm_domains: Add new exynos5433 compatible

Marek Szyprowski (7):
  arm64: dts: exynos: Add GSCL power domain to Exynos 5433 SoC
  arm64: dts: exynos: Add DISP power domain to Exynos 5433 SoC
  arm64: dts: exynos: Add MSCL power domain to Exynos 5433 SoC
  arm64: dts: exynos: Add MFC power domain to Exynos 5433 SoC
  arm64: dts: exynos: Add AUD power domain to Exynos5433 SoC
  arm64: dts: exynos: Add FSYS power domain to Exynos5433 SoC
  arm64: dts: exynos: Add remaining power domains to Exynos5433 SoC

 .../devicetree/bindings/power/pd-samsung.txt       |   1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 118 +++++++++++++++++++++
 drivers/soc/samsung/pm_domains.c                   |   7 ++
 3 files changed, 126 insertions(+)

-- 
1.9.1
