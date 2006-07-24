From: Jason Lunz <lunz@falooley.org>
Subject: [patch, rft] amd74xx: implement suspend-to-ram
Date: Sun, 23 Jul 2006 20:53:41 -0400
Message-ID: <20060724005340.GA4073@opus.vpn-dev.reflex>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <19700101003716.GA3558@ucw.cz> <20060718133920.GA4106@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060718133920.GA4106@suse.cz>
Sender: linux-ide-owner@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


The amd74xx driver needs to reprogram each drive's PIO timings as well
as the DMA timings on resume from s2ram.  Otherwise, my
nforce3-150-based laptop hangs hard when ide_start_power_step() calls
drive->hwif->ide_dma_check(drive).

Suspend/resume from ram now works with the disk and the cdrom under
load, both with and without DMA enabled.

Signed-off-by: Jason Lunz <lunz@falooley.org>
---

I'm hardcoding a maximum of 2 ide channels, but other aspects of this
driver (like the amd_80w global) are already doing that.

DMA is re-enabled on resume even if it wasn't on at suspend, but that
doesn't look unusual in drivers/ide/pci.

 drivers/ide/pci/amd74xx.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

Index: linux-2.6.18-rc2-git1/drivers/ide/pci/amd74xx.c
===================================================================
--- linux-2.6.18-rc2-git1.orig/drivers/ide/pci/amd74xx.c
+++ linux-2.6.18-rc2-git1/drivers/ide/pci/amd74xx.c
@@ -83,6 +83,8 @@
 static ide_pci_device_t *amd_chipset;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
+#define AMD_MAX_CHANNELS	(2)
+static ide_hwif_t *amd_hwifs[AMD_MAX_CHANNELS];
 
 static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 7 };
@@ -416,6 +418,8 @@
 {
 	int i;
 
+	amd_hwifs[hwif->channel] = hwif;
+
 	if (hwif->irq == 0) /* 0 is bogus but will do for now */
 		hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
 
@@ -494,6 +498,53 @@
 	/* 19 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
+static int amd74xx_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	pci_save_state(dev);
+
+	// PM_EVENT_SUSPEND means s2ram. otherwise, the disk behind this device
+	// might hold the s2disk image, and we can't disable the disk
+	// controller until we've used it to write that out.
+	if(state.event == PM_EVENT_SUSPEND) {
+		pci_disable_device(dev);
+		pci_set_power_state(dev, pci_choose_state(dev, state));
+	}
+	return 0;
+}
+
+static int amd74xx_resume(struct pci_dev *dev)
+{
+	int retval = 0;
+	int i;
+
+	pci_set_power_state(dev, PCI_D0);
+	retval = pci_enable_device(dev);
+	pci_restore_state(dev);
+
+	for (i = 0; i < AMD_MAX_CHANNELS; i++) {
+		int d;
+
+		if (!amd_hwifs[i])
+			continue;
+
+		for (d = 0; d < MAX_DRIVES; ++d) {
+			ide_drive_t *drive = &amd_hwifs[i]->drives[d];
+			if (drive->present && !__ide_dma_bad_drive(drive)) {
+				/* this is the primary reason this driver needs
+				 * a suspend()/resume() implementation at all.
+				 * Calling amd74xx_ide_dma_check() without also
+				 * calling amd74xx_tune_drive() hangs my
+				 * nforce3-150 system.  ide-disk.c will do just
+				 * that later if we're resuming from s2ram. */
+				amd_hwifs[i]->tuneproc(drive, 255);
+				amd_hwifs[i]->ide_dma_check(drive);
+			}
+		}
+	}
+
+	return retval;
+}
+
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	amd_chipset = amd74xx_chipsets + id->driver_data;
@@ -539,6 +590,8 @@
 	.name		= "AMD_IDE",
 	.id_table	= amd74xx_pci_tbl,
 	.probe		= amd74xx_probe,
+	.suspend	= amd74xx_suspend,
+	.resume		= amd74xx_resume,
 };
 
 static int amd74xx_ide_init(void)
