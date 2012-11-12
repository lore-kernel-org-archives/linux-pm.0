From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/3] tick: export nohz tick idle symbols for module use
Date: Mon, 12 Nov 2012 14:03:49 -0800
Message-ID: <1352757831-5202-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Allow drivers such as intel_powerclamp to use these apis for
turning on/off ticks during idle.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 kernel/time/tick-sched.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a402608..7c38f08 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -510,6 +510,7 @@ void tick_nohz_idle_enter(void)
 
 	local_irq_enable();
 }
+EXPORT_SYMBOL_GPL(tick_nohz_idle_enter);
 
 /**
  * tick_nohz_irq_exit - update next tick event from interrupt exit
@@ -634,6 +635,7 @@ void tick_nohz_idle_exit(void)
 
 	local_irq_enable();
 }
+EXPORT_SYMBOL_GPL(tick_nohz_idle_exit);
 
 static int tick_nohz_reprogram(struct tick_sched *ts, ktime_t now)
 {
-- 
1.7.9.5
