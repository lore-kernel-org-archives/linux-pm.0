From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 0/3] thermal: rockchip: fix up thermal driver
Date: Mon,  1 Apr 2019 14:43:02 +0800
Message-ID: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

1. add pinctrl control.
2. support PX30 soc

Elaine Zhang (3):
  thermal: rockchip: add pinctrl control
  dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
  thermal: rockchip: Support the PX30 SoC in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |   1 +
 drivers/thermal/rockchip_thermal.c                 | 100 ++++++++++++++++++---
 2 files changed, 90 insertions(+), 11 deletions(-)

-- 
1.9.1
