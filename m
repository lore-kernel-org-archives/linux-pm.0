From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [GIT PULL] ACPI and power management fixes for v3.12-rc4
Date: Fri, 04 Oct 2013 19:21:45 +0200
Message-ID: <1629188.tfKsCbhlKT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.12-rc4

to receive ACPI and power management fixes for v3.12-rc4 with
top-most commit 726dcbe5f5d88080b9106f3a55b95d358b2aa140

  Merge branch 'pm-fixes'

on top of commit 15c03dd4859ab16f9212238f29dd315654aa94f6

  Linux 3.12-rc3

These fix a recent hibernation breakage, the export of an ACPI function
used by binary modules, a mistake in one of recent cpufreq-cpu0 driver
patches, the intel_pstate's handling of one of its sysfs attributes and
an error code path bug in the SPEAr cpufreq driver.

Specifics:

 1) The resume part of user space driven hibernation (s2disk) is now
    broken after the change that moved the creation of memory bitmaps
    to after the freezing of tasks, because I forgot that the resume
    utility loaded the image before freezing tasks and needed the
    bitmaps for that.  The fix adds special handling for that case.

 2) One of recent commits changed the export of acpi_bus_get_device()
    to EXPORT_SYMBOL_GPL(), which was technically correct but broke
    existing binary modules using that function including one in
    particularly widespread use.  Change it back to EXPORT_SYMBOL().

 3) The intel_pstate driver sometimes fails to disable turbo if its
    no_turbo sysfs attribute is set.  Fix from Srinivas Pandruvada.

 4) One of recent cpufreq fixes forgot to update a check in cpufreq-cpu0 
    which still (incorrectly) treats non-NULL as non-error.  Fix from
    Philipp Zabel.

 5) The SPEAr cpufreq driver uses a wrong variable type in one place
    preventing it from catching errors returned by one of the functions
    called by it.  Fix from Sachin Kamat.

Thanks!


---------------

Philipp Zabel (1):
      cpufreq: cpufreq-cpu0: NULL is a valid regulator, part 2

Rafael J. Wysocki (2):
      PM / hibernate: Fix user space driven resume regression
      ACPI: Use EXPORT_SYMBOL() for acpi_bus_get_device()

Sachin Kamat (1):
      cpufreq: SPEAr: Fix incorrect variable type

Srinivas Pandruvada (1):
      intel_pstate: fix no_turbo

---------------

 drivers/acpi/scan.c             | 2 +-
 drivers/cpufreq/cpufreq-cpu0.c  | 2 +-
 drivers/cpufreq/intel_pstate.c  | 5 ++++-
 drivers/cpufreq/spear-cpufreq.c | 2 +-
 kernel/power/snapshot.c         | 5 ++++-
 kernel/power/user.c             | 8 ++++++++
 6 files changed, 19 insertions(+), 5 deletions(-)
