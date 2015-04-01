From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 10/20] x86, amd_idle: Use explicit broadcast oneshot control functions
Date: Thu, 02 Apr 2015 00:15:24 +0200
Message-ID: <25992923.yKMiYkL35g@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/process.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/arch/x86/kernel/process.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/process.c
+++ linux-pm/arch/x86/kernel/process.c
@@ -381,7 +381,7 @@ static void amd_e400_idle(void)
 			tick_broadcast_force();
 			pr_info("Switch to broadcast mode on CPU%d\n", cpu);
 		}
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+		tick_broadcast_enter();
 
 		default_idle();
 
@@ -390,7 +390,7 @@ static void amd_e400_idle(void)
 		 * called with interrupts disabled.
 		 */
 		local_irq_disable();
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+		tick_broadcast_exit();
 		local_irq_enable();
 	} else
 		default_idle();
