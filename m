From: Len Brown <lenb@kernel.org>
Subject: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3 boot hang
Date: Fri, 24 Sep 2010 21:26:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Linux Power Management List <linux-pm@lists.osdl.org>
Cc: linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When the Lenovo Ideapad S10-3 is booted with HT enabled,
it hits a boot hang in the intel_idle driver.

This occurs when entering ATM-C4 for the first time,
unless BM_STS is first cleared.

acpi_idle doesn't see this because it first checks
and clears BM_STS, but it would hit the same hang
if that check were disabled.

http://bugs.meego.com/show_bug.cgi?id=7093
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/634702

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/quirks.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 197e38f..a8dbf2e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -155,6 +155,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_d
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
 
 /*
+ * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
+ * for some HT machines to use C4 w/o hanging.
+ */
+static void __devinit quirk_tigerpoint_bm_sts(struct pci_dev *dev)
+{
+	u32 pmbase;
+	u16 pm1a;
+
+	pci_read_config_dword(dev, 0x40, &pmbase);
+	pmbase = pmbase & 0xff80;
+	pm1a = inw(pmbase);
+
+	if (pm1a & 0x10) {
+		dev_info(&dev->dev, FW_BUG "TigerPoint LPC.BM_STS cleared\n");
+		outw(0x10, pmbase);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
+
+/*
  *	Chipsets where PCI->PCI transfers vanish or hang
  */
 static void __devinit quirk_nopcipci(struct pci_dev *dev)
-- 
1.7.3
