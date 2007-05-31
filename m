From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Thu, 31 May 2007 08:42:33 +0200 (CEST)
Message-ID: <tkrat.e22d2cc8f9fe7f8a__23767.8630430766$1180593831$gmane$org@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>
	<464DDB85.7080203@s5r6.in-berlin.de>
	<tkrat.a98b66b055229e9d@s5r6.in-berlin.de>
	<200705210725.55299.marcus@better.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705210725.55299.marcus@better.se>
Content-Disposition: INLINE
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Marcus, please test:

From: =3D?utf-8?q?Kristian_H=3DC3=3DB8gsberg?=3D <krh@redhat.com>
Subject: [PATCH] Implement suspend/resume PCI driver hooks.
Date: Wed, 30 May 2007 19:06:35 -0400

It's a low-impact design, that just makes suspend/resume look like
a bus reset to the upper level drivers, but it should be sufficient.

Signed-off-by: Kristian H=F8gsberg <krh@redhat.com>
---

 drivers/firewire/fw-card.c |    5 -
 drivers/firewire/fw-ohci.c |  187 +++++++++++++++++++++++++++++---------=
------
 2 files changed, 123 insertions(+), 69 deletions(-)

diff --git a/drivers/firewire/fw-card.c b/drivers/firewire/fw-card.c
index 636151a..9eb1eda 100644
--- a/drivers/firewire/fw-card.c
+++ b/drivers/firewire/fw-card.c
@@ -407,11 +407,6 @@ fw_card_add(struct fw_card *card,
 	card->link_speed =3D link_speed;
 	card->guid =3D guid;
=20
-	/* Activate link_on bit and contender bit in our self ID packets.*/
-	if (card->driver->update_phy_reg(card, 4, 0,
-					 PHY_LINK_ACTIVE | PHY_CONTENDER) < 0)
-		return -EIO;
-
 	/*
 	 * The subsystem grabs a reference when the card is added and
 	 * drops it when the driver calls fw_core_remove_card.
diff --git a/drivers/firewire/fw-ohci.c b/drivers/firewire/fw-ohci.c
index 2e4cfa5..7db2cee 100644
--- a/drivers/firewire/fw-ohci.c
+++ b/drivers/firewire/fw-ohci.c
@@ -417,12 +417,21 @@ ar_context_init(struct ar_context *ctx, struct fw_o=
hci *ohci, u32 regs)
 	ctx->current_buffer =3D ab.next;
 	ctx->pointer =3D ctx->current_buffer->data;
=20
-	reg_write(ctx->ohci, COMMAND_PTR(ctx->regs),
-		  le32_to_cpu(ab.descriptor.branch_address));
+	return 0;
+}
+
+static void ar_context_run(struct ar_context *ctx)
+{
+	struct ar_buffer *ab =3D ctx->current_buffer;
+	dma_addr_t ab_bus;
+	size_t offset;
+=09
+	offset =3D offsetof(struct ar_buffer, data);
+	ab_bus =3D ab->descriptor.data_address - offset;
+
+	reg_write(ctx->ohci, COMMAND_PTR(ctx->regs), ab_bus | 1);
 	reg_write(ctx->ohci, CONTROL_SET(ctx->regs), CONTEXT_RUN);
 	flush_writes(ctx->ohci);
-
-	return 0;
 }
=20
 static void context_tasklet(unsigned long data)
@@ -1039,11 +1048,78 @@ static irqreturn_t irq_handler(int irq, void *dat=
a)
 	return IRQ_HANDLED;
 }
=20
+static int software_reset(struct fw_ohci *ohci)
+{
+	int i;
+
+	reg_write(ohci, OHCI1394_HCControlSet, OHCI1394_HCControl_softReset);
+
+	for (i =3D 0; i < OHCI_LOOP_COUNT; i++) {
+		if ((reg_read(ohci, OHCI1394_HCControlSet) &
+		     OHCI1394_HCControl_softReset) =3D=3D 0)
+			return 0;
+		msleep(1);
+	}
+
+	return -EBUSY;
+}
+
 static int ohci_enable(struct fw_card *card, u32 *config_rom, size_t len=
gth)
 {
 	struct fw_ohci *ohci =3D fw_ohci(card);
 	struct pci_dev *dev =3D to_pci_dev(card->device);
=20
+	if (software_reset(ohci)) {
+		fw_error("Failed to reset ohci card.\n");
+		return -EBUSY;
+	}
+
+	/*
+	 * Now enable LPS, which we need in order to start accessing
+	 * most of the registers.  In fact, on some cards (ALI M5251),
+	 * accessing registers in the SClk domain without LPS enabled
+	 * will lock up the machine.  Wait 50msec to make sure we have
+	 * full link enabled.
+	 */
+	reg_write(ohci, OHCI1394_HCControlSet,
+		  OHCI1394_HCControl_LPS |
+		  OHCI1394_HCControl_postedWriteEnable);
+	flush_writes(ohci);
+	msleep(50);
+
+	reg_write(ohci, OHCI1394_HCControlClear,
+		  OHCI1394_HCControl_noByteSwapData);
+
+	reg_write(ohci, OHCI1394_LinkControlSet,
+		  OHCI1394_LinkControl_rcvSelfID |
+		  OHCI1394_LinkControl_cycleTimerEnable |
+		  OHCI1394_LinkControl_cycleMaster);
+
+	reg_write(ohci, OHCI1394_ATRetries,
+		  OHCI1394_MAX_AT_REQ_RETRIES |
+		  (OHCI1394_MAX_AT_RESP_RETRIES << 4) |
+		  (OHCI1394_MAX_PHYS_RESP_RETRIES << 8));
+
+	ar_context_run(&ohci->ar_request_ctx);
+	ar_context_run(&ohci->ar_response_ctx);
+
+	reg_write(ohci, OHCI1394_SelfIDBuffer, ohci->self_id_bus);
+	reg_write(ohci, OHCI1394_PhyUpperBound, 0x00010000);
+	reg_write(ohci, OHCI1394_IntEventClear, ~0);
+	reg_write(ohci, OHCI1394_IntMaskClear, ~0);
+	reg_write(ohci, OHCI1394_IntMaskSet,
+		  OHCI1394_selfIDComplete |
+		  OHCI1394_RQPkt | OHCI1394_RSPkt |
+		  OHCI1394_reqTxComplete | OHCI1394_respTxComplete |
+		  OHCI1394_isochRx | OHCI1394_isochTx |
+		  OHCI1394_masterIntEnable |
+		  OHCI1394_cycle64Seconds);
+
+	/* Activate link_on bit and contender bit in our self ID packets.*/
+	if (ohci_update_phy_reg(card, 4, 0,
+				PHY_LINK_ACTIVE | PHY_CONTENDER) < 0)
+		return -EIO;
+
 	/*
 	 * When the link is not yet enabled, the atomic config rom
 	 * update mechanism described below in ohci_set_config_rom()
@@ -1701,22 +1777,6 @@ static const struct fw_card_driver ohci_driver =3D=
 {
 	.stop_iso		=3D ohci_stop_iso,
 };
=20
-static int software_reset(struct fw_ohci *ohci)
-{
-	int i;
-
-	reg_write(ohci, OHCI1394_HCControlSet, OHCI1394_HCControl_softReset);
-
-	for (i =3D 0; i < OHCI_LOOP_COUNT; i++) {
-		if ((reg_read(ohci, OHCI1394_HCControlSet) &
-		     OHCI1394_HCControl_softReset) =3D=3D 0)
-			return 0;
-		msleep(1);
-	}
-
-	return -EBUSY;
-}
-
 static int __devinit
 pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 {
@@ -1762,33 +1822,6 @@ pci_probe(struct pci_dev *dev, const struct pci_de=
vice_id *ent)
 		goto fail_iomem;
 	}
=20
-	if (software_reset(ohci)) {
-		fw_error("Failed to reset ohci card.\n");
-		err =3D -EBUSY;
-		goto fail_registers;
-	}
-
-	/*
-	 * Now enable LPS, which we need in order to start accessing
-	 * most of the registers.  In fact, on some cards (ALI M5251),
-	 * accessing registers in the SClk domain without LPS enabled
-	 * will lock up the machine.  Wait 50msec to make sure we have
-	 * full link enabled.
-	 */
-	reg_write(ohci, OHCI1394_HCControlSet,
-		  OHCI1394_HCControl_LPS |
-		  OHCI1394_HCControl_postedWriteEnable);
-	flush_writes(ohci);
-	msleep(50);
-
-	reg_write(ohci, OHCI1394_HCControlClear,
-		  OHCI1394_HCControl_noByteSwapData);
-
-	reg_write(ohci, OHCI1394_LinkControlSet,
-		  OHCI1394_LinkControl_rcvSelfID |
-		  OHCI1394_LinkControl_cycleTimerEnable |
-		  OHCI1394_LinkControl_cycleMaster);
-
 	ar_context_init(&ohci->ar_request_ctx, ohci,
 			OHCI1394_AsReqRcvContextControlSet);
=20
@@ -1801,11 +1834,6 @@ pci_probe(struct pci_dev *dev, const struct pci_de=
vice_id *ent)
 	context_init(&ohci->at_response_ctx, ohci, AT_BUFFER_SIZE,
 		     OHCI1394_AsRspTrContextControlSet, handle_at_packet);
=20
-	reg_write(ohci, OHCI1394_ATRetries,
-		  OHCI1394_MAX_AT_REQ_RETRIES |
-		  (OHCI1394_MAX_AT_RESP_RETRIES << 4) |
-		  (OHCI1394_MAX_PHYS_RESP_RETRIES << 8));
-
 	reg_write(ohci, OHCI1394_IsoRecvIntMaskSet, ~0);
 	ohci->it_context_mask =3D reg_read(ohci, OHCI1394_IsoRecvIntMaskSet);
 	reg_write(ohci, OHCI1394_IsoRecvIntMaskClear, ~0);
@@ -1835,18 +1863,6 @@ pci_probe(struct pci_dev *dev, const struct pci_de=
vice_id *ent)
 		goto fail_registers;
 	}
=20
-	reg_write(ohci, OHCI1394_SelfIDBuffer, ohci->self_id_bus);
-	reg_write(ohci, OHCI1394_PhyUpperBound, 0x00010000);
-	reg_write(ohci, OHCI1394_IntEventClear, ~0);
-	reg_write(ohci, OHCI1394_IntMaskClear, ~0);
-	reg_write(ohci, OHCI1394_IntMaskSet,
-		  OHCI1394_selfIDComplete |
-		  OHCI1394_RQPkt | OHCI1394_RSPkt |
-		  OHCI1394_reqTxComplete | OHCI1394_respTxComplete |
-		  OHCI1394_isochRx | OHCI1394_isochTx |
-		  OHCI1394_masterIntEnable |
-		  OHCI1394_cycle64Seconds);
-
 	bus_options =3D reg_read(ohci, OHCI1394_BusOptions);
 	max_receive =3D (bus_options >> 12) & 0xf;
 	link_speed =3D bus_options & 0x7;
@@ -1908,6 +1924,45 @@ static void pci_remove(struct pci_dev *dev)
 	fw_notify("Removed fw-ohci device.\n");
 }
=20
+#ifdef CONFIG_PM
+static int pci_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct fw_ohci *ohci =3D pci_get_drvdata(pdev);
+	int err;
+
+	software_reset(ohci);
+	free_irq(pdev->irq, ohci);
+	err =3D pci_save_state(pdev);
+	if (err) {
+		fw_error("pci_save_state failed with %d", err);
+		return err;
+	}
+	err =3D pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	if (err) {
+		fw_error("pci_set_power_state failed with %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int pci_resume(struct pci_dev *pdev)
+{
+	struct fw_ohci *ohci =3D pci_get_drvdata(pdev);
+	int err;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	err =3D pci_enable_device(pdev);
+	if (err) {
+		fw_error("pci_enable_device failed with %d", err);
+		return err;
+	}
+
+	return ohci_enable(&ohci->card, ohci->config_rom, CONFIG_ROM_SIZE);
+}
+#endif
+
 static struct pci_device_id pci_table[] =3D {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_FIREWIRE_OHCI, ~0) },
 	{ }
@@ -1920,6 +1975,10 @@ static struct pci_driver fw_ohci_pci_driver =3D {
 	.id_table	=3D pci_table,
 	.probe		=3D pci_probe,
 	.remove		=3D pci_remove,
+#ifdef CONFIG_PM
+	.resume		=3D pci_resume,
+	.suspend	=3D pci_suspend,
+#endif
 };
=20
 MODULE_AUTHOR("Kristian Hoegsberg <krh@bitplanet.net>");



--=20
Stefan Richter
-=3D=3D=3D=3D=3D-=3D-=3D=3D=3D -=3D-=3D =3D=3D=3D=3D=3D
http://arcgraph.de/sr/
