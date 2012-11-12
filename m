From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/3] x86/nmi: export local_touch_nmi() symbol for modules
Date: Mon, 12 Nov 2012 14:03:50 -0800
Message-ID: <1352757831-5202-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/nmi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index f84f5c5..6030805 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -509,3 +509,4 @@ void local_touch_nmi(void)
 {
 	__this_cpu_write(last_nmi_rip, 0);
 }
+EXPORT_SYMBOL_GPL(local_touch_nmi);
-- 
1.7.9.5
