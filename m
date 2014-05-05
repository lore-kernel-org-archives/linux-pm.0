From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v4 0/5] add cpuidle support for Exynos5420
Date: Mon,  5 May 2014 14:57:15 +0530
Message-ID: <1399282040-8995-1-git-send-email-chander.kashyap@linaro.org>
References: <1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45114 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbaEEJ1f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 May 2014 05:27:35 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so9061841pab.41
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2014 02:27:34 -0700 (PDT)
In-Reply-To: <1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

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

