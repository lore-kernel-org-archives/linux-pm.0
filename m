From: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v5 4/8] Documentation: bindings: add dt documentation for dfi
 controller
Date: Wed, 10 Aug 2016 11:26:40 +0800
Message-ID: <1470799604-12877-5-git-send-email-hl@rock-chips.com>
References: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1470799604-12877-1-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the documentation for rockchip dfi devfreq-event driver.

Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v5:
-None

Changes in v4:
-None

Changes in v3:
-None

Changes in v2:
-None 

Changes in v1:
-None

 .../bindings/devfreq/event/rockchip-dfi.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
new file mode 100644
index 0000000..bf42255
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
@@ -0,0 +1,20 @@
+
+* Rockchip rk3399 DFI device
+
+Required properties:
+- compatible: Must be "rockchip,rk3399-dfi".
+- reg: physical base address of each DFI and length of memory mapped region
+- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
+- clocks: phandles for clock specified in "clock-names" property
+- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
+
+Example:
+	dfi: dfi@0xff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
-- 
1.9.1
