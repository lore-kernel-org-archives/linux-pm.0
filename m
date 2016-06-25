From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/4][RFC v2] PM / sleep: Avoid accessing frozen_cpus if it is NULL
Date: Sun, 26 Jun 2016 00:18:30 +0800
Message-ID: <f9847b8bd15ad5056255150c71df37f2f74bc080.1466844557.git.yu.c.chen@intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27815 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbcFYQLV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 25 Jun 2016 12:11:21 -0400
In-Reply-To: <cover.1466844557.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

frozen_cpus might be NULL if the allocation in previous
alloc_frozen_cpus failed, when CONFIG_CPUMASK_OFFSTACK
is set.

This patch avoid accessing this cpumask if it is NULL.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d948e44..d25266e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1021,6 +1021,8 @@ int disable_nonboot_cpus(void)
 {
 	int cpu, first_cpu, error = 0;
 
+	if (frozen_cpus == NULL)
+		return -ENOMEM;
 	cpu_maps_update_begin();
 	first_cpu = cpumask_first(cpu_online_mask);
 	/*
@@ -1072,6 +1074,8 @@ void enable_nonboot_cpus(void)
 {
 	int cpu, error;
 
+	if (frozen_cpus == NULL)
+		return;
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
 	WARN_ON(--cpu_hotplug_disabled < 0);
-- 
2.7.4

