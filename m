From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 0/3] cpufreq: Use cpufreq-cpu0 driver for Exynos3250
Date: Wed, 18 Jun 2014 17:39:59 +0900
Message-ID: <1403080802-2794-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t.figa@samsung.com, kgene.kim@samsung.com, thomas.ab@samsung.com, viresh.kumar@linaro.org, mturquette@linaro.org, shawn.guo@linaro.org
Cc: kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patchset use cpufreq-cpu0 driver to support Exynos3250 cpufreq. So, this
patchset is based on following patchset[1] by Thomas Abraham.
 [1] http://www.spinics.net/lists/arm-kernel/msg339392.html

Changes from v1:
- Rebased on new patchset[1] by Thomas Abraham
- Modify clk-cpu.c to support Exynos3250
- Drop documentation patch on previous patchset[2]
 [2] http://www.spinics.net/lists/cpufreq/msg10265.html
- Add only operating-points for Exynos3250 without armclk-divider-table

Chanwoo Choi (3):
  clk: samsung: cpu: Add support for cpu clocks of Exynos3250
  clk: samsung: exynos3250: Use cpu-clock provider type to support cpufreq
  ARM: dts: Exynos: Add cpu clock table for Exynos3250

 arch/arm/boot/dts/exynos3250.dtsi    | 15 +++++++++++++++
 drivers/clk/samsung/clk-cpu.c        | 31 +++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos3250.c | 14 ++++++++++----
 3 files changed, 56 insertions(+), 4 deletions(-)

-- 
1.8.0
