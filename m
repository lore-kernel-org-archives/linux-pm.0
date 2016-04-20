From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 09/11] soc: renesas: rcar-sysc: Add support for R-Car M2-N power areas
Date: Wed, 20 Apr 2016 14:02:44 +0200
Message-ID: <1461153766-750-10-git-send-email-geert+renesas@glider.be>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

R-Car M2-N is identical to R-Car M2-W w.r.t. power domains, so reuse the
definitions from the latter.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - No changes,

v5:
  - Add Reviewed-by,
  - Reference r8a7791_sysc_info directly for R-Car M2-N in rcar-sysc.c,

v4:
  - No changes,

v3:
  - New (converted from DT to C).
---
 drivers/soc/renesas/Makefile    | 3 ++-
 drivers/soc/renesas/rcar-sysc.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 96463c05ee594335..c6c4ce7ef8a145ea 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
 obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
-obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
+# R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
+obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
 obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 5b70b93a2aa710b2..d8eaf8b2ee202ba1 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -293,6 +293,10 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7791
 	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7793
+	/* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
+	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7791_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
-- 
1.9.1
