From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH 0/2] Rockchip SoC thermal driver
Date: Sat, 23 Aug 2014 08:15:32 +0800
Message-ID: <1408752934-18318-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.4]:52596 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaHWAQd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 20:16:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com, rdunlap@infradead.org, heiko@sntech.de
Cc: cf@rock-chips.com, grant.linkely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, zyw@rock-chips.com, huangtao@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, dianders@chromium.org, Caesar Wang <caesar.wang@rock-chips.com>

This series adds support for the thermal Found on Rockhip SoCs.

Caesar Wang (2):
  dt-bindings: document Rockchip thermal
  thermal: rockchip: add driver for Rockchip thermal

Tested on rk3288 Board.
 .../bindings/thermal/rockchip-thermal.txt          |   33 +
 drivers/thermal/Kconfig                            |    9 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/rockchip_thermal.c                 |  659 ++++++++++++++++++++
 4 files changed, 702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.7.9.5


