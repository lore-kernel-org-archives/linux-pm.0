From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 0/2] Add Mediatek MT8173 cpufreq driver
Date: Mon,  8 Jun 2015 20:29:19 +0800
Message-ID: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "pi-cheng.chen" <pi-cheng.chen@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
share the same power and clock domain. This series tries to add cpufreq support
for MT8173 SoC.

Changes in v4:
- Add bindings for MT8173 cpufreq driver
- Move OPP table back into device tree
- Address comments for last version

Changes in v3:
- Implement MT8173 specific standalone cpufreq driver instead of using
  cpufreq-dt driver
- Define OPP table in the driver source code until new OPP binding is ready

Changes in v2:
- Add intermediate frequency support in cpufreq-dt driver
- Use voltage scaling code of cpufreq-dt for little cluster instead of
  implementaion in notifier of mtk-cpufreq driver
- Code refinement for mtk-cpufreq driver

Pi-Cheng Chen (2):
  dt-bindings: mediatek: Add MT8173 cpufreq driver binding
  cpufreq: mediatek: Add MT8173 cpufreq driver

 .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 127 +++++
 drivers/cpufreq/Kconfig.arm                        |   7 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/mt8173-cpufreq.c                   | 550 +++++++++++++++++++++
 4 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
 create mode 100644 drivers/cpufreq/mt8173-cpufreq.c

-- 
1.9.1
