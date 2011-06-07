From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 4/7] cpuidle: (powerpc) Add
	cpu_idle_wait() to allow	switching idle routines
Date: Tue, 07 Jun 2011 22:00:04 +0530
Message-ID: <20110607162959.6848.26918.stgit__11190.2184239172$1307464255$gmane$org@tringupt.in.ibm.com>
References: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch provides cpu_idle_wait() routine required
by the cpuidle subsystem. Almost all the code is borrowed
from x86.

Signed-off-by: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---

 arch/powerpc/Kconfig              |    4 ++++
 arch/powerpc/include/asm/system.h |    1 +
 arch/powerpc/kernel/idle.c        |   18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2729c66..518beda 100644
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
diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index 2dc595d..811cdf1 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -222,6 +222,7 @@ extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
+void cpu_idle_wait(void);
 
 /*
  * Atomic exchange
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 39a2baa..932392b 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -102,6 +102,24 @@ void cpu_idle(void)
 	}
 }
 
+static void do_nothing(void *unused)
+{
+}
+
+/*
+ * cpu_idle_wait - Used to ensure that all the CPUs come out of the old
+ * idle loop and start using the new idle loop.
+ * Required while changing idle handler on SMP systems.
+ * Caller must have changed idle handler to the new value before the call.
+ */
+void cpu_idle_wait(void)
+{
+	smp_mb();
+	/* kick all the CPUs so that they exit out of old idle routine */
+	smp_call_function(do_nothing, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 int powersave_nap;
 
 #ifdef CONFIG_SYSCTL
