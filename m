From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv4 0/4] cpufreq: Use cpufreq-dt driver for Exynos3250
Date: Mon, 20 Oct 2014 21:08:38 +0900
Message-ID: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: viresh.kumar@linaro.org, tomasz.figa@gmail.com
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, kyungmin.park@samsung.com, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patchset use cpufreq-dt driver to support Exynos3250 cpufreq and tested it
on Exynos3250-based Rinato board.

Changes from v3:
- This patchset is based on 3.18-rc1 with new patchset[3] of Thomas Abraham
  [3] [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
  - http://www.spinics.net/lists/arm-kernel/msg370412.html

Changes from v2:
- Rebased on new patchset of Thomas Abraham
  and for-next branch of samsunc-clk.git of Tomasz Figa

Changes from v1:
- Rebased on new patchset[1] by Thomas Abraham
  [1] [PATCH v10 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
  - http://www.spinics.net/lists/arm-kernel/msg364790.html
- Modify clk-cpu.c to support Exynos3250
- Drop documentation patch on previous patchset[2]
  [2] http://www.spinics.net/lists/cpufreq/msg10265.html
- Add only operating-points for Exynos3250 without armclk-divider-table

Chanwoo Choi (4):
  clk: samsung: exynos3250: Add cpu clock configuration data and instaniate cpu clock
  clk: samsung: exynos3250: Update clock flags related to CPU to use cpu-clock type
  ARM: exynos: Add exynos3250 compatible to use generic cpufreq driver
  ARM: dts: Add CPU OPP and regulator supply property for Exynos3250

 arch/arm/boot/dts/exynos3250.dtsi    | 15 +++++++++++
 arch/arm/mach-exynos/exynos.c        |  1 +
 drivers/clk/samsung/clk-cpu.h        |  4 +++
 drivers/clk/samsung/clk-exynos3250.c | 49 ++++++++++++++++++++++++++++--------
 4 files changed, 59 insertions(+), 10 deletions(-)

-- 
1.8.0
