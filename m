From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: governor: fix compile warning
Date: Wed,  3 Feb 2016 22:06:51 -0800
Message-ID: <1454566011-18072-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60954 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756483AbcBDGHz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Feb 2016 01:07:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Fix warning reported by 0-day
> drivers/cpufreq/cpufreq_governor.c:293:4: error: implicit declaration of
> function 'irq_work_queue_on' [-Werror=implicit-function-declaration]

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/cpufreq_governor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 541c323..0da7fc4 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/export.h>
+#include <linux/irq_work.h>
 #include <linux/kernel_stat.h>
 #include <linux/slab.h>
 
-- 
2.5.0

