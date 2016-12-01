From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] devfreq: exynos: Don't use OPP structures outside of RCU locks
Date: Thu,  1 Dec 2016 15:55:40 +0530
Message-ID: <9cb02ef0037c8d161f7b57ff3e99c2831661da03.1480587838.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35489 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755413AbcLAKZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 05:25:53 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so93761362pga.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2016 02:25:53 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The OPP structures are abused to the best here, without understanding
how the OPP core and RCU locks work.

In short, the OPP pointer saved 'struct exynos_bus' can become invalid
under your nose, as the OPP core may free it.

Fix various abuses around OPP structures and calls.

Compile tested only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I would like it to go via the PM tree. Perhaps that's already the
default tree for this.

 drivers/devfreq/exynos-bus.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 29866f7e6d7e..a8ed7792ece2 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -35,7 +35,7 @@ struct exynos_bus {
 	unsigned int edev_count;
 	struct mutex lock;
 
-	struct dev_pm_opp *curr_opp;
+	unsigned long curr_freq;
 
 	struct regulator *regulator;
 	struct clk *clk;
@@ -99,7 +99,7 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
 	struct dev_pm_opp *new_opp;
-	unsigned long old_freq, new_freq, old_volt, new_volt, tol;
+	unsigned long old_freq, new_freq, new_volt, tol;
 	int ret = 0;
 
 	/* Get new opp-bus instance according to new bus clock */
@@ -113,8 +113,7 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 
 	new_freq = dev_pm_opp_get_freq(new_opp);
 	new_volt = dev_pm_opp_get_voltage(new_opp);
-	old_freq = dev_pm_opp_get_freq(bus->curr_opp);
-	old_volt = dev_pm_opp_get_voltage(bus->curr_opp);
+	old_freq = bus->curr_freq;
 	rcu_read_unlock();
 
 	if (old_freq == new_freq)
@@ -146,7 +145,7 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 			goto out;
 		}
 	}
-	bus->curr_opp = new_opp;
+	bus->curr_freq = new_freq;
 
 	dev_dbg(dev, "Set the frequency of bus (%lukHz -> %lukHz)\n",
 			old_freq/1000, new_freq/1000);
@@ -163,9 +162,7 @@ static int exynos_bus_get_dev_status(struct device *dev,
 	struct devfreq_event_data edata;
 	int ret;
 
-	rcu_read_lock();
-	stat->current_frequency = dev_pm_opp_get_freq(bus->curr_opp);
-	rcu_read_unlock();
+	stat->current_frequency = bus->curr_freq;
 
 	ret = exynos_bus_get_event(bus, &edata);
 	if (ret < 0) {
@@ -226,7 +223,7 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 	}
 
 	new_freq = dev_pm_opp_get_freq(new_opp);
-	old_freq = dev_pm_opp_get_freq(bus->curr_opp);
+	old_freq = bus->curr_freq;
 	rcu_read_unlock();
 
 	if (old_freq == new_freq)
@@ -242,7 +239,7 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 	}
 
 	*freq = new_freq;
-	bus->curr_opp = new_opp;
+	bus->curr_freq = new_freq;
 
 	dev_dbg(dev, "Set the frequency of bus (%lukHz -> %lukHz)\n",
 			old_freq/1000, new_freq/1000);
@@ -335,6 +332,7 @@ static int exynos_bus_parse_of(struct device_node *np,
 			      struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
+	struct dev_pm_opp *opp;
 	unsigned long rate;
 	int ret;
 
@@ -352,22 +350,23 @@ static int exynos_bus_parse_of(struct device_node *np,
 	}
 
 	/* Get the freq and voltage from OPP table to scale the bus freq */
-	rcu_read_lock();
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
-		rcu_read_unlock();
 		goto err_clk;
 	}
 
 	rate = clk_get_rate(bus->clk);
-	bus->curr_opp = devfreq_recommended_opp(dev, &rate, 0);
-	if (IS_ERR(bus->curr_opp)) {
+
+	rcu_read_lock();
+	opp = devfreq_recommended_opp(dev, &rate, 0);
+	if (IS_ERR(opp)) {
 		dev_err(dev, "failed to find dev_pm_opp\n");
 		rcu_read_unlock();
-		ret = PTR_ERR(bus->curr_opp);
+		ret = PTR_ERR(opp);
 		goto err_opp;
 	}
+	bus->curr_freq = dev_pm_opp_get_freq(opp);
 	rcu_read_unlock();
 
 	return 0;
-- 
2.7.1.410.g6faf27b

