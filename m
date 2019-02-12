From: Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 1/6] mfd: Support for Ettus Research E31x devices PMU
Date: Mon, 11 Feb 2019 19:01:38 -0600
Message-ID: <20190212010143.3729-2-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com, Virendra Kakade <virendra.kakade@ni.com>
List-Id: linux-pm@vger.kernel.org

Document bindings for E31x device PMU MFD driver.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 Documentation/devicetree/bindings/mfd/e31x-pmu.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt

diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
new file mode 100644
index 000000000000..ebb5625f6c74
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
@@ -0,0 +1,14 @@
+Ettus Research/National Instruments E31x PMU MFD driver
+
+Required properties:
+- compatible : Must be "ni,e31x-pmu"
+- regmap     : Must be <&regmapnode>
+
+Example:
+
+pmu {
+	compatible = "ni,e31x-pmu";
+	regmap = <&devctrl>;
+	status = "okay";
+};
+
-- 
2.17.1
