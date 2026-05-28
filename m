Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4544CF4E;
	Thu, 28 May 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981311; cv=none; b=AynWe/jLTzVc+NkqHcy0HyH5HjMBL5bUvT+5TbZqkrGgfce3jpEeaK9wmswnI2Im0GQWSseZ42oivjOTyIhjIj72eUcsDLz78lIzUkR4swtqNXMjTwHWG+1Xumt7P379LdITRZIQ701pBzg219ESC/iqQGe4uxRwJWQXcGnCZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981311; c=relaxed/simple;
	bh=6T9MJHzw5RPUOZth29LWxorosegt11SaYrXukZrBVI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLPfl2w2ayrxyPXZNyYNQN4hwqwZJKKfmEpn5alTtbYG/NyWEmo2jdVdH9ILdDwz8t4ZRrRVbscnoEfvSyGQStCkyfEtmqo1f7bDN7tNJPDWWgiEHz/inhuBh7uEoeFYuHDNm2WKEI6hlofa/IZqiMpy4CWWvrmQf9GWh+yy3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0RwG1rP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0RwG1rP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779981309; x=1811517309;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6T9MJHzw5RPUOZth29LWxorosegt11SaYrXukZrBVI8=;
  b=O0RwG1rPk3eoMF/zDxTG/A/PE94r4nUQUVRh1ivZdv7kx8+kIB7rv+5y
   elXZmBY+C4oNfTGktQw5FzqHJ1Y6SAOFVI5hLMDNpjssVjIblSPGJ869U
   hIp57pKc5Izun//YpiHqjn0elKmFZqQmwMJK8GT0YBUQ8OJZsBzrlisSr
   I6Q9cg2gYuWmAzh3ow9Mzns5IZqyVXPapiQ6SeEgW6Y+C1YqbSaqPm5Ff
   oGetNLYpyfIkFeS1R8CcB4vwFVdkV7Dmc71XaDOv87Ul5X4ccHAtjp2we
   eH5AzTy1RdysMMCtnd6m6EmvuEvGPqxV+y2VuTUhS85uq7uof1XSAJpwq
   g==;
X-CSE-ConnectionGUID: Wp/j6N0dQQefG4gx387B7Q==
X-CSE-MsgGUID: tZsBGbLhSiySqwFdLGOZ5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80887344"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80887344"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:07 -0700
X-CSE-ConnectionGUID: KRE1T4CmQhyG6P0f62RdOQ==
X-CSE-MsgGUID: AT/tbURESlyEkNozYtGoEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241536828"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:07 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 28 May 2026 08:25:44 -0700
Subject: [PATCH v2 3/5] thermal: intel: Enable the Directed Package-level
 Thermal Interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rneri-directed-therm-intr-v2-3-8e2f9e0c1a36@linux.intel.com>
References: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
In-Reply-To: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779981967; l=11426;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=6T9MJHzw5RPUOZth29LWxorosegt11SaYrXukZrBVI8=;
 b=ZCeY4dfTMFW8ydhZftwXaFr5ybr79yLsIi2H/pebcKD3PuHSQGwHdmfuvFD8PxE/JLLV0fUvE
 9P+8XGDL8NeCr5GBLQ/sDTlNg1OK2G9aqfUJR7N7Z/g1zEEVIBhMIwr
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
using the CPU hotplug infrastructure. Keep track of the CPUs handling
package-level interrupts with an array.

If the handling CPU goes offline, select a new CPU. Temporarily enable
directed interrupts on both the current and new CPU until hardware
acknowledges the new selection, then disable them on the outgoing CPU.

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
 drivers/thermal/intel/therm_throt.c | 220 +++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 45a8ef4a608b..dcb5d7051ac6 100644
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
@@ -524,6 +532,184 @@ static void thermal_throttle_remove_dev(struct device *dev)
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
+/* Only accessed from CPU hotplug callbacks. No extra locking needed. */
+static unsigned int *directed_intr_handler_cpus;
+
+static bool directed_thermal_pkg_intr_supported(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_DPTI))
+		return false;
+
+	if (!directed_intr_handler_cpus)
+		return false;
+
+	return true;
+}
+
+/*
+ * Must be called with cpu_hotplug_lock held to prevent CPUs from going offline
+ * while iterating through packages. Also, interrupts must be enabled to avoid
+ * deadlocks in SMP function calls.
+ */
+static void disable_all_directed_thermal_pkg_intr(void)
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
+
+	kfree(directed_intr_handler_cpus);
+	directed_intr_handler_cpus = NULL;
+}
+
+static void enable_directed_thermal_pkg_intr(unsigned int cpu)
+{
+	bool enable = true;
+	u16 pkg_id;
+
+	if (!directed_thermal_pkg_intr_supported())
+		return;
+
+	pkg_id = topology_logical_package_id(cpu);
+	if (pkg_id >= topology_max_packages())
+		return;
+
+	/* Another CPU in this package already handles the directed interrupt. */
+	if (directed_intr_handler_cpus[pkg_id] != nr_cpu_ids)
+		return;
+
+	thermal_clear_package_intr_status(PACKAGE_LEVEL,
+					  PACKAGE_THERM_STATUS_DPTI_ACK);
+
+	config_directed_thermal_pkg_intr(&enable);
+	if (!check_directed_thermal_pkg_intr_ack()) {
+		directed_intr_handler_cpus[pkg_id] = cpu;
+		return;
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
+	disable_all_directed_thermal_pkg_intr();
+
+	pr_info_once("Failed to direct package thermal interrupts. All CPUs will receive it.\n");
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
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int thermal_throttle_online(unsigned int cpu)
 {
@@ -549,6 +735,8 @@ static int thermal_throttle_online(unsigned int cpu)
 	 */
 	intel_hfi_online(cpu);
 
+	enable_directed_thermal_pkg_intr(cpu);
+
 	/* Unmask the thermal vector after the above workqueues are initialized. */
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
@@ -566,6 +754,8 @@ static int thermal_throttle_offline(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
 
+	disable_directed_thermal_pkg_intr(cpu);
+
 	intel_hfi_offline(cpu);
 
 	cancel_delayed_work_sync(&state->package_throttle.therm_work);
@@ -578,6 +768,23 @@ static int thermal_throttle_offline(unsigned int cpu)
 	return 0;
 }
 
+static __init void init_directed_pkg_intr(void)
+{
+	int i;
+
+	if (!boot_cpu_has(X86_FEATURE_DPTI))
+		return;
+
+	directed_intr_handler_cpus = kmalloc_array(topology_max_packages(),
+						   sizeof(*directed_intr_handler_cpus),
+						   GFP_KERNEL);
+	if (!directed_intr_handler_cpus)
+		return;
+
+	for (i = 0; i < topology_max_packages(); i++)
+		directed_intr_handler_cpus[i] = nr_cpu_ids;
+}
+
 static __init int thermal_throttle_init_device(void)
 {
 	int ret;
@@ -585,12 +792,19 @@ static __init int thermal_throttle_init_device(void)
 	if (!atomic_read(&therm_throt_en))
 		return 0;
 
+	init_directed_pkg_intr();
+
 	intel_hfi_init();
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/therm:online",
 				thermal_throttle_online,
 				thermal_throttle_offline);
-	return ret < 0 ? ret : 0;
+	if (ret >= 0)
+		return 0;
+
+	disable_all_directed_thermal_pkg_intr();
+
+	return ret;
 }
 device_initcall(thermal_throttle_init_device);
 

-- 
2.43.0

