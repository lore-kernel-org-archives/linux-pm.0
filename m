From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v4 12/12] cpufreq: dt: Reintroduce independent_clocks platform
 data
Date: Fri,  8 Dec 2017 15:12:30 +0530
Message-ID: <1512726150-7204-13-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

The Platform data was removed earlier by,
'commit eb96924acddc ("cpufreq: dt: Kill platform-data")'
since there were no users at that time.
Now this is required when the each of the cpu clocks
can be scaled independently, which is the case
for krait cores. So reintroduce it.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
 drivers/cpufreq/cpufreq-dt.h | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 545946a..8f0e881 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -228,7 +228,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	if (fallback) {
-		cpumask_setall(policy->cpus);
+		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
+
+		if (!pd || !pd->independent_clocks)
+			cpumask_setall(policy->cpus);
 
 		/*
 		 * OPP tables are initialized only for policy->cpu, do it for
@@ -380,6 +383,8 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (data && data->have_governor_per_policy)
 		dt_cpufreq_driver.flags |= CPUFREQ_HAVE_GOVERNOR_PER_POLICY;
 
+	dt_cpufreq_driver.driver_data = data;
+
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
 		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
diff --git a/drivers/cpufreq/cpufreq-dt.h b/drivers/cpufreq/cpufreq-dt.h
index 54d774e..dcc03c6 100644
--- a/drivers/cpufreq/cpufreq-dt.h
+++ b/drivers/cpufreq/cpufreq-dt.h
@@ -13,6 +13,12 @@
 #include <linux/types.h>
 
 struct cpufreq_dt_platform_data {
+	/*
+	 * True when each CPU has its own clock to control its
+	 * frequency, false when all CPUs are controlled by a single
+	 * clock.
+	 */
+	bool independent_clocks;
 	bool have_governor_per_policy;
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
