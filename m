From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain to
 exynos4x12 clocks device
Date: Thu, 01 Sep 2016 15:45:50 +0200
Message-ID: <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos4412 clock controller contains some additional clocks for FIMC-ISP
(Camera ISP) subsystem. Registers for those clocks are partially located
in the SOC area, which belongs to ISP power domain.

This patch extends clock controller node with ISP clock sub-node and link
(phandle) to ISP power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 3394bdcf10ae..4daea67546b9 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -74,6 +74,11 @@
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
+
+		isp-clock-controller {
+			compatible = "samsung,exynos4412-isp-clock";
+			power-domains = <&pd_isp>;
+		};
 	};
 
 	mct@10050000 {
-- 
1.9.1
