From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/16] xen idle: make xen-specific macro xen-specific
Date: Sun, 10 Feb 2013 00:58:23 -0500
Message-ID: <fd112767551c1dc5f15e1db92830d51af186edcf.1360475150.git.len.brown@intel.com>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360475903-30007-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

This macro is only invoked by Xen,
so make its definition specific to Xen.

> set_pm_idle_to_default()
< xen_set_default_idle()

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: xen-devel@lists.xensource.com
---
 arch/x86/include/asm/processor.h | 6 +++++-
 arch/x86/kernel/process.c        | 4 +++-
 arch/x86/xen/setup.c             | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 888184b..c2f7f47 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -998,7 +998,11 @@ extern unsigned long arch_align_stack(unsigned long sp);
 extern void free_init_pages(char *what, unsigned long begin, unsigned long end);
 
 void default_idle(void);
-bool set_pm_idle_to_default(void);
+#ifdef	CONFIG_XEN
+bool xen_set_default_idle(void);
+#else
+#define xen_set_default_idle 0
+#endif
 
 void stop_this_cpu(void *dummy);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ceb05db..b86de21 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -390,7 +390,8 @@ void default_idle(void)
 EXPORT_SYMBOL(default_idle);
 #endif
 
-bool set_pm_idle_to_default(void)
+#ifdef CONFIG_XEN
+bool xen_set_default_idle(void)
 {
 	bool ret = !!x86_idle;
 
@@ -398,6 +399,7 @@ bool set_pm_idle_to_default(void)
 
 	return ret;
 }
+#endif
 void stop_this_cpu(void *dummy)
 {
 	local_irq_disable();
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 8971a26..2b73b5c 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -561,7 +561,7 @@ void __init xen_arch_setup(void)
 #endif
 	disable_cpuidle();
 	disable_cpufreq();
-	WARN_ON(set_pm_idle_to_default());
+	WARN_ON(xen_set_default_idle());
 	fiddle_vdso();
 #ifdef CONFIG_NUMA
 	numa_off = 1;
-- 
1.8.1.3.535.ga923c31
