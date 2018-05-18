From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 00/11] Clean up Tegra20 cpufreq driver
Date: Fri, 18 May 2018 23:06:31 +0300
Message-ID: <20180518200642.24815-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Recently Peter Geis (who is working on Tegra30 cpufreq driver) asked me how
tegra20-cpufreq driver is getting loaded. After taking a look at the code
it became apparent that the drivers code has been rusted a tad and so this
series is intended to refresh the drivers code by disallowing module to be
loaded on non-Tegra20 machines, by cleaning whitespaces in the code, removing
dead EMC code and in the end by allowing tegra20-cpufreq to be built as a
loadable module.

Changelog:

v2:
	- Added the new patch to the series: "Remove unnecessary parentheses",
	  please review.

	- Addressed review comments to the v1 of the series:

	1) Kept undeleted necessary headers in the "Clean up included headers"
	   patch as per Viresh's Kumar request.

	2) Renamed tegra20_cpufreq_data to tegra20_cpufreq and moved cpufreq
	   driver structure to the tegra20_cpufreq as per Thierry's Reding
	   request.

	- Dropped "ARM: tegra: Create platform device for tegra20-cpufreq driver"
	  patch from the series as Thierry already applied it and submitted
	  in the "ARM: tegra: Core changes for v4.18-rc1" pull request.

Dmitry Osipenko (11):
  cpufreq: tegra20: Change module description
  cpufreq: tegra20: Clean up whitespaces in the code
  cpufreq: tegra20: Clean up included headers
  cpufreq: tegra20: Remove EMC clock usage
  cpufreq: tegra20: Release clocks properly
  cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
  cpufreq: tegra20: Remove unnecessary parentheses
  cpufreq: tegra20: Remove unneeded variable initialization
  cpufreq: tegra20: Check if this is Tegra20 machine
  cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
  cpufreq: tegra20: Wrap cpufreq into platform driver

 drivers/cpufreq/Kconfig.arm       |   2 +-
 drivers/cpufreq/tegra20-cpufreq.c | 200 ++++++++++++++++--------------
 2 files changed, 111 insertions(+), 91 deletions(-)

-- 
2.17.0
