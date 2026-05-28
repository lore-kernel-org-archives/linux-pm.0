Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39644D00A;
	Thu, 28 May 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981311; cv=none; b=UWNrN9ZUC/MNKe3shNZZpGUrIwKBTFKWeI1b1fFPIx1KFfJ/SHZVn3/gIphGYqMCbM7XiF9mBuSK4OHqAUiLupY0aD07yAjXMPwJI3uAX+kqS4k1hb0OXvMPOOyE4r/4TDpMgEUpHDfHdankbMHTsiYnOegaWOht6mKnDiMCIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981311; c=relaxed/simple;
	bh=USf6uG0GV/cK6H/yT32++OcuH1Ae5cD2yFuzoC+dViw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlB4vnQVloQW6fT0/7pHzp/vYCus1TNcY7yvv8GsN9U+zDHclLP2nvSuMH2rpUcP9YSkrPtjh0FV5S7j77JUBInjlOk04g1ScGUzdbujn4ajW5NNd50/SOEWyKWXcF9tnCQ5abLdm/0XVUFwM/q+tvZJuc8Y+wtVOSDWh2zEjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7b5Em1y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7b5Em1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779981311; x=1811517311;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=USf6uG0GV/cK6H/yT32++OcuH1Ae5cD2yFuzoC+dViw=;
  b=l7b5Em1ynj5aMJs4X5HRZJWMloJ9XUit9QQb/ATXR9Uaasu7QWI90EO8
   DWM4vFXK/OHGfPZNfOoqzz5Cx+jfNUxDiWkmpeYnmZREqYTdZXzvjs3kX
   DhARWucuaByX6QzD0eePFapnRvNS+1fk1WOJpXtToRnw5pkeT0SuFvV3A
   XDsK9gDhQ1h6XvNWw58QktHfpXuaLFyU3Xe+KdEHZkA10LRp+Nk8wx5mn
   9sBVeyfrRz7fz6AZ8UU1xA/m7h5I1tLcWNiHH601hb4DxqhgCK7vSnrey
   jNHYcc26nC613D7E8TV0zuZTl2SGd159xRQNfs47GKUY8m2AbgFD6HfVk
   Q==;
X-CSE-ConnectionGUID: uR5xgwVaRpWkp7gf6tgmEQ==
X-CSE-MsgGUID: OSiIX0N+RSiMfwU6jwreoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80887347"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80887347"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:08 -0700
X-CSE-ConnectionGUID: Ncufrco/Rki1bMk+n+9M0g==
X-CSE-MsgGUID: xq0N802zQ3aEDZNUGy4oqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241536839"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:07 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 28 May 2026 08:25:45 -0700
Subject: [PATCH v2 4/5] thermal: intel: Add syscore callbacks for suspend
 and resume
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rneri-directed-therm-intr-v2-4-8e2f9e0c1a36@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779981967; l=4845;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=USf6uG0GV/cK6H/yT32++OcuH1Ae5cD2yFuzoC+dViw=;
 b=aO27WoAOHgfoYaVJEA4E62mtTTjtgjPeA6+Mmfx0FkfAEox3F0DvgoHFmhIaYzfALOx0NLrkC
 Cp9O6ybJKPuBLvBguAWGVlA5j6ehSlNXzApIX7m5XxxuRt3Bu1sRS9y
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Directed package-level thermal interrupts are serviced by a single CPU per
package. These handler CPUs are selected at boot through the CPU hotplug
infrastructure. This mechanism is sufficient to restore the directed
interrupt configuration when resuming from suspend for non-boot packages.
It also keeps the handler-tracking array updated.

For the boot package, CPU0 is chosen during boot because its CPU hotplug
online callback runs first. However, this callback is not invoked on
resume. The directed package-level interrupt configuration for the boot
package is not restored. Add a syscore resume callback to re-enable
directed package-level interrupts for this package.

Disabling directed interrupts during suspend is required to keep the
handler-tracking array in a consistent state for the boot package,
allowing the correct configuration to be restored on resume.

The resume callback must busy-wait for hardware acknowledgment of the
directed interrupt setup. Otherwise, the handler-tracking array could be
left in an inconsistent state. This implies running with interrupts
disabled for up to 15ms, though in practice it takes less than 1ms.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
While it may take up to 15ms for hardware to acknowledge the interrupt,
latency measurements show that the latency has a median of 0.4ms. Please
see the preceding patch for details.
---
Changes in v2:
 * Relocated comment blocks for clarity.
 * Reworded the changelog for clarity and accuracy.
---
 drivers/thermal/intel/therm_throt.c | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index dcb5d7051ac6..d4ea795e3c3b 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -14,6 +14,7 @@
  * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
  *          Inspired by Ross Biro's and Al Borchers' counter code.
  */
+#include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/jiffies.h>
@@ -570,7 +571,10 @@ static void config_directed_thermal_pkg_intr(void *info)
 	wrmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
 }
 
-/* Only accessed from CPU hotplug callbacks. No extra locking needed. */
+/*
+ * Only accessed from CPU hotplug and syscore callbacks. No extra locking
+ * needed.
+ */
 static unsigned int *directed_intr_handler_cpus;
 
 static bool directed_thermal_pkg_intr_supported(void)
@@ -588,6 +592,10 @@ static bool directed_thermal_pkg_intr_supported(void)
  * Must be called with cpu_hotplug_lock held to prevent CPUs from going offline
  * while iterating through packages. Also, interrupts must be enabled to avoid
  * deadlocks in SMP function calls.
+ *
+ * The syscore resume callback may call this function but CPU hotplug is disabled
+ * in that context. It also runs with interrupts disabled, but no SMP function
+ * calls are issued because the directed interrupt was torn down before suspend.
  */
 static void disable_all_directed_thermal_pkg_intr(void)
 {
@@ -679,6 +687,10 @@ static void disable_directed_thermal_pkg_intr(unsigned int cpu)
 		 * We are here via CPU hotplug. Since we are holding the
 		 * cpu_hotplug_lock, @new_cpu cannot go offline and interrupts
 		 * are enabled, so the SMP function call is safe.
+		 *
+		 * The syscore suspend callback runs with interrupts disabled,
+		 * but it does not reach this path because all the secondary
+		 * CPUs are offline.
 		 */
 		smp_call_function_single(new_cpu, config_directed_thermal_pkg_intr,
 					 &enable, true);
@@ -768,6 +780,31 @@ static int thermal_throttle_offline(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * CPU0 may be handling the directed interrupt, but the CPU hotplug callbacks
+ * are not called for CPU0 during suspend and resume.
+ */
+static void directed_pkg_intr_syscore_resume(void *data)
+{
+	enable_directed_thermal_pkg_intr(0);
+}
+
+static int directed_pkg_intr_syscore_suspend(void *data)
+{
+	disable_directed_thermal_pkg_intr(0);
+
+	return 0;
+}
+
+static const struct syscore_ops directed_pkg_intr_pm_ops = {
+	.resume = directed_pkg_intr_syscore_resume,
+	.suspend = directed_pkg_intr_syscore_suspend,
+};
+
+static struct syscore directed_pkg_intr_pm = {
+	.ops = &directed_pkg_intr_pm_ops,
+};
+
 static __init void init_directed_pkg_intr(void)
 {
 	int i;
@@ -783,6 +820,8 @@ static __init void init_directed_pkg_intr(void)
 
 	for (i = 0; i < topology_max_packages(); i++)
 		directed_intr_handler_cpus[i] = nr_cpu_ids;
+
+	register_syscore(&directed_pkg_intr_pm);
 }
 
 static __init int thermal_throttle_init_device(void)

-- 
2.43.0

