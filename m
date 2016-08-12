From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [v.1] power:reset:hisi-reboot :- Unmap a region obtained by remap.
Date: Fri, 12 Aug 2016 20:49:18 +0530
Message-ID: <1471015158-6132-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-pm@vger.kernel.org

iounmap frees the mapping when failed to find reboot-offset property
and cannot register restart handler.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/power/reset/hisi-reboot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hisi-reboot.c
index 9ab7f56..f69387e 100644
--- a/drivers/power/reset/hisi-reboot.c
+++ b/drivers/power/reset/hisi-reboot.c
@@ -53,13 +53,16 @@ static int hisi_reboot_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(np, "reboot-offset", &reboot_offset) < 0) {
 		pr_err("failed to find reboot-offset property\n");
+		iounmap(base);
 		return -EINVAL;
 	}
 
 	err = register_restart_handler(&hisi_restart_nb);
-	if (err)
+	if (err) {
 		dev_err(&pdev->dev, "cannot register restart handler (err=%d)\n",
 			err);
+		iounmap(base);
+	}
 
 	return err;
 }
-- 
2.7.4
