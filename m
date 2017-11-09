From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Final power management fixes for v4.14
Date: Thu, 9 Nov 2017 17:36:03 +0100
Message-ID: <CAJZ5v0i0ngNGouoG_RJjxHaeXS=syJp5Gk=5_Rg7UcQstuHfgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-final-4.14

with top-most commit e029b9bf1221f200319541cd6861912b89345665

 Merge branch 'pm-cpufreq-sched'

on top of commit 39dae59d66acd86d1de24294bd2f343fd5e7a625

 Linux 4.14-rc8

to receive final power management fixes for 4.14.

These fix a regression in the schedutil cpufreq governor introduced
by a recent change and blacklist Dell XPS13 9360 from using the
Low Power S0 Idle _DSM interface which triggers serious problems on
one of these machines.

Specifics:

 - Prevent the schedutil cpufreq governor from using the
   utilization of a wrong CPU in some cases which started to
   happen after one of the recent changes in it (Chris Redpath).

 - Blacklist Dell XPS13 9360 from using the Low Power S0 Idle _DSM
   interface as that causes serious issue (related to NVMe) to
   appear on one of these machines, even though the other Dells
   XPS13 9360 in somewhat different HW configurations behave
   correctly (Rafael Wysocki).

Thanks!


---------------

Chris Redpath (1):
      cpufreq: schedutil: Examine the correct CPU when we update util

Rafael J. Wysocki (1):
      ACPI / PM: Blacklist Low Power S0 Idle _DSM for Dell XPS13 9360

---------------

 drivers/acpi/sleep.c             | 28 ++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  6 +-----
 2 files changed, 29 insertions(+), 5 deletions(-)
