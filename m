From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/6] ideapad_laptop: introduce #ifdef CONFIG_PM_SLEEP for PM specific code
Date: Mon, 23 Sep 2013 15:50:47 +0800
Message-ID: <1379922651-5578-3-git-send-email-rui.zhang@intel.com>
References: <1379922651-5578-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1379922651-5578-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

ideapad_acpi_resume() and ideapad_pm is meaningful
only if CONFIG_PM_SLEEP is set.
Thus introduce #ifdef for this piece of code.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Ike Panhc <ike.pan@canonical.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/ideapad-laptop.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 89c4519..5021c55 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -901,6 +901,7 @@ static void ideapad_acpi_notify(struct acpi_device *adevice, u32 event)
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int ideapad_acpi_resume(struct device *device)
 {
 	ideapad_sync_rfk_state(ideapad_priv);
@@ -909,6 +910,7 @@ static int ideapad_acpi_resume(struct device *device)
 }
 
 static SIMPLE_DEV_PM_OPS(ideapad_pm, NULL, ideapad_acpi_resume);
+#endif
 
 static struct acpi_driver ideapad_acpi_driver = {
 	.name = "ideapad_acpi",
@@ -917,7 +919,9 @@ static struct acpi_driver ideapad_acpi_driver = {
 	.ops.add = ideapad_acpi_add,
 	.ops.remove = ideapad_acpi_remove,
 	.ops.notify = ideapad_acpi_notify,
+#ifdef CONFIG_PM_SLEEP
 	.drv.pm = &ideapad_pm,
+#endif
 	.owner = THIS_MODULE,
 };
 module_acpi_driver(ideapad_acpi_driver);
-- 
1.7.9.5
