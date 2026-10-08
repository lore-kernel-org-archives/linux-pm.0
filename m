Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90E3C0603;
	Thu,  8 Oct 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482843; cv=none; b=Qufp89yzDlLaf6LD73kdxLL383zaTYAo+nsJYTrHMWhHp7303o+0ziwvEtkTlqpiSaqPNI+/U3G4Wqbg09sE64ES3R1b5uIsZD1pvFs8jQszr3gVq2oBUYgzvtcIX9BovpQrnTsmcQ2rfNloHG/HcmHEMIC308Fq6S1P0VOkRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482843; c=relaxed/simple;
	bh=tGFhvLTHF8StU5hpI/kKUeUAR2iHNdLWXt2fXvXGvos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnl7lrpW9KK8uy6j5jwLTssIejSqpjomBCPHwvDBxsirvkcsmapAjxF2pwt0LtSrrG01kq5I70buGGpeyWZ0puW0Ze68tZ1bmBgA5DpsZw6qs0qTUTM7eEkJt9hc1oTg4BQRLnmGe18Baqc7IPOPw8NeLWj84TCvD1vKs/YZlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Lj1S1fht; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Lj1S1fht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791482840; x=1823018840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d3vM0Xutbnj89U/Y6NYS4pDDMfcemqS/3QfABGSx4iE=;
  b=Lj1S1fht3LuxOzX0Vg5sroGcmSDh1/PQ+SJfBVv9q94mLENkJeDhA/lx
   n1JKpSsvnB+6KUi7nmevfJCtVGd+ylFCNS2fwTZ6XZP3WO7dJDkWhOf11
   7FlOCA0peqHCgGz7veULXEY2O7qY+YcaKw9cssMhTisPl2NfPFdhKS+vx
   Yjrc3zt3afAKMN335n+OIfxvH/L0aiUHFWwEBelP+v6vJi8yBSLcqRb0k
   VtLSc01FMkinjS0ijws7+5yOVXmyK0Y/IYlLOgHS2qKf3hbrFI1z8AY5K
   GWhZ3AuH474Tvx9YEUbJev+3mUCvxbR0h3dLuZdcEV7qslmDpPrVIgFT6
   Q==;
X-CSE-ConnectionGUID: kBdNeM4aR/2UvNYxMzGQQA==
X-CSE-MsgGUID: mR1cM7kVRji7cPLKQ5ANXw==
X-IronPort-AV: E=Sophos;i="6.27,146,1787011200"; 
   d="scan'208";a="30527618"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 18:07:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:16984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.228:2525] with esmtp (Farcaster)
 id 632c4f48-db91-4138-83e8-b5b2c818f7ab; Thu, 8 Oct 2026 18:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: 632c4f48-db91-4138-83e8-b5b2c818f7ab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 8 Oct 2026 18:07:15 +0000
Received: from ub9ea591b72db54.ant.amazon.com (10.106.83.20) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 8 Oct 2026 18:07:12 +0000
From: Roman Kagan <rkagan@amazon.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Roman Kagan <rkagan@amazon.de>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH] cpuidle: Add the shallow governors
Date: Thu, 8 Oct 2026 20:06:32 +0200
Message-ID: <20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261007-b4-cpuidle-shallow-a4d6190bc8b1
X-Mailer: b4 0.17-dev-3d1b8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The idle states offered by a platform trade wakeup latency for energy
savings, and there are situations where the trade is not worth making:
while a latency-sensitive workload is running, or during a live update
via kexec, where everything from the outgoing kernel stopping the
workload to the incoming kernel resuming it is downtime, and deep idle
states may lengthen it.

The mechanisms currently available for that are all one-way.
cpuidle.off=1, idle=poll and idle=halt can only be requested in the
kernel command line and cannot be undone, and the PM QoS interfaces
(/dev/cpu_dma_latency and the per-CPU pm_qos_resume_latency_us
attribute) can only be used once user space is up, so they cannot cover
the boot of the incoming kernel.

Add governors that keep the CPUs in the shallowest idle states and leave
the scheduler tick running.  Being governors, they can be selected both
at run time, by writing a name to the current_governor attribute in
sysfs, and in the kernel command line, via cpuidle.governor=.  For a
live update, that makes it possible to switch the outgoing kernel to one
of them before the kexec, pass the same governor to the incoming kernel
so that it is in effect from the very beginning of its boot, and switch
to an energy-efficient governor once the post-update work is done.

On x86 and on some powerpc platforms, the shallowest idle state is a
polling loop.  It has the lowest wakeup latency, but also the side
effects documented for idle=poll: the CPU saves almost no energy,
competes with its SMT sibling for the core, and on Intel hardware keeps
the package from using the P-states that require some of its CPUs to be
idle.  Whether that is acceptable is a policy decision, so there are two
governors and the user makes it by choosing between them.  The shallow
governor always selects the shallowest enabled state.  The
shallow_nopoll one skips polling states, unless the state it would
select is too slow to leave for the PM QoS latency limit or all of the
non-polling states are disabled.

A governor named in the kernel command line is not replaced by a
higher-rated one registering later, so cpuidle.governor= holds for the
entire boot.  Both governors have rating 1, below all of the other
governors, so that neither is picked by default.  Where the cpuidle
driver registers no polling states, such as on arm64, the two select the
same states, and neither is a substitute for idle=poll.

Assisted-by: LLM
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
 drivers/cpuidle/governors/Makefile       |   1 +
 drivers/cpuidle/governors/shallow.c      | 104 +++++++++++++++++++++++++++++++
 Documentation/admin-guide/pm/cpuidle.rst |  53 +++++++++++++---
 drivers/cpuidle/Kconfig                  |  20 ++++++
 4 files changed, 169 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
index 63abb5393a4d..10e64092c9ec 100644
--- a/drivers/cpuidle/governors/Makefile
+++ b/drivers/cpuidle/governors/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
 obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
 obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
 obj-$(CONFIG_CPU_IDLE_GOV_HALTPOLL) += haltpoll.o
+obj-$(CONFIG_CPU_IDLE_GOV_SHALLOW) += shallow.o
diff --git a/drivers/cpuidle/governors/shallow.c b/drivers/cpuidle/governors/shallow.c
new file mode 100644
index 000000000000..8d4ac46d302a
--- /dev/null
+++ b/drivers/cpuidle/governors/shallow.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * shallow.c - the shallow and shallow_nopoll idle governors
+ *
+ * Always select the shallowest enabled idle state, trading idle energy
+ * savings for the lowest wakeup latency the platform can offer.  The
+ * shallow_nopoll one skips polling states unless PM QoS requires them.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/init.h>
+
+/**
+ * shallow_select - select the shallowest enabled idle state
+ * @drv: cpuidle driver containing state data
+ * @dev: the CPU
+ * @stop_tick: indication on whether or not to stop the tick
+ *
+ * The state selected here is the least energy-efficient one offered by the
+ * driver, so there is no point in looking at either the timer events or the
+ * PM QoS latency limits: no constraint can justify going shallower than that.
+ * Leave the tick running, as the CPU is not expected to stay idle for long.
+ *
+ * Return: the index of the first idle state not disabled for @dev, or 0 if
+ * all of them are disabled.
+ */
+static int shallow_select(struct cpuidle_driver *drv,
+			  struct cpuidle_device *dev, bool *stop_tick)
+{
+	int i;
+
+	*stop_tick = false;
+
+	/*
+	 * cpuidle_enter_state() does not check whether the state it is asked
+	 * to enter has been disabled, so the per-state "disable" attributes
+	 * need to be honoured here.  If all of the states are disabled, fall
+	 * back to the first one, like the other governors do.
+	 */
+	for (i = 0; i < drv->state_count; i++)
+		if (!dev->states_usage[i].disable)
+			return i;
+
+	return 0;
+}
+
+/**
+ * shallow_nopoll_select - select the shallowest enabled non-polling idle state
+ * @drv: cpuidle driver containing state data
+ * @dev: the CPU
+ * @stop_tick: indication on whether or not to stop the tick
+ *
+ * Same as shallow_select(), but skip the polling states.  Unlike them, the
+ * shallowest non-polling state may take longer to leave than the PM QoS
+ * latency limit allows, so fall back to shallow_select() in that case, as
+ * well as when all of the non-polling states are disabled.
+ *
+ * Return: the index of the first idle state that is neither disabled for @dev
+ * nor a polling one, or what shallow_select() returns in the cases above.
+ */
+static int shallow_nopoll_select(struct cpuidle_driver *drv,
+				 struct cpuidle_device *dev, bool *stop_tick)
+{
+	int i;
+
+	for (i = 0; i < drv->state_count; i++) {
+		if (dev->states_usage[i].disable ||
+		    (drv->states[i].flags & CPUIDLE_FLAG_POLLING))
+			continue;
+
+		if (drv->states[i].exit_latency_ns >
+		    cpuidle_governor_latency_req(dev->cpu))
+			break;
+
+		*stop_tick = false;
+		return i;
+	}
+
+	return shallow_select(drv, dev, stop_tick);
+}
+
+static struct cpuidle_governor shallow_governor = {
+	.name =		"shallow",
+	.rating =	1,
+	.select =	shallow_select,
+};
+
+static struct cpuidle_governor shallow_nopoll_governor = {
+	.name =		"shallow_nopoll",
+	.rating =	1,
+	.select =	shallow_nopoll_select,
+};
+
+static int __init init_shallow(void)
+{
+	int ret = cpuidle_register_governor(&shallow_governor);
+
+	if (ret)
+		return ret;
+
+	return cpuidle_register_governor(&shallow_nopoll_governor);
+}
+
+postcore_initcall(init_shallow);
diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index be4c1120e3f0..8c6a438936d4 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -159,15 +159,16 @@ governor uses that information depends on what algorithm is implemented by it
 and that is the primary reason for having more than one governor in the
 ``CPUIdle`` subsystem.
 
-There are four ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_,
-``ladder`` and ``haltpoll``.  Which of them is used by default depends on the
-configuration of the kernel and in particular on whether or not the scheduler
-tick can be `stopped by the idle loop <idle-cpus-and-tick_>`_.  Available
-governors can be read from the :file:`available_governors`, and the governor
-can be changed at runtime.  The name of the ``CPUIdle`` governor currently
-used by the kernel can be read from the :file:`current_governor_ro` or
-:file:`current_governor` file under :file:`/sys/devices/system/cpu/cpuidle/`
-in ``sysfs``.
+There are six ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_,
+``ladder``, ``haltpoll``, `shallow <shallow-gov_>`_ and
+`shallow_nopoll <shallow-gov_>`_.  Which of them is used by default depends on
+the configuration of the kernel and in particular on whether or not the
+scheduler tick can be `stopped by the idle loop <idle-cpus-and-tick_>`_.
+Available governors can be read from the
+:file:`available_governors`, and the governor can be changed at runtime.  The
+name of the ``CPUIdle`` governor currently used by the kernel can be read from
+the :file:`current_governor_ro` or :file:`current_governor` file under
+:file:`/sys/devices/system/cpu/cpuidle/` in ``sysfs``.
 
 Which ``CPUIdle`` driver is used, on the other hand, usually depends on the
 platform the kernel is running on, but there are platforms with more than one
@@ -345,6 +346,40 @@ given conditions.  However, it applies a different approach to that problem.
 .. kernel-doc:: drivers/cpuidle/governors/teo.c
    :doc: teo-description
 
+.. _shallow-gov:
+
+The Shallow Governors
+=====================
+
+The ``shallow`` governor always selects the shallowest enabled idle state and
+leaves the scheduler tick running.  Unlike the governors described above, it
+makes no attempt to save energy at all; its purpose is to keep the CPU wakeup
+latency, and in particular the latency of inter-processor interrupts, at the
+minimum offered by the platform.
+
+The ``shallow_nopoll`` governor does the same, except that it skips polling
+idle states and selects the shallowest enabled idle state that is not a polling
+one.  That avoids the side effects of idle CPUs spinning, which are described
+for ``idle=poll`` below, at the cost of a higher wakeup latency.  If the exit
+latency of that state is above the `PM QoS <cpu-pm-qos_>`_ limit in effect for
+the CPU, or if all of the non-polling states are disabled, ``shallow_nopoll``
+selects the state that ``shallow`` would select.
+
+Neither of them is used by default, regardless of the configuration of the
+kernel, and they have to be requested explicitly.  That can be done either by
+passing ``cpuidle.governor=shallow`` or ``cpuidle.governor=shallow_nopoll`` in
+the kernel command line, or by writing the governor name to the
+:file:`current_governor` file described `above <idle-loop_>`_.  A governor
+requested in the kernel command line is not replaced by a higher-rated one
+registering later, so it holds for the entire boot and user space can hand the
+deep idle states back at any later point by switching to a different governor.
+
+Note that the shallowest idle state is not necessarily a polling loop.  On the
+platforms whose ``CPUIdle`` driver does not register the generic polling state,
+it is the idle instruction of the CPU architecture (for instance, ``WFI`` on
+arm64), so ``shallow`` is not a substitute for ``idle=poll``.  If the driver
+registers no polling states at all, the two governors select the same states.
+
 .. _idle-states-representation:
 
 Representation of Idle States
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 00e2562041fd..c78aa07ca548 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -44,6 +44,26 @@ config CPU_IDLE_GOV_HALTPOLL
 
 	  Some virtualized workloads benefit from using it.
 
+config CPU_IDLE_GOV_SHALLOW
+	bool "Shallow governors (for latency-sensitive systems)"
+	help
+	  The shallow governor always selects the shallowest enabled idle
+	  state, which keeps the CPU wakeup latency at the minimum offered by
+	  the platform at the cost of giving up idle energy savings.  The
+	  shallow_nopoll governor selects the shallowest enabled idle state
+	  that is not a polling one instead, unless PM QoS requires a lower
+	  latency than that state offers.
+
+	  They are never used by default and have to be requested explicitly,
+	  either by passing cpuidle.governor=shallow or
+	  cpuidle.governor=shallow_nopoll in the kernel command line, or by
+	  writing the governor name to the current_governor attribute in
+	  sysfs.  That makes it possible to keep the CPUs out of deep idle
+	  states while booting or while running a latency-sensitive workload
+	  and to switch to an energy-efficient governor afterwards.
+
+	  If unsure, say N.
+
 config DT_IDLE_STATES
 	bool
 

---
base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
change-id: 20261007-b4-cpuidle-shallow-a4d6190bc8b1

Best regards,
--  
Roman Kagan <rkagan@amazon.de>

