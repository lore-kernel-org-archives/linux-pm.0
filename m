From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.20-rc3
Date: Wed, 14 Nov 2018 21:16:14 +0100
Message-ID: <CAJZ5v0jv7Bbkc4bsnu8xwjQWneRJedbdd3dNp98wEDdCYOpg9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc3

with top-most commit 97dc6c03c1b0a9af7aa26da7b0b266a762451f5f

 Merge branch 'pm-cpuidle'

on top of commit 651022382c7f8da46cb4872a545ee1da6d097d2a

 Linux 4.20-rc1

to receive power management updates for 4.20-rc3.

These remove a stale DT entry left behind after recent removal of
a cpufreq driver without users, fix up error handling in the imx6q
cpufreq driver, fix two issues in the cpufreq documentation, and
update the ARM cpufreq driver.

Specifics:

 - Drop stale DT binding for the arm_big_little_dt driver removed
   recently (Sudeep Holla).

 - Fix up error handling in the imx6q cpufreq driver to make it
   report voltage scaling failures (Anson Huang).

 - Fix two issues in the cpufreq documentation (Viresh Kumar,
   Zhao Wei Liew).

 - Fix ARM cpuidle driver initialization regression from the 4.19
   time frame and rework the driver registration part of it to
   simplify code (Ulf Hansson).

Thanks!


---------------

Anson Huang (1):
      cpufreq: imx6q: add return value check for voltage scale

Sudeep Holla (1):
      dt-bindings: cpufreq: remove stale arm_big_little_dt entry

Ulf Hansson (2):
      ARM: cpuidle: Don't register the driver when back-end init returns -ENXIO
      ARM: cpuidle: Convert to use cpuidle_register|unregister()

Viresh Kumar (1):
      Documentation: cpu-freq: Frequencies aren't always sorted

Zhao Wei Liew (1):
      Documentation: cpufreq: Correct a typo

---------------

 Documentation/admin-guide/pm/cpufreq.rst           |  2 +-
 Documentation/cpu-freq/cpufreq-stats.txt           |  8 ++-
 .../bindings/cpufreq/arm_big_little_dt.txt         | 65 ----------------------
 drivers/cpufreq/imx6q-cpufreq.c                    |  7 ++-
 drivers/cpuidle/cpuidle-arm.c                      | 40 +++----------
 5 files changed, 19 insertions(+), 103 deletions(-)
