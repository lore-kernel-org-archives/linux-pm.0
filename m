From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 29/30] thermal: cpu_cooling: remove unused symbols on cpu_cooling.h
Date: Wed, 17 Apr 2013 13:12:22 -0400
Message-ID: <1366218743-20841-30-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965461Ab3DQRXS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 13:23:18 -0400
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove defines that are not in used.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 include/linux/cpu_cooling.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 75ef931..f48f6fb 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -27,9 +27,6 @@
 #include <linux/thermal.h>
 #include <linux/cpumask.h>
 
-#define CPUFREQ_COOLING_START		0
-#define CPUFREQ_COOLING_STOP		1
-
 #ifdef CONFIG_CPU_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
-- 
1.8.2.1.342.gfa7285d

