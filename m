From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/38] pm: zfcp driver power management callbacks
Date: Thu, 04 Jun 2009 18:19:07 +0200
Message-ID: <20090604161904.378820936__27537.7395134003$1244139414$gmane$org@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=pm_zfcp.patch
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
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Petermann <martin.petermann@de.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: Martin Petermann <martin.petermann@de.ibm.com>

Signed-off-by: Martin Petermann <martin.petermann@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/scsi/zfcp_ccw.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Index: linux-2.6/drivers/s390/scsi/zfcp_ccw.c
===================================================================
--- linux-2.6.orig/drivers/s390/scsi/zfcp_ccw.c
+++ linux-2.6/drivers/s390/scsi/zfcp_ccw.c
@@ -199,6 +199,36 @@ static void zfcp_ccw_shutdown(struct ccw
 	up(&zfcp_data.config_sema);
 }
 
+static int zfcp_ccw_suspend(struct ccw_device *cdev)
+
+{
+	struct zfcp_adapter *adapter = dev_get_drvdata(&cdev->dev);
+
+	down(&zfcp_data.config_sema);
+
+	zfcp_erp_adapter_shutdown(adapter, 0, "ccsusp1", NULL);
+	zfcp_erp_wait(adapter);
+
+	up(&zfcp_data.config_sema);
+
+	return 0;
+}
+
+static int zfcp_ccw_activate(struct ccw_device *cdev)
+
+{
+	struct zfcp_adapter *adapter = dev_get_drvdata(&cdev->dev);
+
+	zfcp_erp_modify_adapter_status(adapter, "ccresu1", NULL,
+				       ZFCP_STATUS_COMMON_RUNNING, ZFCP_SET);
+	zfcp_erp_adapter_reopen(adapter, ZFCP_STATUS_COMMON_ERP_FAILED,
+				"ccresu2", NULL);
+	zfcp_erp_wait(adapter);
+	flush_work(&adapter->scan_work);
+
+	return 0;
+}
+
 static struct ccw_device_id zfcp_ccw_device_id[] = {
 	{ CCW_DEVICE_DEVTYPE(0x1731, 0x3, 0x1732, 0x3) },
 	{ CCW_DEVICE_DEVTYPE(0x1731, 0x3, 0x1732, 0x4) }, /* priv. */
@@ -217,6 +247,9 @@ static struct ccw_driver zfcp_ccw_driver
 	.set_offline = zfcp_ccw_set_offline,
 	.notify      = zfcp_ccw_notify,
 	.shutdown    = zfcp_ccw_shutdown,
+	.freeze      = zfcp_ccw_suspend,
+	.thaw        = zfcp_ccw_activate,
+	.restore     = zfcp_ccw_activate,
 };
 
 /**

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
