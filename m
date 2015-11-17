From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 20/27] Documentation: ARM: topology: 'cluster' property for cluster nodes
Date: Tue, 17 Nov 2015 15:37:44 -0700
Message-ID: <1447799871-56374-21-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robherring2@gmail.com>
List-Id: linux-pm@vger.kernel.org

Add a place holder phandle for a cluster to define cluster specific
properties like PM domain definitions etc.

Cc: Rob Herring <robherring2@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/arm/topology.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
index 1061faf..12b4082 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -109,6 +109,14 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
 	The cluster node name must be "clusterN" as described in 2.1 above.
 	A cluster node can not be a leaf node.
 
+	Properties for a cluster node are -
+
+	-cluster
+		Usage: Optional
+		Value type: <phandle>
+		Definition: a phandle to a cluster node that corresponds to
+			    this cluster.
+
 	A cluster node's child nodes must be:
 
 	- one or more cluster nodes; or
-- 
2.1.4
