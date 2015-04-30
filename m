From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for 4.1-rc2
Date: Thu, 30 Apr 2015 22:09:37 +0200
Message-ID: <CAJZ5v0gMTXhJDL_Uq3M0FdshY6wtxEQFHQRO0t=7=6yv9MZPiw@mail.gmail.com>
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
 pm+acpi-4.1-rc2

to receive power management and ACPI fixes for v4.1-rc2 with
top-most commit 50904a7ddd1cab3e1d2ca007161e976f858d934f

 Merge branches 'acpica', 'acpi-battery' and 'pm-cpuidle'

on top of commit b787f68c36d49bb1d9236f403813641efa74a031

 Linux 4.1-rc1

Three regression fixes this time, one for a recent regression in the
cpuidle core affecting multiple systems, one for an inadvertently
added duplicate typedef in ACPICA that breaks compilation with
GCC 4.5 and one for an ACPI Smart Battery Subsystem driver regression
introduced during the 3.18 cycle (stable-candidate).

Specifics:

 - Fix for a regression in the cpuidle core introduced by one of
   the recent commits in the clockevents_notify() removal series
   that put a call to a function which had to be executed with
   disabled interrupts into a code path running with enabled
   interrupts (Rafael J Wysocki).

 - Fix for a build problem in ACPICA (with GCC 4.5) introduced by one
   of the recent ACPICA tools commits that added a duplicate typedef
   to one of the ACPICA's header files by mistake (Olaf Hering).

 - Fix for a regression in the ACPI SBS (Smart Battery Subsystem)
   driver introduced during the 3.18 development cycle causing the
   smart battery manager to be marked as not present when it should
   be marked as present (Chris Bainbridge).

Thanks!


---------------

Chris Bainbridge (1):
      ACPI / SBS: Enable battery manager when present

Olaf Hering (1):
      ACPICA: remove duplicate u8 typedef

Rafael J. Wysocki (1):
      cpuidle: Run tick_broadcast_exit() with disabled interrupts

---------------

 drivers/acpi/sbs.c        |  2 +-
 drivers/cpuidle/cpuidle.c | 16 ++++++++++++++++
 include/acpi/actypes.h    |  1 -
 kernel/sched/idle.c       | 16 ++--------------
 4 files changed, 19 insertions(+), 16 deletions(-)
