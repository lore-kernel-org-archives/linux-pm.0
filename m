From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/2] PM / sleep: Clear pm_suspend_global_flags upon hibernate
Date: Wed, 23 Mar 2016 00:11:20 +0100
Message-ID: <cf0a2955536f342ee58ddbee16c18cde5f59fc66.1458641423.git.lukas@wunner.de>
References: <cover.1458641423.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1458641423.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When suspending to RAM, waking up and later suspending to disk,
we gratuitously runtime resume devices after the thaw phase.
This does not occur if we always suspend to RAM or always to disk.

pm_complete_with_resume_check(), which gets called from
pci_pm_complete() among others, schedules a runtime resume
if PM_SUSPEND_FLAG_FW_RESUME is set. The flag is set during
a suspend-to-RAM cycle. It is cleared at the beginning of
the suspend-to-RAM cycle but not afterwards and it is not
cleared during a suspend-to-disk cycle at all. Fix it.

Fixes: ef25ba047601 ("PM / sleep: Add flags to indicate platform
    firmware involvement")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 kernel/power/hibernate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index aa0f26b..fca9254 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -339,6 +339,7 @@ int hibernation_snapshot(int platform_mode)
 	pm_message_t msg;
 	int error;
 
+	pm_suspend_clear_flags();
 	error = platform_begin(platform_mode);
 	if (error)
 		goto Close;
-- 
1.8.5.2 (Apple Git-48)

