From: David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3] Optimize C3 entry on Centaur CPUs
Date: Thu, 27 Dec 2018 16:41:50 +0800
Message-ID: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, mingo@redhat.com, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-pm@kernel.org, linux-kernel@vger.kernel.org
Cc: brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, timguo@zhaoxin.com, David Wang <davidwang@zhaoxin.com>
List-Id: linux-pm@vger.kernel.org

For new Centaur CPUs the ucode will take care of the preservation of cache coherence
between CPU cores in C-states regardless of how deep the C-states are. So, it is not
necessary to flush the caches in software befor entering C3. And this useless operation
will cause performance drop for the cores which share some caches with the idling core.  

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Changes from v2 to v3:
*1, Replace "c->x86_mask" with "c->x86_stepping".

Changes from v1 to v2:
* 1, Add some Family/Model/Stepping contrains to let this patch only apply
* to new centaur CPUs.
* 2, The arbiter disable/enable operations maybe needed for old VIA/Centaur
* platform. So, delete "flags->bm_control=0" in patch v1.

---
 arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 158ad14..ed17640 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
+	/*
+	* For all recent Centaur CPUs, the ucode will make sure that each
+	* core can keep cache coherence with each other while entering C3
+	* type state. So, set bm_check to 1 to indicate that the kernel
+	* need not execute a cache flush operation (WBINVD) when entering
+	* C3 type state.
+	*/
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
+		    c->x86_stepping >= 0x0e))
+			flags->bm_check = 1;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
-- 
1.9.1
