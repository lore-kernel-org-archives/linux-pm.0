From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 3/4] Documentation: devicetree: add PPMU events description
Date: Fri, 19 Apr 2019 15:48:07 +0200
Message-ID: <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
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

Extend the documenation by events description with new 'event-data-type'
field. Add example how the event might be defined in DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index 3e36c1d..47feb5f 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
 			reg = <0x104d0000 0x2000>;
 			status = "disabled";
 		};
+
+The 'event' type specified in the PPMU node defines 'event-name'
+which also contains 'id' number and optionally 'event-data-type'.
+
+Example:
+
+		events {
+			ppmu_leftbus_0: ppmu-event0-leftbus {
+				event-name = "ppmu-event0-leftbus";
+				event-data-type = <PPMU_RO_DATA_CNT>;
+			};
+		};
+
+The 'event-data-type' defines the type of data which shell be counted
+by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
+all possible type, i.e. count read requests, count write data in bytes,
+etc. This field is optional and when it is missing, the driver code will
+use default data type.
-- 
2.7.4
