From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.4-rc3
Date: Fri, 27 Nov 2015 16:43:55 +0100
Message-ID: <CAJZ5v0jrdjtozg1gYKi5GB+HFRUEnWyQNQ-2CYR6sRyjjaWFfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.4-rc3

to receive power management and ACPI fixes for v4.4-rc3 with
top-most commit f28a1b0df7adcc981e5ce5a5daf3d638dd019c0e

 Merge branches 'pm-cpufreq' and 'acpi-cppc'

on top of commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4

 Linux 4.4-rc2

These fix one recent regression (cpufreq core), fix up two features
added recently (ACPI CPPC support, SCPI support in the arm_big_little
cpufreq driver) and fix three older bugs in the intel_pstate driver.

Specifics:

 - Fix a recent regression in the cpufreq core causing it to fail
   to clean up sysfs directories properly on cpufreq driver removal
   (Viresh Kumar).

 - Fix a build problem in the SCPI support code recently added to
   the arm_big_little cpufreq driver (Punit Agrawal).

 - Fix up the recently added CPPC cpufreq frontend to process the
   CPU coordination information provided by the platform firmware
   correctly (Ashwin Chaugule).

 - Fix the intel_pstate driver to behave as intended when switched
   over to the "performance" mode via sysfs if hardware-driven
   P-state selection (HWP) is enabled (Alexandra Yates).

 - Fix two rounding errors in the intel_pstate driver that sometimes
   cause it to use lower P-states than requested (Prarit Bhargava).

Thanks!


---------------

Alexandra Yates (1):
      intel_pstate: Fix "performance" mode behavior with HWP enabled

Ashwin Chaugule (1):
      cpufreq: CPPC: Initialize and check CPUFreq CPU co-ord type correctly

Prarit Bhargava (2):
      cpufreq: intel_pstate: Fix limits->max_policy_pct rounding error
      cpufreq: intel_pstate: Fix limits->max_perf rounding error

Punit Agrawal (1):
      cpufreq: SCPI: Depend on SCPI clk driver

Viresh Kumar (1):
      cpufreq: Always remove sysfs cpuX/cpufreq link on ->remove_dev()

---------------

 drivers/cpufreq/Kconfig.arm    | 2 +-
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 drivers/cpufreq/cpufreq.c      | 7 ++-----
 drivers/cpufreq/intel_pstate.c | 6 +++++-
 4 files changed, 10 insertions(+), 8 deletions(-)
