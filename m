From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.18-rc1
Date: Wed, 13 Jun 2018 13:02:13 +0200
Message-ID: <CAJZ5v0hvAcw+9uHA+uMOZvrg75iqTanh53p-8-8S-7RyhSrmRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc1-2

with top-most commit 6a900f884e3e864d13501e63357990bc472f940c

 Merge branches 'pm-domains' and 'pm-tools'

on top of commit 3c89adb0d11117f64d5b501730be7fb2bf53a479

 Merge tag 'pm-4.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 4.18-rc1.

These revert a recent PM core change that introduced a regression,
fix build when the recently added Kryo cpufreq driver is selected,
add support for devices attached to multiple power domains to the
generic power domains (genpd) framework, add support for iowait
boosting on systens with hardware-managed P-states (HWP) enabled
to the intel_pstate driver, modify the behavior of the wakeup_count
device attribute in sysfs, fix a few issues and clean up some
ugliness, mostly in cpufreq (core and drivers) and in the cpupower
utility.

Specifics:

 - Revert a recent PM core change that attempted to fix an issue
   related to device links, but introduced a regression (Rafael
   Wysocki).

 - Fix build when the recently added cpufreq driver for Kryo
   processors is selected by making it possible to build that
   driver as a module (Arnd Bergmann).

 - Fix the long idle detection mechanism in the out-of-band
   (ondemand and conservative) cpufreq governors (Chen Yu).

 - Add support for devices in multiple power domains to the
   generic power domains (genpd) framework (Ulf Hansson).

 - Add support for iowait boosting on systems with hardware-managed
   P-states (HWP) enabled to the intel_pstate driver and make it use
   that feature on systems with Skylake Xeon processors as it is
   reported to improve performance significantly on those systems
   (Srinivas Pandruvada).

 - Fix and update the acpi_cpufreq, ti-cpufreq and imx6q cpufreq
   drivers (Colin Ian King, Suman Anna, S=C3=A9bastien Szymanski).

 - Change the behavior of the wakeup_count device attribute in
   sysfs to expose the number of events when the device might have
   aborted system suspend in progress (Ravi Chandra Sadineni).

 - Fix two minor issues in the cpupower utility (Abhishek Goel,
   Colin Ian King).

Thanks!


---------------

Abhishek Goel (1):
      cpupower : Fix header name to read idle state name

Arnd Bergmann (1):
      cpufreq: kryo: allow building as a loadable module

Chen Yu (1):
      cpufreq: governors: Fix long idle detection logic in load calculation

Colin Ian King (2):
      cpupower: fix spelling mistake: "logilename" -> "logfilename"
      cpufreq: ACPI: make function acpi_cpufreq_fast_switch() static

Rafael J. Wysocki (1):
      Revert "PM / runtime: Fixup reference counting of device link
suppliers at probe"

Ravi Chandra Sadineni (1):
      PM / wakeup: Export wakeup_count instead of event_count via sysfs

Srinivas Pandruvada (4):
      cpufreq: intel_pstate: Add HWP boost utility and sched util hooks
      cpufreq: intel_pstate: HWP boost performance on IO wakeup
      cpufreq: intel_pstate: New sysfs entry to control HWP boost
      cpufreq: intel_pstate: enable boost for Skylake Xeon

Suman Anna (2):
      cpufreq: ti-cpufreq: Fix an incorrect error return value
      cpufreq: ti-cpufreq: Use devres managed API in probe()

S=C3=A9bastien Szymanski (1):
      cpufreq: imx6q: check speed grades for i.MX6ULL

Ulf Hansson (5):
      PM / Domains: dt: Allow power-domain property to be a list of specifi=
ers
      PM / Domains: Don't attach devices in genpd with multi PM domains
      PM / Domains: Split genpd_dev_pm_attach()
      PM / Domains: Add support for multi PM domains per device to genpd
      PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM dom=
ains

---------------

 .../devicetree/bindings/power/power_domain.txt     |  19 ++-
 drivers/base/dd.c                                  |   3 +-
 drivers/base/power/common.c                        |  43 ++++-
 drivers/base/power/domain.c                        | 134 ++++++++++++---
 drivers/base/power/runtime.c                       |  27 +++-
 drivers/base/power/sysfs.c                         |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   4 +-
 drivers/cpufreq/cpufreq_governor.c                 |  12 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  29 +++-
 drivers/cpufreq/intel_pstate.c                     | 179 +++++++++++++++++=
+++-
 drivers/cpufreq/ti-cpufreq.c                       |   7 +-
 include/linux/pm_domain.h                          |  15 ++
 include/linux/pm_runtime.h                         |   6 +-
 tools/power/cpupower/bench/parse.c                 |   2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |  15 ++
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |  35 ++--
 .../cpupower/utils/idle_monitor/cpupower-monitor.h |   9 ++
 18 files changed, 468 insertions(+), 75 deletions(-)
