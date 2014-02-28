From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management fixes for v3.14-rc5
Date: Sat, 1 Mar 2014 00:16:05 +0100
Message-ID: <CAJZ5v0jgsEYh8KTUDPmxP5=XSgqDr15hDCWATqE-FT9vS7v_BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.14-rc5

to receive ACPI and power management fixes for v3.14-rc5
with top-most commit 6c09ea49ceb8a3b2b709718f6acdb1edd92ea899

  Merge branches 'pm-cpufreq', 'pm-hibernate' and 'acpi-processor'

on top of commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691

  Linux 3.14-rc4

These three commits fix a recent intel_pstate regression and two old
bugs that should be fixed in -stable too, one in the ACPI processor
driver and one in the firmare loader.

Specifics:

 - One of the recent intel_pstate driver fixes introduced a rounding
   error that on some systems causes the frequency to be stuck at the
   lowest level forever.  Fix from Dirk Brandewie.

 - The firmware_class driver's PM notifier doesn't handle the
   PM_RESTORE_PREPARE event during hibernation image restore and that
   leads to a deadlock on umhelper_sem in __usermodehelper_disable().
   Fix from Sebastian Capella.

 - acpi_processor_set_throttling() abuses set_cpus_allowed_ptr() in a
   nasty way which triggers the WARN_ON_ONCE() in wq_worker_waking_up()
   among other things.  Fix from Lan Tianyu.

Thanks!


---------------

Dirk Brandewie (1):
      intel_pstate: Change busy calculation to use fixed point math.

Lan Tianyu (1):
      ACPI / processor: Rework processor throttling with work_on_cpu()

Sebastian Capella (1):
      PM / hibernate: Fix restore hang in freeze_processes()

---------------

 drivers/acpi/processor_throttling.c | 69 +++++++++++++++++--------------------
 drivers/base/firmware_class.c       |  1 +
 drivers/cpufreq/intel_pstate.c      | 28 +++++++++------
 3 files changed, 51 insertions(+), 47 deletions(-)
