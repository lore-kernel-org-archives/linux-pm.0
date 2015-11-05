From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/4] PM / OPP: Hold dev_opp_list_lock for writers
Date: Thu,  5 Nov 2015 14:21:20 +0530
Message-ID: <a0998ee49d661dde9421da776403ce7980aeec62.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "4 . 3 # 4 . 3" <stable@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Writers need to update OPP device and their list with dev_opp_list_lock
mutex held, which was missed at few places. Fix it.

Cc: 4.3 <stable@vger.kernel.org> # 4.3
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a93a433c9ac5..7a395f5ba5f9 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1175,13 +1175,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	struct device_opp *dev_opp;
 	int ret = 0, count = 0;
 
+	mutex_lock(&dev_opp_list_lock);
+
 	dev_opp = _managed_opp(opp_np);
 	if (dev_opp) {
 		/* OPPs are already managed */
 		if (!_add_list_dev(dev, dev_opp))
 			ret = -ENOMEM;
+		mutex_unlock(&dev_opp_list_lock);
 		return ret;
 	}
+	mutex_unlock(&dev_opp_list_lock);
 
 	/* We have opp-list node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
@@ -1199,15 +1203,20 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	if (WARN_ON(!count))
 		return -ENOENT;
 
+	mutex_lock(&dev_opp_list_lock);
+
 	dev_opp = _find_device_opp(dev);
 	if (WARN_ON(IS_ERR(dev_opp))) {
 		ret = PTR_ERR(dev_opp);
+		mutex_unlock(&dev_opp_list_lock);
 		goto free_table;
 	}
 
 	dev_opp->np = opp_np;
 	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");
 
+	mutex_unlock(&dev_opp_list_lock);
+
 	return 0;
 
 free_table:
-- 
2.6.2.198.g614a2ac
