From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 2/7] ata: ahci: mvebu: remove stale comment
Date: Tue,  4 Dec 2018 20:28:26 +0100
Message-ID: <20181204192831.12440-3-miquel.raynal@bootlin.com>
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

For Armada-38x (32-bit) SoCs, PM platform support has been added since:
commit 32f9494c9dfd ("ARM: mvebu: prepare pm-board.c for the
                      introduction of Armada 38x support")
commit 3cbd6a6ca81c ("ARM: mvebu: Add standby support")

For Armada 64-bit SoCs, like the A3700 also using this AHCI driver, PM
platform support has always existed.

There are even suspend/resume hooks in this driver since:
commit d6ecf15814888 ("ata: ahci_mvebu: add suspend/resume support")

Remove the stale comment at the end of this driver stating that all
the above does not exist yet.

Fixes: d6ecf15814888 ("ata: ahci_mvebu: add suspend/resume support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index f9cb51be38eb..128d6f22926d 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -197,11 +197,6 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
 
-/*
- * We currently don't provide power management related operations,
- * since there is no suspend/resume support at the platform level for
- * Armada 38x for the moment.
- */
 static struct platform_driver ahci_mvebu_driver = {
 	.probe = ahci_mvebu_probe,
 	.remove = ata_platform_remove_one,
-- 
2.19.1
