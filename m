From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V6 10/10] ARM64: tegra: Add audio PM domain device node for Tegra210
Date: Fri, 26 Feb 2016 15:48:44 +0000
Message-ID: <1456501724-28477-11-git-send-email-jonathanh@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1505 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933449AbcBZPt3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 10:49:29 -0500
In-Reply-To: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add the audio power-domain for tegra210. Note that this also removes the
existing "#power-domain-cells" which was incorrectly included by
commit e53095857166 ("arm64: tegra: Add Tegra210 support").

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

---

So far I have only added the audio power-domain for tegra210 as this is
what I have been testing with to date. However, once this series is
accepted then we can begin to add more.

 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index cd4f45ccd6a7..d2b6bb4eb202 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra210-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/power/tegra-powergate.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -581,7 +582,18 @@
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 
-		#power-domain-cells = <1>;
+		powergates {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_audio: aud {
+				reg = <TEGRA_POWERGATE_AUD>;
+				clocks = <&tegra_car TEGRA210_CLK_APE>,
+					 <&tegra_car TEGRA210_CLK_APB2APE>;
+				resets = <&tegra_car 198>;
+				#power-domain-cells = <0>;
+			};
+		};
 	};
 
 	fuse@0,7000f800 {
-- 
2.1.4

