From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/5] cpufreq: Loongson1: Rename the file to loongson1-cpufreq.c
Date: Mon, 11 Apr 2016 19:55:55 +0800
Message-ID: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33766 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbcDKL4U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 07:56:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kelvin Cheung <keguang.zhang@gmail.com>

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch renames the file to loongson1-cpufreq.c

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/Makefile                                | 2 +-
 drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (100%)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..bebe9c8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
-obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
+obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
similarity index 100%
rename from drivers/cpufreq/ls1x-cpufreq.c
rename to drivers/cpufreq/loongson1-cpufreq.c
-- 
1.9.1

