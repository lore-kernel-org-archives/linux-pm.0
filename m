From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/8] PM: Allow SCSI devices to suspend/resume
	asynchronously
Date: Sun, 24 Jan 2010 00:41:30 +0100
Message-ID: <201001240041.30899.rjw__7009.29202507741$1264291231$gmane$org@sisk.pl>
References: <201001240033.34253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240033.34253.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <gregkh@suse.de>, Linux SCSI <linux-scsi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Set power.async_suspend for all SCSI devices, targets and hosts, so
that they can be suspended and resumed in parallel with the main
suspend/resume thread and possibly with other devices they don't
depend on in a known way (i.e. devices which are not their parents or
children).

The power.async_suspend flag is also set for devices that don't have
suspend or resume callbacks, because otherwise they would make the
main suspend/resume thread wait for their "asynchronous" children
(during suspend) or parents (during resume), effectively negating the
possible gains from executing these devices' suspend and resume
callbacks asynchronously.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/scsi/hosts.c      |    4 ++++
 drivers/scsi/scsi_sysfs.c |    4 ++++
 2 files changed, 8 insertions(+)

Index: linux-2.6/drivers/scsi/hosts.c
===================================================================
--- linux-2.6.orig/drivers/scsi/hosts.c
+++ linux-2.6/drivers/scsi/hosts.c
@@ -215,6 +215,8 @@ int scsi_add_host_with_dma(struct Scsi_H
 		shost->shost_gendev.parent = dev ? dev : &platform_bus;
 	shost->dma_dev = dma_dev;
 
+	device_enable_async_suspend(&shost->shost_gendev);
+
 	error = device_add(&shost->shost_gendev);
 	if (error)
 		goto out;
@@ -222,6 +224,8 @@ int scsi_add_host_with_dma(struct Scsi_H
 	scsi_host_set_state(shost, SHOST_RUNNING);
 	get_device(shost->shost_gendev.parent);
 
+	device_enable_async_suspend(&shost->shost_dev);
+
 	error = device_add(&shost->shost_dev);
 	if (error)
 		goto out_del_gendev;
Index: linux-2.6/drivers/scsi/scsi_sysfs.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_sysfs.c
+++ linux-2.6/drivers/scsi/scsi_sysfs.c
@@ -847,6 +847,8 @@ static int scsi_target_add(struct scsi_t
 	if (starget->state != STARGET_CREATED)
 		return 0;
 
+	device_enable_async_suspend(&starget->dev);
+
 	error = device_add(&starget->dev);
 	if (error) {
 		dev_err(&starget->dev, "target device_add failed, error %d\n", error);
@@ -886,11 +888,13 @@ int scsi_sysfs_add_sdev(struct scsi_devi
 		return error;
 
 	transport_configure_device(&starget->dev);
+	device_enable_async_suspend(&sdev->sdev_gendev);
 	error = device_add(&sdev->sdev_gendev);
 	if (error) {
 		printk(KERN_INFO "error 1\n");
 		goto out_remove;
 	}
+	device_enable_async_suspend(&sdev->sdev_dev);
 	error = device_add(&sdev->sdev_dev);
 	if (error) {
 		printk(KERN_INFO "error 2\n");
