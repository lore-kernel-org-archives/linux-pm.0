From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/38] pm: ctcm driver power management callbacks
Date: Thu, 04 Jun 2009 18:19:05 +0200
Message-ID: <20090604161903.765486755__11102.1533878104$1244139283$gmane$org@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=pm_ctcm.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/net/ctcm_main.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/s390/net/ctcm_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/ctcm_main.c
+++ linux-2.6/drivers/s390/net/ctcm_main.c
@@ -1,7 +1,7 @@
 /*
  * drivers/s390/net/ctcm_main.c
  *
- * Copyright IBM Corp. 2001, 2007
+ * Copyright IBM Corp. 2001, 2009
  * Author(s):
  *	Original CTC driver(s):
  *		Fritz Elfert (felfert@millenux.com)
@@ -1690,6 +1690,38 @@ static void ctcm_remove_device(struct cc
 	put_device(&cgdev->dev);
 }
 
+static int ctcm_pm_suspend(struct ccwgroup_device *gdev)
+{
+	struct ctcm_priv *priv = dev_get_drvdata(&gdev->dev);
+
+	if (gdev->state == CCWGROUP_OFFLINE)
+		return 0;
+	netif_device_detach(priv->channel[READ]->netdev);
+	ctcm_close(priv->channel[READ]->netdev);
+	ccw_device_set_offline(gdev->cdev[1]);
+	ccw_device_set_offline(gdev->cdev[0]);
+	return 0;
+}
+
+static int ctcm_pm_resume(struct ccwgroup_device *gdev)
+{
+	struct ctcm_priv *priv = dev_get_drvdata(&gdev->dev);
+	int rc;
+
+	if (gdev->state == CCWGROUP_OFFLINE)
+		return 0;
+	rc = ccw_device_set_online(gdev->cdev[1]);
+	if (rc)
+		goto err_out;
+	rc = ccw_device_set_online(gdev->cdev[0]);
+	if (rc)
+		goto err_out;
+	ctcm_open(priv->channel[READ]->netdev);
+err_out:
+	netif_device_attach(priv->channel[READ]->netdev);
+	return rc;
+}
+
 static struct ccwgroup_driver ctcm_group_driver = {
 	.owner       = THIS_MODULE,
 	.name        = CTC_DRIVER_NAME,
@@ -1699,6 +1731,9 @@ static struct ccwgroup_driver ctcm_group
 	.remove      = ctcm_remove_device,
 	.set_online  = ctcm_new_device,
 	.set_offline = ctcm_shutdown_device,
+	.freeze	     = ctcm_pm_suspend,
+	.thaw	     = ctcm_pm_resume,
+	.restore     = ctcm_pm_resume,
 };
 
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
