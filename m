From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management changes for v4.18-rc2
Date: Thu, 21 Jun 2018 15:29:54 +0200
Message-ID: <CAJZ5v0jL0rDAD+Urc-tD76embqNABWHkShAeiE0ErSJvNWzbgQ@mail.gmail.com>
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
 pm-4.18-rc2

with top-most commit b51e001385f1c861445af3efeab766811ee8db29

 Merge branch 'pm-tools'

on top of commit ce397d215ccd07b8ae3f71db689aedb85d56ab40

 Linux 4.18-rc1

to receive power management changes for 4.18-rc2.

These are mostly fixes, including some fixes for changes made
during the recent merge window and some "stable" material, plus
some minor extensions of the turbostat utility.

Specifics:

 - Fix the PM core to avoid introducing a runtime PM usage counter
   imbalance when adding device links during driver probe (Rafael
   Wysocki).

 - Fix the operating performance points (OPP) framework to ensure
   that the regulator voltage is always updated as appropriate when
   updating clock rates (Waldemar Rymarkiewicz).

 - Fix the intel_pstate driver to use correct max/min limits for
   cores with differing maximum frequences (Srinivas Pandruvada).

 - Fix a typo in the intel_pstate driver documentation (Rafael
   Wysocki).

 - Fix two issues with the recently added Kryo cpufreq driver (Ilia
   Lin).

 - Fix two recent regressions and some other minor issues in the
   turbostat utility and extend it to provide some more diagnostic
   information (Len Brown, Nathan Ciobanu).

Thanks!


---------------

Ilia Lin (2):
      cpufreq: kryo: Fix possible error code dereference
      cpufreq: kryo: Add module remove and exit

Len Brown (4):
      tools/power turbostat: fix show/hide issues resulting from mis-merge
      tools/power turbostat: decode cpuid.1.HT
      tools/power turbostat: add optional APIC X2APIC columns
      tools/power turbostat: version 18.06.20

Nathan Ciobanu (4):
      tools/power turbostat: fix segfault on 'no node' machines
      tools/power turbostat: alphabetize the help output
      tools/power turbostat: add single character tokens to help
      tools/power turbostat: add the missing command line switches

Rafael J. Wysocki (2):
      PM / core: Fix supplier device runtime PM usage counter imbalance
      Documentation: intel_pstate: Fix typo

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0

Waldemar Rymarkiewicz (1):
      PM / OPP: Update voltage in case freq == old_freq

---------------

 Documentation/admin-guide/pm/intel_pstate.rst |   2 +-
 drivers/base/core.c                           |  15 +-
 drivers/cpufreq/intel_pstate.c                |  27 ++-
 drivers/cpufreq/qcom-cpufreq-kryo.c           |  25 ++-
 drivers/opp/core.c                            |   2 +-
 tools/power/x86/turbostat/turbostat.8         |   2 +-
 tools/power/x86/turbostat/turbostat.c         | 240 ++++++++++++++++++--------
 7 files changed, 224 insertions(+), 89 deletions(-)
