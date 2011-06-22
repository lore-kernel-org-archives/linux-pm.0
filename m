From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] More power management fixes for 3.0
Date: Wed, 22 Jun 2011 22:04:54 +0200
Message-ID: <201106222204.54532.rjw__15128.4923464575$1308773084$gmane$org@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They include:

* Power management documentation fixes updating information on things that have
  changed.

* Fix for potential PCI PM regression related to interactions between system
  suspend/hibernation and the runtime PM framework.

* Fix for smobile regression related to the management of device clocks when
  CONFIG_PM_RUNTIME is unset.

* Fix for a long-standing issue in the async suspend error code path (accompanied
  by a field rename in struct dev_pm_info).

* Fix for a long-standing hibernation bug related to its user space interface.


 Documentation/power/devices.txt    |   67 +++++++----------------------------
 Documentation/power/runtime_pm.txt |    5 ---
 drivers/base/power/clock_ops.c     |    4 +-
 drivers/base/power/main.c          |   28 +++++++++++----
 drivers/pci/pci-driver.c           |    4 ++-
 drivers/usb/core/driver.c          |    6 ++--
 include/linux/device.h             |    4 +-
 include/linux/pm.h                 |    3 +-
 kernel/power/user.c                |    4 ++-
 9 files changed, 50 insertions(+), 75 deletions(-)

---------------

Alan Stern (2):
      PM: Rename dev_pm_info.in_suspend to is_prepared
      PM: Fix async resume following suspend failure

Kevin Hilman (1):
      PM / Runtime: Update doc: usage count no longer incremented across system PM

Michal Kubecek (1):
      PM: Free memory bitmaps if opening /dev/snapshot fails

Rafael J. Wysocki (4):
      PM: Update documentation regarding sysdevs
      PM / Runtime: Handle clocks correctly if CONFIG_PM_RUNTIME is unset
      PM / Domains: Update documentation
      PCI / PM: Block races between runtime PM and system sleep
