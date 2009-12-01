From: Wu Zhangin <wuzhangjin@gmail.com>
Subject: [PATCH v6 0/8] Loongson: YeeLoong: add platform specific
	drivers
Date: Tue,  1 Dec 2009 19:11:54 +0800
Message-ID: <cover.1259660040.git.wuzhangjin__28017.4390798949$1259666090$gmane$org@gmail.com>
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
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, zhangfx@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds platform specific drivers for YeeLoong netbook. including
the backlight, battery, hwmon, video output, suspend and hotkey(input) drivers.
These drivers provide standard interfaces to the user-space applications to
manage the relative devices:
	
 	 Modules			Tools

	- backlight
	  /sys/class/backlight/		kpowersave, gnome-power-manager
	- battery
	  /proc/apm			kpowersave, gnome-power-manager
	- hwmon
	  /sys/class/hwmon/		lm-sensors, sensors-applet...
	- video output
	  /sys/class/video_output	?
	- suspend
	  /sys/power/state		kpowersave, gnome-power-manager
	- hotkey
	  /sys/class/input/		gnome-settings-daemon ?

To utilize the above interfaces, you are recommended to install the latest hal,
dbus.

This v6 revision incorporates with the feedbacks from Ralf, Pavel Machek,
Rafael J. Wysocki and Dmitry Torokhov.

Changes from the old v5 revision:

	- Cleanup the "select" and "depend" of the options
	  Replace some "select"s by "depend"s to avoid potential compiling
	  errors.

	- Cleanup the hotkey(input) driver
	  Merge several functions, Cleanup the comments, Use Switch...Case
	  instead of the array.

	- Fixup of the video output driver  
	  Seems the video output subsystem doesn't handle the input value, we
	  handle it outselves via !!od->request_state.

	- Append the yl_ prefix to the file names
	  yl_ prefix is needed to distinguish it with the next patchset for
	  lynloong pc platform drivers.

All changes have been tested again.

Best Regards,
     Wu Zhangjin

Wu Zhangjin (8):
  Loongson: Lemote-2F: add platform specific submenu
  Loongson: YeeLoong: add platform specific option
  Loongson: YeeLoong: add backlight driver
  Loongson: YeeLoong: add battery driver
  Loongson: YeeLoong: add hwmon driver
  Loongson: YeeLoong: add video output driver
  Loongson: YeeLoong: add suspend driver
  Loongson: YeeLoong: add hotkey driver

 arch/mips/kernel/setup.c                           |    1 +
 arch/mips/loongson/Kconfig                         |   21 +
 arch/mips/loongson/lemote-2f/Makefile              |    7 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c          |  130 ------
 arch/mips/loongson/lemote-2f/ec_kb3310b.h          |  188 --------
 arch/mips/loongson/lemote-2f/pm.c                  |    4 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   65 +++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |   10 +
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.c         |  126 ++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |  193 +++++++++
 .../lemote-2f/yeeloong_laptop/yl_backlight.c       |   93 ++++
 .../lemote-2f/yeeloong_laptop/yl_battery.c         |  127 ++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c |  452 ++++++++++++++++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c  |  239 +++++++++++
 .../lemote-2f/yeeloong_laptop/yl_suspend.c         |  135 ++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_vo.c     |  164 +++++++
 17 files changed, 1635 insertions(+), 322 deletions(-)
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c
