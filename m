From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.18-rc3
Date: Fri, 29 Jun 2018 11:20:20 +0200
Message-ID: <CAJZ5v0ip3jHZTmu6U5bjeHVjYpEhvvNM0zducPu63vo7z07enw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc3

with top-most commit e27b4d4a7b987ffa93a5a1249dd83dcb69f8d040

 Merge branch 'pm-domains'

on top of commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819

 Linux 4.18-rc2

to receive power management fixes for 4.18-rc3.

These fix up recently added features (the Kryo cpufreq driver
and performance states coverage in the generic power domains
framework), add missing documentation for a recently added
sysfs knob in the intel_pstate driver and fix an error in its
documentation.

Specifics:

 - Fix the initialization time error handling in the recently added
   Kryo cpufreq driver (Dan Carpenter).

 - Fix up the recently added coverage of performance states in the
   generic power domains (genpd) framework (Viresh Kumar).

 - Add missing documentation of the new hwp_dynamic_boost sysfs knob
   in the intel_pstate driver (Rafael Wysocki).

 - Fix incorrect sysfs path in the intel_pstate driver documentation
   (Rafael Wysocki).

Thanks!


---------------

Dan Carpenter (1):
      cpufreq: qcom-kryo: Fix error handling in probe()

Rafael J. Wysocki (2):
      Documentation: admin-guide: intel_pstate: Fix sysfs path
      Documentation: intel_pstate: Describe hwp_dynamic_boost sysfs knob

Viresh Kumar (2):
      PM / Domains: Fix return value of of_genpd_opp_to_performance_state()
      PM / Domains: Rename opp_node to np

---------------

 Documentation/admin-guide/pm/intel_pstate.rst | 14 ++++++++++++--
 drivers/base/power/domain.c                   |  7 +++----
 drivers/cpufreq/qcom-cpufreq-kryo.c           |  8 ++++----
 include/linux/pm_domain.h                     |  6 +++---
 4 files changed, 22 insertions(+), 13 deletions(-)
