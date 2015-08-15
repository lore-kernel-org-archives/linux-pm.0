From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.2-rc7
Date: Sat, 15 Aug 2015 10:14:47 -0700
Message-ID: <20150815171445.GA4151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.2-rc7 with top-most

1afb9c539daebc2c8a7b33d0e0b8fc9f74671b02:

  thermal/cpu_cooling: update policy limits if clipped_freq < policy->max (2015-08-14 18:26:23 -0700)

on top of commit 7ddab73346a1277b90fd6a4d044bc948f9cc9ad8:

  Merge branch 'fixes' of git://ftp.arm.linux.org.uk/~rmk/linux-arm (2015-08-13 16:34:56 -0700)


Specifics:
- Locked fix in the cpu cooling code.
- Refactoring in the cpu cooling code.
- Remove devm* functions from power allocator.

BR,

Eduardo Valentin
----------------------------------------------------------------
Dmitry Torokhov (1):
      thermal: power_allocator: do not use devm* interfaces

Russell King (1):
      thermal: cpu_cooling: fix lockdep problems in cpu_cooling

Viresh Kumar (6):
      thermal/cpu_cooling: No need to initialize max_freq to 0
      thermal/cpu_cooling: quit early after updating policy
      thermal/cpu_cooling: convert 'switch' block to 'if' block in notifier
      thermal/cpu_cooling: rename cpufreq_val as clipped_freq
      thermal/cpu_cooling: rename max_freq as clipped_freq in notifier
      thermal/cpu_cooling: update policy limits if clipped_freq < policy->max

 drivers/thermal/cpu_cooling.c     | 73 +++++++++++++++++++++++----------------
 drivers/thermal/power_allocator.c |  8 ++---
 2 files changed, 48 insertions(+), 33 deletions(-)
