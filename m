From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH 0/8] Support and fixes the rk3228 SoCS for thermal
Date: Mon, 15 Feb 2016 15:33:25 +0800
Message-ID: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hello Eduardo, Heiko, Michael & Stephen:

This series pacthes to support the rk3228 SoCs thermal.

They have the following patches to work on rk3228 SoCs.

1a6f334 clk: rockchip: add id of the tsadc clock found on rk3228 SoCs
8cf2d1b clk: rockchip: add the tsadc clocks found on rk3228 SoCs
bd2720c thermal: rockchip: fix a impossible condition caused by the warning
df9c1bd thermal: rockchip: fix calculation error for code_to_temp
fb11fbd thermal: rockchip: the rename compatibles for rockchip SoCs
b907b75 thermal: rockchip: fix the tsadc sequence output on rk3228/rk3399
bdc79c0 ARM: dts: rockchip: add the thermal main info found on rk3228
22ea3c3 ARM: dts: rockchip: enable the tsadc for rk3228 evb

Verified on https://github.com/Caesar-github/rockchip/tree/rk3228-thermal-tests.
This series patches are based on
Linux version 4.5.0-rc4+ (wxt@ubuntu) (...) (GCC) ) #204 SMP Mon Feb 15 14:12:16 CST 6

Tests:

1) Get the temperature in every 500ms.

while true;do ls >/dev/null; done&
while true; do grep "" /sys/class/thermal/thermal_zone0/temp; sleep
.5; done &

2) critical tests
**
/sys/devices/virtual/thermal/thermal_zone0 # cat temp
33000
/sys/devices/virtual/thermal/thermal_zone0 # echo 30000 > trip_point_2_temp
[  988.114192] thermal thermal_zone0: critical temperature reached(33 C),shutting down
...
shutdown
-
**via modify the dts over-temperature protectiong value to trigger otp pin.

Verified on rk3228/rk3288/rk3368 SoCs.
---

Hi Michael,Stephen
PATCH[1/8-2/8]:
Add the tsadc needed clocks for rk3228 SoCs

Hi Eduardo,
PATCH[3/8]:
To fix a build warning came from Dan Carpenter report smatch check,
Thanks.
As the patch exists in https://patchwork.kernel.org/patch/7757311/

PATCH[4/8]:
fix calculation error for code_to_temp
That's a error since the copy causes.

PATCH[5/8]:
the rename compatibles for rockchip SoCs
As the more and more rockchip SOCs are supported in thermal driver. this pacth
supposed to be compatible for better.

PATCH[6/8]:
fix the tsadc sequence output on rk3228/rk3399
Fixes the tsadc sequence output since the rk3228/rk3399 SoCs design.

Hi Heiko,
PATCH[7/8-8/8]: thermal DTS
1) add the thermal main info found on rk3228
2) enable the tsadc for rk3228 evb

I'd appreciate if someone have free time to review that. :)



Caesar Wang (7):
  clk: rockchip: add id of the tsadc clock found on rk3228 SoCs
  clk: rockchip: add the tsadc clocks found on rk3228 SoCs
  thermal: rockchip: fix a impossible condition caused by the warning
  thermal: rockchip: the rename compatibles for rockchip SoCs
  thermal: rockchip: fix the tsadc sequence output on rk3228/rk3399
  ARM: dts: rockchip: add the thermal main info found on rk3228
  ARM: dts: rockchip: enable the tsadc for rk3228 evb

Elaine Zhang (1):
  thermal: rockchip: fix calculation error for code_to_temp

 arch/arm/boot/dts/rk3228-evb.dts       |   7 +
 arch/arm/boot/dts/rk3228.dtsi          |  69 ++++++++++
 drivers/clk/rockchip/clk-rk3228.c      |   4 +-
 drivers/thermal/rockchip_thermal.c     | 239 +++++++++++++++++++--------------
 include/dt-bindings/clock/rk3228-cru.h |   2 +
 5 files changed, 216 insertions(+), 105 deletions(-)

-- 
1.9.1

