From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 06/11] cpufreq: remove __cpufreq_remove_dev()
Date: Wed,  2 Oct 2013 14:13:14 +0530
Message-ID: <6a2e0a9a7a84827cce389cc893b4f5521930df8d.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Nobody except cpufreq_remove_dev() is calling __cpufreq_remove_dev() and so we
don't need separate routines here. Lets merge code from __cpufreq_remove_dev()
to cpufreq_remove_dev() and get rid of __cpufreq_remove_dev().

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 065b4dd..1394dac 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1256,34 +1256,24 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 }
 
 /**
- * __cpufreq_remove_dev - remove a CPU device
+ * cpufreq_remove_dev - remove a CPU device
  *
  * Removes the cpufreq interface for a CPU device.
  */
-static inline int __cpufreq_remove_dev(struct device *dev,
-				       struct subsys_interface *sif,
-				       bool frozen)
-{
-	int ret;
-
-	ret = __cpufreq_remove_dev_prepare(dev, sif, frozen);
-
-	if (!ret)
-		ret = __cpufreq_remove_dev_finish(dev, sif, frozen);
-
-	return ret;
-}
-
 static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id;
-	int retval;
+	int ret;
 
 	if (cpu_is_offline(cpu))
 		return 0;
 
-	retval = __cpufreq_remove_dev(dev, sif, false);
-	return retval;
+	ret = __cpufreq_remove_dev_prepare(dev, sif, false);
+
+	if (!ret)
+		ret = __cpufreq_remove_dev_finish(dev, sif, false);
+
+	return ret;
 }
 
 static void handle_update(struct work_struct *work)
-- 
1.7.12.rc2.18.g61b472e

