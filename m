From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 17:41:31 +0000
Message-ID: <20190208174131.GB22401@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208110053.GA7913@e107155-lin>
 <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
 <20190208115122.GA13043@e107155-lin>
 <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 08, 2019 at 01:04:18PM +0100, Marek Szyprowski wrote:
> Hi Sudeep,
> 
> On 2019-02-08 12:51, Sudeep Holla wrote:
> > On Fri, Feb 08, 2019 at 12:47:06PM +0100, Marek Szyprowski wrote:
> >> On 2019-02-08 12:00, Sudeep Holla wrote:
> >>> On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
> >>>> Dear All,
> >>>>
> >>>> This is a scenario that triggers the above issue:
> >>> [...]
> >>>> 1. system disables non-boot cpu's at the end of system suspend procedure,
> >>>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> >>>> 3. early in the system resume procedure all cpus are got back to online
> >>>>    state,
> >>>> 4. this in turn causes cpufreq to be initialized for the newly onlined
> >>>>    cpus,
> >>>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
> >>>>    ->init() callback,
> >>> This is strictly not just restricted to cpufreq-dt, but to any driver
> >>> supporting multiple policies. So we need a generic fix not just
> >>> cpufreq-dt specific.
> >> Could you point which other driver needs similar fix? Here in cpufreq-dt
> >> the problem was caused by using regulator api (indirectly) from
> >> ->init(). All other drivers, which have regulators support, are for old,
> >> obsolete, uni-processor systems, which don't have the problem of
> >> secondary cpu suspend during system suspend/resume cycle.
> >>
> > scmi_cpufreq for instance. We can fix that in driver my moving to polling
> > to get cpufreq_get_rate, but we support both polling and interrupt based.
> > We may wait for remote processor interrupt in get_rate.
> 
> Frankly, I don't feel I know enough to touch this driver and I don't
> think that this can even be fixed in a generic way in the cpufreq core.

Based on Rafael's suggestion, I cooked up something. See if this helps ?
The policy to cpu dance can be removed and we can just run through the
online cpumask I think.

Regards,
Sudeep

-->8

diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
index e35a886e00bc..03d65a02a542 100644
--- i/drivers/cpufreq/cpufreq.c
+++ w/drivers/cpufreq/cpufreq.c
@@ -1640,6 +1640,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
 void cpufreq_suspend(void)
 {
 	struct cpufreq_policy *policy;
+	int cpu;
 
 	if (!cpufreq_driver)
 		return;
@@ -1662,6 +1663,11 @@ void cpufreq_suspend(void)
 	}
 
 suspend:
+	if (cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME)
+		for_each_active_policy(policy)
+			for_each_cpu(cpu, policy->cpus)
+				cpufreq_offline(cpu);
+
 	cpufreq_suspended = true;
 }
 
@@ -1674,7 +1680,7 @@ void cpufreq_suspend(void)
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
-	int ret;
+	int ret, cpu;
 
 	if (!cpufreq_driver)
 		return;
@@ -1682,6 +1688,11 @@ void cpufreq_resume(void)
 	if (unlikely(!cpufreq_suspended))
 		return;
 
+	if (cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME)
+		for_each_active_policy(policy)
+			for_each_cpu(cpu, policy->cpus)
+				cpufreq_online(cpu);
+
 	cpufreq_suspended = false;
 
 	if (!has_target() && !cpufreq_driver->resume)
@@ -2444,14 +2455,16 @@ static enum cpuhp_state hp_online;
 
 static int cpuhp_cpufreq_online(unsigned int cpu)
 {
-	cpufreq_online(cpu);
+	if (!(cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME))
+		cpufreq_online(cpu);
 
 	return 0;
 }
 
 static int cpuhp_cpufreq_offline(unsigned int cpu)
 {
-	cpufreq_offline(cpu);
+	if (!(cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME))
+		cpufreq_offline(cpu);
 
 	return 0;
 }
diff --git i/drivers/cpufreq/scmi-cpufreq.c w/drivers/cpufreq/scmi-cpufreq.c
index 01871418ffde..0bfc96102739 100644
--- i/drivers/cpufreq/scmi-cpufreq.c
+++ w/drivers/cpufreq/scmi-cpufreq.c
@@ -203,7 +203,8 @@ static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_DEFER_INIT_DURING_RESUME,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
diff --git i/include/linux/cpufreq.h w/include/linux/cpufreq.h
index c86d6d8bdfed..9cf6b3ce063a 100644
--- i/include/linux/cpufreq.h
+++ w/include/linux/cpufreq.h
@@ -385,6 +385,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
 
+/*
+ * Set by drivers to advance/defer the cpufreq online/offline operation during
+ * system suspend/resume.
+ */
+#define CPUFREQ_DEFER_INIT_DURING_RESUME (1 << 7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
