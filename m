From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 3/3] arm64: tegra: Add CCPLEX_CLUSTER area in Tegra186
Date: Mon, 3 Apr 2017 15:42:25 +0300
Message-ID: <1491223345-24386-3-git-send-email-mperttunen@nvidia.com>
References: <1491223345-24386-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491223345-24386-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
registers that initiate CPU frequency/voltage transitions.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 3ea5e6369bc3..765b840933ac 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -347,6 +347,15 @@
 		reg-names = "pmc", "wake", "aotag", "scratch";
 	};
 
+	ccplex@e000000 {
+		compatible = "nvidia,tegra186-ccplex-cluster";
+		reg = <0x0 0x0e060000 0x0 0x1000>,
+		      <0x0 0x0e070000 0x0 0x1000>;
+		reg-names = "a57", "denver";
+
+		nvidia,bpmp = <&bpmp>;
+	};
+
 	sysram@30000000 {
 		compatible = "nvidia,tegra186-sysram", "mmio-sram";
 		reg = <0x0 0x30000000 0x0 0x50000>;
-- 
2.1.4
