From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 09/11] soc: renesas: rcar-sysc: Add support for R-Car M2-N power areas
Date: Thu,  7 Apr 2016 14:20:26 +0200
Message-ID: <1460031628-13336-10-git-send-email-geert+renesas@glider.be>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

R-Car M2-N is identical to R-Car M2-W w.r.t. power domains, so reuse the
definitions from the latter.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - No changes,

v3:
  - New (converted from DT to C).
---
 drivers/soc/renesas/Makefile    | 3 ++-
 drivers/soc/renesas/rcar-sysc.c | 3 +++
 drivers/soc/renesas/rcar-sysc.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

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
index eb382769ffcdbf6f..4bedf38dc6fbba90 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -317,6 +317,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
 #ifdef CONFIG_ARCH_R8A7791
 	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
 #endif
+#ifdef CONFIG_ARCH_R8A7793
+	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7793_sysc_info },
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index e4c22e0516d1bf44..513a2beef1b0eb12 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -52,4 +52,6 @@ struct rcar_sysc_info {
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
+/* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
+#define r8a7793_sysc_info r8a7791_sysc_info
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1
