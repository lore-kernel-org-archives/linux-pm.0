From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.14-rc7
Date: Thu, 26 Oct 2017 18:37:45 +0200
Message-ID: <CAJZ5v0igDPBbCiyeCnO5jy9j3aFioV20g1nz66jXXBx6jAkqLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

It is late in the cycle, but the bug in question is in the
"user space can trigger unexpected behavior" category and the
fix is stable-candidate, so here it goes.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.14-rc7

with top-most commit 0cc2b4e5a020fc7f4d1795741c116c983e9467d7

 PM / QoS: Fix device resume latency PM QoS

on top of commit bb176f67090ca54869fc1262c913aa69d2ede070

 Linux 4.14-rc6

to receive a power management fix for v4.14-rc7.

This fixes a device power management quality of service (PM QoS)
framework implementation issue causing "no restriction" requests
for device resume latency, including "no restriction" set by user
space, to effectively override requests with specific device
resume latency requirements.

Thanks!

---------------

Rafael J. Wysocki (1):
      PM / QoS: Fix device resume latency PM QoS

---------------

 Documentation/ABI/testing/sysfs-devices-power |  4 +-
 drivers/base/cpu.c                            |  3 +-
 drivers/base/power/domain_governor.c          | 53 +++++++++++++++------------
 drivers/base/power/qos.c                      |  2 +-
 drivers/base/power/runtime.c                  |  2 +-
 drivers/base/power/sysfs.c                    | 25 +++++++++++--
 drivers/cpuidle/governors/menu.c              |  4 +-
 include/linux/pm_qos.h                        |  5 ++-
 8 files changed, 63 insertions(+), 35 deletions(-)
