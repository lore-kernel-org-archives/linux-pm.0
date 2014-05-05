From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v3 0/5] add cpuidle support for Exynos5420
Date: Mon,  5 May 2014 13:57:19 +0530
Message-ID: <1399278444-8312-1-git-send-email-chander.kashyap@linaro.org>
References: <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-pm@vger.kernel.org

Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.

This patchset adds cpuidle support for Exynos5420 SoC based on
generic big.little cpuidle driver.

Tested on SMDK5420.

This patch set depends on:
	1. [PATCH 0/5] MCPM backend for Exynos5420
	   http://www.spinics.net/lists/arm-kernel/msg327923.html

	2. [PATCH] arm: exynos: add generic function to calculate cpu number
	   http://www.spinics.net/lists/linux-samsung-soc/msg29446.html
	   http://www.spinics.net/lists/arm-kernel/msg324024.html
		
Changelog is in respective patches.
Chander Kashyap (5):
  driver: cpuidle-big-little: add of_device_id structure
  cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-little
    driver
  driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
  exynos: cpuidle: do not allow cpuidle registration for Exynos5420
  mcpm: exynos: populate suspend and powered_up callbacks

 arch/arm/mach-exynos/cpuidle.c       |    3 +++
 arch/arm/mach-exynos/mcpm-exynos.c   |   34 ++++++++++++++++++++++++++++++++++
 drivers/cpuidle/Kconfig.arm          |    2 +-
 drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
 4 files changed, 49 insertions(+), 2 deletions(-)

-- 
1.7.9.5
