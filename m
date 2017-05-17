From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 0/4] amend some properties related clk and cpu for rk322x
Date: Wed, 17 May 2017 12:45:19 +0800
Message-ID: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

These series of patches amend some assigned-clocks and add cpu opp table
for rk322x SoCs.

the following patches on patchwork are required for this changes.
https://patchwork.kernel.org/patch/9627639/
https://patchwork.kernel.org/patch/9703945/
https://patchwork.kernel.org/patch/9703939/
https://patchwork.kernel.org/patch/9707517/

Elaine Zhang (1):
  arm: dts: rk322x: add some assigned-clocks

Finley Xiao (2):
  arm: dts: rk322x: add operating-points-v2 property for cpu
  arm: dts: rk3229: add a new cpu opp table

Rocky Hao (1):
  arm: dts: rk322x: update tsadc's frequence setting

 arch/arm/boot/dts/rk3229-cpu-opp.dtsi | 85 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi         | 52 ++++++++++++++++++---
 2 files changed, 131 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229-cpu-opp.dtsi

-- 
2.0.0


