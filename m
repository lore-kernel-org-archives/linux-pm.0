From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/3] ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
Date: Mon, 24 Nov 2014 21:10:06 +0100
Message-ID: <1416859808-18503-2-git-send-email-geert+renesas@glider.be>
References: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a node for the Bus State Controller (BSC) on sh73a0, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain A4S.

For now no device tree bindings have been defined yet. All of its
properties follow standard conventions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 87e7d5ef904bde89..b8d4c557c85eca0c 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -997,4 +997,15 @@
 				"intca0";
 		};
 	};
+
+	bsc: bus@fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xfec10000 0x400>;
+		ranges = <0 0 0x20000000>;
+		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&zb_clk>;
+		power-domains = <&pd_a4s>;
+	};
 };
-- 
1.9.1
