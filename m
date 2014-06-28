From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] drivers/power/avs/smartreflex.c: remove unnecessary null test before debugfs_remove_recursive
Date: Sat, 28 Jun 2014 14:33:19 +0200
Message-ID: <1403958799-4692-1-git-send-email-fabf@skynet.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:64638 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545AbaF1Mel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Jun 2014 08:34:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org

Fix checkpatch warning:
WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/power/avs/smartreflex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index db9973b..ecc5979 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1001,8 +1001,7 @@ static int omap_sr_remove(struct platform_device *pdev)
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
-	if (sr_info->dbg_dir)
-		debugfs_remove_recursive(sr_info->dbg_dir);
+	debugfs_remove_recursive(sr_info->dbg_dir);
 
 	pm_runtime_disable(&pdev->dev);
 	list_del(&sr_info->node);
-- 
1.8.4.5

