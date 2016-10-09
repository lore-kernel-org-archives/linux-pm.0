From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH v2 3/4] ARM: dts: add battery node for axp20x/axp22x dtsi
Date: Sun,  9 Oct 2016 14:27:13 +0800
Message-ID: <20161009062714.5085-3-icenowy@aosc.xyz>
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

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Add support for AXP20x.

 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index afbe89c..1602987 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -91,6 +91,11 @@
 		};
 	};
 
+	battery: battery {
+		compatible = "x-powers,axp202-battery";
+		status = "disabled";
+	};
+
 	usb_power_supply: usb_power_supply {
 		compatible = "x-powers,axp202-usb-power-supply";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 458b668..a09ba3f 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -148,6 +148,11 @@
 		};
 	};
 
+	battery: battery {
+		compatible = "x-powers,axp221-battery";
+		status = "disabled";
+	};
+
 	usb_power_supply: usb_power_supply {
 		compatible = "x-powers,axp221-usb-power-supply";
 		status = "disabled";
-- 
2.10.0
