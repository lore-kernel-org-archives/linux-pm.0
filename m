From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v11 6/8] arm64: dts: sdm845: Add interconnect provider DT nodes
Date: Fri,  7 Dec 2018 17:29:15 +0200
Message-ID: <20181207152917.4862-7-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..b3cd256a154e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1324,6 +1324,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rsc_hlos: interconnect {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
