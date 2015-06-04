From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 03/15] ARM: shmobile: r8a7790 dtsi: Add L2 cache-controller nodes
Date: Thu,  4 Jun 2015 20:53:29 +0200
Message-ID: <1433444021-22167-4-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add device nodes for the L2 caches:
  - The L2 cache for the Cortex-A15 CPU cores is 2 MiB large (organized
    as 128 KiB x 16 ways), and requires the following settings:
      - Tag RAM latency: 3 cycles,
      - Data RAM latency: 4 cycles,
      - Data RAM setup: 1 cycle,
  - The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized
    as 64 KiB x 8 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for a Cortex-A15 L2 cache controller?
---
 arch/arm/boot/dts/r8a7790.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7fbcad087ee384e8..729172090f865e4d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -112,6 +112,30 @@
 		};
 	};
 
+	L2_CA15: cache-controller@0 {
+		compatible = "cache";
+
+		arm,data-latency = <4 4 1>;
+		arm,tag-latency = <3 3 3>;
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x200000>;
+		cache-sets = <4096>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
+	L2_CA7: cache-controller@1 {
+		compatible = "cache";
+
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-sets = <2048>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1
