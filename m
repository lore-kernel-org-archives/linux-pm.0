From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.19-rc2
Date: Fri, 31 Aug 2018 01:54:54 +0200
Message-ID: <CAJZ5v0hBmEFyUhhqgUKuvh1DcpuN+FdPkN9_Nf+hUHm9tjtC6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc2

with top-most commit a0b9c4de7bf3dacc32a7e70fff25e158a0bf848f

 Merge branch 'pm-core'

on top of commit dfec4a8478e8e81483a94b663f13153bb7796800

 Merge tag 'pm-4.19-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 4.19-rc2.

These address a corner case in the menu cpuidle governor and fix
error handling in the PM core's generic clock management code.

Specifics:

 - Make the menu cpuidle governor avoid stopping the scheduler tick
   if the predicted idle duration exceeds the tick period length, but
   the selected idle state is shallow and deeper idle states with
   high target residencies are available (Rafael Wysocki).

 - Make the PM core's generic clock management code use a proper data
   type for one variable to make error handling work (Dan Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      PM / clk: signedness bug in of_pm_clk_add_clks()

Rafael J. Wysocki (1):
      cpuidle: menu: Retain tick when shallow state is selected

---------------

 drivers/base/power/clock_ops.c   |  2 +-
 drivers/cpuidle/governors/menu.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)
