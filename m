From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 08/25] dt-bindings: power: supply: add AXP20X/AXP22X AC
 power supply
Date: Fri, 27 Jan 2017 09:54:41 +0100
Message-ID: <20170127085458.18270-9-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs have an AC entry to supply power to
the board. They have a few registers dedicated to the status of the AC
power supply.

This adds the DT binding documentation for the AC power supply for
AXP20X and AXP22X PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - removed #io-channels property,

 .../bindings/power/supply/axp20x_ac_power.txt      | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
new file mode 100644
index 0000000..826e8a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -0,0 +1,22 @@
+AXP20X and AXP22X PMICs' AC power supply
+
+Required Properties:
+ - compatible: One of:
+			"x-powers,axp202-ac-power-supply"
+			"x-powers,axp221-ac-power-supply"
+
+This node is a subnode of the axp20x PMIC.
+
+The AXP20X can read the current current and voltage supplied by AC by
+reading ADC channels from the AXP20X ADC.
+
+The AXP22X is only able to tell if an AC power supply is present and
+usable.
+
+Example:
+
+&axp209 {
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp202-ac-power-supply";
+	};
+};
-- 
2.9.3
