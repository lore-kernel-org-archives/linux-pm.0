From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 2/7] drivers: cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date: Thu, 10 Jan 2019 05:30:51 +0530
Message-ID: <aadc9cff04dc310138b41979239ce51938afedce.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Several cpufreq drivers register themselves as thermal cooling devices.
Adding a pointer to struct cpufreq_policy removes the need for them to
store this pointer in a private data structure.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..2496549d7573 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -95,6 +95,8 @@ struct cpufreq_policy {
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
+	struct thermal_cooling_device *cooldev; /* Pointer to the cooling
+						 * device if used for thermal mitigation */
 	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-- 
2.17.1
