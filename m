From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH v2 4/4] ARM: sunxi: enable battery on reference design tablets
Date: Sun,  9 Oct 2016 14:27:14 +0800
Message-ID: <20161009062714.5085-4-icenowy@aosc.xyz>
References: <20161009062714.5085-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161009062714.5085-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserser.org>, Michael Haas <haas@computerlinguist.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Icenowy Zheng <icenowy@aosc.xyz>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Since battery is one part of the reference design of Allwinner tablets,
enable the battery node of reference design tablets.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Applied to reference design tablet, not Q8 only now.
- Add support for sun5i reference design tablet.

 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 4 ++++
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 20cc940..9e17b46 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -92,6 +92,10 @@
 
 #include "axp209.dtsi"
 
+&battery {
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_ldo2>;
 };
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 9d90361..74517ab 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -112,6 +112,10 @@
 
 #include "axp22x.dtsi"
 
+&battery {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.10.0
