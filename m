From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] PM / yenta: Fix cardbus suspend/resume
	regression
Date: Sat, 26 Sep 2009 01:26:48 +0200
Message-ID: <200909260126.48896.rjw__18262.3239736587$1253921382$gmane$org@sisk.pl>
References: <200909260122.59030.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909260122.59030.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Florian <fs-kernelbugzilla@spline.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since 2.6.29 the PCI PM core have been restoring the standard
configuration registers of PCI devices in the early phase of
resume.  In particular, PCI devices without drivers have been handled
this way since commit 355a72d75b3b4f4877db4c9070c798238028ecb5
(PCI: Rework default handling of suspend and resume).  Unfortunately,
this leads to post-resume problems with CardBus devices which cannot
be accessed in the early phase of resume, because the sockets they
are on have not been woken up yet at that point.

To solve this problem, move the yenta socket resume to the early
phase of resume and, analogously, move the suspend of it to the late
phase of suspend.  Additionally, remove some unnecessary PCI code
from the yenta socket's resume routine.

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=13092, which is a
post-2.6.28 regression.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Florian <fs-kernelbugzilla@spline.de>
---
 drivers/pcmcia/yenta_socket.c |   92 ++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

Index: linux-2.6-stable/drivers/pcmcia/yenta_socket.c
===================================================================
--- linux-2.6-stable.orig/drivers/pcmcia/yenta_socket.c
+++ linux-2.6-stable/drivers/pcmcia/yenta_socket.c
@@ -1225,60 +1225,71 @@ static int __devinit yenta_probe (struct
 }
 
 #ifdef CONFIG_PM
-static int yenta_dev_suspend (struct pci_dev *dev, pm_message_t state)
+static int yenta_dev_suspend_noirq(struct device *dev)
 {
-	struct yenta_socket *socket = pci_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct yenta_socket *socket = pci_get_drvdata(pdev);
 	int ret;
 
-	ret = pcmcia_socket_dev_suspend(&dev->dev, state);
+	ret = pcmcia_socket_dev_suspend(dev);
 
-	if (socket) {
-		if (socket->type && socket->type->save_state)
-			socket->type->save_state(socket);
-
-		/* FIXME: pci_save_state needs to have a better interface */
-		pci_save_state(dev);
-		pci_read_config_dword(dev, 16*4, &socket->saved_state[0]);
-		pci_read_config_dword(dev, 17*4, &socket->saved_state[1]);
-		pci_disable_device(dev);
-
-		/*
-		 * Some laptops (IBM T22) do not like us putting the Cardbus
-		 * bridge into D3.  At a guess, some other laptop will
-		 * probably require this, so leave it commented out for now.
-		 */
-		/* pci_set_power_state(dev, 3); */
-	}
+	if (!socket)
+		return ret;
+
+	if (socket->type && socket->type->save_state)
+		socket->type->save_state(socket);
+
+	pci_save_state(pdev);
+	pci_read_config_dword(pdev, 16*4, &socket->saved_state[0]);
+	pci_read_config_dword(pdev, 17*4, &socket->saved_state[1]);
+	pci_disable_device(pdev);
+
+	/*
+	 * Some laptops (IBM T22) do not like us putting the Cardbus
+	 * bridge into D3.  At a guess, some other laptop will
+	 * probably require this, so leave it commented out for now.
+	 */
+	/* pci_set_power_state(dev, 3); */
 
 	return ret;
 }
 
-
-static int yenta_dev_resume (struct pci_dev *dev)
+static int yenta_dev_resume_noirq(struct device *dev)
 {
-	struct yenta_socket *socket = pci_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct yenta_socket *socket = pci_get_drvdata(pdev);
+	int ret;
 
-	if (socket) {
-		int rc;
+	if (!socket)
+		return 0;
 
-		pci_set_power_state(dev, 0);
-		/* FIXME: pci_restore_state needs to have a better interface */
-		pci_restore_state(dev);
-		pci_write_config_dword(dev, 16*4, socket->saved_state[0]);
-		pci_write_config_dword(dev, 17*4, socket->saved_state[1]);
+	pci_write_config_dword(pdev, 16*4, socket->saved_state[0]);
+	pci_write_config_dword(pdev, 17*4, socket->saved_state[1]);
 
-		rc = pci_enable_device(dev);
-		if (rc)
-			return rc;
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
 
-		pci_set_master(dev);
+	pci_set_master(pdev);
 
-		if (socket->type && socket->type->restore_state)
-			socket->type->restore_state(socket);
-	}
+	if (socket->type && socket->type->restore_state)
+		socket->type->restore_state(socket);
 
-	return pcmcia_socket_dev_resume(&dev->dev);
+	return pcmcia_socket_dev_resume(dev);
 }
+
+static struct dev_pm_ops yenta_pm_ops = {
+	.suspend_noirq = yenta_dev_suspend_noirq,
+	.resume_noirq = yenta_dev_resume_noirq,
+	.freeze_noirq = yenta_dev_suspend_noirq,
+	.thaw_noirq = yenta_dev_resume_noirq,
+	.poweroff_noirq = yenta_dev_suspend_noirq,
+	.restore_noirq = yenta_dev_resume_noirq,
+};
+
+#define YENTA_PM_OPS	(&yenta_pm_ops)
+#else
+#define YENTA_PM_OPS	NULL
 #endif
 
 #define CB_ID(vend,dev,type)				\
@@ -1376,10 +1387,7 @@ static struct pci_driver yenta_cardbus_d
 	.id_table	= yenta_table,
 	.probe		= yenta_probe,
 	.remove		= __devexit_p(yenta_close),
-#ifdef CONFIG_PM
-	.suspend	= yenta_dev_suspend,
-	.resume		= yenta_dev_resume,
-#endif
+	.driver.pm	= YENTA_PM_OPS,
 };
 
 
