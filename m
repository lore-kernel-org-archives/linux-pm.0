From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v1 4/4] ARM: dts: k2hk-evm: attach net,
 qmss and knav_dmas to keystone-gpc
Date: Mon, 29 Sep 2014 17:38:19 +0300
Message-ID: <1412001499-19369-5-git-send-email-grygorii.strashko@ti.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: santosh.shilimkar@ti.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, khilman@linaro.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Grygorii Strashko <grygorii.strashko@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Attach Keystone 2s nodes for NetCP, NetCPx, QMSS, KNAV-DMA devices
to the TI Keystone 2 Generic PM Controller.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 91371f7..c1ceaa2 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -58,6 +58,7 @@
 				clock-output-names = "refclk-ddr3b";
 			};
 		};
+
 		qmss: qmss@2a40000 {
 			compatible = "ti,keystone-navigator-qmss";
 			dma-coherent;
@@ -65,6 +66,8 @@
 			#size-cells = <1>;
 			clocks = <&chipclk13>;
 			ranges;
+			power-domains = <&pm_controller>;
+
 			queue-range	= <0 0x4000>;
 			linkram0	= <0x100000 0x8000>;
 			linkram1	= <0x0 0x10000>;
@@ -198,6 +201,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			power-domains = <&pm_controller>;
+
 			ti,navigator-cloud-address = <0x23a80000 0x23a90000
 						   0x23aa0000 0x23ab0000>;
 
@@ -229,6 +234,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			power-domains = <&pm_controller>;
 
 			clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
 			dma-coherent;
@@ -307,6 +313,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			power-domains = <&pm_controller>;
 
 			clocks = <&clkxge>;
 			clock-names = "clk_xge";
-- 
1.9.1
