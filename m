From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] PM / OPP: Propagate error properly from dev_pm_opp_set_sharing_cpus()
Date: Thu,  5 Nov 2015 14:21:18 +0530
Message-ID: <2cd8d43a1affb10b0aabd80941b6aa6c96eff626.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "4 . 3 # 4 . 3" <stable@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

We are returning 0 even in case of errors, fix it.

Cc: 4.3 <stable@vger.kernel.org> # 4.3
Fixes: 8d4d4e98acd6 ("PM / OPP: Add helpers for initializing CPU OPPs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index c27a1cdffec9..2139c9d4c447 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -156,7 +156,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 out_rcu_read_unlock:
 	rcu_read_unlock();
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
-- 
2.6.2.198.g614a2ac
