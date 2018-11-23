From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal/intel_powerclamp: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Fri, 23 Nov 2018 09:55:22 -0500
Message-ID: <20181123145523.27248-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/intel_powerclamp.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index cde891c54cde..7571f7c2e7c9 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -708,19 +708,7 @@ static int powerclamp_debug_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int powerclamp_debug_open(struct inode *inode,
-			struct file *file)
-{
-	return single_open(file, powerclamp_debug_show, inode->i_private);
-}
-
-static const struct file_operations powerclamp_debug_fops = {
-	.open		= powerclamp_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(powerclamp_debug);
 
 static inline void powerclamp_create_debug_files(void)
 {
-- 
2.17.0
