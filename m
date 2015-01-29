From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/5] ACPI / cpuidle: Drop irrelevant comment from acpi_idle_enter_simple()
Date: Thu, 29 Jan 2015 19:28:28 +0100
Message-ID: <1789234.UijYZuRCfe@vostro.rjw.lan>
References: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The comment about bus master disable in acpi_idle_enter_simple() is
irrelevant, because the function doesn't disable bus mastering, so
drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -785,10 +785,6 @@ static int acpi_idle_enter_simple(struct
 	if (acpi_idle_fallback_to_c1(pr))
 		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
 
-	/*
-	 * Must be done before busmaster disable as we might need to
-	 * access HPET !
-	 */
 	lapic_timer_state_broadcast(pr, cx, 1);
 
 	if (cx->type == ACPI_STATE_C3)
