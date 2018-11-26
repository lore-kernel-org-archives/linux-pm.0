From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
Date: Mon, 26 Nov 2018 17:27:48 +0200
Message-ID: <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
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

In the past, there have been words on various lists that if LDO3 is
disabled in u-boot, but enabled in the DTS, the axp209 driver would
fail to continue/hang. Several enable/disable patches have been
issues to devicetree's in both the kernel and u-boot to address
this issue.

What really happened however, was that the AXP209 shuts down without
a notice and without setting an interrupt. This is caused when LDO3
gets overloaded, for example with large capacitors on the LDO3 output.

Normally, we would expect that AXP209 would source 200 mA as per
datasheet and set and trigger an interrupt when being overloaded.
For some reason however, this does not happen.

As a work-around, implement software-based 'regulator-soft-start'
property for AXP209 LDO3 regulator, which is used to first bring up
the LDO3 to the lowest possible voltage and then enable the LDO.

After that, we can set the requested voltage as usual.

Combining this setting with the regulator-ramp-delay allows LDO3 to
come up slowly and staggered, potentially reducing overall inrush current.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 5542212..7e97bb7 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -36,6 +36,9 @@ Supported common regulator properties, see regulator.txt for more information:
 - regulator-ramp-delay: sets the ramp up delay in uV/us
 			AXP20x/DCDC2: 1600, 800
 			AXP20x/LDO3:  1600, 800
+- regulator-soft-start:	enable the output at the lowest possible voltage and
+			only then set the desired voltage
+			AXP20x/LDO3
 
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
-- 
git-series 0.9.1
