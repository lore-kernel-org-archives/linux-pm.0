From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM updates for 2.6.35
Date: Tue, 18 May 2010 22:09:21 +0200
Message-ID: <201005182209.21774.rjw__11563.4391237565$1274213518$gmane$org@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean Delvare <khali@linux-fr.org>, pm list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management updates for 2.6.35 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They include:

* Runtime PM improvements from Alan Stern and Dominik Brodowski

* Hibernate cleanups from Jiri Slaby

* PM documentation updates from me, Alan Stern and Pavel Machek

* PM QOS update from Mark Gross

* Subsystem PM improvements from Mark Brown and me


 Documentation/power/devices.txt          |  847 +++++++++++++++++-------------
 Documentation/power/pm_qos_interface.txt |   48 +-
 Documentation/power/userland-swsusp.txt  |    4 +
 drivers/acpi/processor_idle.c            |    2 +-
 drivers/base/platform.c                  |    6 +-
 drivers/base/power/runtime.c             |   10 +-
 drivers/base/power/sysfs.c               |   65 +++-
 drivers/cpuidle/governors/ladder.c       |    2 +-
 drivers/cpuidle/governors/menu.c         |    2 +-
 drivers/i2c/i2c-core.c                   |  166 ++++---
 drivers/net/e1000e/netdev.c              |   22 +-
 drivers/net/igbvf/netdev.c               |    6 +-
 drivers/net/wireless/ipw2x00/ipw2100.c   |   11 +-
 fs/libfs.c                               |   35 ++
 include/linux/fs.h                       |    2 +
 include/linux/netdevice.h                |    4 +
 include/linux/pm_qos_params.h            |   14 +-
 include/linux/pm_runtime.h               |    7 +
 include/linux/pm_wakeup.h                |   38 +-
 include/sound/pcm.h                      |    3 +-
 kernel/cgroup_freezer.c                  |   21 +-
 kernel/pm_qos_params.c                   |  218 ++++----
 kernel/power/Makefile                    |    3 +-
 kernel/power/block_io.c                  |  103 ++++
 kernel/power/power.h                     |   27 +-
 kernel/power/snapshot.c                  |  145 ++----
 kernel/power/swap.c                      |  333 +++++-------
 kernel/power/user.c                      |   37 +-
 net/mac80211/mlme.c                      |    2 +-
 sound/core/pcm.c                         |    3 -
 sound/core/pcm_native.c                  |   14 +-
 31 files changed, 1251 insertions(+), 949 deletions(-)

---------------

Alan Stern (2):
      PM: Allow runtime_suspend methods to call pm_schedule_suspend()
      PM: Improve device power management document

Dmitry Torokhov (1):
      PM: pm_wakeup - switch to using bool

Dominik Brodowski (1):
      PM / Runtime: Add sysfs debug files

Jiri Slaby (5):
      FS / libfs: Implement simple_write_to_buffer
      PM / Hibernate: Snapshot cleanup
      PM / Hibernate: Separate block_io
      PM / Hibernate: Move the first_sector out of swsusp_write
      PM / Hibernate: Group swap ops

Mark Brown (1):
      PM / platform_bus: Allow runtime PM by default

Mark Gross (2):
      PM QOS update
      PM: PM QOS update fix

Matt Helsley (1):
      Freezer / cgroup freezer: Update stale locking comments

Pavel Machek (1):
      PM / Hibernate: document open(/dev/snapshot) side effects

Rafael J. Wysocki (2):
      PM: Update device power management document
      i2c: Fix bus-level power management callbacks

Randy Dunlap (1):
      PM / Hibernate: Fix block_io.c printk warning
