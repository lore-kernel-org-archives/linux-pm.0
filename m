From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Tue, 9 Feb 2016 09:40:07 +0530
Message-ID: <20160209041007.GE10843@vireshk>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <d59a1d27c9e2f4cc023dfc9a2b72cb920cbac43a.1453965717.git.viresh.kumar@linaro.org>
 <20160202023418.GK4848@codeaurora.org>
 <20160202061013.GC31828@vireshk>
 <20160208225515.GF10791@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33845 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbcBIEKK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 23:10:10 -0500
Received: by mail-pa0-f48.google.com with SMTP id kp3so1172692pab.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 20:10:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160208225515.GF10791@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>

On 08-02-16, 14:55, Stephen Boyd wrote:
> On 02/02, Viresh Kumar wrote:
> >  static int allocate_resources(int cpu, struct device **cdev,
> >  			      struct regulator **creg, struct clk **cclk)
> >  {
> > @@ -200,6 +225,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	unsigned long min_uV = ~0, max_uV = 0;
> >  	unsigned int transition_latency;
> >  	bool opp_v1 = false;
> > +	const char *name = NULL;
> 
> Is this initialization necessary?
> 
> >  	int ret;
> >  
> >  	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
> > @@ -229,6 +255,25 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	}
> >  
> >  	/*
> > +	 * OPP layer will be taking care of regulators now, but it needs to know
> > +	 * the name of the regulator first.
> > +	 */
> > +	name = find_supply_name(cpu_dev, np);
> > +	if (IS_ERR(name)) {
> 
> This looks to never happen?

Stupid me :(

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 8 Sep 2015 17:16:46 +0530
Subject: [PATCH] cpufreq: dt: Pass regulator name to the OPP core

OPP core can handle the regulators by itself, and but it needs to know
the name of the regulator to fetch. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 4c9f8a828f6f..2af75f8088bb 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -34,6 +34,7 @@ struct private_data {
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	unsigned int voltage_tolerance; /* in percentage */
+	const char *reg_name;
 };
 
 static struct freq_attr *cpufreq_dt_attr[] = {
@@ -119,6 +120,30 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
+/*
+ * An earlier version of opp-v1 bindings used to name the regulator
+ * "cpu0-supply", we still need to handle that for backwards compatibility.
+ */
+static const char *find_supply_name(struct device *dev, struct device_node *np)
+{
+	struct property *pp;
+	int cpu = dev->id;
+
+	/* Try "cpu0" for older DTs */
+	if (!cpu) {
+		pp = of_find_property(np, "cpu0-supply", NULL);
+		if (pp)
+			return "cpu0";
+	}
+
+	pp = of_find_property(np, "cpu-supply", NULL);
+	if (pp)
+		return "cpu";
+
+	dev_dbg(dev, "no regulator for cpu%d\n", cpu);
+	return NULL;
+}
+
 static int allocate_resources(int cpu, struct device **cdev,
 			      struct regulator **creg, struct clk **cclk)
 {
@@ -200,6 +225,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool opp_v1 = false;
+	const char *name;
 	int ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -229,6 +255,20 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/*
+	 * OPP layer will be taking care of regulators now, but it needs to know
+	 * the name of the regulator first.
+	 */
+	name = find_supply_name(cpu_dev, np);
+	if (name) {
+		ret = dev_pm_opp_set_regulator(cpu_dev, name);
+		if (ret) {
+			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
+				policy->cpu, ret);
+			goto out_node_put;
+		}
+	}
+
+	/*
 	 * Initialize OPP tables for all policy->cpus. They will be shared by
 	 * all CPUs which have marked their CPUs shared with OPP bindings.
 	 *
@@ -273,6 +313,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
+	priv->reg_name = name;
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
@@ -366,6 +407,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	kfree(priv);
 out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	if (name)
+		dev_pm_opp_put_regulator(cpu_dev);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -383,6 +426,9 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	if (priv->reg_name)
+		dev_pm_opp_put_regulator(priv->cpu_dev);
+
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
