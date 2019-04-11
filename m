From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 0/8] devfreq: Tegra devfreq fixes / improvements and Tegra30 support
Date: Fri, 12 Apr 2019 01:29:06 +0300
Message-ID: <20190411222914.25539-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
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

Dmitry Osipenko (8):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't release IRQ manually on driver removal
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Drop spinlock
  PM / devfreq: tegra: Remove OPP entries on driver removal
  PM / devfreq: tegra: Support Tegra30

 drivers/devfreq/Kconfig         |  2 +-
 drivers/devfreq/tegra-devfreq.c | 66 ++++++++++++++-------------------
 2 files changed, 29 insertions(+), 39 deletions(-)

-- 
2.21.0
