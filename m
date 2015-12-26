From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.4-rc7
Date: Sat, 26 Dec 2015 22:40:01 +0100
Message-ID: <CAJZ5v0gX65pDn-h-XG0JBRJvm+RuvSOgwNU52BbcAPxr2VvCyg@mail.gmail.com>
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
 pm+acpi-4.4-rc7

to receive power management and ACPI fixes for v4.4-rc7 with top-most
commit 43b28ca8dfb07f2faa44204b3b3e7cb016468847

 Merge branches 'acpi-processor' and 'pm-cpufreq'

on top of commit 4ef7675344d687a0ef5b0d7c0cee12da005870c0

 Linux 4.4-rc6

These fix an ACPI processor driver regression introduced during
the 4.3 cycle and a mistake in the recently added SCPI support
in the arm_big_little cpufreq driver.

Specifics:

 - Fix a thermal management issue introduced by an ACPI processor
   driver change made during the 4.3 development cycle that failed
   to return 0 from a function on success which triggered an error
   cleanup path every time it had been called that deleted useful
   data structures created previously (Srinivas Pandruvada).

 - Fix a variable data type issue in the arm_big_little cpufreq
   driver's SCPI support code added recently that prevents error
   handling in there from working correctly (Dan Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      cpufreq: scpi-cpufreq: signedness bug in scpi_get_dvfs_info()

Srinivas Pandruvada (1):
      ACPI / processor: Fix thermal cooling device regression

---------------

 drivers/acpi/processor_driver.c | 3 ++-
 drivers/cpufreq/scpi-cpufreq.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
