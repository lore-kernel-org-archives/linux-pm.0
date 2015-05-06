From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFC 4/5] ACPI / processor_idle: replace PREFIX with pr_fmt
Date: Wed,  6 May 2015 15:31:29 +0100
Message-ID: <1430922690-6966-5-git-send-email-sudeep.holla@arm.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Like few of the other ACPI modules, replace PREFIX with pr_fmt and
change all the printk call sites to use pr_* companion functions
in processor_idle.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/processor_idle.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 38bdbf36bf4e..866179651dd9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -27,6 +27,7 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
+#define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/module.h>
 #include <linux/acpi.h>
@@ -46,8 +47,6 @@
 #include <asm/apic.h>
 #endif
 
-#define PREFIX "ACPI: "
-
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
@@ -84,9 +83,9 @@ static int set_max_cstate(const struct dmi_system_id *id)
 	if (max_cstate > ACPI_PROCESSOR_MAX_POWER)
 		return 0;
 
-	printk(KERN_NOTICE PREFIX "%s detected - limiting to C%ld max_cstate."
-	       " Override with \"processor.max_cstate=%d\"\n", id->ident,
-	       (long)id->driver_data, ACPI_PROCESSOR_MAX_POWER + 1);
+	pr_notice("%s detected - limiting to C%ld max_cstate."
+		  " Override with \"processor.max_cstate=%d\"\n", id->ident,
+		  (long)id->driver_data, ACPI_PROCESSOR_MAX_POWER + 1);
 
 	max_cstate = (long)id->driver_data;
 
@@ -318,7 +317,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 
 	/* There must be at least 2 elements */
 	if (!cst || (cst->type != ACPI_TYPE_PACKAGE) || cst->package.count < 2) {
-		printk(KERN_ERR PREFIX "not enough elements in _CST\n");
+		pr_err("not enough elements in _CST\n");
 		ret = -EFAULT;
 		goto end;
 	}
@@ -327,7 +326,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 
 	/* Validate number of power states. */
 	if (count < 1 || count != cst->package.count - 1) {
-		printk(KERN_ERR PREFIX "count given by _CST is not valid\n");
+		pr_err("count given by _CST is not valid\n");
 		ret = -EFAULT;
 		goto end;
 	}
@@ -436,11 +435,9 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		 * (From 1 through ACPI_PROCESSOR_MAX_POWER - 1)
 		 */
 		if (current_count >= (ACPI_PROCESSOR_MAX_POWER - 1)) {
-			printk(KERN_WARNING
-			       "Limiting number of power states to max (%d)\n",
-			       ACPI_PROCESSOR_MAX_POWER);
-			printk(KERN_WARNING
-			       "Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
+			pr_warn("Limiting number of power states to max (%d)\n",
+				ACPI_PROCESSOR_MAX_POWER);
+			pr_warn("Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
 			break;
 		}
 	}
@@ -1064,8 +1061,8 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 			retval = cpuidle_register_driver(&acpi_idle_driver);
 			if (retval)
 				return retval;
-			printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
-					acpi_idle_driver.name);
+			pr_debug("%s registered with cpuidle\n",
+				 acpi_idle_driver.name);
 		}
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-- 
1.9.1
