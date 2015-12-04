From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 00/16] Add generic PM domain support for Tegra
Date: Fri, 4 Dec 2015 14:57:01 +0000
Message-ID: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Adds generic PM domain support for Tegra SoCs but so far it is only
enabled Tegra 64-bit devices. There is no reason why this cannot be
enabled for Tegra 32-bit devices, but to keep the patch series to a
minimum only 64-bit devices are enabled.

This series has been boot tested on Tegra210 as well as various 32-bit
Tegra platforms.

Summary of changes since V3 [0]:
- Dropped tegra124 support for now
- Removed MC flush support per feedback from Thierry
- Cleaned up the PMC changes per feedback from Thierry
- Added support for tegra210

Series Summary:
Patch 1:    Adds the new function of_reset_control_get_by_index().
Patch 2-9:  PMC clean-up and fixes
Patch 10:   Adds function to remove a generic PM domain
Patch 11:   Updates DT documentation for PMC w.r.t Tegra210
Patch 12:   Adds DT documentation for tegra generic PM domains
Patch 13:   Adds PMC generic DM domains support
Patch 14:   Adds audio clock for Tegra210 audio power-domain
Patch 15:   Adds DT bindings for Tegra210 audio power-domain
Patch 16:   Enable generic PM domains for tegra64

[0] http://comments.gmane.org/gmane.linux.ports.tegra/22944

Jon Hunter (15):
  soc: tegra: pmc: Add missing structure members to kernel-doc
  soc: tegra: pmc: Fix sparse warning for tegra_pmc_init_tsense_reset
  soc: tegra: pmc: Remove debugfs entry on probe failure
  soc: tegra: pmc: Avoid extra remapping of PMC registers
  soc: tegra: pmc: Wait for powergate state to change
  soc: tegra: pmc: Remove non-existing power partitions for T210
  soc: tegra: pmc: Fix checking of valid partitions
  soc: tegra: pmc: Ensure partitions can be toggled on/off by PMC
  PM / Domains: Add function to remove a pm-domain
  Documentation: DT: bindings: Update NVIDIA PMC for Tegra210
  Documentation: DT: bindings: Add power domain info for NVIDIA PMC
  soc: tegra: pmc: Add generic PM domain support
  clk: tegra210: Add the APB2APE audio clock
  ARM64: tegra: Add audio PM domain device node for Tegra210
  ARM64: tegra: select PM_GENERIC_DOMAINS

Vince Hsu (1):
  reset: add of_reset_control_get_by_index()

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  66 ++-
 arch/arm/boot/dts/tegra124.dtsi                    |   1 +
 arch/arm/mach-tegra/platsmp.c                      |  16 +-
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  11 +-
 drivers/base/power/domain.c                        |  26 +
 drivers/clk/tegra/clk-id.h                         |   1 +
 drivers/clk/tegra/clk-tegra-periph.c               |   1 +
 drivers/clk/tegra/clk-tegra210.c                   |   1 +
 drivers/reset/core.c                               |  40 +-
 drivers/soc/tegra/pmc.c                            | 586 +++++++++++++++++++--
 include/dt-bindings/clock/tegra210-car.h           |   2 +-
 include/dt-bindings/power/tegra-powergate.h        |  35 ++
 include/linux/pm_domain.h                          |   5 +
 include/linux/reset.h                              |   9 +
 include/soc/tegra/pmc.h                            |  38 +-
 16 files changed, 720 insertions(+), 120 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
