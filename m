From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 06/25] ARM: dtsi: axp209: add AXP209 ADC subnode
Date: Fri, 27 Jan 2017 09:54:39 +0100
Message-ID: <20170127085458.18270-7-quentin.schulz@free-electrons.com>
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

X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the ADC subnode for AXP20X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - removed #io-channels property (the IIO channels mapping is done by
 using iio_map structure in the ADC driver),

 arch/arm/boot/dts/axp209.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 675bb0f..00f6ff5 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -53,6 +53,10 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp209_adc: adc {
+		compatible = "x-powers,axp209-adc";
+	};
+
 	axp_gpio: gpio {
 		compatible = "x-powers,axp209-gpio";
 		gpio-controller;
-- 
2.9.3
