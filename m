From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/6][Resend] cpufreq: acpi-cpufreq: Make read and write operations more efficient
Date: Wed, 02 Mar 2016 03:05:22 +0100
Message-ID: <4120468.r1MzG4y28k@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2495375.dFbdlAZmA6@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Setting a new CPU frequency and reading the current request value
in the ACPI cpufreq driver involves each at least two switch
instructions (there's more if the policy is shared).  One of
them is present in drv_read/write() that prepares a command
structure and the other happens in subsequent do_drv_read/write()
when that structure is interpreted.  However, all of those switches
may be avoided by using function pointers.

To that end, add two function pointers to struct acpi_cpufreq_data
to represent read and write operations on the frequency register
and set them up during policy intitialization to point to the pair
of routines suitable for the given processor (Intel/AMD MSR access
or I/O port access).  Then, use those pointers in do_drv_read/write()
and modify drv_read/write() to prepare the command structure for
them without any checks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |  208 ++++++++++++++++++-----------------------
 1 file changed, 95 insertions(+), 113 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -70,6 +70,8 @@ struct acpi_cpufreq_data {
 	unsigned int cpu_feature;
 	unsigned int acpi_perf_cpu;
 	cpumask_var_t freqdomain_cpus;
+	void (*cpu_freq_write)(struct acpi_pct_register *reg, u32 val);
+	u32 (*cpu_freq_read)(struct acpi_pct_register *reg);
 };
 
 /* acpi_perf_data is a pointer to percpu data. */
@@ -243,125 +245,119 @@ static unsigned extract_freq(u32 val, st
 	}
 }
 
-struct msr_addr {
-	u32 reg;
-};
+u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
+{
+	u32 val, dummy;
 
-struct io_addr {
-	u16 port;
-	u8 bit_width;
-};
+	rdmsr(MSR_IA32_PERF_CTL, val, dummy);
+	return val;
+}
+
+void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
+{
+	u32 lo, hi;
+
+	rdmsr(MSR_IA32_PERF_CTL, lo, hi);
+	lo = (lo & ~INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);
+	wrmsr(MSR_IA32_PERF_CTL, lo, hi);
+}
+
+u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
+{
+	u32 val, dummy;
+
+	rdmsr(MSR_AMD_PERF_CTL, val, dummy);
+	return val;
+}
+
+void cpu_freq_write_amd(struct acpi_pct_register *not_used, u32 val)
+{
+	wrmsr(MSR_AMD_PERF_CTL, val, 0);
+}
+
+u32 cpu_freq_read_io(struct acpi_pct_register *reg)
+{
+	u32 val;
+
+	acpi_os_read_port(reg->address, &val, reg->bit_width);
+	return val;
+}
+
+void cpu_freq_write_io(struct acpi_pct_register *reg, u32 val)
+{
+	acpi_os_write_port(reg->address, val, reg->bit_width);
+}
 
 struct drv_cmd {
-	unsigned int type;
-	const struct cpumask *mask;
-	union {
-		struct msr_addr msr;
-		struct io_addr io;
-	} addr;
+	struct acpi_pct_register *reg;
 	u32 val;
+	union {
+		void (*write)(struct acpi_pct_register *reg, u32 val);
+		u32 (*read)(struct acpi_pct_register *reg);
+	} func;
 };
 
 /* Called via smp_call_function_single(), on the target CPU */
 static void do_drv_read(void *_cmd)
 {
 	struct drv_cmd *cmd = _cmd;
-	u32 h;
 
-	switch (cmd->type) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-	case SYSTEM_AMD_MSR_CAPABLE:
-		rdmsr(cmd->addr.msr.reg, cmd->val, h);
-		break;
-	case SYSTEM_IO_CAPABLE:
-		acpi_os_read_port((acpi_io_address)cmd->addr.io.port,
-				&cmd->val,
-				(u32)cmd->addr.io.bit_width);
-		break;
-	default:
-		break;
-	}
+	cmd->val = cmd->func.read(cmd->reg);
 }
 
-/* Called via smp_call_function_many(), on the target CPUs */
-static void do_drv_write(void *_cmd)
+static u32 drv_read(struct acpi_cpufreq_data *data, const struct cpumask *mask)
 {
-	struct drv_cmd *cmd = _cmd;
-	u32 lo, hi;
+	struct acpi_processor_performance *perf = to_perf_data(data);
+	struct drv_cmd cmd = {
+		.reg = &perf->control_register,
+		.func.read = data->cpu_freq_read,
+	};
+	int err;
 
-	switch (cmd->type) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-		rdmsr(cmd->addr.msr.reg, lo, hi);
-		lo = (lo & ~INTEL_MSR_RANGE) | (cmd->val & INTEL_MSR_RANGE);
-		wrmsr(cmd->addr.msr.reg, lo, hi);
-		break;
-	case SYSTEM_AMD_MSR_CAPABLE:
-		wrmsr(cmd->addr.msr.reg, cmd->val, 0);
-		break;
-	case SYSTEM_IO_CAPABLE:
-		acpi_os_write_port((acpi_io_address)cmd->addr.io.port,
-				cmd->val,
-				(u32)cmd->addr.io.bit_width);
-		break;
-	default:
-		break;
-	}
+	err = smp_call_function_any(mask, do_drv_read, &cmd, 1);
+	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
+	return cmd.val;
 }
 
-static void drv_read(struct drv_cmd *cmd)
+/* Called via smp_call_function_many(), on the target CPUs */
+static void do_drv_write(void *_cmd)
 {
-	int err;
-	cmd->val = 0;
+	struct drv_cmd *cmd = _cmd;
 
-	err = smp_call_function_any(cmd->mask, do_drv_read, cmd, 1);
-	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
+	cmd->func.write(cmd->reg, cmd->val);
 }
 
-static void drv_write(struct drv_cmd *cmd)
+static void drv_write(struct acpi_cpufreq_data *data,
+		      const struct cpumask *mask, u32 val)
 {
+	struct acpi_processor_performance *perf = to_perf_data(data);
+	struct drv_cmd cmd = {
+		.reg = &perf->control_register,
+		.val = val,
+		.func.write = data->cpu_freq_write,
+	};
 	int this_cpu;
 
 	this_cpu = get_cpu();
-	if (cpumask_test_cpu(this_cpu, cmd->mask))
-		do_drv_write(cmd);
-	smp_call_function_many(cmd->mask, do_drv_write, cmd, 1);
+	if (cpumask_test_cpu(this_cpu, mask))
+		do_drv_write(&cmd);
+
+	smp_call_function_many(mask, do_drv_write, &cmd, 1);
 	put_cpu();
 }
 
-static u32
-get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *data)
+static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *data)
 {
-	struct acpi_processor_performance *perf;
-	struct drv_cmd cmd;
+	u32 val;
 
 	if (unlikely(cpumask_empty(mask)))
 		return 0;
 
-	switch (data->cpu_feature) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-		cmd.type = SYSTEM_INTEL_MSR_CAPABLE;
-		cmd.addr.msr.reg = MSR_IA32_PERF_CTL;
-		break;
-	case SYSTEM_AMD_MSR_CAPABLE:
-		cmd.type = SYSTEM_AMD_MSR_CAPABLE;
-		cmd.addr.msr.reg = MSR_AMD_PERF_CTL;
-		break;
-	case SYSTEM_IO_CAPABLE:
-		cmd.type = SYSTEM_IO_CAPABLE;
-		perf = to_perf_data(data);
-		cmd.addr.io.port = perf->control_register.address;
-		cmd.addr.io.bit_width = perf->control_register.bit_width;
-		break;
-	default:
-		return 0;
-	}
-
-	cmd.mask = mask;
-	drv_read(&cmd);
+	val = drv_read(data, mask);
 
-	pr_debug("get_cur_val = %u\n", cmd.val);
+	pr_debug("get_cur_val = %u\n", val);
 
-	return cmd.val;
+	return val;
 }
 
 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
@@ -416,7 +412,7 @@ static int acpi_cpufreq_target(struct cp
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
-	struct drv_cmd cmd;
+	const struct cpumask *mask;
 	unsigned int next_perf_state = 0; /* Index into perf table */
 	int result = 0;
 
@@ -438,37 +434,17 @@ static int acpi_cpufreq_target(struct cp
 		}
 	}
 
-	switch (data->cpu_feature) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-		cmd.type = SYSTEM_INTEL_MSR_CAPABLE;
-		cmd.addr.msr.reg = MSR_IA32_PERF_CTL;
-		cmd.val = (u32) perf->states[next_perf_state].control;
-		break;
-	case SYSTEM_AMD_MSR_CAPABLE:
-		cmd.type = SYSTEM_AMD_MSR_CAPABLE;
-		cmd.addr.msr.reg = MSR_AMD_PERF_CTL;
-		cmd.val = (u32) perf->states[next_perf_state].control;
-		break;
-	case SYSTEM_IO_CAPABLE:
-		cmd.type = SYSTEM_IO_CAPABLE;
-		cmd.addr.io.port = perf->control_register.address;
-		cmd.addr.io.bit_width = perf->control_register.bit_width;
-		cmd.val = (u32) perf->states[next_perf_state].control;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	/* cpufreq holds the hotplug lock, so we are safe from here on */
-	if (policy->shared_type != CPUFREQ_SHARED_TYPE_ANY)
-		cmd.mask = policy->cpus;
-	else
-		cmd.mask = cpumask_of(policy->cpu);
+	/*
+	 * The core won't allow CPUs to go away until the governor has been
+	 * stopped, so we can rely on the stability of policy->cpus.
+	 */
+	mask = policy->shared_type == CPUFREQ_SHARED_TYPE_ANY ?
+		cpumask_of(policy->cpu) : policy->cpus;
 
-	drv_write(&cmd);
+	drv_write(data, mask, perf->states[next_perf_state].control);
 
 	if (acpi_pstate_strict) {
-		if (!check_freqs(cmd.mask, data->freq_table[index].frequency,
+		if (!check_freqs(mask, data->freq_table[index].frequency,
 					data)) {
 			pr_debug("acpi_cpufreq_target failed (%d)\n",
 				policy->cpu);
@@ -738,15 +714,21 @@ static int acpi_cpufreq_cpu_init(struct
 		}
 		pr_debug("SYSTEM IO addr space\n");
 		data->cpu_feature = SYSTEM_IO_CAPABLE;
+		data->cpu_freq_read = cpu_freq_read_io;
+		data->cpu_freq_write = cpu_freq_write_io;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		pr_debug("HARDWARE addr space\n");
 		if (check_est_cpu(cpu)) {
 			data->cpu_feature = SYSTEM_INTEL_MSR_CAPABLE;
+			data->cpu_freq_read = cpu_freq_read_intel;
+			data->cpu_freq_write = cpu_freq_write_intel;
 			break;
 		}
 		if (check_amd_hwpstate_cpu(cpu)) {
 			data->cpu_feature = SYSTEM_AMD_MSR_CAPABLE;
+			data->cpu_freq_read = cpu_freq_read_amd;
+			data->cpu_freq_write = cpu_freq_write_amd;
 			break;
 		}
 		result = -ENODEV;

