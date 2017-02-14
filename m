From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Tue, 14 Feb 2017 10:40:55 +0100
Message-ID: <20170214094112.27426-2-quentin.schulz@free-electrons.com>
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

This adds the constant-charge-current property to the list of optional
properties of the battery.

The constant charge current is critical for batteries as they can't
handle all charge currents.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v3

 Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index d78a4aa..3e830fe 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -7,6 +7,7 @@ Optional Properties:
  - voltage-min-design-microvolt: drained battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
+ - constant-charge-current-microamp: battery constant charge current
 
 Future Properties must be named for the corresponding elements in
 enum power_supply_property, defined in include/linux/power_supply.h.
@@ -22,6 +23,7 @@ Example:
 		voltage-min-design-microvolt = <3200000>;
 		energy-full-design-microwatt-hours = <5290000>;
 		charge-full-design-microamp-hours = <1430000>;
+		constant-charge-current-microamp = <300000>;
 	};
 
 	charger: charger@11 {
-- 
2.9.3
