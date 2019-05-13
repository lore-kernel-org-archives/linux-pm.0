From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v4 2/5] dt-bindings: imx-cpufreq-dt: Document opp-supported-hw
 usage
Date: Mon, 13 May 2019 11:01:39 +0000
Message-ID: <7948ab63fe5c92da280542a9a372349486d40c65.1557742902.git.leonard.crestez@nxp.com>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1557742902.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-ID: <1609FAC9533FF0449E0A30AD2B339619@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Aisheng Dong <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

The interpretation of opp-supported-hw bits for imx-cpufreq-dt driver is
not very obvious so attempt to explain it.

There is no OF compat string associated.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../bindings/cpufreq/imx-cpufreq-dt.txt       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt b/Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
new file mode 100644
index 000000000000..87bff5add3f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
@@ -0,0 +1,37 @@
+i.MX CPUFreq-DT OPP bindings
+================================
+
+Certain i.MX SoCs support different OPPs depending on the "market segment" and
+"speed grading" value which are written in fuses. These bits are combined with
+the opp-supported-hw values for each OPP to check if the OPP is allowed.
+
+Required properties:
+--------------------
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: Two bitmaps indicating:
+  - Supported speed grade mask
+  - Supported market segment mask
+    0: Consumer
+    1: Extended Consumer
+    2: Industrial
+    3: Automotive
+
+Example:
+--------
+
+opp_table {
+	compatible = "operating-points-v2";
+	opp-1000000000 {
+		opp-hz = /bits/ 64 <1000000000>;
+		/* grade >= 0, consumer only */
+		opp-supported-hw = <0xf>, <0x3>;
+	};
+
+	opp-1300000000 {
+		opp-hz = /bits/ 64 <1300000000>;
+		opp-microvolt = <1000000>;
+		/* grade >= 1, all segments */
+		opp-supported-hw = <0xe>, <0x7>;
+	};
+}
-- 
2.17.1
