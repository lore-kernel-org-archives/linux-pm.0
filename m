Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFF38E5D5;
	Mon,  9 Mar 2026 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094843; cv=none; b=XHl2VgKiuXyMCMreioKqXCkeRok5DhoHlOXVRnTpXibRUwMwOuh1vb2R+Dhdz6yGI4v8qLyqing4dR04hAFEK4Kb99zi/xS1jbcEm6tuc0S9iQGAUNJONjImw2QaRWFoVeDvi0GjtFpdHGvWuh2bCb59olfA58RW9a5iWH4DOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094843; c=relaxed/simple;
	bh=dGtxAS7nxtT0bG87r2Bb7PJl0WYrAo7+sx542XvvFpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIEheZG3gvgy4DV6mCNcJh+nT28Lvuek6zcbFwbgiGgqhiC8ziv43N4emh6NUwWYxxJ+edJf1+YT3Hl9mskjPkP6P612MxsGRMqarmE23NhCLdU11aSgh3mcVKeBCGWl4IB5CDk7PHEsOtbh3P0idXXOR+DJOJqtQMwPnHS4P34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auzjWCDg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auzjWCDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773094841; x=1804630841;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dGtxAS7nxtT0bG87r2Bb7PJl0WYrAo7+sx542XvvFpA=;
  b=auzjWCDgyuXGK7bNPcY4AlhKOwKI/aWA7yVTP7HWZwTrrWaslwO0iVUF
   e0rMKpG5o2uPXlffhkr4z8BTIkdOLeFxSP7M3ao4Ho0XdcakHE15INyjL
   /oy9jozOVJp4ZcIpEOyPpK/SQemGEITYqSOPkncN7UQpqfWmSurSnvkqb
   3drprtfuIaeZn3wuudW6YAIN8ouzxRnJond9yMY9AWOIprvUoFHdespuV
   JDvolRQuxOTwUQlkzD/91CYZ/Bm3gaYHn261Ova8JNlLlzevYFC1cUtIP
   izIHqC7fcU+9BIKXHJqx2anLOV2FQTCInhSBaO5JLchu7Z/didaVSr43p
   g==;
X-CSE-ConnectionGUID: a0Dg7BWIQzitOxNUf+KZyA==
X-CSE-MsgGUID: aREHnR2mTVKerm1z5klyQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74050655"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74050655"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:38 -0700
X-CSE-ConnectionGUID: QUj/PMltRDCCgv3Hup0zrA==
X-CSE-MsgGUID: Vw5EreVaT2anHHjL8bhZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224004289"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 09 Mar 2026 15:19:25 -0700
Subject: [PATCH 2/4] thermal: intel: Enable Directed Package-level Thermal
 Interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-rneri-directed-therm-intr-v1-2-2956e3000950@linux.intel.com>
References: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
In-Reply-To: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773094782; l=8462;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=dGtxAS7nxtT0bG87r2Bb7PJl0WYrAo7+sx542XvvFpA=;
 b=DBoNoQ6ndihlFMYo4/VyWW2Z9wCieLl8CtfIBqmybsTEtLJxf7Mip8QVfivWakNZjdq5fer+J
 iJ1w7vNbev9C3EdP0FSDGjHkldV6/rsIpOVCZWvxVU3XuKk5z+zwGZG
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Package-level thermal interrupts are broadcast to all online CPUs within a
package, even though only one CPU needs to service them. This results in
unnecessary wakeups, lock contention, and corresponding performance and
power-efficiency penalties.

When supported by hardware, a CPU requests to receive directed package-
level thermal interrupts by setting bit 25 in IA32_THERM_INTERRUPT. The
operating system must then verify that hardware has acknowledged this
request by checking bit 25 in IA32_PACKAGE_THERM_STATUS.

Enable directed package-level thermal interrupts on one CPU per package.
Use the CPU hotplug infrastructure. Keep track of the CPUs handling
package-level interrupts with an array.

If the handling CPU goes offline, select a new CPU. Temporarily enable
directed interrupts on both the current and new CPU until hardware
acknowledges the new selection, then disable them on the outgoing CPU.

Systems without directed-interrupt support retain the current behavior:
all online CPUs in a package receive the interrupt and existing handlers
manage any resulting contention. Also fall back to this behavior if the
directed-interrupt acknowledgment fails during boot.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/therm_throt.c | 178 +++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 44fa4dd15dd1..456f2ac10e0c 100644
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
@@ -244,7 +245,7 @@ static void thermal_intr_init_pkg_clear_mask(void)
 	 * IA32_PACKAGE_THERM_STATUS.
 	 */
 
-	/* All bits except BIT 26 depend on CPUID.06H: EAX[6] = 1 */
+	/* All bits except BITs 25 and 26 depend on CPUID.06H: EAX[6] = 1 */
 	if (boot_cpu_has(X86_FEATURE_PTS))
 		therm_intr_pkg_clear_mask = (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11));
 
@@ -254,6 +255,13 @@ static void thermal_intr_init_pkg_clear_mask(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_HFI))
 		therm_intr_pkg_clear_mask |= BIT(26);
+
+	/*
+	 * Intel SDM Volume 2A: Thermal and Power Management Leaf
+	 * Bit 25: CPUID.06H: EAX[24] = 1
+	 */
+	if (boot_cpu_has(X86_FEATURE_DIRECTED_PKG_THRM_INTR))
+		therm_intr_pkg_clear_mask |= BIT(25);
 }
 
 /*
@@ -524,6 +532,151 @@ static void thermal_throttle_remove_dev(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
 }
 
+static int check_directed_thermal_pkg_intr_ack(void)
+{
+	unsigned int count = 15000;
+	u64 msr_val;
+
+	/*
+	 * Hardware is known to acknowledge the setting of the directed
+	 * interrupt in 10ms or less. Wait for 15ms.
+	 */
+	do {
+		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		udelay(1);
+	} while (!(msr_val & PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK) && --count);
+
+	if (!count)
+		return -ETIMEDOUT;
+
+	thermal_clear_package_intr_status(PACKAGE_LEVEL,
+					  PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK);
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
+		msr_val |= THERM_DIRECTED_INTR_ENABLE;
+	else
+		msr_val &= ~THERM_DIRECTED_INTR_ENABLE;
+
+	wrmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
+}
+
+/* Only accessed from CPU hotplug operations. No extra locking needed. */
+static unsigned int *directed_intr_handler_cpus;
+
+static bool directed_thermal_pkg_intr_supported(unsigned int cpu)
+{
+	if (!boot_cpu_has(X86_FEATURE_DIRECTED_PKG_THRM_INTR))
+		return false;
+
+	if (!directed_intr_handler_cpus)
+		return false;
+
+	return true;
+}
+
+static void enable_directed_thermal_pkg_intr(unsigned int cpu)
+{
+	bool enable = true;
+	u16 pkg_id;
+
+	if (!directed_thermal_pkg_intr_supported(cpu))
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
+					  PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK);
+
+	config_directed_thermal_pkg_intr(&enable);
+	if (!check_directed_thermal_pkg_intr_ack()) {
+		directed_intr_handler_cpus[pkg_id] = cpu;
+		return;
+	}
+
+	/* Failed to enable the directed package interrupt. Roll back. */
+	enable = false;
+	config_directed_thermal_pkg_intr(&enable);
+
+	/*
+	 * This function is first called from the CPU0 hotplug callback during
+	 * boot. Disable the directed package interrupt. All CPUs in a package
+	 * will receive the package-level interrupt.
+	 */
+	if (cpu)
+		return;
+
+	pr_info_once("CPU0: Failed to enable directed package-level thermal interrupt\n");
+	kfree(directed_intr_handler_cpus);
+	directed_intr_handler_cpus = NULL;
+}
+
+static void disable_directed_thermal_pkg_intr(unsigned int cpu)
+{
+	unsigned int new_cpu;
+	bool enable;
+	u16 pkg_id;
+
+	if (!directed_thermal_pkg_intr_supported(cpu))
+		return;
+
+	pkg_id = topology_logical_package_id(cpu);
+	if (pkg_id >= topology_max_packages())
+		return;
+
+	/* Not the CPU handling the directed interrupt */
+	if (directed_intr_handler_cpus[pkg_id] != cpu)
+		return;
+
+	/* Redirect the interrupt to another online CPU in the package. */
+	new_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	if (new_cpu < nr_cpu_ids) {
+		enable = true;
+		thermal_clear_package_intr_status(PACKAGE_LEVEL,
+						  PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK);
+
+		smp_call_function_single(new_cpu, config_directed_thermal_pkg_intr,
+					 &enable, true);
+	}
+
+	/*
+	 * If a new CPU was found, check for acknowledgment. If hardware did not
+	 * acknowledge it, disable the redirection of the interrupt on the new CPU.
+	 * Since no other CPU is configured to receive the package-level interrupt,
+	 * all CPUs in the package will receive it.
+	 */
+	enable = false;
+	if (new_cpu < nr_cpu_ids && check_directed_thermal_pkg_intr_ack()) {
+		smp_call_function_single(new_cpu, config_directed_thermal_pkg_intr,
+					 &enable, true);
+		new_cpu = nr_cpu_ids;
+	}
+
+	/*
+	 * Disable the interrupt on this CPU. Hardware may acknowledge the
+	 * request, but we do not care in this case. We do need to clear the
+	 * ack bit when enabling the interrupt in another CPU.
+	 */
+	config_directed_thermal_pkg_intr(&enable);
+
+	directed_intr_handler_cpus[pkg_id] = new_cpu;
+}
+
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int thermal_throttle_online(unsigned int cpu)
 {
@@ -548,6 +701,8 @@ static int thermal_throttle_online(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 
+	enable_directed_thermal_pkg_intr(cpu);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -557,6 +712,8 @@ static int thermal_throttle_offline(unsigned int cpu)
 	struct device *dev = get_cpu_device(cpu);
 	u32 l;
 
+	disable_directed_thermal_pkg_intr(cpu);
+
 	/* Mask the thermal vector before draining evtl. pending work */
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
@@ -573,6 +730,23 @@ static int thermal_throttle_offline(unsigned int cpu)
 	return 0;
 }
 
+static __init void init_directed_pkg_intr(void)
+{
+	int i;
+
+	if (!boot_cpu_has(X86_FEATURE_DIRECTED_PKG_THRM_INTR))
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
@@ -580,6 +754,8 @@ static __init int thermal_throttle_init_device(void)
 	if (!atomic_read(&therm_throt_en))
 		return 0;
 
+	init_directed_pkg_intr();
+
 	intel_hfi_init();
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/therm:online",

-- 
2.43.0

