From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/3] soc/tegra: bpmp: Generic PM domains for Tegra186
Date: Wed, 29 Mar 2017 18:34:49 +0200
Message-ID: <20170329163452.10761-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Hi Rafael, Kevin, Ulf,

This series implement generic power domains for Tegra186. Since the
power partitions on Tegra186 have a non-contiguous ID range, the PM
domain core is enhanced with a way to allow PM domain providers to
override the default ->xlate() implementation. This is used to look
up the correct PM domain given the ID read from device tree.

The second patch updates the BPMP ABI header to a version that has
support for the MRQ_PG request which is used to enumerate available
power partitions and control them.

An implementation of the generic PM domains using the MRQ_PG request
is provided in patch 3.

Given the dependency of patch 3 on patch 1 I think it'd be easiest
to get an Acked-by on patch 1 and take all of these through the Tegra
tree. If that's okay with you, I can provide a stable branch with the
first patch that could be pulled into the PM tree to resolve potential
conflicts.

Thanks,
Thierry

Changes in v2:
- take into account PG_STATE_RUNNING in tegra_bpmp_powergate_is_powered()
- check return value of pm_genpd_init() and clean up on failure
- simplify error unwinding in tegra_bpmp_init_powergates()

Thierry Reding (3):
  PM / Domains: Allow overriding the ->xlate() callback
  soc/tegra: bpmp: Update ABI header
  soc/tegra: bpmp: Implement generic PM domains

 drivers/base/power/domain.c        |   8 +-
 drivers/firmware/tegra/bpmp.c      |   4 +
 drivers/soc/tegra/Kconfig          |   5 +
 drivers/soc/tegra/Makefile         |   1 +
 drivers/soc/tegra/powergate-bpmp.c | 359 +++++++++++++++++++++++++++++++
 include/linux/pm_domain.h          |   4 +
 include/soc/tegra/bpmp-abi.h       | 418 ++++++++++++++++++++++++++++++++++++-
 include/soc/tegra/bpmp.h           |  12 ++
 8 files changed, 797 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soc/tegra/powergate-bpmp.c

-- 
2.12.0
