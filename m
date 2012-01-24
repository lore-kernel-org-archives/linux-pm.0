From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/10] ACPI / PM: Add Sony Vaio VPCCW29FX to nonvs blacklist.
Date: Mon, 23 Jan 2012 20:30:05 -0500
Message-ID: <93f770846e8dedc5d9117bd4ad9d7efd18420627.1327368464.git.len.brown@intel.com>
References: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1327368609-28409-1-git-send-email-lenb@kernel.org>
In-reply-to: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
References: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

Sony Vaio VPCCW29FX does not resume correctly without
acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.

https://bugzilla.kernel.org/show_bug.cgi?id=34722

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 0a7ed69..ca191ff 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -438,6 +438,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	},
 	{
 	.callback = init_nvs_nosave,
+	.ident = "Sony Vaio VPCCW29FX",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCCW29FX"),
+		},
+	},
+	{
+	.callback = init_nvs_nosave,
 	.ident = "Averatec AV1020-ED2",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "AVERATEC"),
-- 
1.7.9.rc2

