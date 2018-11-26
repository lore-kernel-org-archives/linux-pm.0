From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 02/14] regulator: axp20x: name voltage ramping define properly
Date: Mon, 26 Nov 2018 17:27:43 +0200
Message-ID: <66ac03ac0e34e196e0469927c0feb3c98bc35837.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The current axp20x names the ramping register 'scal' which probably
means scaling. Since the register really has nothing to do with
scaling, but really is the voltage ramp we rename it appropriately.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 include/linux/mfd/axp20x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 517e60e..1293695 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -35,7 +35,7 @@ enum axp20x_variants {
 #define AXP152_ALDO_OP_MODE		0x13
 #define AXP152_LDO0_CTRL		0x15
 #define AXP152_DCDC2_V_OUT		0x23
-#define AXP152_DCDC2_V_SCAL		0x25
+#define AXP152_DCDC2_V_RAMP		0x25
 #define AXP152_DCDC1_V_OUT		0x26
 #define AXP152_DCDC3_V_OUT		0x27
 #define AXP152_ALDO12_V_OUT		0x28
@@ -53,7 +53,7 @@ enum axp20x_variants {
 #define AXP20X_USB_OTG_STATUS		0x02
 #define AXP20X_PWR_OUT_CTRL		0x12
 #define AXP20X_DCDC2_V_OUT		0x23
-#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
+#define AXP20X_DCDC2_LDO3_V_RAMP	0x25
 #define AXP20X_DCDC3_V_OUT		0x27
 #define AXP20X_LDO24_V_OUT		0x28
 #define AXP20X_LDO3_V_OUT		0x29
-- 
git-series 0.9.1
