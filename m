From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 0/4] clk: rockchip: support clock controller for px30 SoC
Date: Thu, 25 Apr 2019 18:12:30 +0800
Message-ID: <1556187154-22632-5-git-send-email-zhangqing@rock-chips.com>
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Change in V3:
[PATCH v3 1/4]: Correct description
[PATCH v3 2/4]: Use an SPDX tag instead.
[PATCH v3 3/4]: Use an SPDX tag instead,
		parent_rate might overflow and fix it.
		fix up the checkpatch warning.
		add more CMPOSITE_xxx_HALFdiv.

Change in V2:
[PATCH v2 2/4]: modify the Author name
[PATCH v2 3/4]: provide a bit more explanation for commit message

Elaine Zhang (4):
  dt-bindings: add bindings for px30 clock controller
  clk: rockchip: add dt-binding header for px30
  clk: rockchip: add support for half divider
  clk: rockchip: add clock controller for px30

 .../bindings/clock/rockchip,px30-cru.txt           |   66 ++
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-half-divider.c            |  231 +++++
 drivers/clk/rockchip/clk-px30.c                    | 1080 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |  126 ++-
 include/dt-bindings/clock/px30-cru.h               |  389 +++++++
 7 files changed, 1903 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c
 create mode 100644 drivers/clk/rockchip/clk-px30.c
 create mode 100644 include/dt-bindings/clock/px30-cru.h

-- 
1.9.1
