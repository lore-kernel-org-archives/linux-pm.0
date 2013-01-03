From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 1/3] tick: export nohz tick idle symbols for module use
Date: Thu,  3 Jan 2013 07:10:02 -0800
Message-ID: <1357225804-27191-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1357225804-27191-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41404 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987Ab3ACXKS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Jan 2013 18:10:18 -0500
In-Reply-To: <1357225804-27191-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Joe Perches <joe@perches.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Allow drivers such as intel_powerclamp to use these apis for
turning on/off ticks during idle.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 kernel/time/tick-sched.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d58e552..a767757 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -553,6 +553,7 @@ void tick_nohz_idle_enter(void)
 
 	local_irq_enable();
 }
+EXPORT_SYMBOL_GPL(tick_nohz_idle_enter);
 
 /**
  * tick_nohz_irq_exit - update next tick event from interrupt exit
@@ -681,6 +682,7 @@ void tick_nohz_idle_exit(void)
 
 	local_irq_enable();
 }
+EXPORT_SYMBOL_GPL(tick_nohz_idle_exit);
 
 static int tick_nohz_reprogram(struct tick_sched *ts, ktime_t now)
 {
-- 
1.7.9.5

