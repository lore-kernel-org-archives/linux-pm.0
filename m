From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 1/4] ARM: mvebu: Use __init for the PM initialization
 functions
Date: Tue, 30 Jun 2015 19:18:57 +0200
Message-ID: <1435684740-24912-2-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

mvebu_pm_init and mvebu_armada_pm_init are only called during boot, so
flag them with __init and save some memory.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pm-board.c | 2 +-
 arch/arm/mach-mvebu/pm.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 0f471fad214a..acc69e369c8b 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -76,7 +76,7 @@ static void mvebu_armada_pm_enter(void __iomem *sdram_reg, u32 srcmd)
 		  [ackcmd] "r" (ackcmd), [gpio_ctrl] "r" (gpio_ctrl) : "r1");
 }
 
-static int mvebu_armada_pm_init(void)
+static int __init mvebu_armada_pm_init(void)
 {
 	struct device_node *np;
 	struct device_node *gpio_ctrl_np;
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 90d85ef75d54..f249c8e04bd4 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -235,7 +235,7 @@ static const struct platform_suspend_ops mvebu_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
 {
 	struct device_node *np;
 	struct resource res;
-- 
2.1.0
