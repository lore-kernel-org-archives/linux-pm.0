From: Rafael Wysocki <rjwysocki@gmail.com>
Subject: [GIT PULL] Power management fixes for v4.6-rc6
Date: Fri, 29 Apr 2016 14:40:51 +0200
Message-ID: <CAJZ5v0hTp=6+j_A+GFptBzG9MD2DnRmxmJ6vm8ZSt-64maGgMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc6

to receive power management material for v4.6-rc6 with top-most
commit 81be193b7e2089dc34a4e3939f1b057f53995f56

 Merge branch 'pm-cpufreq-fixes'

on top of commit 02da2d72174c61988eb4456b53f405e3ebdebce4

 Linux 4.6-rc5

One revert of a recent cpufreq commit that introduced a regression
and a fix for intel_pstate's Turbo Activation Ratio handling code.

Specifics:

 - Revert cpufreq commit that attempted to fix a problem in the
   ondemand/conservative governor code, but did that incorrectly
   and introduced another problem instead (Rafael Wysocki).

 - Fix incorrect decoding of MSR contents related to the
   Turbo Activation Ratio (TAR) handling in the intel_pstate
   driver (Srinivas Pandruvada).

Thanks!

---------------

Rafael J. Wysocki (1):
      Revert "cpufreq: governor: Fix negative idle_time when
configured with CONFIG_HZ_PERIODIC"

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix processing for turbo activation ratio

---------------

 drivers/cpufreq/cpufreq_governor.c | 8 ++------
 drivers/cpufreq/intel_pstate.c     | 5 +++++
 2 files changed, 7 insertions(+), 6 deletions(-)
