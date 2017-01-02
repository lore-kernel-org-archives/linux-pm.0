From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 03/10] PM / OPP: Rename _allocate_opp() to _opp_allocate()
Date: Mon,  2 Jan 2017 14:40:57 +0530
Message-ID: <4c0fa042822d024fbd26997c6b1ade35bc6e42a6.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Make the naming consistent with how other routines are named.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 4 ++--
 drivers/base/power/opp/of.c   | 2 +-
 drivers/base/power/opp/opp.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a8a5e01b7756..422482575954 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1014,7 +1014,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
-struct dev_pm_opp *_allocate_opp(struct device *dev,
+struct dev_pm_opp *_opp_allocate(struct device *dev,
 				 struct opp_table **opp_table)
 {
 	struct dev_pm_opp *opp;
@@ -1167,7 +1167,7 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	new_opp = _allocate_opp(dev, &opp_table);
+	new_opp = _opp_allocate(dev, &opp_table);
 	if (!new_opp) {
 		ret = -ENOMEM;
 		goto unlock;
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 996ca3b42f47..f8512ca2bf41 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -287,7 +287,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	new_opp = _allocate_opp(dev, &opp_table);
+	new_opp = _opp_allocate(dev, &opp_table);
 	if (!new_opp) {
 		ret = -ENOMEM;
 		goto unlock;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index af9f2b849a66..0f23a1059605 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -193,7 +193,7 @@ struct opp_table {
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 void _dev_pm_opp_remove_table(struct device *dev, bool remove_all);
-struct dev_pm_opp *_allocate_opp(struct device *dev, struct opp_table **opp_table);
+struct dev_pm_opp *_opp_allocate(struct device *dev, struct opp_table **opp_table);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
 void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp, bool notify);
 int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-- 
2.7.1.410.g6faf27b
