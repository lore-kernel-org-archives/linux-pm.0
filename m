From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [FIX PATCH v2] acpi/video_detect: Add "Asus UL30VT" to acpi video detect blacklist
Date: Thu, 29 Nov 2012 14:28:06 +0800
Message-ID: <1354170486-28710-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The ACPI video driver can't control backlight correctly on Asus UL30VT.
Vender driver(asus-laptop) can work. This patch is to add "Asus UL30VT"
to acpi video detect blacklist in order to use vender driver for video
control on the "Asus UL30VT" rather than ACPI video driver.

https://bugzilla.kernel.org/show_bug.cgi?id=32592

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
	fix a typo in the changelog. add Cc stable and reporter.
---
 drivers/acpi/video_detect.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b728880..4ac2593 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -156,6 +156,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "X360"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	.ident = "Asus UL30VT",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "UL30VT"),
+		},
+	},
 	{ },
 };
 
-- 
1.7.9.5

