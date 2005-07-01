From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Thu, 30 Jun 2005 22:26:37 -0400
Message-ID: <20050701022634.GA5629.1@tuxdriver.com>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
	<20050630171010.GD11369@kroah.com>
	<20050701014056.GA13710@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58013404858747464=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Resent-Message-Id: <200507010231.j612VCjT005717@bilbo.tuxdriver.com>
In-Reply-To: <20050701014056.GA13710@tuxdriver.com>
Resent-To: linux-pci@atrey.karlin.mff.cuni.cz,
   linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org,
   Greg KH <greg@kroah.com>, Adam Belay <ambx1@neo.rr.com>,
   Russell King <rmk@arm.linux.org.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

--===============58013404858747464==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some PCI devices lose all configuration (including BARs) when
transitioning from D3hot->D0.  This leaves such a device in an
inaccessible state.  The patch below causes the BARs to be restored
when enabling a device, so that the driver will be able to access it.

Acked-by: Adam Belay <ambx1@neo.rr.com>
Acked-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Some firmware leaves devices in D3hot after a (re)boot.  Most drivers
call pci_enable_device very early, so devices left in D3hot that lose
configuration during the D3hot->D0 transition will be inaccessible to
their drivers.

Drivers could be modified to account for this, but it would be difficult
to know which drivers need modification.  This is especially true since
often many devices are covered by the same driver.  It likely would be
necessary to replicate code across dozens of drivers.

Since the fix should be safe for any device, it seems appropriate to
make it part of the PCI infrastructure.

 drivers/pci/pci.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -378,9 +378,56 @@ pci_restore_state(struct pci_dev *dev)
 int
 pci_enable_device_bars(struct pci_dev *dev, int bars)
 {
-	int err;
+	int i, numres, err;
 
 	pci_set_power_state(dev, PCI_D0);
+
+	/* Some devices lose PCI config header data during D3hot->D0
+	   transition.	Since some firmware leaves devices in D3hot
+	   state at boot, this information needs to be restored.  We
+	   could force drivers to do this, but better to leave them
+	   ignorant of PCI PM trivia...
+	*/
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+		numres = 6;
+		break;
+	case PCI_HEADER_TYPE_BRIDGE:
+		numres = 2;
+		break;
+	case PCI_HEADER_TYPE_CARDBUS:
+		numres = 1;
+		break;
+	default:
+		/* Should never get here, but just in case... */
+		numres = 0;
+		break;
+	}
+	for (i = 0; i < numres; i ++) {
+		struct pci_bus_region region;
+		u32 val;
+		int reg;
+
+		if (!dev->resource[i].flags)
+			continue;
+
+		pcibios_resource_to_bus(dev, &region, &dev->resource[i]);
+
+		val = region.start
+		    | (dev->resource[i].flags & PCI_REGION_FLAG_MASK);
+
+		reg = PCI_BASE_ADDRESS_0 + (i * 4);
+
+		pci_write_config_dword(dev, reg, val);
+
+		if ((val & (PCI_BASE_ADDRESS_SPACE
+		          | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
+		 == (PCI_BASE_ADDRESS_SPACE_MEMORY
+		   | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+			pci_write_config_dword(dev, reg + 4, 0);
+		}
+	}
+
 	if ((err = pcibios_enable_device(dev, bars)) < 0)
 		return err;
 	return 0;
-- 
John W. Linville
linville@tuxdriver.com


--===============58013404858747464==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============58013404858747464==--
