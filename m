From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management material for v5.1-rc3
Date: Thu, 4 Apr 2019 22:32:04 +0200
Message-ID: <CAJZ5v0gC4WmXra1RXCxQ8-xa2xfx6PaSost_sf9XUL4wTVeRNQ@mail.gmail.com>
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
 pm-5.1-rc4

with top-most commit 58b0cf8e2418c05ed277c83b5529bd0568bfcc78

 Merge branch 'pm-tools'

on top of commit 79a3aaa7b82e3106be97842dedfd8429248896e6

 Linux 5.1-rc3

to receive power management material for 5.1-rc4.

These fix up the intel_pstate driver after recent changes to prevent
it from printing pointless messages and update the turbostat utility
(mostly fixes and new hardware support).

Specifics:

 - Make intel_pstate only load on Intel processors and prevent it
   from printing pointless failure messages (Borislav Petkov).

 - Update the turbostat utility:
   * Assorted fixes (Ben Hutchings, Len Brown, Prarit Bhargava).
   * Support for AMD Fam 17h (Zen) RAPL and package power (Calvin
     Walton).
   * Support for Intel Icelake and for systems with more than one
     die per package (Len Brown).
   * Cleanups (Len Brown).

Thanks!


---------------

Ben Hutchings (1):
      tools/power turbostat: Add checks for failure of fgets() and fscanf()

Borislav Petkov (1):
      cpufreq/intel_pstate: Load only on Intel hardware

Calvin Walton (2):
      tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
      tools/power turbostat: Also read package power on AMD F17h (Zen)

Len Brown (6):
      tools/power turbostat: Restore ability to execute in topology-order
      tools/power turbostat: Cleanup CC3-skip code
      tools/power turbostat: Cleanup CNL-specific code
      tools/power turbostat: Add Icelake support
      tools/power turbostat: Add Die column
      tools/power turbostat: update version number

Prarit Bhargava (2):
      tools/power turbostat: Do not display an error on systems
without a cpufreq driver
      tools/power turbostat: Warn on bad ACPI LPIT data

---------------

 drivers/cpufreq/intel_pstate.c        |   5 +-
 tools/power/x86/turbostat/turbostat.c | 277 +++++++++++++++++++++++++++-------
 2 files changed, 223 insertions(+), 59 deletions(-)
