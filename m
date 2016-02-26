From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V6 00/10] Add generic PM domain support for Tegra
Date: Fri, 26 Feb 2016 15:48:34 +0000
Message-ID: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Adds generic PM domain support for Tegra SoCs but this series only
enables support for it on Tegra 64-bit devices. There is no reason why
this cannot be enable for Tegra 32-bit devices, but to keep the patch
series to a minimum only 64-bit devices are enabled so far.

This series has been boot tested on Tegra210 as well as various 32-bit
Tegra platforms.

Summary of changes since V5 [2]:
- Split series into 2 series, separating PMC fixes [3] from genpd changes
- This series is based upon fixes series (which is now in -next)
- Added patch to fix removal of genpd subdomain
- Added patch to get last genpd that was added
- Fixed locking in function to remove genpd
- Updated Tegra PMC driver to ensure power-domains cannot be controlled
  by both legacy Tegra APIs and generic PM domain framework
- Removed powergate list from Tegra PMC driver and updated removal of
  power domains to use new genpd APIs.

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

[0] http://comments.gmane.org/gmane.linux.ports.tegra/22944
[1] http://marc.info/?l=linux-tegra&m=144924153600529&w=2
[2] http://marc.info/?l=linux-tegra&m=145399885003830&w=2
[3] http://marc.info/?l=linux-tegra&m=145521381331144&w=2

Jon Hunter (10):
  PM / Domains: Fix removal of a subdomain
  PM / Domains: Add function to get the last domain added
  PM / Domains: Add function to remove a pm-domain
  Documentation: DT: bindings: Update NVIDIA PMC for Tegra
  Documentation: DT: bindings: Add power domain info for NVIDIA PMC
  soc: tegra: pmc: Wait for powergate state to change
  soc: tegra: pmc: Add generic PM domain support
  soc: tegra: pmc: Move powergate definitions to dt-bindings
  ARM64: tegra: select PM_GENERIC_DOMAINS
  ARM64: tegra: Add audio PM domain device node for Tegra210

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  73 ++-
 arch/arm/mach-tegra/platsmp.c                      |  16 +-
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  14 +-
 drivers/base/power/domain.c                        |  58 +-
 drivers/soc/tegra/pmc.c                            | 594 ++++++++++++++++++---
 include/dt-bindings/power/tegra-powergate.h        |  88 +++
 include/linux/pm_domain.h                          |  12 +
 include/soc/tegra/pmc.h                            |  38 +-
 9 files changed, 776 insertions(+), 119 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

-- 
2.1.4
