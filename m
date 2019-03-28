From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 0/3]  cpu_cooling: Make IPA use PM_EM
Date: Thu, 28 Mar 2019 10:13:49 +0000
Message-ID: <20190328101352.25657-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com
Cc: daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, quentin.perret@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The Intelligent Power Allocator (IPA) thermal governor uses an Energy
Model (or EM) of the CPUs to re-distribute the power budget. To do so,
it builds a table of <frequency, power> tuples where the power values
are computed using the 'dynamic-power-coefficient' DT property. All of
this is done in and only for the thermal subsystem, and more
specifically for CPUs -- the power of other types of devices is obtained
differently.

Recently, the CPU scheduler has seen the introduction of Energy Aware
Scheduling (EAS) patches, which also rely on an EM of the CPUs. This EM,
however, is managed by an independent framework, called PM_EM, aimed to
be used by all kernel subsystems interested in the power consumed by
CPUs, and not only the scheduler.

This patch series follows this logic and removes the (now redundant)
thermal-specific EM computation code to migrate IPA to use PM_EM
instead.

Doing so should have no visible functional impact for existing users of
IPA since:

 - during the 5.1 development cycle, a series of patches [1] introduced
   in PM_OPP some infrastructure (dev_pm_opp_of_register_em()) enabling
   the registration of EMs in PM_EM using the DT property used by IPA;

 - the existing upstream cpufreq drivers marked with the
   'CPUFREQ_IS_COOLING_DEV' flag all call dev_pm_opp_of_register_em(),
   which means they all support PM_EM (the only two exceptions are
   qoriq-cpufreq which doesn't in fact use an EM and scmi-cpufreq which
   already supports PM_EM without using the PM_OPP infrastructurei
   because it read power costs directly from firmware);

So, migrating IPA to using PM_EM should effectively be just plumbing
since for the existing IPA users the PM_EM tables will contain the
exact same power values that IPA used to compute on its own until now.
The only new dependency is to compile in CONFIG_ENERGY_MODEL.

Why is this migration still a good thing ? For three main reasons.

 1. it removes redundant code;

 2. it introduces an abstraction layer between IPA and the EM
    computation. PM_EM offers to EAS and IPA (and potentially other
    clients) standardized EM tables and hides 'how' these tables have
    been obtained. PM_EM as of now supports power values either coming
    from the 'dynamic-power-coefficient' DT property or obtained
    directly from firmware using SCMI. The latter is a new feature for
    IPA and that comes 'for free' with the migration. This will also be
    true in the future every time PM_EM gets support for other ways of
    loading the EM. Moreover, PM_EM is documented and has a debugfs
    interface which should help adding support for new platforms.

 3. it builds a consistent view of the EM of CPUs across kernel
    subsystems, which is a pre-requisite for any kind of future work
    aiming at a smarter power allocation using scheduler knowledge about
    the system for example.


[1] https://lore.kernel.org/lkml/20190204110952.16025-1-quentin.perret@arm.com/

Quentin Perret (3):
  arm64: defconfig: Enable CONFIG_ENERGY_MODEL
  PM / EM: Expose perf domain struct
  thermal: cpu_cooling: Migrate to using the EM framework

 arch/arm64/configs/defconfig  |   1 +
 drivers/thermal/cpu_cooling.c | 231 +++++++++++-----------------------
 include/linux/energy_model.h  |   3 +-
 3 files changed, 77 insertions(+), 158 deletions(-)

-- 
2.21.0
