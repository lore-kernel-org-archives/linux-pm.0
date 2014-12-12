From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv3 7/7] ARM: dts: exynos: Add PPMU dt node to
 Exynos3250-based Rinato board
Date: Fri, 12 Dec 2014 17:27:32 +0900
Message-ID: <1418372852-12454-8-git-send-email-cw00.choi@samsung.com>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: devicetree@vger.kernel.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tomasz.figa@gmail.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch add PPMU dt node to Exynos3250-base Rinato board. The PPMU dt node
is used to get the utilization of DMC0/DMC1/LEFTBUS/RIGHTBUS Block.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 7789442..2888098 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -542,6 +542,46 @@
 	status = "okay";
 };
 
+&ppmu_dmc0 {
+	status = "okay";
+
+	events {
+		ppmu_dmc0_3: ppmu-dmc0-pmcnt3 {
+			event-name = "ppmu-dmc0-pmcnt3";
+		};
+	};
+};
+
+&ppmu_dmc1 {
+	status = "okay";
+
+	events {
+		ppmu_dmc1_3: ppmu-dmc1-pmcnt3 {
+			event-name = "ppmu-dmc1-pmcnt3";
+		};
+	};
+};
+
+&ppmu_leftbus {
+	status = "okay";
+
+	events {
+		ppmu_leftbus_3: ppmu-leftbus-pmcnt3 {
+			event-name = "ppmu-leftbus-pmcnt3";
+		};
+	};
+};
+
+&ppmu_rightbus {
+	status = "okay";
+
+	events {
+		ppmu_rightbus_3: ppmu-rightbus-pmcnt3 {
+			event-name = "ppmu-rightbus-pmcnt3";
+		};
+	};
+};
+
 &xusbxti {
 	clock-frequency = <24000000>;
 };
-- 
1.8.5.5
