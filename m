From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/8] opp: of_init_opp_table(): return -ENOSYS when feature isn't implemented
Date: Thu, 22 May 2014 11:07:26 +0530
Message-ID: <7ad59da5b28e8ed632e833fa5095129628bd8deb.1400736536.git.viresh.kumar@linaro.org>
References: <cover.1400736536.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1400736536.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1400736536.git.viresh.kumar@linaro.org>
References: <cover.1400736536.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, nm@ti.com, chander.kashyap@linaro.org, pavel@ucw.cz, len.brown@intel.com, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

When none of CONFIG_PM_OPP or CONFIG_OF is enabled we use the dummy
implementation of of_init_opp_table() routine, which returns -EINVAL currently.
-EINVAL can confuse the callers a bit as it can have other meanings for the
actual implementation of this routine.

It is more appropriate to return -ENOSYS instead to avoid confusion at caller.

Suggested-and-reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0330217..6668150 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -112,7 +112,7 @@ int of_init_opp_table(struct device *dev);
 #else
 static inline int of_init_opp_table(struct device *dev)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 #endif
 
-- 
2.0.0.rc2
