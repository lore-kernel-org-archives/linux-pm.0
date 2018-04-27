From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/2] dt-bindings: power: add i.MX SCU power domains binding doc
Date: Sat, 28 Apr 2018 02:51:02 +0800
Message-ID: <1524855063-14996-2-git-send-email-aisheng.dong@nxp.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, dongas86@gmail.com, khilman@kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

Some i.MX SoCs contain a system controller that is responsible for
controlling the state of the IPs that are present.
Communication between the host processor running an OS and the system
controller happens through a SCU protocol.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../devicetree/bindings/power/nxp,imx-pd-scu.txt   | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/nxp,imx-pd-scu.txt

diff --git a/Documentation/devicetree/bindings/power/nxp,imx-pd-scu.txt b/Documentation/devicetree/bindings/power/nxp,imx-pd-scu.txt
new file mode 100644
index 0000000..d21cc22
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/nxp,imx-pd-scu.txt
@@ -0,0 +1,84 @@
+NXP i.MX Power Domain Based on SCFW
+--------------------------------------------------------------------
+
+Some i.MX SoCs contain a system controller that is responsible for
+controlling the state of the IPs that are present.
+Communication between the host processor running an OS and the system
+controller happens through a SCU protocol [1].
+
+[1] Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+
+Required Properties:
+--------------------
+- compatible:		should be "nxp,<soc>-pd".
+			Supported SoCs: imx8qxp and imx8qm.
+- #power-domain-cells:	Must be 0
+- #address-cells:	Should be 1.
+- #size-cells:		Should be 0.
+
+Optional Properties:
+- reg:			Resource ID of this power domain.
+			No exist means uncontrollable by user.
+			See detailed Resource ID list from:
+			include/dt-bindings/power/imx-rsrc.h
+
+Required properties for power domain sub nodes:
+- reg:			Resource ID of this power domain.
+- #power-domain-cells:	Must be 0
+- power-domains:	phandle pointing to the parent power domain,
+			for more details see:
+			Documentation/devicetree/bindings/power/power_domain.txt
+
+Example:
+-------------
+	scu {
+		compatible = "nxp,imx8qxp-scu";
+		fsl,mu = <&lsio_mu0>;
+		status = "okay";
+
+		pd_lsio: lsio_power_domain {
+			compatible = "nxp,imx8qxp-pd";
+			#power-domain-cells = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_lsio_pwm0: lsio_pwm0@SC_R_PWM_0 {
+				reg = <SC_R_PWM_0>;
+				#power-domain-cells = <0>;
+				power-domains = <&pd_lsio>;
+			};
+			...
+		}
+
+		pd_dma: dma_power_domain {
+			compatible = "nxp,imx8-pd";
+			#power-domain-cells = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_dma_lpuart0: dma_lpuart0@SC_R_UART_0 {
+				reg = <SC_R_UART_0>;
+				#power-domain-cells = <0>;
+				power-domains = <&pd_dma>;
+			};
+			...
+		}
+		...
+	};
+
+PM Domain Consumers
+===================
+Hardware blocks belonging to a PM domain should contain a "power-domains"
+property that is a phandle pointing to the corresponding PM domain node.
+
+Required Properties:
+--------------------
+- power-domains: phandle pointing to the corresponding PM domain node.
+
+Example:
+--------------------
+	lpuart0: serial@5a060000 {
+		compatible = "fsl,imx8qxp-lpuart";
+		....
+		power-domains = <&pd_dma_lpuart0>;
+	};
-- 
2.7.4
