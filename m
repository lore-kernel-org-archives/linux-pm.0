From: Sivaram Nair <sivaramn@nvidia.com>
Subject: [PATCH 1/2] cpuidle: fix finding state with min power_usage
Date: Fri, 14 Dec 2012 15:17:36 +0200
Message-ID: <1355491060-970-1-git-send-email-sivaramn@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:2995 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2LNNSD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Dec 2012 08:18:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, len.brown@intel.com, daniel.lezcano@linaro.org, khilman@ti.com, ccross@android.com, riel@redhat.com, youquan.song@intel.com, akpm@linux-foundation.org, shuox.liu@intel.com
Cc: linux-pm@vger.kernel.org, Sivaram Nair <sivaramn@nvidia.com>, linux-kernel@vger.kernel.org

Since cpuidle_state.power_usage is a signed value, use INT_MAX (instead
of -1) to init the local copies so that functions that tries to find
cpuidle states with minimum power usage works correctly even if they use
non-negative values.

Signed-off-by: Sivaram Nair <sivaramn@nvidia.com>
---
 drivers/cpuidle/cpuidle.c        |    2 +-
 drivers/cpuidle/governors/menu.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8df53dd..fb4a7dd 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -70,7 +70,7 @@ int cpuidle_play_dead(void)
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int i, dead_state = -1;
-	int power_usage = -1;
+	int power_usage = INT_MAX;
 
 	if (!drv)
 		return -ENODEV;
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index bd40b94..20ea33a 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -312,7 +312,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
-	int power_usage = -1;
+	int power_usage = INT_MAX;
 	int i;
 	int multiplier;
 	struct timespec t;
-- 
1.7.9.5

