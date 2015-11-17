From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 15/27] PM / Domains: Add next_wakeup to device's timing data
Date: Tue, 17 Nov 2015 15:37:39 -0700
Message-ID: <1447799871-56374-16-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Allow devices that know when their next wakeup event is, to record save
it as part of timing data. A genpd governor may use this data to
determine if suspending the domain is going to affect the QoS of its
devices.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/pm_domain.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f1329ea..9ac089d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
+#include <linux/ktime.h>
 
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
@@ -104,6 +105,7 @@ struct gpd_timing_data {
 	s64 effective_constraint_ns;
 	bool constraint_changed;
 	bool cached_stop_ok;
+	ktime_t next_wakeup;
 };
 
 struct pm_domain_data {
-- 
2.1.4
