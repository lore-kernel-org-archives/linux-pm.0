From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal: tegra: soctherm: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Fri, 23 Nov 2018 09:50:58 -0500
Message-ID: <20181123145058.27115-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, keescook@chromium.org, nicoleotsuka@gmail.com, ezequiel@collabora.com, srplinux2008@gmail.com
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..45b41b885f49 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -803,17 +803,7 @@ static int regs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, regs_show, inode->i_private);
-}
-
-static const struct file_operations regs_fops = {
-	.open		= regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(regs);
 
 static void soctherm_debug_init(struct platform_device *pdev)
 {
-- 
2.17.0
