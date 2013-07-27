From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] ACPI / PM: Only set power states of devices that are power manageable
Date: Sat, 27 Jul 2013 15:10:52 +0200
Message-ID: <1657971.1utElu0Hzo@vostro.rjw.lan>
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

Make acpi_device_set_power() check if the given device is power
manageable before checking if the given power state is valid for that
device.  Otherwise it will print that "Device does not support" that
power state into the kernel log, which may not make sense for some
power states (D0 and D3cold are supported by all devices by
definition).

Tested-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -159,7 +159,8 @@ int acpi_device_set_power(struct acpi_de
 	int result = 0;
 	bool cut_power = false;
 
-	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
+	if (!device || !device->flags.power_manageable
+	    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
 		return -EINVAL;
 
 	/* Make sure this is a valid target state */

