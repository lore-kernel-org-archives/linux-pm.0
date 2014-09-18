From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 12/19] ACPI / Fan: support INT3404 thermal device
Date: Thu, 18 Sep 2014 09:53:43 +0800
Message-ID: <1411005230-2227-13-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Aaron Lu <aaron.lu@intel.com>

INT3404 ACPI object follows the ACPI 5.0 fan object definition as
described in section 11.3 of the ACPI 5.0 Specification.
Thus we can reuse the ACPI fan driver for INT3404 ACPI object.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f7d1c80..e007c49 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -42,6 +42,7 @@ static int acpi_fan_remove(struct platform_device *pdev);
 
 static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
+	{"INT3404", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
-- 
1.8.3.2

