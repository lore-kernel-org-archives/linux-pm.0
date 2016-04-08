From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v8 06/20] PM / devfreq: exynos: Add support of bus frequency of
 sub-blocks using passive governor
Date: Fri, 08 Apr 2016 13:24:55 +0900
Message-ID: <1460089509-16260-7-git-send-email-cw00.choi@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1460089509-16260-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the support of bus frequency feature for sub-blocks which share
the one power line. If each bus depends on the power line, each bus is not able
to change the voltage by oneself. To optimize the power-consumption on runtime,
some buses using the same power line should change the source clock and
regulator at the same time. So, this patch uses the passive governor to support
the bus frequency for all buses which sharing the one power line.

For example,

Exynos3250 include the two power line for AXI buses as following:
: VDD_MIF : MIF (Memory Interface) provide the DMC (Dynamic Memory Controller)
  with the power (regulator).
: VDD_INT : INT (Internal) provide the various sub-blocks with the power
  (regulator).

Each bus is included in as follwoing block. In the case of VDD_MIF, only DMC bus
use the power line. So, there is no any depencency between buese. But, in the
case of VDD_INT, various buses share the one power line of VDD_INT. We need to
make the depenency between buses. When using passive governor, there is no
problem to support the bus frequency as DVFS for all buses. One bus should be
operated as the parent bus device which gathering the current load of INT block
and then decides the new frequency with some governors except of passive
governor. After deciding the new frequency by the parent bus device, the rest
bus devices will change the each source clock according to new frequency of the
parent bus device.

- MIF (Memory Interface) block
: VDD_MIF |--- DMC

- INT (Internal) block
: VDD_INT |--- LEFTBUS (parent)
          |--- PERIL
          |--- MFC
          |--- G3D
          |--- RIGHTBUS
          |--- FSYS
          |--- LCD0
          |--- PERIR
          |--- ISP
          |--- CAM

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
[tjakobi: Reported debugfs error during booting and cw00.choi fix it.]
Reported-by: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/devfreq/Kconfig      |   1 +
 drivers/devfreq/exynos-bus.c | 219 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 174 insertions(+), 46 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index d260cd0219f6..30e1daf1c827 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -78,6 +78,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
 	depends on ARCH_EXYNOS
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select DEVFREQ_GOV_PASSIVE
 	select DEVFREQ_EVENT_EXYNOS_PPMU
 	select PM_DEVFREQ_EVENT
 	select PM_OPP
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 137de6196af3..50fe1a16c574 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -1,7 +1,7 @@
 /*
  * Generic Exynos Bus frequency driver with DEVFREQ Framework
  *
- * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  * Author : Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
  *
  * This driver support Exynos Bus frequency feature by using
@@ -93,7 +93,7 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
 }
 
 /*
- * Must necessary function for devfreq governor
+ * Must necessary function for devfreq simple-ondemand governor
  */
 static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 {
@@ -202,59 +202,81 @@ static void exynos_bus_exit(struct device *dev)
 		regulator_disable(bus->regulator);
 
 	dev_pm_opp_of_remove_table(dev);
+	clk_disable_unprepare(bus->clk);
 }
 
-static int exynos_bus_parse_of(struct device_node *np,
-			      struct exynos_bus *bus)
+/*
+ * Must necessary function for devfreq passive governor
+ */
+static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
+					u32 flags)
 {
-	struct device *dev = bus->dev;
-	unsigned long rate;
-	int i, ret, count, size;
+	struct exynos_bus *bus = dev_get_drvdata(dev);
+	struct dev_pm_opp *new_opp;
+	unsigned long old_freq, new_freq;
+	int ret = 0;
 
-	/* Get the clock to provide each bus with source clock */
-	bus->clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(bus->clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(bus->clk);
+	/* Get new opp-bus instance according to new bus clock */
+	rcu_read_lock();
+	new_opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(new_opp)) {
+		dev_err(dev, "failed to get recommended opp instance\n");
+		rcu_read_unlock();
+		return PTR_ERR(new_opp);
 	}
 
-	ret = clk_prepare_enable(bus->clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to get enable clock\n");
-		return ret;
-	}
+	new_freq = dev_pm_opp_get_freq(new_opp);
+	old_freq = dev_pm_opp_get_freq(bus->curr_opp);
+	rcu_read_unlock();
 
-	/* Get the freq/voltage OPP table to scale the bus frequency */
-	rcu_read_lock();
-	ret = dev_pm_opp_of_add_table(dev);
+	if (old_freq == new_freq)
+		return 0;
+
+	/* Change the frequency according to new OPP level */
+	mutex_lock(&bus->lock);
+
+	ret = clk_set_rate(bus->clk, new_freq);
 	if (ret < 0) {
-		dev_err(dev, "failed to get OPP table\n");
-		rcu_read_unlock();
-		goto err_clk;
+		dev_err(dev, "failed to set the clock of bus\n");
+		goto out;
 	}
 
-	rate = clk_get_rate(bus->clk);
-	bus->curr_opp = dev_pm_opp_find_freq_ceil(dev, &rate);
-	if (IS_ERR(bus->curr_opp)) {
-		dev_err(dev, "failed to find dev_pm_opp\n");
-		rcu_read_unlock();
-		ret = PTR_ERR(bus->curr_opp);
-		goto err_opp;
-	}
-	rcu_read_unlock();
+	*freq = new_freq;
+	bus->curr_opp = new_opp;
+
+	dev_dbg(dev, "Set the frequency of bus (%lukHz -> %lukHz)\n",
+			old_freq/1000, new_freq/1000);
+out:
+	mutex_unlock(&bus->lock);
+
+	return ret;
+}
+
+static void exynos_bus_passive_exit(struct device *dev)
+{
+	struct exynos_bus *bus = dev_get_drvdata(dev);
+
+	dev_pm_opp_of_remove_table(dev);
+	clk_disable_unprepare(bus->clk);
+}
+
+static int exynos_bus_parent_parse_of(struct device_node *np,
+					struct exynos_bus *bus)
+{
+	struct device *dev = bus->dev;
+	int i, ret, count, size;
 
 	/* Get the regulator to provide each bus with the power */
 	bus->regulator = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(bus->regulator)) {
 		dev_err(dev, "failed to get VDD regulator\n");
-		ret = PTR_ERR(bus->regulator);
-		goto err_opp;
+		return PTR_ERR(bus->regulator);
 	}
 
 	ret = regulator_enable(bus->regulator);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable VDD regulator\n");
-		goto err_opp;
+		return ret;
 	}
 
 	/*
@@ -305,6 +327,51 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 err_regulator:
 	regulator_disable(bus->regulator);
+
+	return ret;
+}
+
+static int exynos_bus_parse_of(struct device_node *np,
+			      struct exynos_bus *bus)
+{
+	struct device *dev = bus->dev;
+	unsigned long rate;
+	int ret;
+
+	/* Get the clock to provide each bus with source clock */
+	bus->clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(bus->clk)) {
+		dev_err(dev, "failed to get bus clock\n");
+		return PTR_ERR(bus->clk);
+	}
+
+	ret = clk_prepare_enable(bus->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to get enable clock\n");
+		return ret;
+	}
+
+	/* Get the freq and voltage from OPP table to scale the bus freq */
+	rcu_read_lock();
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get OPP table\n");
+		rcu_read_unlock();
+		goto err_clk;
+	}
+
+	rate = clk_get_rate(bus->clk);
+	bus->curr_opp = devfreq_recommended_opp(dev, &rate, 0);
+	if (IS_ERR(bus->curr_opp)) {
+		dev_err(dev, "failed to find dev_pm_opp\n");
+		rcu_read_unlock();
+		ret = PTR_ERR(bus->curr_opp);
+		goto err_opp;
+	}
+	rcu_read_unlock();
+
+	return 0;
+
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
 err_clk:
@@ -319,8 +386,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct devfreq_dev_profile *profile;
 	struct devfreq_simple_ondemand_data *ondemand_data;
+	struct devfreq_passive_data *passive_data;
+	struct devfreq *parent_devfreq;
 	struct exynos_bus *bus;
-	int ret;
+	int ret, max_state;
+	unsigned long min_freq, max_freq;
 
 	if (!np) {
 		dev_err(dev, "failed to find devicetree node\n");
@@ -337,20 +407,33 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	/* Parse the device-tree to get the resource information */
 	ret = exynos_bus_parse_of(np, bus);
 	if (ret < 0)
-		return ret;
+		goto err;
 
-	/* Initalize the struct profile and governor data */
 	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
-	if (!profile)
-		return -ENOMEM;
+	if (!profile) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if (of_parse_phandle(dev->of_node, "devfreq", 0))
+		goto passive;
+	else
+		ret = exynos_bus_parent_parse_of(np, bus);
+
+	if (ret < 0)
+		goto err;
+
+	/* Initalize the struct profile and governor data for parent device */
 	profile->polling_ms = 50;
 	profile->target = exynos_bus_target;
 	profile->get_dev_status = exynos_bus_get_dev_status;
 	profile->exit = exynos_bus_exit;
 
 	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
-	if (!ondemand_data)
-		return -ENOMEM;
+	if (!ondemand_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	ondemand_data->upthreshold = 40;
 	ondemand_data->downdifferential = 5;
 
@@ -359,14 +442,15 @@ static int exynos_bus_probe(struct platform_device *pdev)
 						ondemand_data);
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev, "failed to add devfreq device\n");
-		return  PTR_ERR(bus->devfreq);
+		ret = PTR_ERR(bus->devfreq);
+		goto err;
 	}
 
 	/* Register opp_notifier to catch the change of OPP  */
 	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
 	if (ret < 0) {
 		dev_err(dev, "failed to register opp notifier\n");
-		return ret;
+		goto err;
 	}
 
 	/*
@@ -376,16 +460,59 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	ret = exynos_bus_enable_edev(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable devfreq-event devices\n");
-		return ret;
+		goto err;
 	}
 
 	ret = exynos_bus_set_event(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		return ret;
+		goto err;
 	}
 
+	goto out;
+passive:
+	/* Initalize the struct profile and governor data for passive device */
+	profile->target = exynos_bus_passive_target;
+	profile->exit = exynos_bus_passive_exit;
+
+	/* Get the instance of parent devfreq device */
+	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	if (IS_ERR(parent_devfreq)) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
+
+	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
+	if (!passive_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	passive_data->parent = parent_devfreq;
+
+	/* Add devfreq device for exynos bus with passive governor */
+	bus->devfreq = devm_devfreq_add_device(dev, profile, "passive",
+						passive_data);
+	if (IS_ERR(bus->devfreq)) {
+		dev_err(dev,
+			"failed to add devfreq dev with passive governor\n");
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
+
+out:
+	max_state = bus->devfreq->profile->max_state;
+	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
+	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
+	pr_info("exynos-bus: new bus device registered: %s (%6ld KHz ~ %6ld KHz)\n",
+			dev_name(dev), min_freq, max_freq);
+
 	return 0;
+
+err:
+	dev_pm_opp_of_remove_table(dev);
+	clk_disable_unprepare(bus->clk);
+
+	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
