From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [PATCH V2 6/6] cpuidle/powernv: Enable idle powernv cpu to call
 into the cpuidle framework.
Date: Wed, 31 Jul 2013 08:29:49 +0530
Message-ID: <20130731025947.19448.32213.stgit@deepthi>
References: <20130731025840.19448.24468.stgit@deepthi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130731025840.19448.24468.stgit@deepthi>
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, michael@ellerman.id.au, srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: rjw@sisk.pl, dongsheng.wang@freescale.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch enables idle powernv cpu to hook on to the cpuidle
framework, if available, else call on to default idle platform
code.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 84438af..d4283dd 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/interrupt.h>
 #include <linux/bug.h>
+#include <linux/cpuidle.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -196,6 +197,15 @@ static int __init pnv_probe(void)
 	return 1;
 }
 
+void powernv_idle(void)
+{
+	/* Hook to cpuidle framework if available, else
+	 * call on default platform idle code
+	*/
+	if (cpuidle_idle_call())
+		power7_idle();
+}
+
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
@@ -205,7 +215,7 @@ define_machine(powernv) {
 	.show_cpuinfo		= pnv_show_cpuinfo,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
-	.power_save             = power7_idle,
+	.power_save             = powernv_idle,
 	.calibrate_decr		= generic_calibrate_decr,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
