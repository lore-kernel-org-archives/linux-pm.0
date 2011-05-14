From: Tejun Heo <tj@kernel.org>
Subject: [PATCH v2.6.38-rc7] Revert "libata: ahci_start_engine
 compliant to AHCI spec"
Date: Sat, 14 May 2011 12:28:04 +0200
Message-ID: <20110514102804.GB23665__525.535216047679$1305369142$gmane$org@htj.dyndns.org>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<201105132222.11582.rjw@sisk.pl> <201105132244.29605.rjw@sisk.pl>
	<20110514101807.GA23665@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110514101807.GA23665@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Michael Leun <lkml20100708@newton.leun.net>
List-Id: linux-pm@vger.kernel.org

This reverts commit 270dac35c26433d06a89150c51e75ca0181ca7e4.

The commits causes command timeouts on AC plug/unplug.  It isn't yet
clear why.  As the commit was for a single rather obscure controller,
revert the change for now.

The problem was reported and bisected by Gu Rui in bug#34692.

 https://bugzilla.kernel.org/show_bug.cgi?id=34692

Also, reported by Rafael and Michael in the following thread.

 http://thread.gmane.org/gmane.linux.kernel/1138771

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Gu Rui <chaos.proton@gmail.com>
Reported-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Michael Leun <lkml20100708@newton.leun.net>
Cc: Jian Peng <jipeng2005@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
As we're already in -rc7, I'm sending the revert patch to both Jeff
and Linus.

Thank you.

 drivers/ata/libahci.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ff9d832..d38c40f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -561,27 +561,6 @@ void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
-	u8 status;
-
-	status = readl(port_mmio + PORT_TFDATA) & 0xFF;
-
-	/*
-	 * At end of section 10.1 of AHCI spec (rev 1.3), it states
-	 * Software shall not set PxCMD.ST to 1 until it is determined
-	 * that a functoinal device is present on the port as determined by
-	 * PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h
-	 *
-	 * Even though most AHCI host controllers work without this check,
-	 * specific controller will fail under this condition
-	 */
-	if (status & (ATA_BUSY | ATA_DRQ))
-		return;
-	else {
-		ahci_scr_read(&ap->link, SCR_STATUS, &tmp);
-
-		if ((tmp & 0xf) != 0x3)
-			return;
-	}
 
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-- 
1.7.1
