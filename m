From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] mips: decrease size of au1xxx_dbdma_pm_regs[][]
Date: Tue, 21 Jul 2009 16:19:08 +0200
Message-ID: <4A65CE5C.4090607__11673.8819903278$1248200264$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, Manuel Lauss <manuel.lauss@googlemail.com>, ralf@linux-mips.org, linux-pm@lists.linux-foundation.org, linux-mips@linux-mips.org, Andrew Morton <akpm@linux-fo>
List-Id: linux-pm@vger.kernel.org

There are 16 individual channels (NUM_DBDMA_CHANS) to save/restore
plus the global ddma block config (the +1). The last register in a
channel can be skipped since it's read-only (at offset 0x18).

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Thanks for your review and explanation, Manuel!

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 3ab6d80..19c1c82 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -175,7 +175,7 @@ static dbdev_tab_t dbdev_tab[] = {
 #define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
 
 #ifdef CONFIG_PM
-static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][8];
+static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][6];
 #endif
 
 
@@ -993,14 +993,13 @@ void au1xxx_dbdma_suspend(void)
 	au1xxx_dbdma_pm_regs[0][3] = au_readl(addr + 0x0c);
 
 	/* save channel configurations */
-	for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {
+	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
 		au1xxx_dbdma_pm_regs[i][0] = au_readl(addr + 0x00);
 		au1xxx_dbdma_pm_regs[i][1] = au_readl(addr + 0x04);
 		au1xxx_dbdma_pm_regs[i][2] = au_readl(addr + 0x08);
 		au1xxx_dbdma_pm_regs[i][3] = au_readl(addr + 0x0c);
 		au1xxx_dbdma_pm_regs[i][4] = au_readl(addr + 0x10);
 		au1xxx_dbdma_pm_regs[i][5] = au_readl(addr + 0x14);
-		au1xxx_dbdma_pm_regs[i][6] = au_readl(addr + 0x18);
 
 		/* halt channel */
 		au_writel(au1xxx_dbdma_pm_regs[i][0] & ~1, addr + 0x00);
@@ -1027,14 +1026,13 @@ void au1xxx_dbdma_resume(void)
 	au_writel(au1xxx_dbdma_pm_regs[0][3], addr + 0x0c);
 
 	/* restore channel configurations */
-	for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {
+	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
 		au_writel(au1xxx_dbdma_pm_regs[i][0], addr + 0x00);
 		au_writel(au1xxx_dbdma_pm_regs[i][1], addr + 0x04);
 		au_writel(au1xxx_dbdma_pm_regs[i][2], addr + 0x08);
 		au_writel(au1xxx_dbdma_pm_regs[i][3], addr + 0x0c);
 		au_writel(au1xxx_dbdma_pm_regs[i][4], addr + 0x10);
 		au_writel(au1xxx_dbdma_pm_regs[i][5], addr + 0x14);
-		au_writel(au1xxx_dbdma_pm_regs[i][6], addr + 0x18);
 		au_sync();
 		addr += 0x100;	/* next channel base */
 	}
