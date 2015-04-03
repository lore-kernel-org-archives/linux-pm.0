From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 14/21] intel_idle: Use explicit broadcast oneshot control function
Date: Fri, 03 Apr 2015 02:14:23 +0200
Message-ID: <20714596.QMfNNPbuyU@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -638,12 +638,12 @@ static int intel_idle(struct cpuidle_dev
 		leave_mm(cpu);
 
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+		tick_broadcast_enter();
 
 	mwait_idle_with_hints(eax, ecx);
 
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+		tick_broadcast_exit();
 
 	return index;
 }
