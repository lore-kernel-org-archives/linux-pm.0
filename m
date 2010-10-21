From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management updates for 2.6.37
Date: Thu, 21 Oct 2010 23:50:15 +0200
Message-ID: <201010212350.15409.rjw__23741.4752402858$1287697949$gmane$org@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management updates for 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They include:

 * Runtime PM framework updates from Alan Stern and me.  The autosuspend
   feature is now available at the core level to drivers wanting to use it.

 * Hibernate image compression from Bojan Smojver.

 * Operating Performance Points framework from Nishanth Menon.

 * Hibernate improvements and fixes.

 * sysfs attribute for checking pm_trace device matches from James Hogan.

 * Extension of the wakeup events code for collecting wakeup sources
   statistics.


 Documentation/ABI/testing/sysfs-devices-power |   88 +++
 Documentation/ABI/testing/sysfs-power         |   29 +
 Documentation/kernel-parameters.txt           |    5 +
 Documentation/power/00-INDEX                  |    2 +
 Documentation/power/interface.txt             |    2 +-
 Documentation/power/opp.txt                   |  375 ++++++++++
 Documentation/power/runtime_pm.txt            |  227 ++++++-
 Documentation/power/s2ram.txt                 |    7 +
 Documentation/power/swsusp.txt                |    3 +-
 drivers/base/power/Makefile                   |    1 +
 drivers/base/power/generic_ops.c              |    4 +-
 drivers/base/power/main.c                     |   21 +-
 drivers/base/power/opp.c                      |  628 ++++++++++++++++
 drivers/base/power/power.h                    |    2 +
 drivers/base/power/runtime.c                  |  944 +++++++++++++------------
 drivers/base/power/sysfs.c                    |  217 ++++++-
 drivers/base/power/trace.c                    |   36 +-
 drivers/base/power/wakeup.c                   |  613 ++++++++++++++--
 fs/sysfs/group.c                              |   59 ++
 include/linux/opp.h                           |  105 +++
 include/linux/pm.h                            |   38 +-
 include/linux/pm_runtime.h                    |  121 +++-
 include/linux/pm_wakeup.h                     |  127 +++-
 include/linux/resume-trace.h                  |    2 +
 include/linux/suspend.h                       |    6 +-
 include/linux/sysfs.h                         |   15 +
 kernel/power/Kconfig                          |   17 +
 kernel/power/hibernate.c                      |   25 +-
 kernel/power/main.c                           |   29 +-
 kernel/power/power.h                          |   10 +-
 kernel/power/process.c                        |   11 +-
 kernel/power/snapshot.c                       |   13 +-
 kernel/power/swap.c                           |  300 ++++++++-
 33 files changed, 3447 insertions(+), 635 deletions(-)

---------------

Alan Stern (7):
      sysfs: Add sysfs_merge_group() and sysfs_unmerge_group()
      PM / Runtime: Move code in drivers/base/power/runtime.c
      PM / Runtime: Replace boolean arguments with bitflags
      PM / Runtime: Merge synchronous and async runtime routines
      PM / Runtime: Combine runtime PM entry points
      PM / Runtime: Add no_callbacks flag
      PM / Runtime: Implement autosuspend support

Bojan Smojver (1):
      PM / Hibernate: Compress hibernation image with LZO

James Hogan (2):
      PM: Lock PM device list mutex in show_dev_hash()
      PM: Add sysfs attr for rechecking dev hash from PM trace

Kevin Cernekee (1):
      PM: Fix signed/unsigned warning in dpm_show_time()

Ming Lei (1):
      PM: runtime: add missed pm_request_autosuspend

Nishanth Menon (1):
      PM: Introduce library for device-specific OPPs (v7)

Ohad Ben-Cohen (1):
      PM / Runtime: Lenient generic runtime pm callbacks

Rafael J. Wysocki (12):
      PM: Fix unmet dependency warning from kconfig
      PM / Runtime: Use alloc_workqueue() for creating the PM workqueue
      PM / Hibernate: Improve comments in hibernate_preallocate_memory()
      PM / Hibernate: Make default image size depend on total RAM size
      PM / Wakeup: Introduce wakeup source objects and event statistics (v3)
      PM: Fix potential issue with failing asynchronous suspend
      PM / Hibernate: Make some boot messages look less scary
      PM: Allow wakeup events to abort freezing of tasks
      PM / Runtime: Reduce code duplication in core helper functions
      PM / Hibernate: Modify signature used to mark swap
      PM / Runtime: Remove idle notification after failing suspend
      PM / Wakeup: Show wakeup sources statistics in debugfs
