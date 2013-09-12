From: Bill Huang <bilhuang@nvidia.com>
Subject: [PATCH v2 0/4] Remodel Tegra cpufreq driver to support Tegra series SoCs
Date: Thu, 12 Sep 2013 04:24:47 -0700
Message-ID: <1378985091-9447-1-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, viresh.kumar@linaro.org, swarren@wwwdotorg.org
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Bill Huang <bilhuang@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This patch series remodel Tegra cpufreq driver to make it more easy to
add new SoC support, in addition to that, adding probe function in the
driver to let probe defer can be used to control init sequence when we
going to support DVFS.

Changes since v1:

- Split up patches.
- Split configuration-time data out of structure "tegra_cpufreq_data".
- Bug fixes.

Bill Huang (4):
  cpufreq: tegra: Call tegra_cpufreq_init() specifically in machine
    code
  cpufreq: tegra: Remove not used header files and clean up codes
  cpufreq: tegra: Re-model Tegra cpufreq driver
  ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig  |    1 +
 arch/arm/mach-tegra/common.c      |    2 +
 drivers/cpufreq/Kconfig.arm       |    8 +-
 drivers/cpufreq/Makefile          |    1 +
 drivers/cpufreq/tegra-cpufreq.c   |  194 +++++++++++++++++--------------------
 drivers/cpufreq/tegra-cpufreq.h   |   42 ++++++++
 drivers/cpufreq/tegra20-cpufreq.c |  138 ++++++++++++++++++++++++++
 include/linux/tegra-soc.h         |   11 ++-
 8 files changed, 290 insertions(+), 107 deletions(-)
 create mode 100644 drivers/cpufreq/tegra-cpufreq.h
 create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

-- 
1.7.9.5
