From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/2] ACPI/Sleep: use init_nvs_nosave_s3() for Sony Vaio VPCCW29FX and VPCEB1S1E  callback in the non-nvs blacklist
Date: Mon, 28 Jan 2013 15:47:05 +0800
Message-ID: <1359359225-28223-2-git-send-email-tianyu.lan@intel.com>
References: <1359359225-28223-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1359359225-28223-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: Lan Tianyu <tianyu.lan@intel.com>, stern@rowland.harvard.edu, swilmet@gnome.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sony Vaio VPCCW29FX and VPCEB1S1E just need to ban saving
nvs during s3 rather than both s3 and s4. So this patch is
to set their callbacks to be init_nvs_nosave_s3().

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/sleep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 405b962..ee33a9a 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -230,7 +230,7 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		},
 	},
 	{
-	.callback = init_nvs_nosave,
+	.callback = init_nvs_nosave_s3,
 	.ident = "Sony Vaio VPCCW29FX",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
@@ -270,7 +270,7 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		},
 	},
 	{
-	.callback = init_nvs_nosave,
+	.callback = init_nvs_nosave_s3,
 	.ident = "Sony Vaio VPCEB1S1E",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-- 
1.7.10.4

