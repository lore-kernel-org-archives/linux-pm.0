From: Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/2] Remodel Tegra cpufreq drivers to support Tegra series SoC
Date: Thu, 5 Dec 2013 15:44:20 +0800
Message-ID: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch series remodel Tegra cpufreq driver to make it more easy to
add new SoC support, in addition to that, adding probe function in the
driver to let probe defer can be used to control init sequence when we
are going to support DVFS.

Changes since v2:

- Fix Kconfig.
- Rebase on top of branch 'cpufreq-next' on git://git.linaro.org/people/vireshk/linux.git.

Changes since v1:

- Split up patches.
- Split configuration-time data out of structure "tegra_cpufreq_data".
- Bug fixes.

Bill Huang (2):
  cpufreq: tegra: Call tegra_cpufreq_init() specifically in machine
    code
  cpufreq: tegra: Re-model Tegra cpufreq driver

 arch/arm/mach-tegra/tegra.c       |    2 +
 drivers/cpufreq/Kconfig.arm       |   12 +++
 drivers/cpufreq/Makefile          |    1 +
 drivers/cpufreq/tegra-cpufreq.c   |  188 +++++++++++++++++--------------------
 drivers/cpufreq/tegra-cpufreq.h   |   40 ++++++++
 drivers/cpufreq/tegra20-cpufreq.c |  136 +++++++++++++++++++++++++++
 include/linux/tegra-soc.h         |   11 ++-
 7 files changed, 287 insertions(+), 103 deletions(-)
 create mode 100644 drivers/cpufreq/tegra-cpufreq.h
 create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

-- 
1.7.9.5
