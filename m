From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.19-rc1
Date: Tue, 14 Aug 2018 12:19:31 +0200
Message-ID: <CAJZ5v0gHEBHDF+UQjwZKvHZ=fHdDdr7Bs2s2jCVwPnP33uxh4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc1

with top-most commit 7425ecd5e3e8c9d84f399a102282a23a90a19278

 Merge branch 'pm-cpufreq'

on top of commit 9b7c19e96cededec6b0435933adefbd56cad37ab

 Merge branch 'pm-tools'

to receive the first batch of power management updates for 4.19-rc1.

These add a new framework for CPU idle time injection, to be used
by all of the idle injection code in the kernel in the future, fix
some issues and add a number of relatively small extensions in
multiple places.

Specifics:

 - Add a new framework for CPU idle time injection (Daniel Lezcano).

 - Add AVS support to the armada-37xx cpufreq driver (Gregory CLEMENT).

 - Add support for current CPU frequency reporting to the ACPI CPPC
   cpufreq driver (George Cherian).

 - Rework the cooling device registration in the imx6q/thermal
   driver (Bastian Stender).

 - Make the pcc-cpufreq driver refuse to work with dynamic
   scaling governors on systems with many CPUs to avoid
   scalability issues with it (Rafael Wysocki).

 - Fix the intel_pstate driver to report different maximum CPU
   frequencies on systems where they really are different and to
   ignore the turbo active ratio if hardware-managend P-states (HWP)
   are in use; make it use the match_string() helper (Xie Yisheng,
   Srinivas Pandruvada).

 - Fix a minor deferred probe issue in the qcom-kryo cpufreq
   driver (Niklas Cassel).

 - Add a tracepoint for the tracking of frequency limits changes
   (from Andriod) to the cpufreq core (Ruchi Kandoi).

 - Fix a circular lock dependency between CPU hotplug and sysfs
   locking in the cpufreq core reported by lockdep (Waiman Long).

 - Avoid excessive error reports on driver registration failures
   in the ARM cpuidle driver (Sudeep Holla).

 - Add a new device links flag to the driver core to make links go
   away automatically on supplier driver removal (Vivek Gautam).

 - Eliminate potential race condition between system-wide power
   management transitions and system shutdown (Pingfan Liu).

 - Add a quirk to save NVS memory on system suspend for the ASUS
   1025C laptop (Willy Tarreau).

 - Make more systems use suspend-to-idle (instead of ACPI S3) by
   default (Tristian Celestin).

 - Get rid of stack VLA usage in the low-level hibernation code on
   64-bit x86 (Kees Cook).

 - Fix error handling in the hibernation core and mark an expected
   fall-through switch in it (Chengguang Xu, Gustavo Silva).

 - Extend the generic power domains (genpd) framework to support
   attaching a device to a power domain by name (Ulf Hansson).

 - Fix device reference counting and user limits initialization in
   the devfreq core (Arvind Yadav, Matthias Kaehlcke).

 - Fix a few issues in the rk3399_dmc devfreq driver and improve its
   documentation (Enric Balletbo i Serra, Lin Huang, Nick Milner).

 - Drop a redundant error message from the exynos-ppmu devfreq driver
   (Markus Elfring).

Thanks!


---------------

Arvind Yadav (1):
      PM / devfreq: use put_device() instead of kfree()

Bastian Stender (1):
      cpufreq: imx6q/thermal: imx: register cooling device depending on OF

Chengguang Xu (1):
      PM / hibernate: cast PAGE_SIZE to int when comparing with error code

Daniel Lezcano (1):
      powercap / idle_inject: Add an idle injection framework

Enric Balletbo i Serra (5):
      dt-bindings: clock: add rk3399 DDR3 standard speed bins.
      PM / devfreq: rk3399_dmc: remove wait for dcf irq event.
      dt-bindings: devfreq: rk3399_dmc: move interrupts to be optional.
      PM / devfreq: rk3399_dmc: fix spelling mistakes.
      PM / devfreq: rk3399_dmc: Fix duplicated opp table on reload.

George Cherian (1):
      cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC

Gregory CLEMENT (2):
      dt-bindings: marvell: Add documentation for the Armada 3700 AVS binding
      cpufreq: armada-37xx: Add AVS support

Gustavo A. R. Silva (1):
      PM / hibernate: Mark expected switch fall-through

Kees Cook (1):
      x86/power/hibernate_64: Remove VLA usage

Lin Huang (1):
      PM / devfreq: rk3399_dmc: do not print error when get supply and
clk defer.

Markus Elfring (1):
      PM / devfreq: exynos-ppmu: Delete an error message for a failed
memory allocation in exynos_ppmu_probe()

Matthias Kaehlcke (1):
      PM / devfreq: Init user limits from OPP limits, not viceversa

Nick Milner (1):
      dt-bindings: devfreq: rk3399_dmc: improve binding documentation.

Niklas Cassel (1):
      cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER

Pingfan Liu (1):
      PM / reboot: Eliminate race between reboot and suspend

Rafael J. Wysocki (1):
      cpufreq: pcc-cpufreq: Disable dynamic scaling on many-CPU systems

Ruchi Kandoi (1):
      cpufreq: trace frequency limits change

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Show different max frequency with turbo 3 and HWP
      cpufreq: intel_pstate: Ignore turbo active ratio in HWP

Sudeep Holla (1):
      ARM: cpuidle: silence error on driver registration failure

Tristian Celestin (1):
      ACPI / PM: Default to s2idle in all machines supporting LP S0

Ulf Hansson (3):
      PM / Domains: dt: Add a power-domain-names property
      PM / Domains: Introduce option to attach a device by name to genpd
      PM / Domains: Introduce dev_pm_domain_attach_by_name()

Vivek Gautam (2):
      driver core: Rename flag AUTOREMOVE to AUTOREMOVE_CONSUMER
      driver core: Add flag to autoremove device link on supplier unbind

Waiman Long (2):
      cpu/hotplug: Add a cpus_read_trylock() function
      cpufreq: Fix a circular lock dependency problem

Willy Tarreau (1):
      ACPI / PM: save NVS memory for ASUS 1025C laptop

Xie Yisheng (1):
      cpufreq: intel_pstate: use match_string() helper

---------------

 .../bindings/arm/marvell/armada-37xx.txt           |  15 +
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 211 ++++++------
 .../devicetree/bindings/power/power_domain.txt     |   8 +
 Documentation/driver-api/device_link.rst           |  12 +-
 Documentation/power/freezing-of-tasks.txt          |  12 +-
 Documentation/power/suspend-and-cpuhotplug.txt     |   6 +-
 Documentation/trace/events-power.rst               |   1 +
 arch/x86/power/hibernate_64.c                      |  36 ++-
 drivers/acpi/sleep.c                               |  30 +-
 drivers/base/core.c                                |  25 +-
 drivers/base/power/common.c                        |  17 +
 drivers/base/power/domain.c                        |  24 ++
 drivers/cpufreq/armada-37xx-cpufreq.c              | 163 +++++++++-
 drivers/cpufreq/cppc_cpufreq.c                     |  52 +++
 drivers/cpufreq/cpufreq.c                          |   8 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  21 ++
 drivers/cpufreq/intel_pstate.c                     |  27 +-
 drivers/cpufreq/pcc-cpufreq.c                      |   9 +
 drivers/cpufreq/qcom-cpufreq-kryo.c                |   5 +-
 drivers/cpuidle/cpuidle-arm.c                      |   3 +-
 drivers/devfreq/devfreq.c                          |  16 +-
 drivers/devfreq/event/exynos-ppmu.c                |   6 +-
 drivers/devfreq/rk3399_dmc.c                       | 102 +++---
 drivers/gpu/drm/tegra/dc.c                         |   2 +-
 drivers/gpu/ipu-v3/ipu-pre.c                       |   3 +-
 drivers/gpu/ipu-v3/ipu-prg.c                       |   3 +-
 drivers/powercap/Kconfig                           |  10 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/idle_inject.c                     | 356 +++++++++++++++++++++
 drivers/soc/imx/gpc.c                              |   2 +-
 drivers/thermal/imx_thermal.c                      |  28 +-
 include/dt-bindings/clock/rk3399-ddr.h             |  56 ++++
 include/linux/cpu.h                                |   2 +
 include/linux/device.h                             |  14 +-
 include/linux/idle_inject.h                        |  29 ++
 include/linux/pm_domain.h                          |  15 +
 include/linux/suspend.h                            |   2 +-
 include/trace/events/power.h                       |  25 ++
 kernel/cpu.c                                       |   6 +
 kernel/freezer.c                                   |   4 +-
 kernel/power/hibernate.c                           |  16 +-
 kernel/power/main.c                                |  12 +-
 kernel/power/suspend.c                             |   4 +-
 kernel/power/swap.c                                |   4 +-
 kernel/power/user.c                                |   4 +-
 kernel/reboot.c                                    |   6 +-
 mm/page_alloc.c                                    |  11 +-
 47 files changed, 1139 insertions(+), 285 deletions(-)
