From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 00/13] add power domain support for Rockchip Socs
Date: Wed, 23 May 2018 14:48:36 +0800
Message-ID: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

add power domain support for RK3036/RK3128/RK3228/PX30 Soc.
fix up the wrong value when set power domain up.

Change in V2:
Fix up the commit message description and Assign author.

Change in V3:
[PATCH 01/13]: The Copyright description use SPDX tag instead.
[PATCH 05/13]: The Copyright description use SPDX tag instead.
[PATCH 08/13]: The Copyright description use SPDX tag instead.
[PATCH 11/13]: The Copyright description use SPDX tag instead.

Caesar Wang (3):
  dt-bindings: power: add RK3036 SoCs header for power-domain
  dt-bindings: add binding for rk3036 power domains
  Soc: rockchip: power-domain: add power domain support for rk3036

Elaine Zhang (6):
  dt-bindings: power: add RK3128 SoCs header for power-domain
  dt-bindings: add binding for rk3128 power domains
  soc: rockchip: power-domain: add power domain support for rk3128
  dt-bindings: power: add RK3228 SoCs header for power-domain
  dt-bindings: add binding for rk3228 power domains
  soc: rockchip: power-domain: add power domain support for rk3228

Finley Xiao (4):
  soc: rockchip: power-domain: Fix wrong value when power up pd
  dt-bindings: power: add PX30 SoCs header for power-domain
  dt-bindings: add binding for px30 power domains
  soc: rockchip: power-domain: add power domain support for px30

 .../bindings/soc/rockchip/power_domain.txt         |  12 +++
 drivers/soc/rockchip/pm_domains.c                  | 116 ++++++++++++++++++++-
 include/dt-bindings/power/px30-power.h             |  27 +++++
 include/dt-bindings/power/rk3036-power.h           |  13 +++
 include/dt-bindings/power/rk3128-power.h           |  14 +++
 include/dt-bindings/power/rk3228-power.h           |  21 ++++
 6 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/px30-power.h
 create mode 100644 include/dt-bindings/power/rk3036-power.h
 create mode 100644 include/dt-bindings/power/rk3128-power.h
 create mode 100644 include/dt-bindings/power/rk3228-power.h

-- 
1.9.1
