From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management and ACPI updates for v4.3-rc1
Date: Fri, 11 Sep 2015 23:45:32 +0200
Message-ID: <CAJZ5v0i7WN2XBuMg-bpaNhNMZ5nWvJEJR3qbpQigca=gveqNpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35626 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbIKVpe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 17:45:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.3-rc1-2

to receive addtional power management and ACPI material for v4.3-rc1
with top-most commit 4614e0cc66a8ea1d163efc364ba743424dee5c0a

 Merge branches 'pm-cpu', 'pm-cpuidle' and 'pm-domains'

on top of commit ae982073095a44f004d7ffb9f271077abef9dbcf

 Merge tag 'pm+acpi-4.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

These are mostly fixes and cleanups on top of the previous PM+ACPI
pull request (cpufreq core and drivers, cpuidle, generic power
domains framework).  Some of them didn't make to that pull request
and some fix issues introduced by it.

The only really new thing is the support for suspend frequency in
the cpufreq-dt driver, but it is needed to fix an issue with
Exynos platforms.

Specifics:

 - Build fix for the new Mediatek MT8173 cpufreq driver (Guenter Roeck).

 - Generic power domains framework fixes (power on error code
   path, subdomain removal) and cleanup of a deprecated API user
   (Geert Uytterhoeven, Jon Hunter, Ulf Hansson).

 - cpufreq-dt driver fixes including two fixes for bugs related to
   the new Operating Performance Points Device Tree bindings
   introduced recently (Viresh Kumar).

 - Suspend frequency support for the cpufreq-dt driver
   (Bartlomiej Zolnierkiewicz, Viresh Kumar).

 - cpufreq core cleanups (Viresh Kumar).

 - intel_pstate driver fixes (Chen Yu, Kristen Carlson Accardi).

 - Additional sanity check in the cpuidle core (Xunlei Pang).

 - Fix for a comment related to CPU power management (Lina Iyer).

Thanks!


---------------

Bartlomiej Zolnierkiewicz (3):
      PM / OPP: add dev_pm_opp_get_suspend_opp() helper
      cpufreq: allow cpufreq_generic_suspend() to work without suspend frequency
      cpufreq-dt: add suspend frequency support

Chen Yu (1):
      intel_pstate: Fix user input of min/max to legal policy region

Geert Uytterhoeven (1):
      staging: board: Migrate away from __pm_genpd_name_add_device()

Guenter Roeck (1):
      cpufreq: Add ARM_MT8173_CPUFREQ dependency on THERMAL

Jon Hunter (1):
      PM / Domains: Ensure subdomain is not in use before removing

Kristen Carlson Accardi (1):
      intel_pstate: fix PCT_TO_HWP macro

Lina Iyer (1):
      kernel/cpu_pm: fix cpu_cluster_pm_exit comment

Ulf Hansson (1):
      PM / Domains: Try power off masters in error path of __pm_genpd_poweron()

Viresh Kumar (6):
      cpufreq: dt: Check OPP count before marking them shared
      cpufreq: dt: Print error on failing to mark OPPs as shared
      cpufreq: dt: Tolerance applies on both sides of target voltage
      cpufreq: staticize cpufreq_cpu_get_raw()
      cpufreq: Use __func__ to print function's name
      PM / OPP: Return suspend_opp only if it is enabled

Xunlei Pang (1):
      cpuidle/coupled: Add sanity check for safe_state_index

---------------

 drivers/base/power/domain.c             | 38 +++++++++++++++++++++-----------
 drivers/base/power/opp.c                | 28 +++++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm             |  1 +
 drivers/cpufreq/cpufreq-dt.c            | 39 ++++++++++++++++++++++-----------
 drivers/cpufreq/cpufreq.c               |  9 ++++----
 drivers/cpufreq/intel_pstate.c          | 38 +++++++++++++++++++++++---------
 drivers/cpuidle/coupled.c               | 22 +++++++++++++++++++
 drivers/cpuidle/cpuidle.h               |  6 +++++
 drivers/cpuidle/driver.c                |  4 ++++
 drivers/staging/board/armadillo800eva.c |  2 +-
 drivers/staging/board/board.c           | 36 +++++++++++++++++++++++++++++-
 include/linux/pm_opp.h                  |  6 +++++
 kernel/cpu_pm.c                         |  2 +-
 13 files changed, 187 insertions(+), 44 deletions(-)
