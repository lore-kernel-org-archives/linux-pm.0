From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/8] dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
Date: Mon, 30 Jul 2018 10:11:18 +0200
Message-ID: <20180730081124.30698-3-enric.balletbo@collabora.com>
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730081124.30698-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>, kernel@collabora.com, robin.murphy@arm.com, Sean Paul <seanpaul@chromium.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
general register files to know the DRAM type, so add a phandle to the
syscon that manages these registers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v1:
- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring

 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 0ec68141f85a..951789c0cdd6 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -12,6 +12,8 @@ Required properties:
 			 for details.
 - center-supply:	 DMC supply node.
 - status:		 Marks the node enabled/disabled.
+- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
+			 files".
 
 Optional properties:
 - interrupts:		 The CPU interrupt number. The interrupt specifier
-- 
2.18.0
