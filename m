From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 00/11] arm64: tegra: Add Tegra DFLL for Tegra210 Jetson TX1
Date: Fri, 22 Apr 2016 18:31:00 +0800
Message-ID: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5870 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbcDVKby (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 06:31:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>

This patch series implements the DFLL/CL-DVFS clock source on Tegra210
based on Tegra124 DFLL driver, Tegra210 support on Tegra124 cpufreq
driver, and exposes DFLL HW as a PWM controller and provides DFLL_PWM
driver to generate PWM signals to control an OpenVReg (PWM regulator)
for CPU rail.

This patch series has been tested on the Jetson TX1.

Penny Chiu (11):
  clk: tegra: dfll: Fix voltage comparison
  clk: tegra: dfll: Move SoC specific data into of_device_id
  clk: tegra: Add DFLL DVCO reset control for Tegra210
  clk: tegra: Add Tegra210 support in DFLL driver
  pwm: tegra-dfll: Add driver for Tegra DFLL PWM controller
  clk: tegra: dfll: Add PWM inferface
  cpufreq: tegra124: Add Tegra210 support
  arm64: tegra: Add PWM regulator for CPU rail on Jetson TX1
  arm64: tegra: Add DFLL clock node on Jetson TX1
  arm64: tegra: Add clock properties on cpu0 for Tegra210
  arm64: config: Enable CPUFreq-DT, Tegra DFLL PWM, and PWM regulator

 .../bindings/clock/nvidia,tegra124-dfll.txt        |  21 +-
 .../bindings/pwm/nvidia,tegra-dfll-pwm.txt         |  48 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  56 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  23 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  21 +
 arch/arm64/configs/defconfig                       |   4 +
 drivers/clk/tegra/Makefile                         |   4 +-
 drivers/clk/tegra/clk-dfll.c                       | 422 +++++++++++++++------
 drivers/clk/tegra/clk-dfll.h                       |   1 +
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         | 127 ++++++-
 drivers/clk/tegra/clk-tegra210.c                   |  68 ++++
 drivers/clk/tegra/cvb.c                            |  12 +-
 drivers/clk/tegra/cvb.h                            |   8 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |   3 +-
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-tegra-dfll.c                       | 322 ++++++++++++++++
 include/dt-bindings/reset/tegra210-car.h           |  12 +
 include/soc/tegra/pwm-tegra-dfll.h                 |  27 ++
 19 files changed, 1046 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
 create mode 100644 drivers/pwm/pwm-tegra-dfll.c
 create mode 100644 include/dt-bindings/reset/tegra210-car.h
 create mode 100644 include/soc/tegra/pwm-tegra-dfll.h

-- 
2.8.1

