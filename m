From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.7-rc4
Date: Sat, 18 Jun 2016 02:27:22 +0200
Message-ID: <CAJZ5v0jqQZeW8irb=VP6yjY=x9xxFp92SrCG7Z0_sNKzGA6A-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc4

to receive power management fixes for v4.7-rc4 with top-most commit
9d066a252786e1a18484a6283f82614d42a9f4ac

 Merge branches 'pm-opp' and 'pm-cpufreq-fixes'

on top of commit 5edb56491d4812c42175980759da53388e5d86f5

 Linux 4.7-rc3

Fixes for two recent regressions that may lead to degraded performance
(operating performance points framework, intel_pstate).

Specifics:

 - Fix a recent regression in the intel_pstate driver that may
   lead to degraded performance on some systems due to missing
   turbo state entry in the table returned by the ACPI _PSS
   object (Srinivas Pandruvada).

 - Fix a recent regression in the OPP (operating performance points)
   framework that may lead to degraded performance on some systems
   where the OPP table is created too early (Viresh Kumar).

Thanks!

---------------

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Adjust _PSS[0] freqeuency if needed

Viresh Kumar (1):
      PM / OPP: Add 'UNKNOWN' status for shared_opp in struct opp_table

---------------

 drivers/base/power/opp/cpu.c   | 12 +++++++++---
 drivers/base/power/opp/of.c    | 10 ++++++++--
 drivers/base/power/opp/opp.h   |  8 +++++++-
 drivers/cpufreq/intel_pstate.c | 22 ++--------------------
 4 files changed, 26 insertions(+), 26 deletions(-)
