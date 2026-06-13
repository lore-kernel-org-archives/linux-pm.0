Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBD3A6B8D;
	Sat, 13 Jun 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388438; cv=none; b=VdqQepmltJEPeuLxVJS/uFcl7L4y8EW6z69QTaS92jzTqZeNSdzj1TQeAVSOVdWu9+JbUWTFbaytGXCpm6pJvP0iJokqale2osvA/DoBa4dpeLBwu+htsVpwPG43QWJ57UDHKDpWCugt0ZldBDHCgwp9rhTAW7Gx+7eM4LvELLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388438; c=relaxed/simple;
	bh=yWQtVbLQ4z6IGYPknN2S7wqXHWU3vjwKYqAZYpXVc70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSNNMsQDtB5Gc/kDZoipYnwSXN7wLx1AbXi7u5tTvaTnFwyfD9xNSlObA7RXTEccQbYtaRvW/wqRKhxDDqZrpw5udh75biVgqqE0AfB5iz4EgkCrxe6jPLqTe2gv3mGuQqAay+CCLs1JJoTZxFqjl7OrFh91ufOo0MuzrxYj86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYoy3m5K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYoy3m5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388436; x=1812924436;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yWQtVbLQ4z6IGYPknN2S7wqXHWU3vjwKYqAZYpXVc70=;
  b=BYoy3m5K9rRaRvKO3fz3aiS0bcf6YsO7nkL4p2Fq7JQjAfkWjtiKCZRR
   q4bQjMmetSDszNIgLe5XjAhEPUdGncAyYLd53PJcE/6xWwkl5UaUNi/sA
   qXWauIIXDOpCw/LaBK3TJC8zvAoBHdXanSFzLfVD3WToIVv5FMSz8PBYh
   8hffpXyRD5VJtG6fcd/xwYBQ1xgrglNJkX2eaIAXsEtmjbxPJ73Vn9rDv
   LTMp3wtw5aby5daiZZbXjp5VPM2/AVhrQjdhvuVIEQQtxqMJVnNZxvvOR
   kH4NDTvAl9Gd2Pc9G7NEXpYtrbo1Z6XwYWrKJuaS1QXXWDUvyxNvQ+hyP
   g==;
X-CSE-ConnectionGUID: CSUQozw1QFqCFfUSzxYg0Q==
X-CSE-MsgGUID: OGA9gz3lQE6+YITQl2lKnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029424"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029424"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: gX9a/0qGRoOcq5Of7QyadQ==
X-CSE-MsgGUID: D66aBxKFTymKeXUJjKP9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221857"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 13 Jun 2026 15:17:50 -0700
Subject: [PATCH v3 4/6] thermal: intel: Enable the Directed Package-level
 Thermal Interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-rneri-directed-therm-intr-v3-4-3a26d1e47fc8@linux.intel.com>
References: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
In-Reply-To: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=10880;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=yWQtVbLQ4z6IGYPknN2S7wqXHWU3vjwKYqAZYpXVc70=;
 b=lowzoxFNPoq6Pc2U/X1ug8n3u4AsBL+ziLD1N3bP8R3XgGd9HhHm+rSOj6l0vFdl+CbAVL5vQ
 E3H4K3VshBIBXue4vkBBre6Rob437w5wZO/h0FnZGF2d0z1H2W9wBJ2
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Package-level thermal interrupts are broadcast to all online CPUs within a
package, even though only one CPU needs to service them. This results in
unnecessary wakeups, lock contention, and corresponding performance and
power-efficiency penalties.

When supported by hardware, a CPU requests to receive directed package-
level thermal interrupts by setting a designated bit in
IA32_THERM_INTERRUPT. The operating system must then verify that hardware
has acknowledged this request by checking a designated bit in
IA32_PACKAGE_THERM_STATUS.

Enable directed package-level thermal interrupts on one CPU per package
using the CPU hotplug infrastructure. The first CPU of a package that
comes online will handle the interrupt. If the handling CPU goes offline,
select a new CPU. Temporarily enable directed interrupts on both the
current and new CPU until hardware acknowledges the new selection, then
disable them on the outgoing CPU.

Systems without directed-interrupt support continue to broadcast the
package-level interrupt to all CPUs.

Also, add a rollback mechanism in the CPU hotplug online callback to
fall back to broadcast mode if the directed-interrupt acknowledgment fails
in any package. This is most important during boot, when all CPUs in a
package come online and would otherwise keep retrying on faulty hardware.
A complete rollback is not needed in the CPU hotplug offline callback since
at that point the hardware is known to work.

While here, update an inline comment to point to the correct volume of the
Intel Software Developer's Manual.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
When enabling the interrupt, the kernel may wait up to 15ms for hardware to
acknowledge the directed thermal interrupt. In practice, hardware takes
much less time.

The table below shows latency measurements obtained from 10,000 cycles of
CPU offline/online operations that resulted in the redirection of the
package-level thermal interrupt.

 Percentile          latency (ms)
  50th (median)        0.441
  90th                 0.744
  99th                 1.174
  99.9th               2.152

It usually takes less than 1ms and ~2ms in unusually long cases.

Methodology:
The value of the TSC counter is read just after redirecting the interrupt
(i.e., writing to MSR_IA32_THERM_INTERRUPT) and again after hardware
acknowledges the redirection (i.e., when the expected bit in
MSR_IA32_PACKAGE_THERM_STATUS changes). The delta is converted to
milliseconds.
---
Changes in v3:
 * This patch became too big. Split into two: the preceding patch
   handles the init and cleanup code paths. This patch now focuses on
   CPU hotplug.
 * Fixed a potential deadlock when calling kfree() with local interrupts
   disabled in CONFIG_PREEMPT_RT. (Sashiko)
 * Updated enable_directed_thermal_pkg_intr() to return an error for
   callers to handle.
 * Renamed disable_all_directed_thermal_pkg_intr() =>
   disable_directed_thermal_pkg_intr_all().

Changes in v2:
 * Used updated names of the Directed Package Thermal Interrupt CPUID
   and MSR bits.
 * Removed the unused argument from directed_thermal_pkg_intr_supported().
 * Redesigned the rollback mechanism to handle all packages, not only
   the boot package.
 * Fixed the handling of the return value of cpumask_any_but(), which on
   failure returns small_cpumask_bits, not nr_cpu_ids.
 * Added measurements of the latency of setup acknowledgment from
   hardware.
 * Updated comment to point to the correct volume of the Intel SDM.
---
 drivers/thermal/intel/therm_throt.c | 179 +++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 8e259c4e5fe8..2a55e3b05980 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
+#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/smp.h>
@@ -244,16 +245,23 @@ static void thermal_intr_init_pkg_clear_mask(void)
 	 * IA32_PACKAGE_THERM_STATUS.
 	 */
 
-	/* All bits except BIT 26 depend on CPUID.06H: EAX[6] = 1 */
+	/* All bits except BITs 25 and 26 depend on CPUID.06H: EAX[6] = 1 */
 	if (boot_cpu_has(X86_FEATURE_PTS))
 		therm_intr_pkg_clear_mask = (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11));
 
 	/*
-	 * Intel SDM Volume 2A: Thermal and Power Management Leaf
+	 * Intel SDM Volume 1: Thermal and Power Management Leaf
 	 * Bit 26: CPUID.06H: EAX[19] = 1
 	 */
 	if (boot_cpu_has(X86_FEATURE_HFI))
 		therm_intr_pkg_clear_mask |= BIT(26);
+
+	/*
+	 * Intel SDM Volume 1: Thermal and Power Management Leaf
+	 * Bit 25: CPUID.06H: EAX[24] = 1
+	 */
+	if (boot_cpu_has(X86_FEATURE_DPTI))
+		therm_intr_pkg_clear_mask |= BIT(25);
 }
 
 /*
@@ -524,6 +532,44 @@ static void thermal_throttle_remove_dev(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
 }
 
+static int check_directed_thermal_pkg_intr_ack(void)
+{
+	unsigned int count = 15000;
+	u64 msr_val;
+
+	/*
+	 * Hardware acknowledges the directed interrupt setup in 10ms or less.
+	 * Wait 15ms to be safe.
+	 */
+	do {
+		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		udelay(1);
+	} while (!(msr_val & PACKAGE_THERM_STATUS_DPTI_ACK) && --count);
+
+	if (!count)
+		return -ETIMEDOUT;
+
+	thermal_clear_package_intr_status(PACKAGE_LEVEL,
+					  PACKAGE_THERM_STATUS_DPTI_ACK);
+
+	return 0;
+}
+
+static void config_directed_thermal_pkg_intr(void *info)
+{
+	bool enable = *((bool *)info);
+	u64 msr_val;
+
+	rdmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
+
+	if (enable)
+		msr_val |= THERM_INT_DPTI_ENABLE;
+	else
+		msr_val &= ~THERM_INT_DPTI_ENABLE;
+
+	wrmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
+}
+
 /*
  * Accessed from CPU hotplug callbacks and from code that runs while CPU
  * hotplug is inactive: the init and cleanup paths.
@@ -542,6 +588,127 @@ static bool directed_thermal_pkg_intr_supported(void)
 	return true;
 }
 
+/*
+ * Must be called with cpu_hotplug_lock held to prevent CPUs from going offline
+ * while iterating through packages and interrupts must be enabled to avoid
+ * deadlocks in SMP function calls.
+ */
+static void disable_directed_thermal_pkg_intr_all(void)
+{
+	bool enable = false;
+	int i;
+
+	if (!directed_thermal_pkg_intr_supported())
+		return;
+
+	for (i = 0; i < topology_max_packages(); i++) {
+		if (directed_intr_handler_cpus[i] == nr_cpu_ids)
+			continue;
+
+		smp_call_function_single(directed_intr_handler_cpus[i],
+					 config_directed_thermal_pkg_intr,
+					 &enable, true);
+	}
+}
+
+static int enable_directed_thermal_pkg_intr(unsigned int cpu)
+{
+	bool enable = true;
+	u16 pkg_id;
+
+	if (!directed_thermal_pkg_intr_supported())
+		return 0;
+
+	pkg_id = topology_logical_package_id(cpu);
+	if (pkg_id >= topology_max_packages())
+		return -EINVAL;
+
+	/* Another CPU in this package already handles the directed interrupt. */
+	if (directed_intr_handler_cpus[pkg_id] != nr_cpu_ids)
+		return 0;
+
+	thermal_clear_package_intr_status(PACKAGE_LEVEL,
+					  PACKAGE_THERM_STATUS_DPTI_ACK);
+
+	config_directed_thermal_pkg_intr(&enable);
+	if (!check_directed_thermal_pkg_intr_ack()) {
+		directed_intr_handler_cpus[pkg_id] = cpu;
+		return 0;
+	}
+
+	/*
+	 * A failure indicates faulty hardware. Roll back completely so that
+	 * no other CPU tries. This is especially important during boot as all
+	 * CPUs may come online and would otherwise keep trying.
+	 */
+	enable = false;
+	config_directed_thermal_pkg_intr(&enable);
+
+	return -ETIMEDOUT;
+}
+
+static void disable_directed_thermal_pkg_intr(unsigned int cpu)
+{
+	unsigned int new_cpu;
+	bool enable;
+	u16 pkg_id;
+
+	if (!directed_thermal_pkg_intr_supported())
+		return;
+
+	pkg_id = topology_logical_package_id(cpu);
+	if (pkg_id >= topology_max_packages())
+		return;
+
+	/* Not the CPU handling the directed interrupt. */
+	if (directed_intr_handler_cpus[pkg_id] != cpu)
+		return;
+
+	/*
+	 * The package-level interrupt must remain directed after this CPU goes
+	 * offline.
+	 */
+	new_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	if (new_cpu < nr_cpu_ids) {
+		enable = true;
+		thermal_clear_package_intr_status(PACKAGE_LEVEL,
+						  PACKAGE_THERM_STATUS_DPTI_ACK);
+
+		/*
+		 * We are here via CPU hotplug. Since we are holding the
+		 * cpu_hotplug_lock, @new_cpu cannot go offline and interrupts
+		 * are enabled, so the SMP function call is safe.
+		 */
+		smp_call_function_single(new_cpu, config_directed_thermal_pkg_intr,
+					 &enable, true);
+	}
+
+	/*
+	 * If hardware does not acknowledge the directed interrupt setup on
+	 * @new_cpu, disable the redirection. Since no other CPU is configured
+	 * to receive the package-level interrupt, all CPUs in the package will
+	 * receive it.
+	 */
+	enable = false;
+	if (new_cpu < nr_cpu_ids && check_directed_thermal_pkg_intr_ack()) {
+		smp_call_function_single(new_cpu, config_directed_thermal_pkg_intr,
+					 &enable, true);
+
+		pr_warn_once("Failed to redirect package thermal interrupt from CPU%u to CPU%u; reverting to broadcast.\n",
+			     cpu, new_cpu);
+
+		new_cpu = nr_cpu_ids;
+	}
+
+	/*
+	 * Clear the directed interrupt on @cpu. Hardware acknowledgment can be
+	 * ignored since @cpu is going offline.
+	 */
+	config_directed_thermal_pkg_intr(&enable);
+
+	directed_intr_handler_cpus[pkg_id] = (new_cpu < nr_cpu_ids) ? new_cpu : nr_cpu_ids;
+}
+
 static __init void init_directed_pkg_intr(void)
 {
 	int i;
@@ -564,6 +731,7 @@ static void cleanup_directed_pkg_thermal_intr(void)
 	if (!directed_thermal_pkg_intr_supported())
 		return;
 
+	disable_directed_thermal_pkg_intr_all();
 	kfree(directed_intr_handler_cpus);
 	directed_intr_handler_cpus = NULL;
 }
@@ -593,6 +761,11 @@ static int thermal_throttle_online(unsigned int cpu)
 	 */
 	intel_hfi_online(cpu);
 
+	if (enable_directed_thermal_pkg_intr(cpu)) {
+		pr_info_once("Failed to direct package thermal interrupts. All CPUs will receive it.\n");
+		cleanup_directed_pkg_thermal_intr();
+	}
+
 	/* Unmask the thermal vector after the above workqueues are initialized. */
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
@@ -610,6 +783,8 @@ static int thermal_throttle_offline(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
 
+	disable_directed_thermal_pkg_intr(cpu);
+
 	intel_hfi_offline(cpu);
 
 	cancel_delayed_work_sync(&state->package_throttle.therm_work);

-- 
2.43.0

