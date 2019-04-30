From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 0/3] thermal: rockchip: fix up thermal driver
Date: Tue, 30 Apr 2019 18:09:43 +0800
Message-ID: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

1. add pinctrl control.
2. support PX30 soc

change in V3:
PATCH V3 1/3: remove panic.
PATCH V3 2/3: No change in V3.
PATCH V3 2/3: No change in V3

change in V2:
PATCH V2 1/3: keep tshut_mode TSHUT_MODE_GPIO;
              In case of pinctrl get or lookup error, just bail out;
              No need to use the thermal_pinctrl_select_otp/gpio wrappers,
              just replace them with:
PATCH V2 2/3: No change in V2.
PATCH V2 2/3: keep tshut_mode TSHUT_MODE_GPIO;
              Remove the grf in 'rk_tsadcv4_initialize' function.

Elaine Zhang (3):
  thermal: rockchip: fix up the tsadc pinctrl setting error
  dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
  thermal: rockchip: Support the PX30 SoC in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 drivers/thermal/rockchip_thermal.c                 | 74 +++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

-- 
1.9.1
