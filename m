From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 4/8] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
Date: Fri, 15 Apr 2016 15:32:51 +0900
Message-ID: <1460701975-24178-5-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, tomasz.figa@gmail.com, s.nawrocki@samsung.com, kgene@kernel.org
Cc: mark.rutland@arm.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, inki.dae@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds the NoCP (Network on Chip Probe) Device Tree node
to measure the bandwidth of memory and g3d in Exynos542x SoC.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7b99cb58d82d..63f84df73c53 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -294,6 +294,42 @@
 		};
 	};
 
+	nocp_mem0_0: nocp@10CA1000 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1000 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_1: nocp@10CA1400 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1400 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem1_0: nocp@10CA1800 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1800 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem1_1: nocp@10CA1C00 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1C00 0x200>;
+		status = "disabled";
+	};
+
+	nocp_g3d_0: nocp@11A51000 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x11A51000 0x200>;
+		status = "disabled";
+	};
+
+	nocp_g3d_1: nocp@11A51400 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x11A51400 0x200>;
+		status = "disabled";
+	};
+
 	gsc_pd: power-domain@10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
-- 
1.9.1
