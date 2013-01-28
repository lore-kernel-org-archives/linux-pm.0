From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 1/2] ACPI/Sleep: Add init_nvs_nosave_s3() function
Date: Mon, 28 Jan 2013 15:47:04 +0800
Message-ID: <1359359225-28223-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30048 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab3A1HtR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jan 2013 02:49:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: Lan Tianyu <tianyu.lan@intel.com>, stern@rowland.harvard.edu, swilmet@gnome.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

commit 1bad2f19f7f7 introduces nvs_nosave_s3 flag to just ban
saving nvs in ths s3 rather than both of s3 and s4. This patch
is to add init_nvs_nosave_s3() to set nvs_nosave_s3 to true for
those machines in the nonvs blacklist which only don't need to
saving nvs during s3 rather than both s3 and s4.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/sleep.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2fcc67d..405b962 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -141,6 +141,12 @@ static int __init init_nvs_nosave(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init init_nvs_nosave_s3(const struct dmi_system_id *d)
+{
+	acpi_nvs_nosave_s3();
+	return 0;
+}
+
 static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{
 	.callback = init_old_suspend_ordering,
-- 
1.7.10.4

