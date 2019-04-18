From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 3/4] Documentation: devicetree: add PPMU events
 description
Date: Thu, 18 Apr 2019 15:38:31 +0200
Message-ID: <1555594712-18341-4-git-send-email-l.luba@partner.samsung.com>
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133854eucas1p11bd927755163f0030a1748a023099a06@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
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
