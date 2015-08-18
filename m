From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 0/6] ARM: berlin: add cpufreq support
Date: Tue, 18 Aug 2015 13:46:02 +0200
Message-ID: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33854 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbbHRLqL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 07:46:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

This series adds the cpufreq support to the Berlin SoCs, using
cpufreq-dt.

First, the cpuclk clock is added to the BG2Q clock driver. This clock
has a divider fixed to 1, so we use a fixed factor clock here.

Then register a platform device for cpufreq-dt.

I also added the OPP table definition in the BG2Q, BG2 and BG2CD device
trees. When using a BG2Q, some bootloaders may update this table when
booting (mine doesn't).

Tested on a BG2Q DMP.

Thanks,

Antoine

Changes since v1:
	- added the BG2 and BG2CD support
	- moved MAX_CLKS out of the Berlin clk driver
	- reordered the patches

Antoine Tenart (6):
  clk: berlin: move MAX_CLKS out of drivers/clk/berlin
  clk: berlin: add cpuclk
  ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q
  ARM: berlin: dts: add the cpufreq-dt bindings on the BG2
  ARM: berlin: dts: add the cpufreq-dt bindings on the BG2CD
  ARM: berlin: register cpufreq-dt

 arch/arm/boot/dts/berlin2.dtsi       | 10 ++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi     |  8 ++++++++
 arch/arm/boot/dts/berlin2q.dtsi      | 11 +++++++++++
 arch/arm/mach-berlin/berlin.c        |  6 ++++++
 drivers/clk/berlin/bg2.c             |  1 -
 drivers/clk/berlin/bg2q.c            | 13 ++++++-------
 include/dt-bindings/clock/berlin2.h  |  2 ++
 include/dt-bindings/clock/berlin2q.h |  3 +++
 8 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.5.0

