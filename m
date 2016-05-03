From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] drivers: acpi: add CPU id to cooling device type of processor driver
Date: Mon,  2 May 2016 22:04:39 -0700
Message-ID: <1462251879-7224-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, in an ACPI based system, the processor driver registers
one cooling device per processor. However, the cooling device type
is the same for each processor. For example, on a system with four
processors, the sysfs reading of each cooling device would look like:
ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
Processor
Processor
Processor
Processor

which turns out to fine. But, some parts of the thermal code may use
type to identify participating devices in a thermal zone. Besides,
adding notifications to user space may cause the production of messages
that may confuse the listener.

For this reason, this patch adds the processor ID cooling device type.
After this change, the cooling device listing in the same previous example
would look like this:
ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
Processor.0
Processor.1
Processor.2
Processor.3

allowing an easier identification of cooling device target.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/acpi/processor_driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d2fa8cb..6e982c1 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -163,6 +163,7 @@ static struct notifier_block acpi_cpu_notifier = {
 static int acpi_pss_perf_init(struct acpi_processor *pr,
 		struct acpi_device *device)
 {
+	char cdev_name[THERMAL_NAME_LENGTH];
 	int result = 0;
 
 	acpi_processor_ppc_has_changed(pr, 0);
@@ -172,7 +173,8 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
 	if (pr->flags.throttling)
 		pr->flags.limit = 1;
 
-	pr->cdev = thermal_cooling_device_register("Processor", device,
+	snprintf(cdev_name, sizeof(cdev_name), "Processor.%d", pr->id);
+	pr->cdev = thermal_cooling_device_register(cdev_name, device,
 						   &processor_cooling_ops);
 	if (IS_ERR(pr->cdev)) {
 		result = PTR_ERR(pr->cdev);
-- 
2.1.4

