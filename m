From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 2/3][RFC/RFT] x86/mtrr: Add cpu id into the MTRR setting data structure
Date: Tue, 31 Oct 2017 17:58:41 +0800
Message-ID: <4a62f5c3474944ed6e85bc59f32da15d765ed6de.1509438899.git.yu.c.chen@intel.com>
References: <cover.1509438899.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509438899.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

We record the cpu which has issued the MTRR setting command, then
in the mtrr_rendezvous_handler() we can distinguish it from the
other cpus. This is used for MTRR synchronization optimization.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/cpu/mtrr/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 40d5a8a75212..a4e7e23f3c2e 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -148,6 +148,7 @@ struct set_mtrr_data {
 	unsigned long	smp_size;
 	unsigned int	smp_reg;
 	mtrr_type	smp_type;
+	int		smp_cpu;
 };
 
 /**
@@ -231,7 +232,8 @@ set_mtrr(unsigned int reg, unsigned long base, unsigned long size, mtrr_type typ
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
 				      .smp_size = size,
-				      .smp_type = type
+				      .smp_type = type,
+				      .smp_cpu = smp_processor_id()
 				    };
 
 	stop_machine(mtrr_rendezvous_handler, &data, cpu_online_mask);
@@ -243,7 +245,8 @@ static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
 				      .smp_size = size,
-				      .smp_type = type
+				      .smp_type = type,
+				      .smp_cpu = smp_processor_id()
 				    };
 
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
@@ -255,7 +258,8 @@ static void set_mtrr_from_inactive_cpu(unsigned int reg, unsigned long base,
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
 				      .smp_size = size,
-				      .smp_type = type
+				      .smp_type = type,
+				      .smp_cpu = smp_processor_id()
 				    };
 
 	stop_machine_from_inactive_cpu(mtrr_rendezvous_handler, &data,
-- 
2.13.5
