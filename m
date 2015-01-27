From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/2] Fix reboot issue on Odroid boards with eMMC card
Date: Tue, 27 Jan 2015 09:11:27 +0100
Message-ID: <1422346289-9348-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <Liquid.Acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

This patchset fixes reboot hang issue on Hardkernel's Odroid boards with
eMMC card. Those boards are designed in such a way, that the eMMC nreset
signal is routed to SoC GPIO line instead of the board reset logic. To
properly restard system, one need to set this line to zero before
performing reboot.

The initial patches consisted of a complete reset/power off driver, but
after further analysis, it turned out that only eMMC nreset line control
logic is specific for those boards. Everything else can be done by
generic Exynos code, so the code has been moved to Exynos DW MMC driver.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

initial version:
http://thread.gmane.org/gmane.linux.power-management.general/51855/


Path summary:

Marek Szyprowski (2):
  mmc: dw_mmc-exynos: add support for controlling emmc reset pin
  ARM: dts: exynos*-odroid*: add eMMC reset line

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |  6 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 43 +++++++++++++++++++++-
 4 files changed, 50 insertions(+), 1 deletion(-)

-- 
1.9.2
