From: <cl@rock-chips.com>
Subject: [PATCH v1 3/3] arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board
Date: Wed, 23 Aug 2017 16:40:32 +0800
Message-ID: <1503477632-9661-4-git-send-email-cl@rock-chips.com>
References: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org, rocky.hao@rock-chips.com, afaerber@suse.de, fabio.estevam@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, Liang Chen <cl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

RK3328 Evaluation Board use rk805 pmic, and one of the DCDCs in
rk805 is for cpu regulator, assign the cpu regulator, so the
cpufreq can work fine.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 479f9d9..b0658f4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -96,6 +96,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
1.9.1
