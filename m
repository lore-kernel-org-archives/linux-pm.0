From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 2/3] x86/nmi: export local_touch_nmi() symbol for modules
Date: Fri,  4 Jan 2013 03:12:44 -0800
Message-ID: <1357297965-17839-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1357297965-17839-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32520 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754370Ab3ADTNO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 14:13:14 -0500
In-Reply-To: <1357297965-17839-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Joe Perches <joe@perches.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

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

