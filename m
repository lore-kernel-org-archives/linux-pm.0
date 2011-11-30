From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 1/4] cpuidle: (powerpc) Add
 cpu_idle_wait() to allow switching of idle routines
Date: Wed, 30 Nov 2011 18:16:31 +0530
Message-ID: <20111130124625.972.59898.stgit__27570.0852428146$1322657412$gmane$org@deepthi-ThinkPad-T420>
References: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org, len.brown@intel.com
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch provides cpu_idle_wait() routine for the powerpc
platform which is required by the cpuidle subsystem. This
routine is required to change the idle handler on SMP systems.
The equivalent routine for x86 is in arch/x86/kernel/process.c
but the powerpc implementation is different.

cpuidle_disable variable is to enable/disable cpuidle
framework if power_save option is set during the boot
time.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
---
 arch/powerpc/Kconfig                 |    4 ++++
 arch/powerpc/include/asm/processor.h |    2 ++
 arch/powerpc/include/asm/system.h    |    1 +
 arch/powerpc/kernel/idle.c           |   27 +++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 951e18f..beeeec7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -87,6 +87,10 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default y if 64BIT
 
+config ARCH_HAS_CPU_IDLE_WAIT
+	bool
+	default y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index eb11a44..811b7e7 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -382,6 +382,8 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PROCESSOR_H */
diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index e30a13d..ff66680 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -221,6 +221,7 @@ extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
+void cpu_idle_wait(void);
 
 /*
  * Atomic exchange
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 39a2baa..8574b0e 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -39,9 +39,13 @@
 #define cpu_should_die()	0
 #endif
 
+unsigned long cpuidle_disable = IDLE_NO_OVERRIDE;
+EXPORT_SYMBOL(cpuidle_disable);
+
 static int __init powersave_off(char *arg)
 {
 	ppc_md.power_save = NULL;
+	cpuidle_disable = IDLE_POWERSAVE_OFF;
 	return 0;
 }
 __setup("powersave=off", powersave_off);
@@ -102,6 +106,29 @@ void cpu_idle(void)
 	}
 }
 
+
+/*
+ * cpu_idle_wait - Used to ensure that all the CPUs come out of the old
+ * idle loop and start using the new idle loop.
+ * Required while changing idle handler on SMP systems.
+ * Caller must have changed idle handler to the new value before the call.
+ * This window may be larger on shared systems.
+ */
+void cpu_idle_wait(void)
+{
+	int cpu;
+	smp_mb();
+
+	/* kick all the CPUs so that they exit out of old idle routine */
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		if (cpu != smp_processor_id())
+			smp_send_reschedule(cpu);
+	}
+	put_online_cpus();
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 int powersave_nap;
 
 #ifdef CONFIG_SYSCTL
