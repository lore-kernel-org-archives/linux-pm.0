From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/13] cpufreq/ia64: Replace racy task affinity logic
Date: Wed, 12 Apr 2017 22:07:35 +0200
Message-ID: <20170412201042.865458445@linutronix.de>
References: <20170412200726.941336635@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=cpufreq-ia64--Use-work_on_cpu--.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The get() and target() callbacks must run on the affected cpu. This is
achieved by temporarily setting the affinity of the calling thread to the
requested CPU and reset it to the original affinity afterwards.

That's racy vs. concurrent affinity settings for that thread resulting in
code executing on the wrong CPU and overwriting the new affinity setting.

Replace it by work_on_cpu(). All call pathes which invoke the callbacks are
already protected against CPU hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/ia64-acpi-cpufreq.c |   91 +++++++++++++++---------------------
 1 file changed, 38 insertions(+), 53 deletions(-)

--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -34,6 +34,11 @@ struct cpufreq_acpi_io {
 	unsigned int				resume;
 };
 
+struct cpufreq_acpi_req {
+	unsigned int		cpu;
+	unsigned int		state;
+};
+
 static struct cpufreq_acpi_io	*acpi_io_data[NR_CPUS];
 
 static struct cpufreq_driver acpi_cpufreq_driver;
@@ -83,8 +88,7 @@ processor_get_pstate (
 static unsigned
 extract_clock (
 	struct cpufreq_acpi_io *data,
-	unsigned value,
-	unsigned int cpu)
+	unsigned value)
 {
 	unsigned long i;
 
@@ -98,60 +102,42 @@ extract_clock (
 }
 
 
-static unsigned int
+static long
 processor_get_freq (
-	struct cpufreq_acpi_io	*data,
-	unsigned int		cpu)
+	void *arg)
 {
-	int			ret = 0;
-	u32			value = 0;
-	cpumask_t		saved_mask;
-	unsigned long 		clock_freq;
+	struct cpufreq_acpi_req *req = arg;
+	struct cpufreq_acpi_io	*data = acpi_io_data[req->cpu];
+	u32			value;
+	int			ret;
 
 	pr_debug("processor_get_freq\n");
-
-	saved_mask = current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 	if (smp_processor_id() != cpu)
-		goto migrate_end;
+		return -EAGAIN;
 
 	/* processor_get_pstate gets the instantaneous frequency */
 	ret = processor_get_pstate(&value);
-
 	if (ret) {
-		set_cpus_allowed_ptr(current, &saved_mask);
 		pr_warn("get performance failed with error %d\n", ret);
-		ret = 0;
-		goto migrate_end;
+		return ret;
 	}
-	clock_freq = extract_clock(data, value, cpu);
-	ret = (clock_freq*1000);
-
-migrate_end:
-	set_cpus_allowed_ptr(current, &saved_mask);
-	return ret;
+	return 1000 * extract_clock(data, value);
 }
 
 
-static int
+static long
 processor_set_freq (
-	struct cpufreq_acpi_io	*data,
-	struct cpufreq_policy   *policy,
-	int			state)
+	void *arg)
 {
-	int			ret = 0;
-	u32			value = 0;
-	cpumask_t		saved_mask;
-	int			retval;
+	struct cpufreq_acpi_req *req = arg;
+	unsigned int		cpu = req->cpu;
+	struct cpufreq_acpi_io	*data = acpi_io_data[cpu];
+	int			ret, state = req->state;
+	u32			value;
 
 	pr_debug("processor_set_freq\n");
-
-	saved_mask = current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(policy->cpu));
-	if (smp_processor_id() != policy->cpu) {
-		retval = -EAGAIN;
-		goto migrate_end;
-	}
+	if (smp_processor_id() != cpu)
+		return -EAGAIN;
 
 	if (state == data->acpi_data.state) {
 		if (unlikely(data->resume)) {
@@ -159,8 +145,7 @@ processor_set_freq (
 			data->resume = 0;
 		} else {
 			pr_debug("Already at target state (P%d)\n", state);
-			retval = 0;
-			goto migrate_end;
+			return 0;
 		}
 	}
 
@@ -171,7 +156,6 @@ processor_set_freq (
 	 * First we write the target state's 'control' value to the
 	 * control_register.
 	 */
-
 	value = (u32) data->acpi_data.states[state].control;
 
 	pr_debug("Transitioning to state: 0x%08x\n", value);
@@ -179,17 +163,11 @@ processor_set_freq (
 	ret = processor_set_pstate(value);
 	if (ret) {
 		pr_warn("Transition failed with error %d\n", ret);
-		retval = -ENODEV;
-		goto migrate_end;
+		return -ENODEV;
 	}
 
 	data->acpi_data.state = state;
-
-	retval = 0;
-
-migrate_end:
-	set_cpus_allowed_ptr(current, &saved_mask);
-	return (retval);
+	return 0;
 }
 
 
@@ -197,11 +175,13 @@ static unsigned int
 acpi_cpufreq_get (
 	unsigned int		cpu)
 {
-	struct cpufreq_acpi_io *data = acpi_io_data[cpu];
+	struct cpufreq_acpi_req req;
+	long ret;
 
-	pr_debug("acpi_cpufreq_get\n");
+	req.cpu = cpu;
+	ret = work_on_cpu(cpu, processor_get_freq, &req);
 
-	return processor_get_freq(data, cpu);
+	return ret > 0 ? (unsigned int) ret : 0;
 }
 
 
@@ -210,7 +190,12 @@ acpi_cpufreq_target (
 	struct cpufreq_policy   *policy,
 	unsigned int index)
 {
-	return processor_set_freq(acpi_io_data[policy->cpu], policy, index);
+	struct cpufreq_acpi_req req;
+
+	req.cpu = policy->cpu;
+	req.state = index;
+
+	return work_on_cpu(cpu, processor_set_freq, &req);
 }
 
 static int
