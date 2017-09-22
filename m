From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.14-rc2
Date: Sat, 23 Sep 2017 01:07:20 +0200
Message-ID: <CAJZ5v0jjkJa+H9Edh_Mjg-sDhEobVMHB6HKQkyP94cnpFe6tjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.14-rc2

with top-most commit d84c97f8f77bc4124256e76864f125f45ad53744

 Merge branches 'pm-cpufreq' and 'pm-cpuidle'

on top of commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e

 Linux 4.14-rc1

to receive power management fixes for v4.14-rc2.

These fix a cpufreq regression introduced by recent changes related
to the generic DT driver, an initialization time memory leak in
cpuidle on ARM, a PM core bug that may cause system suspend/resume
to fail on some systems, a request type validation issue in the PM
QoS framework and two documentation-related issues.

Specifics:

 - Fix a regression in cpufreq on systems using DT as the source of
   CPU configuration information where two different code paths
   attempt to create the cpufreq-dt device object (there can be only
   one) and fix up the "compatible" matching for some TI platforms
   on top of that (Viresh Kumar, Dave Gerlach).

 - Fix an initialization time memory leak in cpuidle on ARM which
   occurs if the cpuidle driver initialization fails (Stefan Wahren).

 - Fix a PM core function that checks whether or not there are any
   system suspend/resume callbacks for a device, but forgets to
   check legacy callbacks which then may be skipped incorrectly
   and the system may crash and/or the device may become unusable
   after a suspend-resume cycle (Rafael Wysocki).

 - Fix request type validation for latency tolerance PM QoS requests
   which may lead to unexpected behavior (Jan Sch=C3=B6nherr).

 - Fix a broken link to PM documentation from a header file and a
   typo in a PM document (Geert Uytterhoeven, Rafael Wysocki).

Thanks!


---------------

Dave Gerlach (1):
      cpufreq: ti-cpufreq: Support additional am43xx platforms

Geert Uytterhoeven (1):
      driver core: Fix link to device power management documentation

Jan H. Sch=C3=B6nherr (1):
      PM / QoS: Use the correct variable to check the QoS request type

Rafael J. Wysocki (2):
      PM: docs: Drop an excess character from devices.rst
      PM: core: Fix device_pm_check_callbacks()

Stefan Wahren (1):
      ARM: cpuidle: Avoid memleak if init fail

Viresh Kumar (1):
      cpufreq: dt-platdev: Add some missing platforms to the blacklist

---------------

 Documentation/driver-api/pm/devices.rst |  2 +-
 drivers/base/power/main.c               |  9 ++++++---
 drivers/base/power/qos.c                | 10 +++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c    | 12 ++++++++++++
 drivers/cpufreq/ti-cpufreq.c            |  2 +-
 drivers/cpuidle/cpuidle-arm.c           |  6 ++++--
 include/linux/device.h                  |  2 +-
 7 files changed, 30 insertions(+), 13 deletions(-)
