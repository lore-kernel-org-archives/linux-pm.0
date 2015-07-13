From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 00/19] Add generic PM domain support for Tegra SoCs
Date: Mon, 13 Jul 2015 13:39:38 +0100
Message-ID: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series is based upon the V2 series from Vince Hsu [1]. The code
for the MC flush operations and PMC code for the generic PM domains
has been re-written to simplify and consolidate legacy/existing support
for power-domains on the Tegra SoC.

This series has been boot tested on various 32-bit Tegra platforms
as well as compile tested for 64-bit ARM. A summary of the results is
available here [2]. Would be great to get some more testing for PCI,
SATA, GR3D and DRM.

Summary:

Patch 1:     Adds the new function of_reset_control_get_by_index().
Patch 2-5:   Add the MC flush operations for Tegra30/Tegra114/Tegra124.
Patch 6:     Is a PLLD fix for Tegra114.
Patch 7-9:   PMC preparation for generic PM domains.
Patch 10-13: Update drivers to support generic PM domains
Patch 14:    Add DT documentation for tegra generic PM domains
Patch 15:    Add PMC generic DM domains support
Patch 16:    Remove legacy functions
Patch 17-18: Add DT bindings for tegra124
Patch 19:    Enable generic PM domains for tegra


Changes:
   v3:
   * Re-wrote and simplified MC flush code
   * Re-wrote PMC code for generic PM domains to permit devices to use
     legacy DT blobs without generic PM domain info.
   * Re-worked DRM, PCI, AHCI and GR3D drivers to allow then to work
     with and without generic PM domains.
   * Added DT documentation for tegra generic PM domain bindings.
   * Dropped DT bindings for T30 and T114 (plan to add later)

   v2 (Vince Hsu):
   * Add support for Tegra30/Tegra114
   * Address Alex's comments

[1] https://lkml.org/lkml/2015/3/12/284
[2] https://nvtb.github.io//epmt/jonathanh-tester/test_20150713051933_58fc293c9467f52c51f1e52e5d5a8da174b8550a/20150713051933/


Jon Hunter (12):
  memory: tegra: Add MC flush support
  soc: tegra: pmc: Wait for powergate state to change
  soc: tegra: pmc: Clean-up PMC helper functions
  soc: tegra: pmc: Prepare for migrating to generic PM domains
  drm/tegra: dc: Prepare for generic PM domains
  PCI: tegra: Add support for generic PM domains
  ata: ahci_tegra: Add support for generic PM domains
  drm/tegra: gr3d: Add support for generic PM domains
  Documentation: DT: bindings: Add power domain info for NVIDIA PMC
  soc: tegra: pmc: Add generic PM domain support
  soc: tegra: pmc: Remove the deprecated powergate APIs
  ARM: tegra: Add PM domain device nodes to Tegra124 DT

Vince Hsu (7):
  reset: add of_reset_control_get_by_index()
  memory: tegra: add flush operation for Tegra30 memory clients
  memory: tegra: add flush operation for Tegra114 memory clients
  memory: tegra: add flush operation for Tegra124 memory clients
  clk: tegra: remove TEGRA_PLL_USE_LOCK for PLLD/PLLD2
  ARM: tegra: add GPU power supply to Jetson TK1 DT
  ARM: tegra: select PM_GENERIC_DOMAINS

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  99 ++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   6 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  80 +++
 arch/arm/mach-tegra/Kconfig                        |   1 +
 arch/arm/mach-tegra/platsmp.c                      |  18 +-
 drivers/ata/ahci_tegra.c                           |  51 +-
 drivers/clk/tegra/clk-tegra114.c                   |   6 +-
 drivers/gpu/drm/tegra/dc.c                         |  94 +--
 drivers/gpu/drm/tegra/gr3d.c                       |  57 +-
 drivers/memory/tegra/mc.c                          | 110 ++++
 drivers/memory/tegra/mc.h                          |   2 +
 drivers/memory/tegra/tegra114.c                    |  21 +
 drivers/memory/tegra/tegra124.c                    |  31 +
 drivers/memory/tegra/tegra30.c                     |  24 +
 drivers/pci/host/pci-tegra.c                       |  49 +-
 drivers/reset/core.c                               |  40 +-
 drivers/soc/tegra/pmc.c                            | 647 ++++++++++++++++++---
 include/dt-bindings/power/tegra-powergate.h        |  42 ++
 include/linux/reset.h                              |   9 +
 include/soc/tegra/mc.h                             |  34 ++
 include/soc/tegra/pmc.h                            |  74 +--
 21 files changed, 1264 insertions(+), 231 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

-- 
2.1.4
