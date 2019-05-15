From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v5.2-rc1
Date: Wed, 15 May 2019 12:13:25 +0200
Message-ID: <CAJZ5v0i-sU2cXVdVUW1CCvbCmaTsqphXYXocS=ufeGFAChYOag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.2-rc1-2

with top-most commit 2a8d69f6139b605b2e36c80540cb8e8da2d016be

 Merge branches 'pm-cpufreq' and 'pm-domains'

on top of commit 8f5e823f9131a430b12f73e9436d7486e20c16f5

 Merge tag 'pm-5.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.2-rc1.

These fix a recent regression causing kernels built with CONFIG_PM
unset to crash on systems that support the Performance and Energy
Bias Hint (EPB), clean up the cpufreq core and some users of
transition notifiers and introduce a new power domain flag into
the generic power domains framework (genpd).

Specifics:

 - Fix recent regression causing kernels built with CONFIG_PM
   unset to crash on systems that support the Performance and
   Energy Bias Hint (EPB) by avoiding to compile the EPB-related
   code depending on CONFIG_PM when it is unset (Rafael Wysocki).

 - Clean up the transition notifier invocation code in the cpufreq
   core and change some users of cpufreq transition notifiers
   accordingly (Viresh Kumar).

 - Change MAINTAINERS to cover the schedutil governor as part of
   cpufreq (Viresh Kumar).

 - Simplify cpufreq_init_policy() to avoid redundant computations
   (Yue Hu).

 - Add explanatory comment to the cpufreq core (Rafael Wysocki).

 - Introduce a new flag, GENPD_FLAG_RPM_ALWAYS_ON, to the generic
   power domains (genpd) framework along with the first user of it
   (Leonard Crestez).

Thanks!


---------------

Leonard Crestez (2):
      PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
      soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for ERR009619

Rafael J. Wysocki (2):
      x86: intel_epb: Take CONFIG_PM into account
      cpufreq: Explain the kobject_put() in cpufreq_policy_alloc()

Viresh Kumar (2):
      cpufreq: Call transition notifier only once for each policy
      cpufreq: Update MAINTAINERS to include schedutil governor

Yue Hu (1):
      cpufreq: Don't find governor for setpolicy drivers in
cpufreq_init_policy()

---------------

 MAINTAINERS                     |   2 +
 arch/arm/kernel/smp.c           |  24 ++++---
 arch/sparc/kernel/time_64.c     |  28 ++++----
 arch/x86/kernel/cpu/intel_epb.c |  22 ++++++-
 arch/x86/kernel/tsc.c           |   2 +-
 arch/x86/kvm/x86.c              |  31 +++++----
 drivers/base/power/domain.c     |   8 ++-
 drivers/cpufreq/cpufreq.c       | 140 +++++++++++++++++++++++-----------------
 drivers/soc/imx/gpc.c           |  13 +++-
 include/linux/cpufreq.h         |  14 ++--
 include/linux/pm_domain.h       |   4 ++
 11 files changed, 183 insertions(+), 105 deletions(-)
