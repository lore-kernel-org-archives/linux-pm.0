From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/7] ata: libahci_platform: comply to PHY framework
Date: Tue,  4 Dec 2018 20:28:25 +0100
Message-ID: <20181204192831.12440-2-miquel.raynal@bootlin.com>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181204192831.12440-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Current implementation of the libahci does not take into account the
new PHY framework. Correct the situation by adding a call to
phy_set_mode() before phy_power_on().

PHYs should also be handled at suspend/resume time. For this, call
ahci_platform_enable/disable_phys() at suspend/resume_host() time. These
calls are guarded by a HFLAG (AHCI_HFLAG_SUSPEND_PHYS) that the user of
the libahci driver must set manually in hpriv->flags at probe time. This
is to avoid breaking users that have not been tested with this change.

Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci.h             |  2 ++
 drivers/ata/libahci_platform.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index ef356e70e6de..8810475f307a 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -254,6 +254,8 @@ enum {
 	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
 							SATA_MOBILE_LPM_POLICY
 							as default lpm_policy */
+	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
+							suspend/resume */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 4b900fc659f7..81b1a3332ed6 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 		if (rc)
 			goto disable_phys;
 
+		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+
 		rc = phy_power_on(hpriv->phys[i]);
 		if (rc) {
 			phy_exit(hpriv->phys[i]);
@@ -738,6 +744,9 @@ int ahci_platform_suspend_host(struct device *dev)
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
+	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
+		ahci_platform_disable_phys(hpriv);
+
 	return ata_host_suspend(host, PMSG_SUSPEND);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
@@ -756,6 +765,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
 int ahci_platform_resume_host(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
@@ -766,6 +776,9 @@ int ahci_platform_resume_host(struct device *dev)
 		ahci_init_controller(host);
 	}
 
+	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
+		ahci_platform_enable_phys(hpriv);
+
 	ata_host_resume(host);
 
 	return 0;
-- 
2.19.1
