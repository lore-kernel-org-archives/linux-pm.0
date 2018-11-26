From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on the Lime2
Date: Mon, 26 Nov 2018 17:27:50 +0200
Message-ID: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
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

With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
LDO3 this may be less arbitrary, but for LDO4 this is just wrong.

In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
which has no other purpose then a CSI/TS interface, however the case
may still be, that the connected IO may be just as well be 3.3 volts.
The big misnomer is however, that the schematic names GPIO-2 pin4
LDO3_2.8V, rather then VDD-CSI0 or similar.

This is much worse for LDO4 however, which is not referenced on any
pin, is now set to 2.8 volts, but port bank G can also support various
other peripherals such as UARTS etc.

By having 2.8 volts however for LDO4, we thus now have peripherals that
no longer function properly all of the time.

Ideally, we want to set a supply voltage for each port bank, but the
monolithic nature of the sunxi pinctroller currently prevents this and
as such, the board should at least configure the LDO4 with the proper
ranges.

Until we can set the consumer at the port bank level, a child
device-tree has to do something like:

&reg_ldo4 {
    regulator-min-microvolt = <3300000>;
    regulator-max-microvolt = <3300000>;
};

While doing this the same way results in the same solution currently,
we force the hack into the final devicetree rather then having it wrong
at the board level.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ffafe97..1b9867f 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -250,9 +250,10 @@
 };
 
 &reg_ldo4 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
-	regulator-name = "vddio-csi1";
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vdd-io-pg";
 };
 
 &reg_usb0_vbus {
-- 
git-series 0.9.1
