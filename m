From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] ACPI / PM: Sanitize checks in acpi_power_on_resources()
Date: Tue, 22 Jan 2013 03:11:32 +0100
Message-ID: <2460397.W1PpBYs6jy@vostro.rjw.lan>
References: <1792467.qHBR6KraFh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1792467.qHBR6KraFh@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After the only user of acpi_power_on_resources(),
acpi_bus_init_power(), has been changed to avoid calling it
for state equal to ACPI_STATE_D3_COLD, it doesn't have to special
case that state any more.

For this reason, modify the checks in acpi_power_on_resources()
so that it returns -EINVAL for ACPI_STATE_D3_COLD as it should.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -622,12 +622,9 @@ int acpi_power_get_inferred_state(struct
 
 int acpi_power_on_resources(struct acpi_device *device, int state)
 {
-	if (!device || state < ACPI_STATE_D0 || state > ACPI_STATE_D3_COLD)
+	if (!device || state < ACPI_STATE_D0 || state > ACPI_STATE_D3_HOT)
 		return -EINVAL;
 
-	if (state == ACPI_STATE_D3_COLD)
-		return 0;
-
 	return acpi_power_on_list(&device->power.states[state].resources);
 }
 

