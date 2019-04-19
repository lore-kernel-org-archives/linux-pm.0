From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 4/4] DT: arm: exynos4412: add event data type which is
 monitored
Date: Fri, 19 Apr 2019 15:48:08 +0200
Message-ID: <1555681688-19643-5-git-send-email-l.luba@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, willy.mh.wolff.ml@gmail.com, kgene@kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, l.luba@partner.samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

The patch adds new field in the PPMU event which shows explicitly
what kind of data the event is monitoring. It is possible to change it
using defined values in exynos_ppmu.h file.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
index 3a3b2fa..549faba 100644
--- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -6,12 +6,16 @@
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
  */
 
+#include <dt-bindings/pmu/exynos_ppmu.h>
+
 &ppmu_dmc0 {
        status = "okay";
 
        events {
 	       ppmu_dmc0_3: ppmu-event3-dmc0 {
 		       event-name = "ppmu-event3-dmc0";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -22,6 +26,8 @@
        events {
 	       ppmu_dmc1_3: ppmu-event3-dmc1 {
 		       event-name = "ppmu-event3-dmc1";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -32,6 +38,8 @@
        events {
 	       ppmu_leftbus_3: ppmu-event3-leftbus {
 		       event-name = "ppmu-event3-leftbus";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -42,6 +50,8 @@
        events {
 	       ppmu_rightbus_3: ppmu-event3-rightbus {
 		       event-name = "ppmu-event3-rightbus";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
-- 
2.7.4
