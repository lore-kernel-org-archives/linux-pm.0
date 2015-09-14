From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] irqchip: gic: Add arm,pl390 support
Date: Mon, 14 Sep 2015 22:06:43 +0200
Message-ID: <1442261204-30931-2-git-send-email-geert+renesas@glider.be>
References: <1442261204-30931-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442261204-30931-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the PrimeCell=C2=AE Generic Interrupt Controller (PL390=
) to
the GIC DT bindings and driver.

Currently the GIC driver treats this GIC variant the same as other GIC
variants, but there are differences in hardware topology (e.g. clock
inputs).

Sort the list of compatible values while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.

 Documentation/devicetree/bindings/arm/gic.txt | 9 +++++----
 drivers/irqchip/irq-gic.c                     | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentat=
ion/devicetree/bindings/arm/gic.txt
index 2da059a4790cb3c6..24742853ba460223 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -11,13 +11,14 @@ have PPIs or SGIs.
 Main node required properties:
=20
 - compatible : should be one of:
-	"arm,gic-400"
+	"arm,arm1176jzf-devchip-gic"
+	"arm,arm11mp-gic"
 	"arm,cortex-a15-gic"
-	"arm,cortex-a9-gic"
 	"arm,cortex-a7-gic"
-	"arm,arm11mp-gic"
+	"arm,cortex-a9-gic"
+	"arm,gic-400"
+	"arm,pl390"
 	"brcm,brahma-b15-gic"
-	"arm,arm1176jzf-devchip-gic"
 	"qcom,msm-8660-qgic"
 	"qcom,msm-qgic2"
 - interrupt-controller : Identifies the node as an interrupt controlle=
r
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4b2255317e4764f9..81179d01f14de2fe 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1046,6 +1046,7 @@ IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic=
", gic_of_init);
 IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
+IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
=20
 #endif
=20
--=20
1.9.1

