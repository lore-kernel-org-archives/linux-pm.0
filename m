From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 16/16] PM / OPP: don't print error message for deferred probing
Date: Fri, 11 Sep 2015 17:32:12 +0530
Message-ID: <d8fc12550d6a7f1fb249d5e66d40295b953c10e5.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_of_add_table() can fail with a return value of -EPROBE_DEFER
and in such a case we should skip printing the error message, as its not
really an error.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 9ac691341fb0..f259a994fd16 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -198,8 +198,9 @@ int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 
 		ret = dev_pm_opp_of_add_table(cpu_dev);
 		if (ret) {
-			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
-			       __func__, cpu, ret);
+			if (ret != -EPROBE_DEFER)
+				pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
+				       __func__, cpu, ret);
 
 			/* Free all other OPPs */
 			dev_pm_opp_of_cpumask_remove_table(cpumask);
-- 
2.4.0
