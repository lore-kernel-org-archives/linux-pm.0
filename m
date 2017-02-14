From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Tue, 14 Feb 2017 10:41:05 +0100
Message-ID: <20170214094112.27426-12-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
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

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the DT binding documentation for the battery power
supply which gets various data from the PMIC, such as the battery status
(charging, discharging, full, dead), current max limit, current current,
battery capacity (in percentage), voltage max and min limits, current
voltage and battery capacity (in Ah).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

v3:
 - removed constant charge current property, now should use the WIP
 battery framework,

v2:
 - changed DT node name from ac_power_supply to ac-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),
 - added x-powers,constant-charge-current property to set the maximal
 default constant current charge of the battery,

 .../bindings/power/supply/axp20x_battery.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
new file mode 100644
index 0000000..c248866
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -0,0 +1,20 @@
+AXP20x and AXP22x battery power supply
+
+Required Properties:
+ - compatible, one of:
+			"x-powers,axp209-battery-power-supply"
+			"x-powers,axp221-battery-power-supply"
+
+This node is a subnode of the axp20x/axp22x PMIC.
+
+The AXP20X and AXP22X can read the battery voltage, charge and discharge
+currents of the battery by reading ADC channels from the AXP20X/AXP22X
+ADC.
+
+Example:
+
+&axp209 {
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp209-battery-power-supply";
+	}
+};
-- 
2.9.3
