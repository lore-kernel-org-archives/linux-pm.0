From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 0/4] amend some properties related clk and cpu for rk322x
Date: Wed, 17 May 2017 18:16:13 +0800
Message-ID: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:50719 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdEQKQ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 06:16:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>

These series of patches amend some assigned-clocks and add cpu opp table
for rk322x SoCs.

the following patches on patchwork are required for this change.
https://patchwork.kernel.org/patch/9627639/
https://patchwork.kernel.org/patch/9703945/
https://patchwork.kernel.org/patch/9703939/
https://patchwork.kernel.org/patch/9707517/

Changes from v1:
 - Updated the 'Signed-off-by' tag with original authors' email id.
 - Updated the 'Acked-by' tag from Viresh Kumar <viresh.kumar@linaro.org>.

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
