From: Lina Iyer <lina.iyer@linaro.org>
Subject: [BUG FIX] PM / cpu_domains: Check for NULL callbacks
Date: Tue,  1 Mar 2016 14:15:19 -0700
Message-ID: <1456866931-37851-2-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Check for NULL platform callback before calling.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu_domains.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index 7069411..bcaa474 100644
--- a/drivers/base/power/cpu_domains.c
+++ b/drivers/base/power/cpu_domains.c
@@ -157,16 +157,22 @@ static int cpu_pd_power_on(struct generic_pm_domain *genpd)
 {
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
 
-	return pd->ops.power_on();
+	if (pd->ops.power_on)
+		return pd->ops.power_on();
+
+	return 0;
 }
 
 static int cpu_pd_power_off(struct generic_pm_domain *genpd)
 {
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
 
-	return pd->ops.power_off(genpd->state_idx,
+	if (pd->ops.power_off)
+		return pd->ops.power_off(genpd->state_idx,
 			genpd->states[genpd->state_idx].param,
 			pd->cpus);
+
+	return 0;
 }
 
 /**
-- 
2.1.4
