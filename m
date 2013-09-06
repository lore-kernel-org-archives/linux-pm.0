From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/2] virtio_pci: pm: Use CONFIG_PM_SLEEP instead of CONFIG_PM
Date: Fri,  6 Sep 2013 16:20:06 +0800
Message-ID: <1378455607-32459-2-git-send-email-aaron.lu@intel.com>
References: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10098 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3IFITb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 04:19:31 -0400
In-Reply-To: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org

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
Reviewed-by: Amit Shah <amit.shah@redhat.com>
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
1.8.4.12.g2ea3df6

