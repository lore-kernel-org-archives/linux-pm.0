From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.12-rc1, part 2
Date: Wed, 10 May 2017 00:58:05 +0200
Message-ID: <CAJZ5v0i=Ge2YpepTNXERJQnLkj+VZFeYVmG77hLsO3L0cb=1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-extra-4.12-rc1

with top-most commit 80449d89d4d6d0af4d6d310597e0f4a3fe0c08a9

 Merge branches 'pm-domains', 'pm-cpuidle', 'pm-sleep' and 'powercap'

on top of commit 08be881064da126b8df4b96b0b3e2e307969a4a1

 Merge tag 'acpi-4.12-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for v4.12-rc1.

These add new CPU IDs to a couple of drivers, fix a possible NULL
pointer dereference in the cpuidle core, update DT-related things
in the generic power domains framework and finally update the
suspend/resume infrastructure to improve the handling of wakeups
from suspend-to-idle.

Specifics:

 - Add Intel Gemini Lake CPU IDs to the intel_idle and intel_rapl
   drivers (David Box).

 - Add a NULL pointer check to the cpuidle core to prevent it from
   crashing on platforms with incomplete cpuidle configuration (Fei
   Li).

 - Fix DT-related documentation in the generic power domains (genpd)
   framework and add a MAINTAINERS entry for DT-related material in
   genpd (Viresh Kumar).

 - Update the system suspend/resume infrastructure to improve the
   handling of aborts of suspend transitions in progress in the
   wakeup framework and rework the suspend-to-idle core loop to make
   it possible to filter out spurious wakeup events (specifically the
   ones coming from ACPI) without resuming all the way up to user
   space every time (Rafael Wysocki).

Thanks!

---------------

David E. Box (2):
      powercap: intel_rapl: Add support for Gemini Lake
      x86/intel_idle: add Gemini Lake support

Li, Fei (1):
      cpuidle: check dev before usage in cpuidle_use_deepest_state()

Rafael J. Wysocki (2):
      PM / wakeup: Integrate mechanism to abort transitions in progress
      ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle

Viresh Kumar (2):
      PM / Domains: Fix DT example
      PM / Domains: Add DT file to MAINTAINERS

---------------

 .../devicetree/bindings/power/power_domain.txt     |  2 +-
 MAINTAINERS                                        |  1 +
 drivers/acpi/battery.c                             |  2 +-
 drivers/acpi/button.c                              |  5 +-
 drivers/acpi/device_pm.c                           |  3 +-
 drivers/acpi/sleep.c                               | 28 +++++++++++
 drivers/base/power/main.c                          |  5 --
 drivers/base/power/wakeup.c                        | 54 ++++++++++++----------
 drivers/cpuidle/cpuidle.c                          |  3 +-
 drivers/idle/intel_idle.c                          |  2 +
 drivers/powercap/intel_rapl.c                      |  1 +
 include/linux/pm_wakeup.h                          | 25 ++++++++--
 include/linux/suspend.h                            |  7 ++-
 kernel/power/process.c                             |  2 +-
 kernel/power/suspend.c                             | 29 ++++++++++--
 15 files changed, 123 insertions(+), 46 deletions(-)
