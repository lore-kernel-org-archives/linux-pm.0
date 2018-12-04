From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 5/7] ata: ahci: mvebu: request PHY suspend/resume for
 Armada 3700
Date: Tue,  4 Dec 2018 20:28:29 +0100
Message-ID: <20181204192831.12440-6-miquel.raynal@bootlin.com>
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

A feature has been added in the libahci driver: the possibility to set
a new flag in hpriv->flags to let the core handle PHY suspend/resume
automatically. Make use of this feature to make suspend to RAM work
with SATA drives on A3700.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index bbab688d3c34..d4bba3ace45d 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -30,6 +30,7 @@
 
 struct ahci_mvebu_plat_data {
 	int (*plat_config)(struct ahci_host_priv *hpriv);
+	unsigned int flags;
 };
 
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
@@ -195,6 +196,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	hpriv->flags |= pdata->flags;
 	hpriv->plat_data = (void *)pdata;
 
 	rc = ahci_platform_enable_resources(hpriv);
@@ -225,6 +227,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.plat_config = ahci_mvebu_armada_3700_config,
+	.flags = AHCI_HFLAG_SUSPEND_PHYS,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
-- 
2.19.1
