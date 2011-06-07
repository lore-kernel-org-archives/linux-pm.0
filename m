From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 2/7] cpuidle: replace xen access to x86
	pm_idle and	default_idle
Date: Tue, 07 Jun 2011 21:59:38 +0530
Message-ID: <20110607162933.6848.14665.stgit__3996.49414835057$1307464249$gmane$org@tringupt.in.ibm.com>
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

From: Len Brown <len.brown@intel.com>

When a Xen Dom0 kernel boots on a hypervisor, it gets access
to the raw-hardware ACPI tables.  While it parses the idle tables
for the hypervisor's beneift, it uses HLT for its own idle.

Rather than have xen scribble on pm_idle and access default_idle,
have it simply disable_cpuidle() so acpi_idle will not load and
architecture default HLT will be used.

cc: xen-devel@lists.xensource.com
Signed-off-by: Len Brown <len.brown@intel.com>
---

 arch/x86/xen/setup.c      |    3 ++-
 drivers/cpuidle/cpuidle.c |    4 ++++
 include/linux/cpuidle.h   |    2 ++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index be1a464..ab1a916 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/memblock.h>
+#include <linux/cpuidle.h>
 
 #include <asm/elf.h>
 #include <asm/vdso.h>
@@ -424,7 +425,7 @@ void __init xen_arch_setup(void)
 #ifdef CONFIG_X86_32
 	boot_cpu_data.hlt_works_ok = 1;
 #endif
-	pm_idle = default_idle;
+	disable_cpuidle();
 	boot_option_idle_override = IDLE_HALT;
 
 	fiddle_vdso();
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a171b9e..8d7303b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -34,6 +34,10 @@ int cpuidle_disabled(void)
 {
 	return off;
 }
+void disable_cpuidle(void)
+{
+	off = 1;
+}
 
 #if defined(CONFIG_ARCH_HAS_CPU_IDLE_WAIT)
 static void cpuidle_kick_cpus(void)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1e85538..2786787 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -127,6 +127,7 @@ struct cpuidle_driver {
 };
 
 #ifdef CONFIG_CPU_IDLE
+extern void disable_cpuidle(void);
 
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 struct cpuidle_driver *cpuidle_get_driver(void);
@@ -140,6 +141,7 @@ extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 
 #else
+static inline void disable_cpuidle(void) { }
 
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return -ENODEV; }
