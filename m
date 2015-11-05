From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] PM / OPP: Add opp_rcu_lockdep_assert() to _find_device_opp()
Date: Thu,  5 Nov 2015 14:21:21 +0530
Message-ID: <6f78bb732c54ff35c4adfc0de256f20fe7cd39ba.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "4 . 3 # 4 . 3" <stable@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

_find_device_opp() should be called with rcu-read lock or
dev_opp_list_lock held. Add the opp_rcu_lockdep_assert() check to make
sure caller have taken appropriate locks.

Fix comment over the routine as well.

Cc: 4.3 <stable@vger.kernel.org> # 4.3
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7a395f5ba5f9..5e4b1d82b2f8 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -81,14 +81,18 @@ static struct device_opp *_managed_opp(const struct device_node *np)
  * Return: pointer to 'struct device_opp' if found, otherwise -ENODEV or
  * -EINVAL based on type of error.
  *
- * Locking: This function must be called under rcu_read_lock(). device_opp
- * is a RCU protected pointer. This means that device_opp is valid as long
- * as we are under RCU lock.
+ * Locking: For readers, this function must be called under rcu_read_lock().
+ * device_opp is a RCU protected pointer, which means that device_opp is valid
+ * as long as we are under RCU lock.
+ *
+ * For Writers, this function must be called with dev_opp_list_lock held.
  */
 struct device_opp *_find_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 
+	opp_rcu_lockdep_assert();
+
 	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
-- 
2.6.2.198.g614a2ac
