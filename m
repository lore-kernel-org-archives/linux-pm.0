From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 12/20] ACPI / processor: Use explicit broadcast controll function
Date: Thu, 02 Apr 2015 00:17:20 +0200
Message-ID: <1907004.LSbzWGMaAs@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -178,11 +178,10 @@ static void lapic_timer_state_broadcast(
 	int state = cx - pr->power.states;
 
 	if (state >= pr->power.timer_broadcast_on_state) {
-		unsigned long reason;
-
-		reason = broadcast ?  CLOCK_EVT_NOTIFY_BROADCAST_ENTER :
-			CLOCK_EVT_NOTIFY_BROADCAST_EXIT;
-		clockevents_notify(reason, &pr->id);
+		if (broadcast)
+			tick_broadcast_enter();
+		else
+			tick_broadcast_exit();
 	}
 }
 

