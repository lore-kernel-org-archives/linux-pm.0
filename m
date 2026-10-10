Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD924A6CE6;
	Sat, 10 Oct 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639010; cv=none; b=CelNfYUEgKt2ORlYseJiOC0Gh6FiQZCzH+eujH+EUDrno575osE596XEjqb45EQOph3nrCLEIHzl0tsCxMGvYtRfgIzcL+tQ/CiEFyoMZ52xv4zGNmMxxkPydOHQJ9zEMZXKqlGgDR4fIAbSQvTiS0FOKVWslB3ZeKnPxYr8+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639010; c=relaxed/simple;
	bh=X+3hIunzUmc2hY5TT9pZeKZVM+zpiFNpOuIBCQEfmuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=KwR3zb6T0G+r9pNAKcHG5iLBLBfusyxwRemPtgGcASzVx5D9WCfqy18e+JiY4rWAhjWRUm63+DqfhDobGEaqgOHxIfS0ZHbD5a7FxhQhGbXb8O/me82Cs+0is4dFjAQdjOa2aQ/Hvf3rCF0yBe1u7EZCYC9XVzif4f6nJy3CIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=HQUCk/eB; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="HQUCk/eB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791639009; x=1823175009;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=rzoRpzZO3uArA+DlsDdGQpplvzMH814yqR1dLqTqR1c=;
  b=HQUCk/eBSx9NJ4pcfY0gZFempsns5kR5K8QjPpDjaGw6iTF3iCDueEj0
   k6V+UyvTBlZlw2Fgrn4XXE3U61zzpUu2G3TPfsrA8HtPCiahY2MxGTaTy
   qp7s5ESdwR4I7oFXC14GGPLj1lmbmuZiS8sydnUnFeYw0K3XNceQKRrXQ
   CipiIf1mXzICv5HT/cPUw8qXRhI2QT6Tov2aaOJEbh37nn5PXiZ2Q9nkp
   yxECeJMe0BiqcpOHvgPvXZHyeRA6VI7s7I5bI2p4xZxJ2ct8DOkIgBiAw
   +uZ5vjrLum9y/MfKOEQ4vpC6ahYvolfi7xRP9nNbGZTo/7ibVtKoe1Xnw
   A==;
X-CSE-ConnectionGUID: uauVy7kKSKi3Lzn6H3meyA==
X-CSE-MsgGUID: Jj9kYhgiT9i5R0RQv0G0Iw==
X-IronPort-AV: E=Sophos;i="6.27,150,1787011200"; 
   d="scan'208";a="30949584"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 13:30:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:13903]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.68:2525] with esmtp (Farcaster)
 id 394abd3d-ee49-42a7-a5cb-a7d46c500e40; Sat, 10 Oct 2026 13:30:06 +0000 (UTC)
X-Farcaster-Flow-ID: 394abd3d-ee49-42a7-a5cb-a7d46c500e40
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sat, 10 Oct 2026 13:30:05 +0000
Received: from localhost (10.1.213.18) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Sat, 10 Oct 2026
 13:30:05 +0000
From: Roman Kagan <rkagan@amazon.de>
Date: Sat, 10 Oct 2026 15:29:41 +0200
Subject: [PATCH v2] PM: QoS: Add a sysfs CPU latency request with a
 boot-time value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07ZhOQ3i48j8Iiz5GGYOUtIAPw
 r8LGHcuT3LvObOIFJiiOCWzCDRxZN+toA6JsI3urgTsVhZKqgylzMGkYPuRXUsQG922/gE6dRm
 W0tjCoFiPfaALP3dpVX85juZGdthM26LhOPjw2qsTbrtfoPgXmBAQLJaUI6rcYHrWd/323dGRq
 Jdl+QBKKs0HxgAAAA==
X-Change-ID: 20261007-b4-cpuidle-shallow-a4d6190bc8b1
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Len Brown <lenb@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>, Roman Kagan
	<rkagan@amazon.de>
X-Mailer: b4 0.17-dev-3d1b8
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The idle states offered by a platform trade wakeup latency for energy
savings, and there are situations where the trade is not worth making:
while a latency-sensitive workload is running, or during a live update
via kexec, where everything from the outgoing kernel stopping the
workload to the incoming kernel resuming it is downtime, and deep idle
states may lengthen it.

The CPU latency PM QoS limit is meant for that, but user space can only
take part in it through /dev/cpu_dma_latency, with a request that lives
only as long as the file stays open.  It cannot be in effect while the
incoming kernel boots, and on the outgoing side the process holding the
file normally goes away with the rest of user space before the kexec.
The per-CPU pm_qos_resume_latency_us and per-state "disable" attributes
in sysfs are not tied to an open file, but they cannot be set before
user space is up either.  The existing command line options restricting
idle states either cannot be undone (cpuidle.off=1, idle=poll,
idle=halt, processor.max_cstate= and intel_idle.max_cstate=) or are
specific to one driver (intel_idle.states_off=).

Add a CPU latency request shared by the entire user space, like the
resume latency request of each CPU, and expose it as
/sys/devices/system/cpu/pm_qos_cpu_latency_us with the same format as
the per-CPU attributes: "0" means no constraint and "n/a" means that no
latency is acceptable.  Its initial value can be set with the
pm_qos_cpu_latency_us= command line parameter, and the request is added
before any cpuidle driver registers, much like the boot-time request
intel_idle holds until device_initcall_sync.  For a live update, the
outgoing kernel can be given a limit through sysfs before the kexec, the
incoming kernel can be booted with the same limit, and user space can
write 0 to lift it once the workload is running again.  As the limit is
the minimum over all requests, this one can only make it stricter.

PM QoS is used rather than the per-state "disable" flags, e.g. through
a command line option disabling the states above a given exit latency,
because the genpd governor applies the CPU latency limit to the idle
states of CPU PM domains too, while the flags only apply to the states
of individual CPUs, and because lifting the limit takes one write rather
than one per CPU and state.  A boot-time value for the per-CPU resume
latency requests would take one write per CPU to lift and would depend
on CONFIG_PM.

Assisted-by: LLM
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
Changes in v2:
- Drop the shallow governors (Christian Loehle)
- Add a CPU latency PM QoS request settable from the kernel command line
  and through sysfs instead; the commit message explains why PM QoS
  rather than the per-state "disable" flags
- Link to v1: https://patch.msgid.link/20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de
---
 Documentation/admin-guide/kernel-parameters.txt    |  11 ++
 kernel/power/qos.c                                 | 111 +++++++++++++++++++++
 Documentation/ABI/testing/sysfs-devices-system-cpu |  27 +++++
 Documentation/admin-guide/pm/cpuidle.rst           |  32 ++++--
 Documentation/power/pm_qos_interface.rst           |  17 +++-
 5 files changed, 188 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..a01c8f9cb00f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5389,6 +5389,17 @@ Kernel parameters
 			Format: <bool>
 			Default value is set by CONFIG_DPM_WATCHDOG_ENABLED.
 
+	pm_qos_cpu_latency_us=
+			[CPU_IDLE] Initial value of the CPU latency limit
+			requested through
+			/sys/devices/system/cpu/pm_qos_cpu_latency_us, in
+			microseconds.  It stays in effect until user space
+			writes a different value to that attribute.
+			Format: <integer> | n/a
+			"0" means no constraint (the default) and "n/a" means
+			that no latency is acceptable.  Other values, from 1
+			to 1999999999, are limits in microseconds.
+
 	pnp.debug=1	[PNP]
 			Enable PNP debug messages (depends on the
 			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 1944dbeb0d4c..f38136193907 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -21,6 +21,7 @@
 /*#define DEBUG*/
 
 #include <linux/pm_qos.h>
+#include <linux/cpu.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -335,6 +336,116 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
 }
 EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
 
+/* User space interface to the CPU latency QoS via sysfs. */
+
+/*
+ * Unlike the requests made through the misc device, this one is shared by the
+ * entire user space and is not tied to an open file, like the resume latency
+ * request of each CPU.  Its initial value can be set in the kernel command
+ * line.
+ */
+static struct pm_qos_request cpu_latency_qos_sysfs_req;
+static s32 cpu_latency_qos_boot_value __initdata = PM_QOS_DEFAULT_VALUE;
+
+/*
+ * Use the format of the power/pm_qos_resume_latency_us attribute of CPUs: "0"
+ * means no constraint and "n/a" means that no latency is acceptable.
+ */
+static int cpu_latency_qos_parse(const char *buf, s32 *value)
+{
+	s32 val;
+
+	if (!kstrtos32(buf, 0, &val)) {
+		/*
+		 * Prevent users from writing negative or "no constraint" values
+		 * directly.
+		 */
+		if (val < 0 || val >= PM_QOS_CPU_LATENCY_DEFAULT_VALUE)
+			return -EINVAL;
+
+		*value = val ? val : PM_QOS_DEFAULT_VALUE;
+	} else if (sysfs_streq(buf, "n/a")) {
+		*value = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init cpu_latency_qos_setup(char *str)
+{
+	if (cpu_latency_qos_parse(str, &cpu_latency_qos_boot_value))
+		pr_warn("Invalid pm_qos_cpu_latency_us= value: %s\n", str);
+
+	return 1;
+}
+__setup("pm_qos_cpu_latency_us=", cpu_latency_qos_setup);
+
+static ssize_t pm_qos_cpu_latency_us_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	s32 value = READ_ONCE(cpu_latency_qos_sysfs_req.node.prio);
+
+	if (value == 0)
+		return sysfs_emit(buf, "n/a\n");
+	if (value == PM_QOS_CPU_LATENCY_DEFAULT_VALUE)
+		value = 0;
+
+	return sysfs_emit(buf, "%d\n", value);
+}
+
+static ssize_t pm_qos_cpu_latency_us_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t n)
+{
+	s32 value;
+	int ret;
+
+	ret = cpu_latency_qos_parse(buf, &value);
+	if (ret)
+		return ret;
+
+	cpu_latency_qos_update_request(&cpu_latency_qos_sysfs_req, value);
+
+	return n;
+}
+
+static DEVICE_ATTR_RW(pm_qos_cpu_latency_us);
+
+/*
+ * The cpu subsystem root device is registered before any initcalls run, so
+ * both the request and its attribute can be set up before any cpuidle driver
+ * registers.
+ */
+static int __init cpu_latency_qos_sysfs_init(void)
+{
+	struct device *dev_root;
+	int ret = -ENODEV;
+
+	cpu_latency_qos_add_request(&cpu_latency_qos_sysfs_req,
+				    cpu_latency_qos_boot_value);
+
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		ret = device_create_file(dev_root,
+					 &dev_attr_pm_qos_cpu_latency_us);
+		put_device(dev_root);
+	}
+
+	if (ret) {
+		pr_err("%s: %s setup failed\n", __func__,
+		       dev_attr_pm_qos_cpu_latency_us.attr.name);
+		/* Do not leave a limit in place that cannot be lifted. */
+		cpu_latency_qos_update_request(&cpu_latency_qos_sysfs_req,
+					       PM_QOS_DEFAULT_VALUE);
+	}
+
+	return ret;
+}
+core_initcall(cpu_latency_qos_sysfs_init);
+
 /* User space interface to the CPU latency QoS via misc device. */
 
 static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 82d10d556cc8..08ffb3c47b32 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -141,6 +141,33 @@ Description:	Discover cpuidle policy and mechanism
 		Documentation/driver-api/pm/cpuidle.rst for more information.
 
 
+What:		/sys/devices/system/cpu/pm_qos_cpu_latency_us
+Date:		October 2026
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		(RW) The CPU latency limit requested by user space for all
+		CPUs, in microseconds.  It is a single PM QoS request shared by
+		the entire user space, which stays in effect until it is
+		updated.  The global CPU latency limit is the minimum of this
+		request and of the other ones, made by kernel code and through
+		/dev/cpu_dma_latency, so it may be lower than this value.
+		Reading the file returns the value of this request, not the
+		global limit.
+
+		As for the power/pm_qos_resume_latency_us attributes of CPUs,
+		"0" means no constraint and "n/a" means that no latency is
+		acceptable.  Other values, from 1 to 1999999999, are limits in
+		microseconds.  Writing anything else fails with -EINVAL.
+
+		The initial value can be set with the pm_qos_cpu_latency_us=
+		kernel command line parameter.
+
+		Present if CONFIG_CPU_IDLE is set.
+
+		See Documentation/admin-guide/pm/cpuidle.rst for more
+		information.
+
+
 What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/name
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index be4c1120e3f0..ea3bc4e4f29e 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -520,13 +520,16 @@ individual CPUs.  Kernel code (e.g. device drivers) can set both of them with
 the help of special internal interfaces provided by the PM QoS framework.  User
 space can modify the former by opening the :file:`cpu_dma_latency` special
 device file under :file:`/dev/` and writing a binary value (interpreted as a
-signed 32-bit integer) to it.  In turn, the resume latency constraint for a CPU
-can be modified from user space by writing a string (representing a signed
-32-bit integer) to the :file:`power/pm_qos_resume_latency_us` file under
+signed 32-bit integer) to it, or by writing a string to the
+:file:`pm_qos_cpu_latency_us` file under :file:`/sys/devices/system/cpu/` in
+``sysfs``.  In turn, the resume latency constraint for a CPU can be modified
+from user space by writing a string (representing a signed 32-bit integer) to
+the :file:`power/pm_qos_resume_latency_us` file under
 :file:`/sys/devices/system/cpu/cpu<N>/` in ``sysfs``, where the CPU number
-``<N>`` is allocated at the system initialization time.  Negative values
-will be rejected in both cases and, also in both cases, the written integer
-number will be interpreted as a requested PM QoS constraint in microseconds.
+``<N>`` is allocated at the system initialization time.  Negative values will
+be rejected in all of these cases and the written integer number will be
+interpreted as a requested PM QoS constraint in microseconds, except that ``0``
+written to the ``sysfs`` files means no constraint (see below).
 
 The requested value is not automatically applied as a new constraint, however,
 as it may be less restrictive (greater in this particular case) than another
@@ -574,6 +577,16 @@ determine the effective value to be set as the resume latency constraint for the
 CPU in question every time the list of requests is updated this way or another
 (there may be other requests coming from kernel code in that list).
 
+Similarly, there is one global CPU latency limit request associated with the
+:file:`pm_qos_cpu_latency_us` file under :file:`/sys/devices/system/cpu/` in
+``sysfs``.  It is shared by the entire user space and is not tied to any file
+descriptor, so it stays in effect until it is updated.  Its initial value can be
+set with the ``pm_qos_cpu_latency_us=`` kernel command line parameter, which
+puts the limit in place before any ``CPUIdle`` driver is registered, and user
+space can lift it later.  As for the :file:`power/pm_qos_resume_latency_us`
+files of CPUs, ``0`` means no constraint and ``n/a`` means that no latency is
+acceptable.  Other values, from 1 to 1999999999, are limits in microseconds.
+
 CPU idle time governors are expected to regard the minimum of the global
 (effective) CPU latency limit and the effective resume latency constraint for
 the given CPU as the upper limit for the exit latency of the idle states that
@@ -615,6 +628,13 @@ governor will be used instead of the default one.  It is possible to force
 the ``menu`` governor to be used on the systems that use the ``ladder`` governor
 by default this way, for example.
 
+The ``pm_qos_cpu_latency_us=`` kernel command line parameter sets the initial
+value of the global CPU latency limit request associated with the
+:file:`pm_qos_cpu_latency_us` file in ``sysfs`` (see `above <cpu-pm-qos_>`_), so
+it can be used to keep idle states with exit latency beyond the given value from
+being selected from the start, and the limit can be lifted at run time by
+writing to that file.
+
 The other kernel command line parameters controlling CPU idle time management
 described below are only relevant for the *x86* architecture and references
 to ``intel_idle`` affect Intel processors only.
diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 4c008e2202f0..f5d53f01652f 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -57,11 +57,12 @@ From user space:
 
 The infrastructure exposes two separate device nodes, /dev/cpu_dma_latency for
 the CPU latency QoS and /dev/cpu_wakeup_latency for the CPU system wakeup
-latency QoS.
+latency QoS, and a sysfs file, /sys/devices/system/cpu/pm_qos_cpu_latency_us,
+for the CPU latency QoS.
 
-Only processes can register a PM QoS request.  To provide for automatic
-cleanup of a process, the interface requires the process to register its
-parameter requests as follows.
+Requests made through the device nodes belong to the processes making them.
+To provide for automatic cleanup of a process, the interface requires the
+process to register its parameter requests as follows.
 
 To register the default PM QoS target for the CPU latency QoS, the process must
 open /dev/cpu_dma_latency.  To register a CPU system wakeup QoS limit, the
@@ -77,6 +78,14 @@ using the 10 char long format e.g. "0x12345678".
 To remove the user mode request for a target value simply close the device
 node.
 
+The sysfs file is associated with a single CPU latency QoS request that is not
+tied to any process and is shared by the entire user space.  Writing to the
+file updates that request, which stays in effect until the next update.  The
+value is a number of microseconds from 1 to 1999999999, with the same special
+cases as for the per-CPU resume latency: "0" means no constraint and "n/a"
+means that no latency is acceptable.  The initial value of that request can be
+set with the pm_qos_cpu_latency_us= kernel command line parameter.
+
 
 2. PM QoS per-device latency and flags framework
 ================================================

---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20261007-b4-cpuidle-shallow-a4d6190bc8b1

Best regards,
--  
Roman Kagan <rkagan@amazon.de>

