From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.2-rc5
Date: Thu, 30 Jul 2015 02:52:01 +0200
Message-ID: <CAJZ5v0hXpNnxFzfz7Gdp7k4_S=y3S=iYgRwGVRoxtXZBcqormw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.2-rc5

to receive power management and ACPI fixes for v4.2-rc5 with
top-most commit d29809b8eb12d291d7b507fdaaa5e44707641685

 Merge branches 'pm-cpufreq' and 'acpi-pm'

on top of commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f

 Linux 4.2-rc4

These fix three regressions, two recent ones (cpufreq core and
ACPI device power management) and one introduced during the 4.1
cycle (intel_pstate).

Specifics:

 - Fix a recently introduced issue in the cpufreq core causing
   it to attempt to create duplicate symbolic links to the policy
   directory in sysfs for CPUs that are offline when the cpufreq
   driver is being registered (Rafael J Wysocki).

 - Fix a recently introduced problem in the ACPI device power
   management core code causing it to store an incorrect value
   in the device object's power.state field in some cases which
   in turn leads to attempts to turn power resources off while
   they should still be on going forward (Mika Westerberg).

 - Fix an intel_pstate driver issue introduced during the 4.1 cycle
   which leads to kernel panics on boot on Knights Landing chips due
   to incomplete support for them in that driver (Lukasz Anaczkowski).

Thanks!


---------------

Lukasz Anaczkowski (1):
      intel_pstate: Add get_scaling cpu_defaults param to Knights Landing

Mika Westerberg (1):
      ACPI / PM: Use target_state to set the device power state

Rafael J. Wysocki (1):
      cpufreq: Avoid attempts to create duplicate symbolic links

---------------

 drivers/acpi/device_pm.c       |   2 +-
 drivers/cpufreq/cpufreq.c      | 108 +++++++++++++++++++++--------------------
 drivers/cpufreq/intel_pstate.c |   1 +
 include/linux/cpufreq.h        |   1 +
 4 files changed, 58 insertions(+), 54 deletions(-)
