From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/2] thermal: rcar: change type of ctemp in rcar_thermal_update_temp()
Date: Wed, 7 Jan 2015 10:13:11 +0900
Message-ID: <1420593191-3736-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org

Since the ctemp is used for rcar_thermal_write() in
rcar_thermal_update_temp(), the type of 'ctemp' should be "u32" instead
of "int". This patch also changes type of the helper variables 'old'
and 'new'.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 2f3b4ff..70bb02c 100644
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

