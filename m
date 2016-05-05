From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH 2/6] arm: bcm21664: Remove reset code
Date: Thu,  5 May 2016 13:48:50 -0700
Message-ID: <1462481334-8943-3-git-send-email-chris.brand@broadcom.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

The kona reset driver now provides this functionality.

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 arch/arm/mach-bcm/board_bcm21664.c | 42 --------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/mach-bcm/board_bcm21664.c
index 82ad5687771f..65b3db06e57a 100644
--- a/arch/arm/mach-bcm/board_bcm21664.c
+++ b/arch/arm/mach-bcm/board_bcm21664.c
@@ -11,53 +11,12 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/io.h>
 
 #include <asm/mach/arch.h>
 
 #include "kona_l2_cache.h"
 
-#define RSTMGR_DT_STRING		"brcm,bcm21664-resetmgr"
-
-#define RSTMGR_REG_WR_ACCESS_OFFSET	0
-#define RSTMGR_REG_CHIP_SOFT_RST_OFFSET	4
-
-#define RSTMGR_WR_PASSWORD		0xa5a5
-#define RSTMGR_WR_PASSWORD_SHIFT	8
-#define RSTMGR_WR_ACCESS_ENABLE		1
-
-static void bcm21664_restart(enum reboot_mode mode, const char *cmd)
-{
-	void __iomem *base;
-	struct device_node *resetmgr;
-
-	resetmgr = of_find_compatible_node(NULL, NULL, RSTMGR_DT_STRING);
-	if (!resetmgr) {
-		pr_emerg("Couldn't find " RSTMGR_DT_STRING "\n");
-		return;
-	}
-	base = of_iomap(resetmgr, 0);
-	if (!base) {
-		pr_emerg("Couldn't map " RSTMGR_DT_STRING "\n");
-		return;
-	}
-
-	/*
-	 * A soft reset is triggered by writing a 0 to bit 0 of the soft reset
-	 * register. To write to that register we must first write the password
-	 * and the enable bit in the write access enable register.
-	 */
-	writel((RSTMGR_WR_PASSWORD << RSTMGR_WR_PASSWORD_SHIFT) |
-		RSTMGR_WR_ACCESS_ENABLE,
-		base + RSTMGR_REG_WR_ACCESS_OFFSET);
-	writel(0, base + RSTMGR_REG_CHIP_SOFT_RST_OFFSET);
-
-	/* Wait for reset */
-	while (1);
-}
-
 static void __init bcm21664_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -71,6 +30,5 @@ static const char * const bcm21664_dt_compat[] = {
 
 DT_MACHINE_START(BCM21664_DT, "BCM21664 Broadcom Application Processor")
 	.init_machine = bcm21664_init,
-	.restart = bcm21664_restart,
 	.dt_compat = bcm21664_dt_compat,
 MACHINE_END
-- 
1.9.1
