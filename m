From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Drop stale comment from acpi_power_transition()
Date: Fri, 08 May 2015 01:08:24 +0200
Message-ID: <3096284.ja1pCUgd23@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

An old comment in acpi_power_transition() indicates that support
for ordering power resources needs to be added, but the current
code handles that already.

Drop the comment to avoid confusion.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -711,8 +711,6 @@ int acpi_power_transition(struct acpi_de
 	    || (device->power.state > ACPI_STATE_D3_COLD))
 		return -ENODEV;
 
-	/* TBD: Resources must be ordered. */
-
 	/*
 	 * First we reference all power resources required in the target list
 	 * (e.g. so the device doesn't lose power while transitioning).  Then,

