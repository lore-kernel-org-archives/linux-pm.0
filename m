From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ACPI / cpuidle: remove superfluous pr == NULL checks
Date: Fri, 30 Aug 2013 12:30:51 +0200
Message-ID: <5858980.cRdNx0rNzu@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The only acpi_processor_get_power_info_fadt() user
(acpi_processor_get_power_info()) dereferences pr before calling
the function.

The only acpi_processor_hotplug() user (acpi_cpu_soft_notify())
checks for pr == NULL before calling the function.

The only acpi_processor_cst_has_changed() user (acpi_processor_notify())
checks for pr == NULL before calling the function.

The only acpi_processor_power_init() user (__acpi_processor_start())
dereferences pr before calling the function.

Thus remove superfluous pr == NULL checks from affected functions.

Also:

While at it remove redundant brackets from acpi_processor_hotplug().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/processor_idle.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f98dd00..35c8f2b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -272,9 +272,6 @@ static void tsc_check_state(int state) { return; }
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 {
 
-	if (!pr)
-		return -EINVAL;
-
 	if (!pr->pblk)
 		return -ENODEV;
 
@@ -1076,12 +1073,8 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
 	if (disabled_by_idle_boot_param())
 		return 0;
 
-	if (!pr)
-		return -EINVAL;
-
-	if (nocst) {
+	if (nocst)
 		return -ENODEV;
-	}
 
 	if (!pr->flags.power_setup_done)
 		return -ENODEV;
@@ -1108,9 +1101,6 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 	if (disabled_by_idle_boot_param())
 		return 0;
 
-	if (!pr)
-		return -EINVAL;
-
 	if (nocst)
 		return -ENODEV;
 
@@ -1183,9 +1173,6 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		first_run++;
 	}
 
-	if (!pr)
-		return -EINVAL;
-
 	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status =
 		    acpi_os_write_port(acpi_gbl_FADT.smi_command, acpi_gbl_FADT.cst_control, 8);
-- 
1.8.2.3


