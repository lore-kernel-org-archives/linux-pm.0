Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541A3546C8;
	Wed, 12 Aug 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536232; cv=none; b=NaeHwhpFt5ZK/VfRmAGzWQ1GH3K8nMTSowTCV2xtDAVh/j4MFSY+zLWgTCQ4vdw4UqhedsLY22WbQZZSaDS/269Ueq+7Xd5TPc/ViuRiKxQe8NqN6F0EwpKH7UP0jyNXIAI7mvBGCJ21B3bDqB/kF9a/nRxaQdmassb2ofbLWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536232; c=relaxed/simple;
	bh=kvpBh02FRfteHfgHwO5CYuK1PrTOzwA3xxXqAWpXKc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utZxyxjffJNj89+DuJCMUmRd6Faff1UgvNf5YkJo9I5VsY5fxWEcKJ2RY/NwhATlhqXAIdOuzFS1Ty7Z+hogvwOIR37+5SJmDsRsN09sgcho0xahtnivCigiDVgOqDfsPkg1p7SFLiF3ipGumtSKI3Es+P/x5gvoonlkuFVjRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=wnCDNiel; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="wnCDNiel"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: ae1f50a7-1b19-44d8-b6d4-d2eb0f197f70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1786536219;
	bh=kvpBh02FRfteHfgHwO5CYuK1PrTOzwA3xxXqAWpXKc8=;
	h=From:To:Cc:Subject:Date:From;
	b=wnCDNiel0WNIh0FyQByH3cB6lNK/N0zzuFhCU3HxZjQFt3p3pnQPrgl+2SRTUfIFV
	 jkaOmkKVp/DY68OKedhqEefhWCJHK+YuIiN5Mr/Ns21F7foyZ3z3YlaxcK9N6p2Ben
	 IQGnK/VyXPVQpPwZgdaHalnNw+25/6FrLxT7oTkGcNjejLdkdeWEvubyjotYAl+DdK
	 0sV0rA37+etzHbWEPX9f60FpXBLFXw4MrwmjATepTz7AtTjAGGh9V37YhFS6zH64LU
	 xaShiUnOPl0X+az1GwTXA+2KpWwJLhdZ6dHIeHv25ATmdQvhe+a/tmaWhnu5PMoyAK
	 NCo7oPetnNkoQ==
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH] ACPI: x86: Apple T2 systems need early CPU offlining
Date: Wed, 12 Aug 2026 14:03:26 +0200
Message-ID: <20260812120326.155226-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

Linux reports _OSI("Darwin") on x86 Apple systems. On T2 Macs, the
selected firmware suspend path makes secondary CPU startup during early
resume take several seconds per CPU. The same CPUs can be brought online
normally after platform resume.

We therefore move secondary CPU hotplug outside the generic CPU PM
notifier window on T2 systems. A prepare notifier runs before the CPU
core blocks hotplug, while a post notifier restores only the CPUs it
removed after the core enables hotplug again.

This reduces CPU bring-up during resume from several seconds per CPU to a
fraction of a second. The change was tested on MacBookPro15,1,
MacBookPro16,2, MacBookAir9,1 and a 27-inch T2 iMac.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/acpi/x86/apple.c | 140 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
index 45d0f16..5595a6a 100644
--- a/drivers/acpi/x86/apple.c
+++ b/drivers/acpi/x86/apple.c
@@ -6,7 +6,13 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cpu.h>
+#include <linux/cpuhplock.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
 #include <linux/platform_data/x86/apple.h>
+#include <linux/suspend.h>
 #include <linux/uuid.h>
 #include "../internal.h"
 
@@ -146,3 +152,137 @@ out_free:
 	ACPI_FREE(props);
 	bitmap_free(valid);
 }
+
+#ifdef CONFIG_PM_SLEEP_SMP
+/*
+ * The ACPI path selected by _OSI("Darwin") leaves Apple T2 systems in a
+ * state where bringing secondary CPUs online during early resume may take
+ * several seconds per CPU. Normal CPU hotplug after platform resume is not
+ * affected, so we move it outside the generic suspend CPU hotplug window.
+ */
+static cpumask_var_t apple_t2_offlined_cpus;
+
+#define PCI_DEVICE_ID_APPLE_T2_BRIDGE 0x1801
+
+static bool __init apple_t2_present(void)
+{
+	struct pci_dev *pdev;
+
+	if (!x86_apple_machine)
+		return false;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_APPLE,
+			      PCI_DEVICE_ID_APPLE_T2_BRIDGE, NULL);
+	if (!pdev)
+		return false;
+
+	pci_dev_put(pdev);
+	return true;
+}
+
+static void apple_t2_restore_cpus(void)
+{
+	unsigned int cpu;
+	int ret;
+
+	for_each_cpu(cpu, apple_t2_offlined_cpus) {
+		ret = add_cpu(cpu);
+		if (ret) {
+			pr_err("ACPI: Apple T2 failed to restore CPU%u: %d\n",
+			       cpu, ret);
+			continue;
+		}
+
+		cpumask_clear_cpu(cpu, apple_t2_offlined_cpus);
+	}
+}
+
+static void apple_t2_offline_cpus(void)
+{
+	unsigned int cpu;
+	int ret;
+
+	if (!cpumask_empty(apple_t2_offlined_cpus)) {
+		pr_err("ACPI: Apple T2 CPUs from the previous suspend remain offline\n");
+		apple_t2_restore_cpus();
+		if (!cpumask_empty(apple_t2_offlined_cpus)) {
+			pr_err("ACPI: Apple T2 early CPU offlining skipped\n");
+			return;
+		}
+	}
+
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+
+		ret = remove_cpu(cpu);
+		if (ret) {
+			pr_err("ACPI: Apple T2 failed to offline CPU%u: %d\n",
+			       cpu, ret);
+			continue;
+		}
+
+		cpumask_set_cpu(cpu, apple_t2_offlined_cpus);
+	}
+}
+
+static int apple_t2_cpu_prepare(struct notifier_block *nb,
+				unsigned long action, void *unused)
+{
+	if (action == PM_SUSPEND_PREPARE)
+		apple_t2_offline_cpus();
+
+	return NOTIFY_OK;
+}
+
+static int apple_t2_cpu_restore(struct notifier_block *nb,
+				unsigned long action, void *unused)
+{
+	if (action == PM_POST_SUSPEND)
+		apple_t2_restore_cpus();
+
+	return NOTIFY_OK;
+}
+
+/*
+ * The CPU core PM notifier runs at priority 0. We offline CPUs before
+ * hotplug is blocked, then restore them after it enables hotplug again.
+ */
+static struct notifier_block apple_t2_cpu_prepare_nb = {
+	.notifier_call = apple_t2_cpu_prepare,
+	.priority = 1,
+};
+
+static struct notifier_block apple_t2_cpu_restore_nb = {
+	.notifier_call = apple_t2_cpu_restore,
+	.priority = -1,
+};
+
+static int __init apple_t2_cpu_pm_init(void)
+{
+	int ret;
+
+	if (!apple_t2_present())
+		return 0;
+
+	if (!alloc_cpumask_var(&apple_t2_offlined_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = register_pm_notifier(&apple_t2_cpu_prepare_nb);
+	if (ret)
+		goto free_mask;
+
+	ret = register_pm_notifier(&apple_t2_cpu_restore_nb);
+	if (ret)
+		goto unregister_prepare;
+
+	return 0;
+
+unregister_prepare:
+	unregister_pm_notifier(&apple_t2_cpu_prepare_nb);
+free_mask:
+	free_cpumask_var(apple_t2_offlined_cpus);
+	return ret;
+}
+late_initcall(apple_t2_cpu_pm_init);
+#endif
-- 
2.55.0

