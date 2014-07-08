From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: [PATCH] cpufreq: Makefile: fix compilation for davinci platform
Date: Tue,  8 Jul 2014 16:25:38 +0100
Message-ID: <1404833138-8244-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57969 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbaGHP0F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jul 2014 11:26:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

>From patch with commt-id:8a7b1227e303d7e927214ee0f260041aef44bb58
"cpufreq: davinci: move cpufreq driver to drivers/cpufreq"
this added dependancy only for CONFIG_ARCH_DAVINCI_DA850 where as
davinci_cpufreq_init() call is used by all davinci platform.

This patch fixes following build error:

arch/arm/mach-davinci/built-in.o: In function `davinci_init_late':
:(.init.text+0x928): undefined reference to `davinci_cpufreq_init'
make: *** [vmlinux] Error 1

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/cpufreq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 738c8b7..db6d9a2 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
 # LITTLE drivers, so that it is probed last.
 obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
-obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= davinci-cpufreq.o
+obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
-- 
1.9.1

