From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Subject: [PATCH v2 2/4] cpufreq: dt-bindings: add bindings for mtk-cpufreq driver
Date: Wed,  4 Mar 2015 16:49:14 +0800
Message-ID: <1425458956-20665-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "pi-cheng.chen" <pi-cheng.chen@linaro.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, fan.chen@mediatek.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add dt-binding for mtk-cpufreq driver so that the driver could get SoC specific
information (intermediate_clk for now) from device tree.

Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-mtk.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
new file mode 100644
index 0000000..53bf108
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
@@ -0,0 +1,17 @@
+
+Mediatek cpufreq driver
+-------------------
+
+Mediatek SoC cpufreq driver for CPU frequency scaling.
+
+Required properties:
+- compatible: "mediatek,mtk-cpufreq"
+- intermediate_clk: The intermediate clock source which CPUs will switch to
+during CPU frequency transition.
+
+Examples:
+--------
+	mtk-cpufreq {
+		compatible = "mediatek,mtk-cpufreq";
+		intermediate_clk = <&apmixedsys APMIXED_MAINPLL>;
+	};
-- 
1.9.1
