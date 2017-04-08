From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/5] Some Allwinner CCU tweaks and basical DVFS support for H3/H2+
Date: Sun,  9 Apr 2017 02:50:20 +0800
Message-ID: <20170408185025.53841-1-icenowy@aosc.io>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:42528 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdDHSvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Apr 2017 14:51:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>

This patchset aim to add basical DVFS support for Allwinner H3/H2+ SoCs, they
seem to be nearly the same.

The first patch is a CCU fix for all NKMP-type clocks, not H3 limited. Please
schedule this patch to 4.11 queue, as A33 needs also this patch. It solves the
problem that system hangs when the PLL_CPUX change for the first time.

The second patch allows the PLL_CPUX to change for CPUX clock on H3.

The third patch imports a bunch of new SoCs' compatibles into
cpufreq-dt-platdev driver.

The fourth patch adds several operating points for Allwinner H3/H2+ CPU.

The fifth patch adds the regulator node to Orange Pi Zero board's device
tree.

Icenowy Zheng (5):
  clk: sunxi-ng: prevent NKMP clocks from temporarily get higher freq
  clk: sunxi-ng: allow set parent clock (PLL_CPUX) for CPUX clock on H3
  cpufreq: dt: Add support for some new Allwinner SoCs
  ARM: sun8i: h3: add operating-points-v2 table for CPU
  ARM: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 21 +++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                   | 38 +++++++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c               |  2 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                   | 76 +++++++++++++++++++----
 drivers/cpufreq/cpufreq-dt-platdev.c              |  5 ++
 5 files changed, 129 insertions(+), 13 deletions(-)

-- 
2.12.2
