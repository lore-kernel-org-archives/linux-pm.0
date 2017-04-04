From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 2/3] dt-bindings: Add bindings for nvidia,tegra186-ccplex-cluster
Date: Tue, 4 Apr 2017 16:43:36 +0300
Message-ID: <1491313417-25085-2-git-send-email-mperttunen@nvidia.com>
References: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
registers that initiate CPU frequency/voltage transitions.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- Only one regs entry.
- s/Phandle/phandle/

 .../arm/tegra/nvidia,tegra186-ccplex-cluster.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
new file mode 100644
index 000000000000..e8fb416c892b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
@@ -0,0 +1,17 @@
+NVIDIA Tegra CCPLEX_CLUSTER area
+
+Required properties:
+- compatible: Should contain one of the following:
+  - "nvidia,tegra186-ccplex-cluster": for Tegra186
+- reg: Must contain an (offset, length) pair of the device's MMIO
+  register area
+- nvidia,bpmp: phandle to BPMP device that can be queried for OPP tables
+
+Example:
+
+	ccplex@e000000 {
+		compatible = "nvidia,tegra186-ccplex-cluster";
+		reg = <0x0 0x0e000000 0x0 0x3fffff>,
+
+		nvidia,bpmp = <&bpmp>;
+	};
-- 
2.1.4
