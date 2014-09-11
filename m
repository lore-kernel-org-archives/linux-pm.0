From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management fixes for 3.17-rc5
Date: Thu, 11 Sep 2014 16:17:46 +0200
Message-ID: <CAJZ5v0gdcq5S5qLEY_XAWG3LkfLtz6t_+3XRMqCwehstmd2coQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.17-rc5

to receive ACPI and power management fixes for v3.17-rc5 with
top-most commit d2be8992df5d113a57374b7f654d667b8f9b32f4

 Merge branches 'acpi-rtc', 'acpi-lpss' and 'acpi-battery'

on top of commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd

 Linux 3.17-rc4

These are regression fixes (cpufreq, ACPI battery) and fixes for
stuff that never worked correctly (ACPI RTC operation region handler
and PM domain implementation in the ACPI LPSS driver).

Specifics:

 - Fix for the cpufreq Operation Performance Points (OPP) code
   where a recent commit added a kcalloc() call with an incorrect
   ordering of arguments.  From Anand Moon.

 - Reverts of two ACPI battery commits that caused incorrect
   diagnostic information to be printed to dmesg in some cases
   from Bj=C3=B8rn Mork.

 - Fix for the ACPI RTC operation region handler that applied the
   & operator to an argument already representing an address and
   that caused it to overwrite its own argument instead of writing
   to the address contained in it as expected.  From Chun-Yi Lee.

 - Fix for the PM domain implementation in the ACPI LPSS (Low-Power
   Subsystem) driver where one callback pointer pointed to a wrong
   routine and one was NULL, but it shouldn't.  From Fu Zhonghui.

Thanks!

---------------

Anand Moon (1):
      cpufreq / OPP: Fix the order of arguments for kcalloc()

Bj=C3=B8rn Mork (2):
      Revert "ACPI / battery: Fix warning message in acpi_battery_get_s=
tate()"
      Revert "ACPI / battery: fix wrong value of capacity_now reported
when fully charged"

=46u Zhonghui (1):
      ACPI / LPSS: complete PM entries for LPSS power domain

Lee, Chun-Yi (1):
      ACPI / RTC: Fix CMOS RTC opregion handler accesses to wrong addre=
sses

---------------

 drivers/acpi/acpi_cmos_rtc.c  |  2 +-
 drivers/acpi/acpi_lpss.c      | 10 +++++-----
 drivers/acpi/battery.c        | 14 --------------
 drivers/cpufreq/cpufreq_opp.c |  2 +-
 4 files changed, 7 insertions(+), 21 deletions(-)
