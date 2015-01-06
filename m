From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] thermal: rcar: change type of ctemp in rcar_thermal_update_temp()
Date: Tue, 6 Jan 2015 19:02:08 +0900
Message-ID: <1420538528-5236-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:8881 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752716AbbAFKCZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 05:02:25 -0500
In-Reply-To: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the ctemp is used for rcar_thermal_write() in
rcar_thermal_update_temp(), the type of ctemp should be "u32" instead
of "int".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/thermal/rcar_thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index bbdf64e..6dcead1 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -63,7 +63,7 @@ struct rcar_thermal_priv {
 	struct mutex lock;
 	struct list_head list;
 	int id;
-	int ctemp;
+	u32 ctemp;
 };
 
 #define rcar_thermal_for_each_priv(pos, common)	\
@@ -145,7 +145,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 {
 	struct device *dev = rcar_priv_to_dev(priv);
 	int i;
-	int ctemp, old, new;
+	u32 ctemp, old, new;
 	int ret = -EINVAL;
 
 	mutex_lock(&priv->lock);
-- 
1.7.9.5

