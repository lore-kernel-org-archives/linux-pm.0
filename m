From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 0/7] Register an Energy Model for Arm reference platforms
Date: Mon, 28 Jan 2019 16:55:15 +0000
Message-ID: <20190128165522.31749-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com, mka@chromium.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

The Energy Model (EM) framework feeds interested subsystems (the
scheduler/EAS as of now) with power costs provided by drivers. Yet, no
driver is actually doing that upstream yet. This series updates a set of
CPUFreq drivers and DT files in order to register power costs in the EM
framework for some of the Arm reference platforms for EAS: Hikey960,
Juno and TC2.

The series is split as follows:

 * Patch 01 introduces in PM_OPP a helper function which estimates the
   CPU power using the P=CV²f equation also used by IPA. It should be
   noted that this introduces duplicate code with IPA, which will
   eventually be fixed by migrating IPA to using PM_EM. The ideal plan
   would be to do so later, in a separate patch series. I would indeed
   prefer to keep the thermal and CPUFreq discussion separate at this
   stage, if deemed acceptable.

 * Patches 02-04 make use of that PM_OPP helper function from the
   following CPUFreq drivers: cpufreq-dt, scpi-cpufreq and
   arm_big_little.

 * Patch 05 modifies the SCMI cpufreq driver to pass the power costs
   obtained from firmware to PM_EM.

 * Patches 06-07 provide the dynamic-power-coefficient values for Juno
   and TC2.

Thanks,
Quentin

Dietmar Eggemann (3):
  cpufreq: arm_big_little: Register an Energy Model
  arm64: dts: juno: Add cpu dynamic-power-coefficient information
  arm: dts: vexpress-v2p-ca15_a7: Add cpu dynamic-power-coefficient
    information

Quentin Perret (4):
  PM / OPP: Introduce a power estimation helper
  cpufreq: dt: Register an Energy Model
  cpufreq: scpi: Register an Energy Model
  cpufreq: scmi: Register an Energy Model

 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |  5 ++
 arch/arm64/boot/dts/arm/juno-r2.dts        |  6 +++
 arch/arm64/boot/dts/arm/juno.dts           |  6 +++
 drivers/cpufreq/arm_big_little.c           | 10 ++++
 drivers/cpufreq/cpufreq-dt.c               |  7 ++-
 drivers/cpufreq/scmi-cpufreq.c             | 36 ++++++++++++-
 drivers/cpufreq/scpi-cpufreq.c             |  8 ++-
 drivers/opp/of.c                           | 60 ++++++++++++++++++++++
 include/linux/pm_opp.h                     |  5 ++
 9 files changed, 140 insertions(+), 3 deletions(-)

-- 
2.20.1
