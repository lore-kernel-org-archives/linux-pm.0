From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management updates for 2.6.38
Date: Fri, 7 Jan 2011 22:16:58 +0100
Message-ID: <201101072216.58606.rjw__15969.4416019649$1294435126$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management updates for 2.6.38 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They include:

* Runtime PM framework update from Alan Stern.

* Modification of core suspend/resume routines to avoid aborting suspend on wakeup
  events when we aren't supposed to take wakeup events during suspend into account.

* Modification of core suspend/resume routines to use a different list of devices
  for each stage of device suspend (and simplifications resulting from that).

* Addition of pm_generic_ functions prototypes and update of the SPI bus type
  subsystem-level PM routines from Mark Brown.

* PM-related fixes.


 Documentation/power/drivers-testing.txt |    8 +-
 Documentation/power/runtime_pm.txt      |   31 ++++++
 drivers/base/power/generic_ops.c        |    6 +-
 drivers/base/power/main.c               |  174 +++++++++++--------------------
 drivers/base/power/runtime.c            |   47 +++++++--
 drivers/base/power/wakeup.c             |   20 ++--
 drivers/spi/spi.c                       |   92 +++++++++++++++--
 drivers/usb/core/driver.c               |    7 +-
 include/linux/device.h                  |    4 +-
 include/linux/pm.h                      |   51 ++-------
 include/linux/pm_runtime.h              |   13 +++
 include/linux/suspend.h                 |    4 +-
 kernel/freezer.c                        |    9 ++-
 kernel/power/Makefile                   |    5 +-
 kernel/power/hibernate.c                |    7 +-
 kernel/power/process.c                  |    8 ++-
 kernel/power/suspend.c                  |    2 +-
 17 files changed, 282 insertions(+), 206 deletions(-)

---------------

Aaro Koskinen (1):
      PM / Runtime: Fix comments to match runtime callback code

Alan Stern (1):
      PM / Runtime: Add synchronous runtime interface for interrupt handlers (v3)

Jon Mason (1):
      PM: Fix references to basic-pm-debugging.txt in drivers-testing.txt

Mark Brown (2):
      PM: Prototype the pm_generic_ operations
      spi / PM: Support dev_pm_ops

MyungJoo Ham (2):
      PM / Hibernate: hibernation_ops->leave should be checked too
      PM / Hibernate: When failed, in_suspend should be reset

Rafael J. Wysocki (10):
      PM: Prevent dpm_prepare() from returning errors unnecessarily
      PM / Wakeup: Replace pm_check_wakeup_events() with pm_wakeup_pending()
      PM: Use pm_wakeup_pending() in __device_suspend()
      PM: Avoid compiler warning in pm_noirq_op()
      PM: Use a different list of devices for each stage of device suspend
      PM: Remove redundant checks from core device resume routines
      PM: Replace the device power.status field with a bit field
      PM: Permit registration of parentless devices during system suspend
      PM: Use dev_name() in core device suspend and resume routines
      PM / Runtime: Generic resume shouldn't set RPM_ACTIVE unconditionally

Tejun Heo (1):
      Freezer: Fix a race during freezing of TASK_STOPPED tasks

Tracey Dent (1):
      PM: Use proper ccflag flag in kernel/power/Makefile
