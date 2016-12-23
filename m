From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/9] Runtime PM for Exynos pin controller driver
Date: Fri, 23 Dec 2016 13:24:40 +0100
Message-ID: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161223122513epcas1p394d93d72d2d32c8910aafd1f6cc6b5e2@epcas1p3.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

This patchset is a next step to add support for audio power domain on
Exynos5 SoCs.

Audio power domain on Exynos5 SoCs contains following hardware modules:
1. clock controller
2. pin controller
3. PL330 DMA controller
4. I2S audio controller

Till now it was assumed that pin controller is located in the "always on"
power domain and lacked runtime power management. This patch finally
removes such assumption and adds runtime pm support and awareness to this
driver. To achieve this, some changes in the Exynos platform support code
were needed, like moving pad retention control to the pin controller driver.
Some cleanup to the pin controller driver has been also done while changing
the code. This new feature requires some additional information in the
device tree, what is handled by patches 1,2 and 9.

Please note that patches are ordered in such a way that the changes can be
bisected, so the properties are added to dts before the code requiring them.

The other patches related to enabling full support for audio power domain
can be found here:
1. PL330 ADMA controller non-irqsafe runtime PM:
   https://www.spinics.net/lists/arm-kernel/msg550008.html
2. Runtime PM for clock controllers (Exynos Audio subsystem will be added
   in v4 soon): https://www.spinics.net/lists/arm-kernel/msg538122.html

Patches are based on linux-next from 2016.12.22.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (9):
  ARM: dts: exynos: Add PMU syscon to pinctrl nodes
  ARM: dts: exynos: Add pinctrl sleep state for 542x i2s module
  pinctrl: samsung: Remove dead code
  pinctrl: samsung: Use generic of_device_get_match_data helper
  pinctrl: samsung: Move retention control from mach-exynos to the
    pinctrl driver
  pinctrl: samsung: Replace syscore ops with standard platform device
    pm_ops
  pinctrl: samsung: Add property to mark pad state as suitable for power
    down
  pinctrl: samsung: Add runtime PM support
  ARM: dts: exynos: Add audio power domain support to Exynos542x SoCs

 .../bindings/pinctrl/samsung-pinctrl.txt           |  12 ++
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +
 arch/arm/boot/dts/exynos4210.dtsi                  |   3 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |   3 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   4 +
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  11 ++
 arch/arm/boot/dts/exynos5420.dtsi                  |  18 ++-
 arch/arm/mach-exynos/suspend.c                     |  64 ---------
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 148 +++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 126 ++++++++----------
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  15 +++
 11 files changed, 271 insertions(+), 135 deletions(-)

-- 
1.9.1
