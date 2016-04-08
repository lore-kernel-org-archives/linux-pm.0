From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v8 08/20] PM / devfreq: exynos: Add the detailed correlation
 between sub-blocks and power line
Date: Fri, 08 Apr 2016 13:24:57 +0900
Message-ID: <1460089509-16260-9-git-send-email-cw00.choi@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: mark.rutland@arm.com, inki.dae@samsung.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and power line
for Exynos3250, Exynos4210 and Exynos4x12.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index 03f13d38f1a1..b098fa2ba5d4 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -53,6 +53,57 @@ Optional properties only for parent bus device:
 - exynos,voltage-tolerance: the percentage value for bus voltage tolerance
 			which is used to calculate the max voltage.
 
+Detailed correlation between sub-blocks and power line according to Exynos SoC:
+- In case of Exynos3250, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC
+		|--- G3D
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- FSYS
+		|--- LCD0
+		|--- PERIR
+		|--- ISP
+		|--- CAM
+
+- In case of Exynos4210, there is one power line as following:
+	VDD_INT |--- DMC (parent device)
+		|--- LEFTBUS
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- LCD0
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- LCD1
+
+- In case of Exynos4x12, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- IMAGE
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- ISP
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1
