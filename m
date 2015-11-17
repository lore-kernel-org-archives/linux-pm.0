From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 05/27] PM / Domains: remove old power on/off latencies.
Date: Tue, 17 Nov 2015 15:37:29 -0700
Message-ID: <1447799871-56374-6-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that all known users have been converted to use state latencies,
we can remove the latency field in the generic_pm_domain structure.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c | 15 ---------------
 include/linux/pm_domain.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3fb4c93..c300293 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1248,21 +1248,6 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
 		genpd->states[i].param = st[i].param;
 	}
 
-	/*
-	 * Copy the latency values To keep compatibility with
-	 * platforms that are not converted to use the multiple states.
-	 * This will be removed once all platforms are converted to use
-	 * multiple states. note that non converted platforms will use the
-	 * default single off state.
-	 */
-	if (genpd->power_on_latency_ns != 0)
-		genpd->states[0].power_on_latency_ns =
-				genpd->power_on_latency_ns;
-
-	if (genpd->power_off_latency_ns != 0)
-		genpd->states[0].power_off_latency_ns =
-				genpd->power_off_latency_ns;
-
 	genpd->state_count = st_count;
 
 	/* to save memory, Name allocation will happen if debug is enabled */
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 15df24c..108a4b3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,9 +61,7 @@ struct generic_pm_domain {
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
 	int (*power_off)(struct generic_pm_domain *domain);
-	s64 power_off_latency_ns;
 	int (*power_on)(struct generic_pm_domain *domain);
-	s64 power_on_latency_ns;
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
-- 
2.1.4
