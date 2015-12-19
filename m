From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.4-rc6
Date: Sat, 19 Dec 2015 04:45:20 +0100
Message-ID: <CAJZ5v0i=-hZODTu6FiER3A5=oLOMycxh-zMtDb0PVKcfjgrzfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.4-rc6

to receive power management fixes for v4.4-rc6 with top-most commit
f1b9fc591e437ec07626ba84e1d81be19cb00eb6

 Merge branches 'powercap', 'pm-cpufreq' and 'pm-domains'

on top of commit 9f9499ae8e6415cefc4fe0a96ad0e27864353c89

 Linux 4.4-rc5

These fix a potential regression introduced during the 4.3 cycle
(generic power domains framework), a nasty bug that has been present
forever (power capping RAPL driver), a build issue (Tegra cpufreq
driver) and a minor ugliness introduced recently (intel_pstate).

Specifics:

 - Fix a potential regression in the generic power domains
   framework introduced during the 4.3 development cycle that
   may lead to spurious failures of system suspend in certain
   situations (Ulf Hansson).

 - Fix a problem in the power capping RAPL (Running Average
   Power Limits) driver that causes it to initialize successfully
   on some systems where it is not supposed to do that which is
   due to an incorrect check in an initialization routine (Prarit
   Bhargava).

 - Fix a build problem in the cpufreq Tegra driver that depends
   on the regulator framework, but that dependency is not reflected
   in Kconfig (Arnd Bergmann).

 - Fix a recent mistake in the intel_pstate driver where a numeric
   constant is used directly instead of a symbol defined specifically
   for the case in question (Prarit Bhargava).

Thanks!


---------------

Arnd Bergmann (1):
      cpufreq: tegra: add regulator dependency for T124

Prarit Bhargava (2):
      cpufreq: intel_pstate: Minor cleanup for FRAC_BITS
      powercap / RAPL: fix BIOS lock check

Ulf Hansson (1):
      PM / Domains: Allow runtime PM callbacks to be re-used during system PM

---------------

 drivers/base/power/domain.c    | 33 ++++++++++++++++++++++-----------
 drivers/cpufreq/Kconfig.arm    |  2 +-
 drivers/cpufreq/intel_pstate.c |  2 +-
 drivers/powercap/intel_rapl.c  |  7 +++++--
 4 files changed, 29 insertions(+), 15 deletions(-)
