From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 13/21] ACPI / processor: Use explicit broadcast controll function
Date: Fri, 03 Apr 2015 02:12:03 +0200
Message-ID: <2653377.MSAlfA939I@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51616 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752758AbbDCAQR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 20:16:17 -0400
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
 

