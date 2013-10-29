From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v3 0/4] ARM: vexpress/TC2: cpufreq support
Date: Tue, 29 Oct 2013 12:18:36 +0000
Message-ID: <1383049120-8336-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep.KarkadaNagesha@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi Rafael,

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

Changes v2->v3:
	- Dropped "cpufreq: arm-big-little: use clk_get instead of
	  clk_get_sys" as it's already pulled in.
	- Rebased on [1] to include opp_* to dev_pm_opp_* changes

Changes v1->v2:
	- Introduced ARCH_VEXPRESS_SPC config to make dependency
	  selection cleaner
	- Other minor review comments from Nico implemented

Regards,
Sudeep

[1] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
linux-next

Sudeep KarkadaNagesha (4):
  ARM: vexpress/TC2: add support for CPU DVFS
  ARM: vexpress/TC2: add cpu clock support
  cpufreq: arm_big_little: add vexpress SPC interface driver
  ARM: vexpress/TC2: register vexpress-spc cpufreq device

 arch/arm/mach-vexpress/Kconfig         |  12 ++
 arch/arm/mach-vexpress/Makefile        |   3 +-
 arch/arm/mach-vexpress/spc.c           | 366 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-vexpress/spc.h           |   2 +-
 arch/arm/mach-vexpress/tc2_pm.c        |   7 +-
 drivers/cpufreq/Kconfig.arm            |   8 +
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/vexpress-spc-cpufreq.c |  70 +++++++
 8 files changed, 464 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c

-- 
1.8.1.2

