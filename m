From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH RFC v2 0/7] Devfreq support for Exynos5250/5420
Date: Thu, 22 May 2014 22:51:55 +0530
Message-ID: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62142 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbaEVRWU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:22:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: kesavan.abhilash@gmail.com

This patchset adds devfreq support on Exynos5250 and Exynos5420.
The patches add the missing INT clock support for exynos5250 and
also add a new 5420 driver. We also have patches which add the
PPMU node and fix a typo in the exynos5250 driver.

Changes since RFC v1:
	- Exynos5420 support has been added to the existent Exynos5250
	  driver itself.
	- Rebased on Chanwoo Choi's devfreq consolidation patchset.
	- Removed unused clocks from the clock list
	- Used the PPMU nodes with different compatible strings to
	  differentiate between exynos5250 and exynos5420.

The patches have been tested on Exynos5250 based Snow board and Exynos5420
based Peach-Pit boards. They have been prepared on linux-next(20140521) with
the devfreq for-next branch merged. Also applied is the "devfreq resource
management" series from Chanwoo Choi[1].
[1] https://lkml.org/lkml/2014/4/25/826

Abhilash Kesavan (3):
  ARM: dts: Add PPMU device tree support for Exynos5250
  ARM: dts: Add PPMU device tree support for Exynos5420
  PM / devfreq: exynos: Fix typo in macro

Andrew Bresticker (2):
  clk: exynos5250: add aliases for clocks used by devfreq
  PM / devfreq: exynos5250: migrate to common-clock

Arjun.K.V (2):
  clk: exynos5420: Add aliases for clocks used by devfreq
  PM / devfreq: Add devfreq driver for Exynos5420

 .../bindings/arm/exynos/ppmu-exynos5.txt           |   27 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |    7 +
 drivers/clk/samsung/clk-exynos5250.c               |   25 +-
 drivers/clk/samsung/clk-exynos5420.c               |   73 ++-
 drivers/devfreq/Kconfig                            |   10 +-
 drivers/devfreq/exynos/exynos5_bus.c               |  665 +++++++++++++++++---
 drivers/devfreq/exynos/exynos_ppmu.h               |    2 +-
 8 files changed, 703 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

-- 
1.7.9.5

