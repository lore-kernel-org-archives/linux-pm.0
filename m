From: Alan <alan@linux.intel.com>
Subject: [PATCH 2/2] goldfish: Enable ACPI-based enumeration for goldfish
 battery
Date: Fri, 26 Feb 2016 18:45:50 +0000
Message-ID: <20160226184541.2962.40016.stgit@localhost.localdomain>
References: <20160226184455.2962.92705.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54578 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbcBZSqT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 13:46:19 -0500
In-Reply-To: <20160226184455.2962.92705.stgit@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dbaryshkov@gmail.com, dwmw2@infradead.org, sre@kernel.org, linux-pm@vger.kernel.org

From: Yu Ning <yu.ning@intel.com>

Besides adding ACPI bindings to the goldfish battery driver, modify the
ACPI driver to inform it that goldfish battery is a platform device.
The latter step is necessary with kernel 3.16 or newer.

Signed-off-by: Yu Ning <yu.ning@intel.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan <alan@linux.intel.com>
---
 drivers/power/goldfish_battery.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/goldfish_battery.c b/drivers/power/goldfish_battery.c
index 7510796..f5c525e 100644
--- a/drivers/power/goldfish_battery.c
+++ b/drivers/power/goldfish_battery.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/acpi.h>
 
 struct goldfish_battery_data {
 	void __iomem *reg_base;
@@ -233,12 +234,19 @@ static const struct of_device_id goldfish_battery_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, goldfish_battery_of_match);
 
+static const struct acpi_device_id goldfish_battery_acpi_match[] = {
+	{ "GFSH0001", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, goldfish_battery_acpi_match);
+
 static struct platform_driver goldfish_battery_device = {
 	.probe		= goldfish_battery_probe,
 	.remove		= goldfish_battery_remove,
 	.driver = {
 		.name = "goldfish-battery",
 		.of_match_table = goldfish_battery_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_battery_acpi_match),
 	}
 };
 module_platform_driver(goldfish_battery_device);

