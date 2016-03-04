From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.5-rc7
Date: Sat, 5 Mar 2016 00:36:45 +0100
Message-ID: <CAJZ5v0gFLL=T_4urojrwM11g74nhOjVWKgcHxyQFGwmTorU2kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.5-rc7

to receive power management and ACPI fixes for v4.5-rc7 with top-most
commit bfc6b97d528def357adcbdadf71b21c8e5f7dbc4

 Merge branches 'pm-cpufreq-fixes' and 'pm-sleep-fixes'

on top of commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af

 Linux 4.5-rc6

Two build fixes for cpufreq drivers (including one for breakage
introduced recently) and a fix for a graph tracer crash when
used over suspend-to-RAM on x86.

Specifics:

 - Prevent the graph tracer from crashing when used over
   suspend-to-RAM on x86 by pausing it before invoking
   do_suspend_lowlevel() and un-pausing it when that function
   has returned (Todd Brandt).

 - Fix build issues in the qoriq and mediatek cpufreq drivers
   related to broken dependencies on THERMAL (Arnd Bergmann).

Thanks!

---------------

Arnd Bergmann (2):
      cpufreq: qoriq: allow building as module with THERMAL=m
      cpufreq: mediatek: allow building as a module

Todd E Brandt (1):
      PM / sleep / x86: Fix crash on graph trace through x86 suspend

---------------

 arch/x86/kernel/acpi/sleep.c     | 7 +++++++
 drivers/cpufreq/Kconfig          | 1 +
 drivers/cpufreq/Kconfig.arm      | 4 ++--
 drivers/cpufreq/mt8173-cpufreq.c | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)
