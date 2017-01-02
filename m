From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 06/22] ARM: dtsi: axp22x: add AXP22X ADC subnode
Date: Mon,  2 Jan 2017 17:37:06 +0100
Message-ID: <20170102163723.7939-7-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

X-Powers AXP22X PMIC has multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the ADC subnode for AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 458b668..a2c4401 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -52,6 +52,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp221_adc: axp221_adc {
+		compatible = "x-powers,axp221-adc";
+		#io-channel-cells = <1>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.9.3
