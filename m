From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] ACPI / cpuidle: Clean up white space in a switch statement
Date: Thu, 29 Jan 2015 19:29:22 +0100
Message-ID: <1581418.n626dfWREn@vostro.rjw.lan>
References: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49324 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751880AbbA2SIU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 13:08:20 -0500
In-Reply-To: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

White space in the switch statement in acpi_processor_setup_cpuidle_states()
does not adhere to the kernel coding style and that makes the code
difficult to read.  Clean that up.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -968,20 +968,20 @@ static int acpi_processor_setup_cpuidle_
 
 		state->flags = 0;
 		switch (cx->type) {
-			case ACPI_STATE_C1:
 
+		case ACPI_STATE_C1:
 			state->enter = acpi_idle_enter_c1;
 			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
 			break;
 
-			case ACPI_STATE_C2:
+		case ACPI_STATE_C2:
 			state->enter = acpi_idle_enter_simple;
 			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
 			break;
 
-			case ACPI_STATE_C3:
+		case ACPI_STATE_C3:
 			state->enter = pr->flags.bm_check ?
 					acpi_idle_enter_bm :
 					acpi_idle_enter_simple;

