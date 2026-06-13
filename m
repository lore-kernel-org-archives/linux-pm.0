Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F43A6EEC;
	Sat, 13 Jun 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388438; cv=none; b=mfwx5c1ou6WE6ULBLqHCKBASpvMUddKYntXChtpMzvTQ5ApxrSdptGHj232j66hSkQGATMjK7WTWKE+jIVUaxxKd39ljs++Y7l0T9G+KardB1gx0xjEOjor7AiWxla87V74kWrw8xNnqyc0zmD/z6W+LZ1jVK4N1BrpTAvnYH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388438; c=relaxed/simple;
	bh=JlXIrfwmFavIh6IBHpaTTsN1+1aCF2ZOhhdM0OVwJ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8MsvF2npxiQw6GawZDTtGKSRDErxJWMrTZisNCUus5PNR6QjCiifFA6wY1TGhN5O7UoW4rnIsZkyyLBaksXfxnJNF1QkMM54VKPwsrIk+gzi2+WjO3cTTSTkLrLEl22L86jy1vfa4VCQeXr9/I4UwsJ7lWCPniPQP7BApi5yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsX7Sho8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsX7Sho8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388437; x=1812924437;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JlXIrfwmFavIh6IBHpaTTsN1+1aCF2ZOhhdM0OVwJ6M=;
  b=VsX7Sho8m9SwxfxiW4WRSZ5gGhuvbJRSELj3yY4mw52vbofCnzgl4XO9
   XO8BX5lfuKgRxJCToXGjUKvh3Z7WxTQwyyG3lzFD+NONu4O/0F3yMnEbC
   P2ZiU8Ac4VHAdVGZXDDM35UlSVhzn7uNI0LK1IQXUkdorRGr6lB8wRSft
   jcTq8E+MwVrrvW6lOX1HPuUcY452VE11p3O600e4nqlAj8unKgE9JGv2v
   hoLOoyA+CrdVjRYh2a3dM+mZcwHgMkF/PfYlRnAsXbtJaQeV6w94QbesZ
   iYeR1spFHN9QEMKz42g2/hxSVcrEvbApeub98XnfppegbpgKHjLvsWItG
   w==;
X-CSE-ConnectionGUID: z/1YQ7jRRc+B444LZomefw==
X-CSE-MsgGUID: Hrge3IZZRkuTPppsTtE/vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029427"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: vg4toAmDRvS2dlZuRo5y0w==
X-CSE-MsgGUID: xx4d54GFRxuemXMKAomIVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221860"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 13 Jun 2026 15:17:51 -0700
Subject: [PATCH v3 5/6] thermal: intel: Add syscore callbacks for suspend
 and resume
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-rneri-directed-therm-intr-v3-5-3a26d1e47fc8@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=4816;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=JlXIrfwmFavIh6IBHpaTTsN1+1aCF2ZOhhdM0OVwJ6M=;
 b=4/b1TIOtp7Lo9OiF7I7is7y/gsERATU5rhQU9Dljp27DSJegw+X5iuJC+ffk3kam1gSvGC8sH
 Oys8GKVG3KMB5G9D0Rq/bFoJQXUh1fNbSVdYp7uDU+SwYSValDFZcEN
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
Changes in v3:
 * Reworded comments.

Changes in v2:
 * Relocated comment blocks for clarity.
 * Reworded the changelog for clarity and accuracy.
---
 drivers/thermal/intel/therm_throt.c | 40 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 2a55e3b05980..916b76c0822e 100644
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
@@ -572,7 +573,7 @@ static void config_directed_thermal_pkg_intr(void *info)
 
 /*
  * Accessed from CPU hotplug callbacks and from code that runs while CPU
- * hotplug is inactive: the init and cleanup paths.
+ * hotplug is inactive: the init and cleanup paths as well as syscore callbacks.
  * No extra locking needed.
  */
 static unsigned int *directed_intr_handler_cpus;
@@ -678,6 +679,10 @@ static void disable_directed_thermal_pkg_intr(unsigned int cpu)
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
@@ -709,6 +714,36 @@ static void disable_directed_thermal_pkg_intr(unsigned int cpu)
 	directed_intr_handler_cpus[pkg_id] = (new_cpu < nr_cpu_ids) ? new_cpu : nr_cpu_ids;
 }
 
+/*
+ * CPU0 may be handling the directed interrupt, but the CPU hotplug callbacks
+ * are not called for CPU0 during suspend and resume.
+ */
+static void directed_pkg_intr_syscore_resume(void *data)
+{
+	/*
+	 * We can't do anything to handle errors. If direction fails for CPU0,
+	 * another CPU will take over or disable direction entirely during CPU
+	 * hotplug.
+	 */
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
@@ -724,6 +759,8 @@ static __init void init_directed_pkg_intr(void)
 
 	for (i = 0; i < topology_max_packages(); i++)
 		directed_intr_handler_cpus[i] = nr_cpu_ids;
+
+	register_syscore(&directed_pkg_intr_pm);
 }
 
 static void cleanup_directed_pkg_thermal_intr(void)
@@ -731,6 +768,7 @@ static void cleanup_directed_pkg_thermal_intr(void)
 	if (!directed_thermal_pkg_intr_supported())
 		return;
 
+	unregister_syscore(&directed_pkg_intr_pm);
 	disable_directed_thermal_pkg_intr_all();
 	kfree(directed_intr_handler_cpus);
 	directed_intr_handler_cpus = NULL;

-- 
2.43.0

