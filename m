From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 11/21] x86, amd_idle: Use explicit broadcast oneshot control functions
Date: Fri, 03 Apr 2015 02:05:53 +0200
Message-ID: <8569669.lgxIty9PKW@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61457 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752864AbbDCAQT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 20:16:19 -0400
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

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

