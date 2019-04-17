From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v3 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30 support
Date: Thu, 18 Apr 2019 01:29:09 +0300
Message-ID: <20190417222925.5815-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Changelog:

v3: Addressed all review comments that were made by Chanwoo Choi to v2.

    Patch "Synchronize IRQ after masking it in hardware" morphed into
    "Properly disable interrupts", which disables interrupts more solidly.

    Added new minor patch: "Rename tegra-devfreq.c to tegra30-devfreq.c".

    Added missed error handlings for dev_pm_opp_add().

v2: The patchset was quite heavily reworked since v1, few patches we
    dropped or squashed into the new ones and more patches we added.
    In a result more bugs and potential problems are fixed now, driver's
    code got more clean up.

    The Tegra20 driver-addition patch is now a part of this series, it has
    no changes since v1.

    https://patchwork.ozlabs.org/project/linux-tegra/list/?series=102823

Dmitry Osipenko (16):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Replace write memory barrier with the read
    barrier
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Drop primary interrupt handler
  PM / devfreq: tegra: Properly disable interrupts
  PM / devfreq: tegra: Clean up driver's probe / remove
  PM / devfreq: tegra: Avoid inconsistency of current frequency value
  PM / devfreq: tegra: Mark ACTMON's governor as immutable
  PM / devfreq: tegra: Move governor registration to driver's probe
  PM / devfreq: tegra: Reconfigure hardware on governor's restart
  PM / devfreq: tegra: Support Tegra30
  PM / devfreq: tegra: Enable COMPILE_TEST for the driver
  PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
  PM / devfreq: Introduce driver for NVIDIA Tegra20

 MAINTAINERS                                   |   8 +
 drivers/devfreq/Kconfig                       |  15 +-
 drivers/devfreq/Makefile                      |   3 +-
 drivers/devfreq/tegra20-devfreq.c             | 202 +++++++++++
 .../{tegra-devfreq.c => tegra30-devfreq.c}    | 315 ++++++++----------
 5 files changed, 369 insertions(+), 174 deletions(-)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c
 rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (81%)

-- 
2.21.0
