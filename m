From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 2/4] ARM: dtsi: axp81x: add AC power supply subnode
Date: Thu,  4 Oct 2018 22:34:08 +0300
Message-ID: <20181004193410.7265-3-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 043c717dcef1..67c17151b584 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -69,6 +69,11 @@
 		};
 	};
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp813-battery-power-supply";
 		status = "disabled";
-- 
2.17.1
