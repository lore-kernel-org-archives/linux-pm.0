From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] virtio_pci: pm: Use CONFIG_PM_SLEEP instead of CONFIG_PM
Date: Fri, 06 Sep 2013 10:28:36 +0800
Message-ID: <52293DD4.6050403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43460 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab3IFC2E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Sep 2013 22:28:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.linux-foundation.org, Linux-pm mailing list <linux-pm@vger.kernel.org>


The virtio_pci_freeze/restore are defined under CONFIG_PM but is used
by SET_SYSTEM_SLEEP_PM_OPS macro, which is defined under
CONFIG_PM_SLEEP. So if CONFIG_PM_SLEEP is not cofigured but
CONFIG_PM_RUNTIME is, the following warning message appeared:

drivers/virtio/virtio_pci.c:770:12: warning: =E2=80=98virtio_pci_freeze=
=E2=80=99 defined but not used [-Wunused-function]
 static int virtio_pci_freeze(struct device *dev)
            ^
drivers/virtio/virtio_pci.c:790:12: warning: =E2=80=98virtio_pci_restor=
e=E2=80=99 defined but not used [-Wunused-function]
 static int virtio_pci_restore(struct device *dev)
            ^
=46ix it by changing CONFIG_PM to CONFIG_PM_SLEEP.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/virtio/virtio_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 1aba255..98917fc 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -766,7 +766,7 @@ static void virtio_pci_remove(struct pci_dev *pci_d=
ev)
 	kfree(vp_dev);
 }
=20
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtio_pci_freeze(struct device *dev)
 {
 	struct pci_dev *pci_dev =3D to_pci_dev(dev);
@@ -824,7 +824,7 @@ static struct pci_driver virtio_pci_driver =3D {
 	.id_table	=3D virtio_pci_id_table,
 	.probe		=3D virtio_pci_probe,
 	.remove		=3D virtio_pci_remove,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.driver.pm	=3D &virtio_pci_pm_ops,
 #endif
 };
--=20
1.8.3.2.10.g43d11f4

