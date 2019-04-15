From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 00/19] NVIDIA Tegra devfreq improvements and Tegra20/30 support
Date: Mon, 15 Apr 2019 17:54:46 +0300
Message-ID: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

I tried to utilize the Tegra devfreq driver on Tegra30 and found out that
it doesn't work properly due to improper Hz<->kHz conversions made by the
driver. After fixing that problem and doing some more testing I noticed
that there are things that could be improved and in result here is this
patchset that fixes the problems, makes some improvements and adds support
for NVIDIA Tegra30 SoC's. This series was tested on Tegra30 and Tegra124
machines.

This series also adds support for the Tegra20 SoC's that do not have
the ACTMON hardware unit, but can use Memory Controller counters to make
decision about the required memory frequency. Please note that the patch
that instantiates a platform device for the driver isn't a part of this
series, I'll submit it later on because of interdependency with some other
ongoing patchset.

Please review, thanks.

Changelog:

v2: The patchset was quite heavily reworked since v1, few patches we
    dropped or squashed into the new ones and more patches we added.
    In a result more bugs and potential problems are fixed now, driver's
    code got more clean up.

    The Tegra20 driver-addition patch is now a part of this series, it has
    no changes since v1.

Dmitry Osipenko (19):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Replace write memory barrier with the read
    barrier
  PM / devfreq: tegra: Fix missed error checking on devfreq
    initialization failure
  PM / devfreq: tegra: Register clk notifier in the end of driver's
    probe
  PM / devfreq: tegra: Remove OPP entries on driver removal
  PM / devfreq: tegra: Change interrupt request order
  PM / devfreq: tegra: Drop primary interrupt handler
  PM / devfreq: tegra: De-initialize properly on driver's probe error
  PM / devfreq: tegra: Avoid inconsistency of current frequency value
  PM / devfreq: tegra: Mark ACTMON's governor as immutable
  PM / devfreq: tegra: Move governor registration to driver's probe
  PM / devfreq: tegra: Synchronize IRQ after masking it in hardware
  PM / devfreq: tegra: Reconfigure hardware on governor's restart
  PM / devfreq: tegra: Support Tegra30
  PM / devfreq: tegra: Enable COMPILE_TEST for the driver
  PM / devfreq: Introduce driver for NVIDIA Tegra20

 MAINTAINERS                       |   8 +
 drivers/devfreq/Kconfig           |  15 +-
 drivers/devfreq/Makefile          |   1 +
 drivers/devfreq/tegra-devfreq.c   | 296 +++++++++++++-----------------
 drivers/devfreq/tegra20-devfreq.c | 177 ++++++++++++++++++
 5 files changed, 324 insertions(+), 173 deletions(-)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c

-- 
2.21.0
