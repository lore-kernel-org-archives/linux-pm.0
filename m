From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v2 1/3] of: Add binding for NVIDIA Tegra ACTMON node
Date: Mon, 24 Nov 2014 13:28:16 +0100
Message-ID: <1416832111-367-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1416832111-367-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416832111-367-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This block gathers statistics about various counters and can be configured to
fire interrupts when thresholds are crossed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

---

v2:	* Add operating-points property
---
 .../devicetree/bindings/arm/tegra/actmon.txt       | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt

diff --git a/Documentation/devicetree/bindings/arm/tegra/actmon.txt b/Documentation/devicetree/bindings/arm/tegra/actmon.txt
new file mode 100644
index 0000000..b4069df
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/actmon.txt
@@ -0,0 +1,38 @@
+Tegra124 Activity Monitor driver
+
+Required properties:
+
+- compatible: should be "nvidia,tegra124-actmon"
+- reg: offset and length of the register set for the device
+- interrupts: standard interrupt property
+- clocks: Must contain a phandle and clock specifier pair for each entry in clock-names. See ../clock/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - actmon
+  - emc
+- resets: Must contain an entry for each entry in reset-names. See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - actmon
+- operating-points: Supported operating points. See ../power/opp.txt for details.
+
+Example:
+	actmon@6000c800 {
+		compatible = "nvidia,tegra124-actmon";
+		reg = <0x0 0x6000c800 0x0 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
+			 <&tegra_car TEGRA124_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car 119>;
+		reset-names = "actmon";
+		operating-points = <
+			/* kHz	uV */
+			102000	800000
+			204000	800000
+			300000	820000
+			396000	850000
+			528000	880000
+			600000	910000
+			792000	980000
+			924000	1010000
+		>;
+	};
-- 
1.9.3
