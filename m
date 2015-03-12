From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 00/17] Add generic PM domain support for Tegra SoCs
Date: Thu, 12 Mar 2015 20:15:01 +0800
Message-ID: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6197 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbCLMPB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 08:15:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>

Hi,

This is the v2 of Tegra generic PM domain support. The v1 is the RFC
series[1].

Patch 1 adds the new function of_reset_control_get_by_index().

Patch 2 - 5 add the MC flush operations for Tegra30/Tegra114/Tegra124.

Patch 6 is a PLLD fix for Tegra114.

Patch 7 is based on Thierry's proof-of-concept work and adds necessary
changes to support DT parsing and power sequence.

Patch 8 - 11 add the power domain nodes into DT.

Patch 12 - 17 are the clean up for the legacy powergate API. 

TODO:
* The GR3D is broken on ToT now. Have to verify it with this series after
   we fix it properly.

v2:
* Add support for Tegra30/Tegra114
* Address Alex's comments 

[1] http://www.spinics.net/lists/linux-tegra/msg21012.html

Thanks,
Vince

Thierry Reding (1):
  soc: tegra: pmc: Add generic PM domain support

Vince Hsu (16):
  reset: add of_reset_control_get_by_index()
  memory: tegra: add mc flush support
  memory: tegra: add flush operation for Tegra30 memory clients
  memory: tegra: add flush operation for Tegra114 memory clients
  memory: tegra: add flush operation for Tegra124 memory clients
  clk: tegra: remove TEGRA_PLL_USE_LOCK for PLLD/PLLD2
  ARM: tegra: add PM domain device nodes to Tegra30 DT
  ARM: tegra: add PM domain device nodes to Tegra114 DT
  ARM: tegra: add PM domain device nodes to Tegra124 DT
  ARM: tegra: add GPU power supply to Jetson TK1 DT
  drm/tegra: dc: remove the power sequence from driver
  PCI: tegra: remove the power sequence from driver
  ata: ahci_tegra: remove power sequence from driver
  drm/tegra: remove GR3D power sequence from driver
  ARM: tegra: select PM_GENERIC_DOMAINS
  soc/tegra: remove lagacy powergate APIs

 arch/arm/boot/dts/tegra114.dtsi             |  43 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts   |   4 +
 arch/arm/boot/dts/tegra124.dtsi             |  86 +++-
 arch/arm/boot/dts/tegra30.dtsi              |  45 +-
 arch/arm/mach-tegra/Kconfig                 |   1 +
 drivers/ata/ahci_tegra.c                    |  11 -
 drivers/clk/tegra/clk-tegra114.c            |   6 +-
 drivers/gpu/drm/tegra/dc.c                  |  46 +-
 drivers/gpu/drm/tegra/gr3d.c                |  32 +-
 drivers/memory/tegra/mc.c                   | 122 ++++++
 drivers/memory/tegra/mc.h                   |   5 +
 drivers/memory/tegra/tegra114.c             | 106 ++++-
 drivers/memory/tegra/tegra124.c             |  38 +-
 drivers/memory/tegra/tegra30.c              |  80 +++-
 drivers/pci/host/pci-tegra.c                |  22 +-
 drivers/reset/core.c                        |  44 +-
 drivers/soc/tegra/pmc.c                     | 657 +++++++++++++++++++++++++---
 include/dt-bindings/power/tegra-powergate.h |  30 ++
 include/linux/reset.h                       |   9 +
 include/soc/tegra/mc.h                      |  46 +-
 include/soc/tegra/pmc.h                     |  22 -
 21 files changed, 1255 insertions(+), 200 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

-- 
2.1.4

