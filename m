From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] ACPI / PM: Make messages in acpi_device_set_power() print device names
Date: Sat, 27 Jul 2013 15:11:27 +0200
Message-ID: <1895563.95T8SxMegu@vostro.rjw.lan>
References: <10433383.dueoNg39qi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <10433383.dueoNg39qi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify acpi_device_set_power() so that diagnostic messages printed by
it to the kernel log always contain the name of the device concerned
to make it possible to identify the device that triggered the message
if need be.

Also replace printk(KERN_WARNING ) with dev_warn() everywhere in that
function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -166,20 +166,20 @@ int acpi_device_set_power(struct acpi_de
 	/* Make sure this is a valid target state */
 
 	if (state == device->power.state) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at %s\n",
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] already in %s\n",
+				  device->pnp.bus_id,
 				  acpi_power_state_string(state)));
 		return 0;
 	}
 
 	if (!device->power.states[state].flags.valid) {
-		printk(KERN_WARNING PREFIX "Device does not support %s\n",
-		       acpi_power_state_string(state));
+		dev_warn(&device->dev, "Power state %s not supported\n",
+			 acpi_power_state_string(state));
 		return -ENODEV;
 	}
 	if (device->parent && (state < device->parent->power.state)) {
-		printk(KERN_WARNING PREFIX
-			      "Cannot set device to a higher-powered"
-			      " state than parent\n");
+		dev_warn(&device->dev, "Cannot transition to a higher-powered "
+			 "state than parent\n");
 		return -ENODEV;
 	}
 
@@ -192,8 +192,8 @@ int acpi_device_set_power(struct acpi_de
 
 	if (state < device->power.state && state != ACPI_STATE_D0
 	    && device->power.state >= ACPI_STATE_D3_HOT) {
-		printk(KERN_WARNING PREFIX
-			"Cannot transition to non-D0 state from D3\n");
+		dev_warn(&device->dev,
+			 "Cannot transition to non-D0 state from D3\n");
 		return -ENODEV;
 	}
 
@@ -220,10 +220,8 @@ int acpi_device_set_power(struct acpi_de
 
  end:
 	if (result) {
-		printk(KERN_WARNING PREFIX
-			      "Device [%s] failed to transition to %s\n",
-			      device->pnp.bus_id,
-			      acpi_power_state_string(state));
+		dev_warn(&device->dev, "Failed to change power state to %s\n",
+			 acpi_power_state_string(state));
 	} else {
 		device->power.state = state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,

