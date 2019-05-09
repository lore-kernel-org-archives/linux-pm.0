From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] x86: intel_epb: Take CONFIG_PM into account
Date: Thu, 09 May 2019 23:28:41 +0200
Message-ID: <3431308.1mSSVdqTRr@kreacher>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1627338.1fd8ofggM8@kreacher> <20190509174338.GA24432@splinter>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509174338.GA24432@splinter>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
interface) caused kernels built with CONFIG_PM unset to crash on
systems supporting the Performance and Energy Bias Hint (EPB),
because it attempts to add files to sysfs directories that don't
exist on those systems.

Prevent that from happening by taking CONFIG_PM into account so
that the code depending on it is not compiled at all when it is
not set.

Fixes: b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface)
Reported-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/cpu/intel_epb.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/intel_epb.c
+++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
@@ -97,6 +97,7 @@ static void intel_epb_restore(void)
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
 }
 
+#ifdef CONFIG_PM
 static struct syscore_ops intel_epb_syscore_ops = {
 	.suspend = intel_epb_save,
 	.resume = intel_epb_restore,
@@ -193,6 +194,25 @@ static int intel_epb_offline(unsigned in
 	return 0;
 }
 
+static inline void register_intel_ebp_syscore_ops(void)
+{
+	register_syscore_ops(&intel_epb_syscore_ops);
+}
+#else /* !CONFIG_PM */
+static int intel_epb_online(unsigned int cpu)
+{
+	intel_epb_restore();
+	return 0;
+}
+
+static int intel_epb_offline(unsigned int cpu)
+{
+	return intel_epb_save();
+}
+
+static inline void register_intel_ebp_syscore_ops(void) {}
+#endif
+
 static __init int intel_epb_init(void)
 {
 	int ret;
@@ -206,7 +226,7 @@ static __init int intel_epb_init(void)
 	if (ret < 0)
 		goto err_out_online;
 
-	register_syscore_ops(&intel_epb_syscore_ops);
+	register_intel_ebp_syscore_ops();
 	return 0;
 
 err_out_online:
