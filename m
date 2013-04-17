From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 19/30] thermal: cpu_cooling: update documentation for cpufreq_get_max_state
Date: Wed, 17 Apr 2013 13:12:12 -0400
Message-ID: <1366218743-20841-20-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53632 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965452Ab3DQRTs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 13:19:48 -0400
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Update documentation for cpufreq_get_max_state callback.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 35b5835..490084b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -342,6 +342,11 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
  * cpufreq_get_max_state - callback function to get the max cooling state.
  * @cdev: thermal cooling device pointer.
  * @state: fill this variable with the max cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * max cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
  */
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
-- 
1.8.2.1.342.gfa7285d

