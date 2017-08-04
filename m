From: Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] intel-vbtn: match power button on press rather than release
Date: Fri,  4 Aug 2017 12:00:06 -0500
Message-ID: <1501866006-24811-1-git-send-email-mario.limonciello@dell.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>, dvhart@infradead.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

This fixes a problem where the system gets stuck in a loop
unable to wakeup via power button in s2idle.

The problem happens because:
 - press power button:
   - system emits 0xc0 (power press), event ignored
   - system emits 0xc1 (power release), event processed,
     emited as KEY_POWER
   - set wakeup_mode to true
   - system goes to s2idle
 - press power button
   - system emits 0xc0 (power press), wakeup_mode is true,
     system wakes
   - system emits 0xc1 (power release), event processed,
     emited as KEY_POWER
   - system goes to s2idle again

To avoid this situation, process the presses (which matches what
intel-hid does too).

Verified on an Dell XPS 9365

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/intel-vbtn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 61f1063..4809267 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -36,8 +36,8 @@ static const struct acpi_device_id intel_vbtn_ids[] = {
 
 /* In theory, these are HID usages. */
 static const struct key_entry intel_vbtn_keymap[] = {
-	{ KE_IGNORE, 0xC0, { KEY_POWER } },	/* power key press */
-	{ KE_KEY, 0xC1, { KEY_POWER } },	/* power key release */
+	{ KE_KEY, 0xC0, { KEY_POWER } },	/* power key press */
+	{ KE_IGNORE, 0xC1, { KEY_POWER } },	/* power key release */
 	{ KE_KEY, 0xC4, { KEY_VOLUMEUP } },		/* volume-up key press */
 	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
 	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
-- 
2.7.4
