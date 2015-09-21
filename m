From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 0/5] Support the thermal for RK3368 SoCs
Date: Mon, 21 Sep 2015 12:16:06 +0800
Message-ID: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34159 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbIUEQc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 00:16:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, will.deacon@arm.com, robh+dt@kernel.org, inux-kernel@vger.kernel.org, galak@codeaurora.org, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, mark.rutland@arm.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ijc+devicetree@hellion.org.uk, Caesar Wang <wxt@rock-chips.com>

This series patchs are working for RK3368 on Rockchip platform.

This patchset are based on linus master branch.
(Note: add Dmitry two thermal patchs for rockchip
 https://patchwork.kernel.org/patch/6973101/
 https://patchwork.kernel.org/patch/6973131/
)

the git log oneline as follows:

30451f4 arm64: dts: Enable the Thermal on R88 board.
1637a7c arm64: dts: Add main Thermal info to rk3368.dtsi
8f908b7 arm64: dts: Add the thermal data found on RK3368
a501fad thermal: rockchip: Support the RK3368 SoCs in thermal driver
c765254 dt-bindings: thermal: Support the RK3368 SoCs compatible
ff7fd5d thermal: rockhip: fix setting thermal shutdown polarity
f54373c thermal: rockchip: fix handling of invalid readings
0410a40 arm64: dts: rockchip: Add the needed timer for RK3368 SoC
f696cac arm64: Enable the timer on Rockchip architecture
e84d626 clocksource: rockchip: Make the driver more readability and compatible
1f93e4a Linux 4.3-rc2
.....

@Heiko,
The PATCH [4/5] is working based on big/littel cluster cpufreq added.
Anyway, the PATCH [4/5] also work for next kernel.

@Eduardo,

The PATCH[2/4] is based on the Dmitry's patchs.

 https://patchwork.kernel.org/patch/6973101/
 https://patchwork.kernel.org/patch/6973131/

---
This series are tested on RK3368 board.

while true;do ls >/dev/null; done&

while true; do grep "" /sys/class/thermal/thermal_zone[1-2]/temp;date;sleep .5;
done &

You can get the temperature form sensors.

/sys/class/thermal/thermal_zone0/temp:27500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:30000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:27500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:30000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:32500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:30000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:22500
/sys/class/thermal/thermal_zone1/temp:32500
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:22500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:30000
/sys/class/thermal/thermal_zone1/temp:32500
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:32500
/sys/class/thermal/thermal_zone0/temp:32500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:32500



Caesar Wang (5):
  dt-bindings: thermal: Support the RK3368 SoCs compatible
  thermal: rockchip: Support the RK3368 SoCs in thermal driver
  arm64: dts: Add the thermal data found on RK3368
  arm64: dts: Add main Thermal info to rk3368.dtsi
  arm64: dts: Enable the Thermal on R88 board

 .../bindings/thermal/rockchip-thermal.txt          |   4 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   6 +
 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi   | 112 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  30 +++
 drivers/thermal/rockchip_thermal.c                 | 201 ++++++++++++++++++---
 5 files changed, 327 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi

-- 
1.9.1

