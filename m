From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by tegra20-cpufreq driver
Date: Thu, 30 Aug 2018 22:43:51 +0300
Message-ID: <20180830194356.14059-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

This series adds support for CPU frequency scaling on Tegra30 and device
tree support that allows to implement thermal throttling and customize
available CPU frequencies per-board. The tegra20-cpufreq driver has been
re-worked to support that all.

Note that Tegra30 support not strictly depends on the clock patches that
are under review now, CPUFREQ driver will fail to probe until CCLKG clock
will get exposed by the clock driver. Hence this series can be applied
independently of the clock patches, CPUFREQ will start to work on Tegra30
once both patchsets will be applied.

Dmitry Osipenko (5):
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Support OPP, thermal cooling and Tegra30
  ARM: tegra: Create tegra20-cpufreq device on Tegra30
  ARM: dts: tegra20: Add CPU Operating Performance Points
  ARM: dts: tegra30: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  38 ++
 arch/arm/boot/dts/tegra20.dtsi                |  58 +++
 arch/arm/boot/dts/tegra30.dtsi                |  65 ++++
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/cpufreq/Kconfig.arm                   |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/tegra20-cpufreq.c             | 334 +++++++++++++-----
 7 files changed, 422 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

-- 
2.18.0
