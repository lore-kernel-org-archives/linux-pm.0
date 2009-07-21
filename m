From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] mips: decrease size of au1xxx_dbdma_pm_regs[][]
Date: Tue, 21 Jul 2009 14:46:51 +0200
Message-ID: <4A65B8BB.40502__12940.1945895099$1248200258$gmane$org@gmail.com>
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
To: rjw@sisk.pl, ralf@linux-mips.org, linux-pm@lists.linux-foundation.org, linux-mips@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Only registers [0-DDMA_CHANNEL_BASE][0-6] are used by the suspend
and resume routines.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
These routines are on the bottom of the file. Only used are
registers:

au1xxx_dbdma_pm_regs[0][0-3]

and 

au1xxx_dbdma_pm_regs[1-NUM_DBDMA_CHANS][0-6]

Is my patch right, that assumes that the array can be smaller, or
should the storage and recovery of other registers be added?

Roel

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 3ab6d80..bf48a21 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -175,7 +175,7 @@ static dbdev_tab_t dbdev_tab[] = {
 #define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
 
 #ifdef CONFIG_PM
-static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][8];
+static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS][7];
 #endif
 
 
