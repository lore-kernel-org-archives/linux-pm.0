From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH 0/5] ARM: vexpress/TC2: cpufreq support
Date: Wed, 16 Oct 2013 14:52:38 +0100
Message-ID: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Pawel Moll <pawel.moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi,

The SPC(Serial Power Controller) on Versatile Express V2P-CA15_A7(TC2)
not only controls low-power states, wake-up irqs and per-CPU jump addresses
but also the CPU performance operating points which is essential to provide
CPU DVFS. The M3 microcontroller can provide upto eight performance values,
one set for each cluster (CA15 or CA7). Each of this value contains the
frequency(kHz) and voltage(mV) at that performance level. It expects
these performance level to be passed through the SPC PERF_LVL registers.
    
This patch series adds support to populate those OPPs, add them to the
cpu devices and runtime programming of these performance levels through
clock framework. It also adds a small interface cpufreq driver to validate
the OPPs and register the arm_big_little cpufreq driver.

Regards,
Sudeep

Sudeep KarkadaNagesha (5):
  cpufreq: arm-big-little: use clk_get instead of clk_get_sys
  ARM: vexpress/TC2: add support for CPU DVFS
  ARM: vexpress/TC2: add cpu clock support
  cpufreq: arm_big_little: add vexpress SPC interface driver
  ARM: vexpress/TC2: register vexpress-spc cpufreq device

 arch/arm/mach-vexpress/Kconfig         |   2 +
 arch/arm/mach-vexpress/spc.c           | 361 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-vexpress/spc.h           |   2 +-
 arch/arm/mach-vexpress/tc2_pm.c        |   7 +-
 drivers/cpufreq/Kconfig.arm            |   8 +
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/arm_big_little.c       |   2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c |  69 +++++++
 8 files changed, 447 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c

-- 
1.8.1.2

