From: Ross Zwisler <zwisler@google.com>
Subject: [PATCH 2/2] gsmi: Log event for critical thermal thresholds
Date: Mon, 22 Oct 2018 14:32:18 -0600
Message-ID: <20181022203218.7007-2-zwisler@google.com>
References: <20181022203218.7007-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022203218.7007-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Duncan Laurie <dlaurie@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Ross Zwisler <zwisler@google.com>
List-Id: linux-pm@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

This registers a notifier for the new thermal notifier
introduced in a previous commit and logs a kernel shutdown
event when the notifier is called for crossing the
THERMAL_TRIP_CRITICAL threshold.

To test:
1) Modify critical shutdown threshold in the BIOS
2) Generate a load on the system to increase temperature
3) Wait until system powers off
4) Power back on and read the event log:

4 | 2012-07-18 10:47:02 | Kernel Event | Critical Thermal Threshold
5 | 2012-07-18 10:47:06 | Kernel Event | Clean Shutdown
6 | 2012-07-18 10:47:06 | ACPI Enter | S5

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
[ rez: updated changelog for upstream ]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/firmware/google/gsmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index c8f169bf2e27d..ee0c611b83e99 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -29,6 +29,7 @@
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ucs2_string.h>
+#include <linux/thermal.h>
 
 #define GSMI_SHUTDOWN_CLEAN	0	/* Clean Shutdown */
 /* TODO(mikew@google.com): Tie in HARDLOCKUP_DETECTOR with NMIWDT */
@@ -40,6 +41,7 @@
 #define GSMI_SHUTDOWN_SOFTWDT	6	/* Software Watchdog */
 #define GSMI_SHUTDOWN_MBE	7	/* Uncorrected ECC */
 #define GSMI_SHUTDOWN_TRIPLE	8	/* Triple Fault */
+#define GSMI_SHUTDOWN_THERMAL	9	/* Critical Thermal Threshold */
 
 #define DRIVER_VERSION		"1.0"
 #define GSMI_GUID_SIZE		16
@@ -670,6 +672,18 @@ static struct notifier_block gsmi_panic_notifier = {
 	.notifier_call = gsmi_panic_callback,
 };
 
+static int gsmi_thermal_callback(struct notifier_block *nb,
+				 unsigned long reason, void *arg)
+{
+	if (reason == THERMAL_TRIP_CRITICAL)
+		gsmi_shutdown_reason(GSMI_SHUTDOWN_THERMAL);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block gsmi_thermal_notifier = {
+	.notifier_call = gsmi_thermal_callback
+};
+
 /*
  * This hash function was blatantly copied from include/linux/hash.h.
  * It is used by this driver to obfuscate a board name that requires a
@@ -892,6 +906,7 @@ static __init int gsmi_init(void)
 		goto out_remove_sysfs_files;
 	}
 
+	register_thermal_notifier(&gsmi_thermal_notifier);
 	register_reboot_notifier(&gsmi_reboot_notifier);
 	register_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -918,6 +933,7 @@ static __init int gsmi_init(void)
 
 static void __exit gsmi_exit(void)
 {
+	unregister_thermal_notifier(&gsmi_thermal_notifier);
 	unregister_reboot_notifier(&gsmi_reboot_notifier);
 	unregister_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
-- 
2.19.1.568.g152ad8e336-goog
