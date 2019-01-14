From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 3/9] drivers: cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date: Mon, 14 Jan 2019 15:51:05 +0530
Message-ID: <bbc4cccbe2931de5f7e07b70a4873624424ac930.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Several cpufreq drivers register themselves as thermal cooling devices.
Adding a pointer to struct cpufreq_policy removes the need for them to
store this pointer in a private data structure.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..9fbc1d996967 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -95,6 +95,9 @@ struct cpufreq_policy {
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cooldev;
+
 	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-- 
2.17.1
