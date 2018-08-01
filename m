From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Urgent power management fixes for v4.18
Date: Wed, 1 Aug 2018 12:07:43 +0200
Message-ID: <CAJZ5v0gZpLtLZUK87B7O0Zn_srvaHUYBSMD4gn7U4A6uNhxNcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-urgent-4.18

with top-most commit 9b7c19e96cededec6b0435933adefbd56cad37ab

 Merge branch 'pm-tools'

on top of commit acb1872577b346bd15ab3a3f8dff780d6cca4b70

 Linux 4.18-rc7

to receive urgent power management fixes for final 4.18.

These fix the scope of a recent intel_pstate driver optimization
used incorrectly on some systems due to processor identification
ambiguity and fix a few issues in the turbostat utility, including
three recent regressions.

Specifics:

 - Use ACPI FADT preferred PM Profile to distinguish Skylake
   desktop processors from some server ones with the same model
   number in order to limit the scope of the recent IO-wait boost
   optimization to servers, as intended (Srinivas Pandruvada).

 - Fix several issues in the turbostat utility:
   * Fix the -S option on 1-CPU systems (Len Brown).
   * Fix computations using incorrect processor core counts (Artem
     Bityutskiy).
   * Fix the x2apic debug message (Len Brown).
   * Fix logical node enumeration to allow for non-sequential
     physical nodes (Prarit Bhargava).
   * Fix reported family on modern AMD processors (Calvin Walton).
   * Clarify the RAPL column information in the man page (Len Brown).

Thanks!


---------------

Artem Bityutskiy (1):
      tools/power turbostat: fix bogus summary values

Calvin Walton (1):
      tools/power turbostat: Read extended processor family from CPUID

Len Brown (4):
      tools/power turbostat: Update turbostat(8) RAPL throttling
column description
      tools/power turbostat: fix -S on UP systems
      tools/power turbostat: fix x2apic debug message output file
      tools/power turbostat: version 18.07.27

Prarit Bhargava (1):
      tools/power turbostat: Fix logical node enumeration to allow for
non-sequential physical nodes

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Limit the scope of HWP dynamic boost platforms

---------------

 drivers/cpufreq/intel_pstate.c        |  17 ++++-
 tools/power/x86/turbostat/turbostat.8 |   4 +-
 tools/power/x86/turbostat/turbostat.c | 120 ++++++++++++++++------------------
 3 files changed, 74 insertions(+), 67 deletions(-)
