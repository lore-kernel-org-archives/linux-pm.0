From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH 0/8] thermal: rockchip: Support rk3366/rk3399 SoCS and fixes the driver
Date: Fri, 22 Apr 2016 18:02:46 +0800
Message-ID: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32919 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbcDVKDM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 06:03:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, Heiko Stuebner <heiko@sntech.de>
Cc: dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Matthias Brugger <mbrugger@suse.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org

Hello Eduardo, Heiko
This series pacthes to support the rk3366/rk3399 SoCs thermal, and fixes the driver.

a83d083 thermal: rockchip: disable thermal->clk in err case
5ea5556 thermal: rockchip: fixes the code_to_temp for tsadc driver
da69a2 thermal: rockchip: update the tsadc table for rk3399
571a5b5 thermal: rockchip: handle the power sequence for tsadc controller
e9eb603 thermal: rockchip: Support RK3366 SoCs in the thermal driver
bc0e86f thermal: rockchip: add the notes for better reading
4dc79deb ARM: dts: rockchip: move the rk3288 thermal data into rk3288.dtsi
5e66f50 arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Verified on url =
https://github.com/Caesar-github/rockchip/tree/wip/fixes-rockchip-thermal
Based on linux-next kernel for 20160422

Verified on rk3288/rk3366/rk3399 SoCs with rockchip inside kernel(develop4.4).

The rk3399 dtsi has benn sent on https://patchwork.kernel.org/patch/8905841/.

---



Caesar Wang (6):
  thermal: rockchip: fixes the code_to_temp for tsadc driver
  thermal: rockchip: update the tsadc table for rk3399
  thermal: rockchip: handle the power sequence for tsadc controller
  thermal: rockchip: add the notes for better reading
  ARM: dts: rockchip: move the rk3288 thermal data into rk3288.dtsi
  arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Elaine Zhang (1):
  thermal: rockchip: Support RK3366 SoCs in the thermal driver

Shawn Lin (1):
  thermal: rockchip: disable thermal->clk in err case

 arch/arm/boot/dts/rk3288-thermal.dtsi            | 118 ----------
 arch/arm/boot/dts/rk3288.dtsi                    |  73 +++++-
 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi | 112 ---------
 arch/arm64/boot/dts/rockchip/rk3368.dtsi         |  66 +++++-
 drivers/thermal/rockchip_thermal.c               | 279 +++++++++++++++++------
 5 files changed, 352 insertions(+), 296 deletions(-)
 delete mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi
 delete mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi

-- 
1.9.1

