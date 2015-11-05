From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 0/9] Better compatible for the rockchip thermal and support RK3368 SoCs
Date: Thu,  5 Nov 2015 13:17:56 +0800
Message-ID: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36316 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbbKEFS3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 00:18:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

This series patchs are working for RK3368 on Rockchip platform.

@Heiko,
    The PATCH [5/6] is working based on big/littel cluster cpufreq
    added. Anyway, the PATCH [5/6] also work for next kernel.

@Eduardo,
This patchset are based on linus master branch.
Note: Need add the following thermal patchs for thermal driver before apply
this series patchs.

1) thermal: rockchip: fix handling of invalid readings
(https://patchwork.kernel.org/patch/6973101/)

2) thermal: rockhip: fix setting thermal shutdown polarity
(https://patchwork.kernel.org/patch/6973131/)

3) dt-bindings: rockchip-thermal: Add the pinctrl states in this document
(https://patchwork.kernel.org/patch/7472021/)

4) thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
(https://patchwork.kernel.org/patch/7472051/)

I'm glad these patchs have merged in thermal-soc git tree which can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git

the git log oneline my local branch as follows:
3e2c90b arm64: dts: Enable the Thermal on R88 board
a33ee26 arm64: dts: Add main Thermal info to rk3368.dtsi
fc051c9 arm64: dts: Add the thermal data found on RK3368
d6e7126 thermal: rockchip: Support the RK3368 SoCs in thermal drivers
d16eb7f thermal: rockchip: Add the flag for adc value increment or decrement
acc3ead thermal: rockchip: improve the conversion function
f295e0b thermal: rockchip: trivial: fix typo in commit
2291fc3 thermal: rockchip: better to compatible the driver for different SoCs
e18e646 dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible

29eb0c7 thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
cf2100b dt-bindings: rockchip-thermal: Add the pinctrl states in this document
38e287b0 thermal: rockhip: fix setting thermal shutdown polarity
ddee4a2 thermal: rockchip: fix handling of invalid readings
8a28d67 Merge tag 'powerpc-4.3-6' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
977bf06 powerpc/dma: dma_set_coherent_mask() should not be GPL only
a22c4d7 block: re-add discard_granularity and alignment checks
23d8827 Merge branch 'fixes' of git://ftp.arm.linux.org.uk/~rmk/linux-arm
3d0aa36 Merge branch 'for-linus' of git://git.kernel.dk/linux-block
dc5bc3f Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
9e17f90 Merge tag 'fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux
174fd8d blkcg: fix incorrect read/write sync/async stat accounting
858e904 Merge tag 'iommu-fixes-v4.3-rc7' of
......

----
This series are tested on RK3368 board.

while true;do ls >/dev/null; done&

while true; do grep "" /sys/class/thermal/thermal_zone[0-1]/temp; sleep .5; done &

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
/sys/class/thermal/thermal_zone1/temp:32500
/sys/class/thermal/thermal_zone0/temp:32500


Changes in v2:
- As Eduardo comments on patch v1, split in smaller changes.
- make the conversion table in as a parameter both code_to_temp
  and temp_to_code function.
Series-changes: 1
- As Dmitry comment, make the conversion table in as a parameter.
- remove some unused, completed on other patchs.
- fix a copy wrong name.
Series-changes: 1
- support the opt gpio pinctrl state

Changes in v1:
- %s/thermal/rockchip-thermal in subject.
- add a new patch for thermal driver to support more SoCs.

Caesar Wang (9):
  dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible
  thermal: rockchip: better to compatible the driver for different SoCs
  thermal: rockchip: trivial: fix typo in commit
  thermal: rockchip: improve the conversion function
  thermal: rockchip: Add the flag for adc value increment or decrement
  thermal: rockchip: Support the RK3368 SoCs in thermal drivers
  arm64: dts: Add the thermal data found on RK3368
  arm64: dts: Add main Thermal info to rk3368.dtsi
  arm64: dts: Enable the Thermal on R88 board

 .../bindings/thermal/rockchip-thermal.txt          |   4 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   6 +
 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi   | 112 ++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  36 +++
 drivers/thermal/rockchip_thermal.c                 | 312 +++++++++++++++------
 5 files changed, 389 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi

-- 
1.9.1

