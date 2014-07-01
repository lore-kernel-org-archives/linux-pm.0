From: Chander Kashyap <k.chander@samsung.com>
Subject: [PATCH 0/2] cpuidle fixes and cleanup
Date: Tue,  1 Jul 2014 20:02:36 +0530
Message-ID: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50124 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbaGAOc5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 10:32:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: daniel.lezcano@linaro.org, kgene.kim@samsung.com, linux-pm@vger.kernel.org, Chander Kashyap <k.chander@samsung.com>

This patch series fixes the cpuidle for different states. Also removes arm
diagnostic and power register save/restore code as it is made generic.

Based on:
ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
 http://www.spinics.net/lists/arm-kernel/msg340506.html

ARM: save/restore power control register on Cortex-A9 suspend/resume
 http://www.spinics.net/lists/arm-kernel/msg343320.html

Chander Kashyap (2):
  ARM: Exynos: remove arm diagnostic and power register save/restore
    code
  cpuidle: Exynos: fix cpuidle for all states

 arch/arm/mach-exynos/common.h    |    2 +-
 arch/arm/mach-exynos/pm.c        |   95 +++++---------------------------------
 drivers/cpuidle/cpuidle-exynos.c |    7 ++-
 3 files changed, 17 insertions(+), 87 deletions(-)

-- 
1.7.9.5

