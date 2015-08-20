From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.2-rc8
Date: Fri, 21 Aug 2015 00:14:41 +0200
Message-ID: <CAJZ5v0hhAE=3oWvfSL4zN5=Qb4-yGyCR+XLtm+CVXH0fKvhuuw@mail.gmail.com>
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
 pm+acpi-4.2-rc8

to receive power management and ACPI fixes for v4.2-rc8 (if you
decide to do an -rc8) or for the final v4.2 with top-most commit
b8a1171f71c62cdd049fbc452a095173d32ee5fd

 Merge branches 'acpi-video' and 'cpufreq-fixes'

on top of commit 2c6625cd545bdd66acff14f3394865d43920a5c7

 Linux 4.2-rc7

These fix a recent regression in the ACPI backlight code and a memory
leak in the Exynos cpufreq driver.

Specifics:

 - Fix a recently introduced issue in the ACPI backlight code which
   causes lockdep to complain about a circular lock dependency during
   initialization (Hans de Goede).

 - Fix a possible memory leak during initialization in the Exynos cpufreq
   driver (Shailendra Verma).

Thanks!


---------------

Hans de Goede (1):
      ACPI / video: Fix circular lock dependency issue in the video-detect code

Shailendra Verma (1):
      cpufreq: exynos: Fix for memory leak in case SoC name does not match

---------------

 drivers/acpi/video_detect.c      | 16 +++++++++++++---
 drivers/cpufreq/exynos-cpufreq.c |  6 ++++--
 2 files changed, 17 insertions(+), 5 deletions(-)
