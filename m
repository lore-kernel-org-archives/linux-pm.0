From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V5 00/14] Add generic PM domain support for Tegra
Date: Thu, 28 Jan 2016 16:33:38 +0000
Message-ID: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9067 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945942AbcA1QeH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 11:34:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>

Adds generic PM domain support for Tegra SoCs but this series only
enables support for it on Tegra 64-bit devices. There is no reason why
this cannot be enable for Tegra 32-bit devices, but to keep the patch
series to a minimum only 64-bit devices are enabled so far.

This series has been boot tested on Tegra210 as well as various 32-bit
Tegra platforms.

Summary of changes since V4 [1]:
- Re-worked fix to handle base address on probe failure
- Added patch to lock around simultaneuous accesses to PMC registers
- Added patch to change powergate and rail IDs to unsigned type
- Added patch to fix testing of powergate state
- Updated patch to check for valid powergates to use a bitmap
- Updated Tegra DT PMC bindings per Rob H's feedback
- Updated Tegra power domains binding per Thierry's feedback
- Updated Tegra generic power domain support per Thierry's feedback

Summary of changes since V3 [0]:
- Dropped tegra124 support for now
- Removed MC flush support per feedback from Thierry
- Cleaned up the PMC changes per feedback from Thierry
- Added support for tegra210

Series Summary:
Patch 1-7:  PMC clean-up and fixes
Patch 8:    Adds function to remove a generic PM domain
Patch 9:    Updates DT documentation for tegra PMC
Patch 10:   Adds DT documentation for tegra generic PM domains
Patch 11:   Adds PMC generic DM domains support
Patch 12:   Adds audio clock for Tegra210 audio power-domain
Patch 13:   Adds DT bindings for Tegra210 audio power-domain
Patch 14:   Enable generic PM domains for tegra64

[0] http://comments.gmane.org/gmane.linux.ports.tegra/22944
[1] http://marc.info/?l=linux-tegra&m=144924153600529&w=2

Jon Hunter (14):
  soc: tegra: pmc: Restore base address on probe failure
  soc: tegra: pmc: Protect public functions from potential race
    conditions
  soc: tegra: pmc: Change powergate and rail IDs to be an unsigned type
  soc: tegra: pmc: Fix testing of powergate state
  soc: tegra: pmc: Wait for powergate state to change
  soc: tegra: pmc: Fix checking of valid partitions
  soc: tegra: pmc: Ensure partitions can be toggled on/off by PMC
  PM / Domains: Add function to remove a pm-domain
  Documentation: DT: bindings: Update NVIDIA PMC for Tegra
  Documentation: DT: bindings: Add power domain info for NVIDIA PMC
  soc: tegra: pmc: Add generic PM domain support
  clk: tegra210: Add the APB2APE audio clock
  ARM64: tegra: Add audio PM domain device node for Tegra210
  ARM64: tegra: select PM_GENERIC_DOMAINS

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  67 ++-
 arch/arm/mach-tegra/platsmp.c                      |  16 +-
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  11 +-
 drivers/base/power/domain.c                        |  26 +
 drivers/clk/tegra/clk-id.h                         |   1 +
 drivers/clk/tegra/clk-tegra-periph.c               |   1 +
 drivers/clk/tegra/clk-tegra210.c                   |   1 +
 drivers/gpu/drm/tegra/drm.h                        |   2 +-
 drivers/soc/tegra/pmc.c                            | 603 ++++++++++++++++++---
 include/dt-bindings/clock/tegra210-car.h           |   2 +-
 include/dt-bindings/power/tegra-powergate.h        |  36 ++
 include/linux/pm_domain.h                          |   5 +
 include/soc/tegra/pmc.h                            |  73 +--
 14 files changed, 709 insertions(+), 137 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

-- 
2.1.4

