From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] power: supply: axp288_fuel_gauge: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Thu, 22 Nov 2018 09:25:51 -0500
Message-ID: <20181122142551.25367-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, hdegoede@redhat.com, wens@csie.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 084c8ba9749d..9ff2461820d8 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -307,22 +307,12 @@ static int fuel_gauge_debug_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fuel_gauge_debug_show, inode->i_private);
-}
-
-static const struct file_operations fg_debug_fops = {
-	.open       = debug_open,
-	.read       = seq_read,
-	.llseek     = seq_lseek,
-	.release    = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fuel_gauge_debug);
 
 static void fuel_gauge_create_debugfs(struct axp288_fg_info *info)
 {
 	info->debug_file = debugfs_create_file("fuelgauge", 0666, NULL,
-		info, &fg_debug_fops);
+		info, &fuel_gauge_debug_fops);
 }
 
 static void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
-- 
2.17.0
