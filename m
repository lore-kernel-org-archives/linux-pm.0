From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 7/7] cpuidle: (POWER) Handle power_save=off
Date: Tue, 07 Jun 2011 22:00:38 +0530
Message-ID: <20110607163033.6848.70719.stgit__6166.25441839478$1307464354$gmane$org@tringupt.in.ibm.com>
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

This patch makes pseries_idle_driver to be not registered when
power_save=off kernel boot option is specified. For this
boot_option_idle_override is used similar to how it is used for x86.

Signed-off-by: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/processor.h            |    3 +++
 arch/powerpc/kernel/idle.c                      |    4 ++++
 arch/powerpc/platforms/pseries/processor_idle.c |    4 ++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index d50c2b6..0ce167e 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -377,6 +377,9 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+extern unsigned long  boot_option_idle_override;
+enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PROCESSOR_H */
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 932392b..61515f4 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -39,9 +39,13 @@
 #define cpu_should_die()	0
 #endif
 
+unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
+EXPORT_SYMBOL(boot_option_idle_override);
+
 static int __init powersave_off(char *arg)
 {
 	ppc_md.power_save = NULL;
+	boot_option_idle_override = IDLE_POWERSAVE_OFF;
 	return 0;
 }
 __setup("powersave=off", powersave_off);
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index ff44b49..c4c3383 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -288,6 +288,10 @@ static int pseries_idle_probe(void)
 		return -EPERM;
 	}
 
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE) {
+		return -ENODEV;
+	}
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		printk(KERN_DEBUG "Using default idle\n");
 		return -ENODEV;
