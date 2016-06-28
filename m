From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 04/13] soc: renesas: rcar-sysc: Move SYSC interrupt config to rcar-sysc driver
Date: Tue, 28 Jun 2016 16:10:33 +0200
Message-ID: <1467123042-8468-5-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

On R-Car H1 and Gen2, the SYSC interrupt registers are always configured
using hardcoded values in platform code. For R-Car Gen2, values are
provided for H2 and M2-W only, other SoCs are not yet supported, and
never will be.

Move this configuration from SoC-specific platform code to the
rcar_sysc_init() wrapper, so it can be skipped if the SYSC is configured
from DT. This would be the case not only for H1, H2, and M2-W using a
modern DTS, but also for other R-Car Gen2 SoCs not supported by the
platform code, relying purely on DT.

There is no longer a need to return the mapped register block, hence
make the function return void.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
v5:
  - Add Reviewed-by,

v4:
  - New.
---
 arch/arm/mach-shmobile/pm-r8a7779.c   |  6 +-----
 arch/arm/mach-shmobile/pm-rcar-gen2.c |  6 +-----
 drivers/soc/renesas/rcar-sysc.c       | 12 ++++++++----
 include/linux/soc/renesas/rcar-sysc.h |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 4174cbcbc467d047..5c9a93f5e650181a 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -23,11 +23,7 @@
 
 static void __init r8a7779_sysc_init(void)
 {
-	void __iomem *base = rcar_sysc_init(0xffd85000);
-
-	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(0x0131000e, base + SYSCIER);
-	iowrite32(0, base + SYSCIMR);
+	rcar_sysc_init(0xffd85000, 0x0131000e);
 }
 
 #else /* CONFIG_PM || CONFIG_SMP */
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 61361dac6068210a..dd9ac366868f4336 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -36,11 +36,7 @@
 
 static void __init rcar_gen2_sysc_init(u32 syscier)
 {
-	void __iomem *base = rcar_sysc_init(0xe6180000);
-
-	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(syscier, base + SYSCIER);
-	iowrite32(0, base + SYSCIMR);
+	rcar_sysc_init(0xe6180000, syscier);
 }
 
 #else /* CONFIG_SMP */
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 68d6856c9d3cd192..22f0d646225c444e 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -400,10 +400,14 @@ out_put:
 }
 early_initcall(rcar_sysc_pd_init);
 
-void __iomem * __init rcar_sysc_init(phys_addr_t base)
+void __init rcar_sysc_init(phys_addr_t base, u32 syscier)
 {
-	if (rcar_sysc_pd_init())
-		rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+	if (!rcar_sysc_pd_init())
+		return;
 
-	return rcar_sysc_base;
+	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+
+	/* enable all interrupt sources, but do not use interrupt handler */
+	iowrite32(syscier, rcar_sysc_base + SYSCIER);
+	iowrite32(0, rcar_sysc_base + SYSCIMR);
 }
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 92fc613ab23db091..7b8b280c181b8389 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -11,6 +11,6 @@ struct rcar_sysc_ch {
 
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-void __iomem *rcar_sysc_init(phys_addr_t base);
+void rcar_sysc_init(phys_addr_t base, u32 syscier);
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1
