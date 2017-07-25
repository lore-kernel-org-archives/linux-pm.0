From: Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH 5/5] arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation board
Date: Tue, 25 Jul 2017 17:16:10 +0800
Message-ID: <1500974170-23132-1-git-send-email-rocky.hao@rock-chips.com>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

enable tsadc module on RK3328 eavluation board

Change-Id: Ieb45a02b90dae3fbefe7d2b571b3961412d866ad
Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 8c61d91bf89b..e7db0dc97ce0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -52,6 +52,10 @@
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
1.9.1
