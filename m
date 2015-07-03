From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH RFC 0/5] cpufreq support for Marvell Armada 38x
Date: Fri,  3 Jul 2015 08:11:52 +0200
Message-ID: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55162 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754031AbbGCGML (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:12:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Hi,

This series of patches adds cpufreq support for the Marvell Armada 38x
processor. It is done in the same way it was done for Armada XP. It
was based on the work of Nadav Haklai and Neta Zur.

The first patch extends the clk-cpu clock family with the support of
the Armada 38x SoCs

The second and the third patches prepare the pmsu part to add Armada
38x support.

The third patch really add the cpufreq support, the main differences
with Armada XP is that Armada 38x SoCs uses cortex A9 and that the
frequency of the CPUs are not independent.

Then the last patch update the deice tree in order to activate this
feature.

This is still an RFC because there is still some stability issue to
fix with the current code.The solution has been found but still need
time to write it properly. As most of the code is already there your
feedback is very welcome.

Thanks,

Gregory

Gregory CLEMENT (5):
  clk: mvebu: Add Armada 38x support for clk-cpu
  ARM: mvebu: Use shorter register definition in pmsu.c
  ARM: mvebu: Made the dynamic frequency scaling support more generic
  ARM: mvebu: Armada 38x: Add dynamic frequency scaling support in pmsu
  ARM: mvebu: Update Armada 38x DT for dynamic frequency scaling

 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  27 ++-
 arch/arm/boot/dts/armada-380.dtsi                  |   3 +
 arch/arm/boot/dts/armada-385.dtsi                  |   6 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   9 +
 arch/arm/mach-mvebu/pmsu.c                         | 207 ++++++++++++-------
 drivers/clk/mvebu/clk-cpu.c                        | 220 ++++++++++++++++-----
 6 files changed, 353 insertions(+), 119 deletions(-)

-- 
2.1.0

