From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Propagate error properly from dev_pm_opp_set_sharing_cpus()
Date: Fri, 30 Oct 2015 18:10:28 +0530
Message-ID: <e936a7f240750777c8eee41f3eed6b948ef4de70.1446208794.git.viresh.kumar@linaro.org>
References: <20151030120450.GH7289@mwanda>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151030120450.GH7289@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

We are returning 0 even in case of errors, fix it.

Fixes: 8d4d4e98acd6 ("PM / OPP: Add helpers for initializing CPU OPPs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 91f15b2e25ee..2122543e769d 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -153,7 +153,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 unlock:
 	mutex_unlock(&dev_opp_list_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
-- 
2.6.2.198.g614a2ac
