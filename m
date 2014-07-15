From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v3 0/7]  Devfreq support for Exynos5250/5420
Date: Wed, 16 Jul 2014 00:03:26 +0530
Message-ID: <1405449206-26146-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48032 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbaGOSdm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 14:33:42 -0400
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, t.figa@samsung.com, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

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
Changes since RFC v2:
	- Re-based on the latest devfreq/samsung clock tree.
	- Fixed comment from Sergei Shtylyov.

The patches have been tested on Exynos5250 based Snow board and Exynos5420
based Peach-Pit boards. They have been prepared on linux-next(20140714) with
the samsung clk-next branch merged[1].

[1] //git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git

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

 .../bindings/arm/exynos/ppmu-exynos5.txt           |   26 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |    7 +
 drivers/clk/samsung/clk-exynos5250.c               |   25 +-
 drivers/clk/samsung/clk-exynos5420.c               |   73 ++-
 drivers/devfreq/Kconfig                            |   10 +-
 drivers/devfreq/exynos/exynos5_bus.c               |  665 +++++++++++++++++---
 drivers/devfreq/exynos/exynos_ppmu.h               |    2 +-
 8 files changed, 702 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

-- 
1.7.9.5

