From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI updates for v4.5-rc1, part 2
Date: Thu, 21 Jan 2016 02:50:30 +0100
Message-ID: <CAJZ5v0j=9weKnHLUqyBm9ThRWfnSP1YxLiR3uad55oz9tnebxA@mail.gmail.com>
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
 pm+acpi-4.5-rc1-2

to receive the second batch of power management and ACPI updates for
v4.5-rc1 with top-most commit db2b52f75250c88ee3c6ba3d91bef38f3f1a1e8c

 Merge branch 'pm-tools'

on top of commit 67990608c8b95d2b8ccc29932376ae73d5818727

 Merge tag 'pm+acpi-4.5-rc1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

This includes fixes on top of the previous batch of PM+ACPI updates
and some new material as well.

>From the new material perspective the most significant are the driver
core changes that should allow USB devices to stay suspended over
system suspend/resume cycles if they have been runtime-suspended
already beforehand.  Apart from that, ACPICA is updated to upstream
revision 20160108 (cosmetic mostly, but including one fixup on top
of the previous ACPICA update) and there are some devfreq updates
the didn't make it before (due to timing).

A few recent regressions are fixed, most importantly in the cpuidle
menu governor and in the ACPI backlight driver and some x86 platform
drivers depending on it.

Some more bugs are fixed and cleanups are made on top of that.

Specifics:

 - Modify the driver core and the USB subsystem to allow USB devices
   to stay suspended over system suspend/resume cycles if they have
   been runtime-suspended already beforehand and fix some bugs on
   top of these changes (Tomeu Vizoso, Rafael Wysocki).

 - Update ACPICA to upstream revision 20160108, including updates
   of the ACPICA's copyright notices, a code fixup resulting from
   a regression fix that was necessary in the upstream code only
   (the regression fixed by it has never been present in Linux)
   and a compiler warning fix (Bob Moore, Lv Zheng).

 - Fix a recent regression in the cpuidle menu governor that broke
   it on practically all architectures other than x86 and make a
   couple of optimizations on top of that fix (Rafael Wysocki).

 - Clean up the selection of cpuidle governors depending on whether
   or not the kernel is configured for tickless systems (Jean Delvare).

 - Revert a recent commit that introduced a regression in the ACPI
   backlight driver, address the problem it attempted to fix in a
   different way and revert one more cosmetic change depending on
   the problematic commit (Hans de Goede).

 - Add two more ACPI backlight quirks (Hans de Goede).

 - Fix a few minor problems in the core devfreq code, clean it up
   a bit and update the MAINTAINERS information related to it
   (Chanwoo Choi, MyungJoo Ham).

 - Improve an error message in the ACPI fan driver (Andy Lutomirski).

 - Fix a recent build regression in the cpupower tool (Shreyas Prabhu).

Thanks!


---------------

Andy Lutomirski (1):
      ACPI / fan: Improve acpi_device_update_power error message

Bob Moore (2):
      ACPICA: Additional 2016 copyright changes
      ACPICA: Update version to 20160108

Chanwoo Choi (7):
      PM / devfreq: event: Remove the error log of
devfreq_event_get_edev_by_phandle()
      PM / devfreq: event: Fix the error and warning from script/checkpatch.pl
      PM / devfreq: Add show_one macro to delete the duplicate code
      PM / devfreq: Set the freq_table of devfreq device
      PM / devfreq: Modify the indentation of trans_stat sysfs for readability
      MAINTAINERS: Add missing git repository and directory for devfreq
      MAINTAINERS: Add devfreq-event entry

Hans de Goede (6):
      ACPI / video: Add disable_backlight_sysfs_if quirk for the
Toshiba Portege R700
      ACPI / video: Revert "ACPI / video: driver must be registered
before checking for keypresses"
      ACPI / video: Fix using an uninitialized mutex / list_head in
acpi_video_handles_brightness_key_presses()
      ACPI / video: Document acpi_video_handles_brightness_key_presses() a bit
      ACPI / video: Revert "thinkpad_acpi: Use
acpi_video_handles_brightness_key_presses()"
      ACPI / video: Add disable_backlight_sysfs_if quirk for the
Toshiba Satellite R830

Jean Delvare (3):
      time: nohz: Expose tick_nohz_enabled
      cpuidle: Default to ladder governor on ticking systems
      cpuidle: Don't enable all governors by default

Lv Zheng (2):
      ACPICA: Reduce regression fix divergence from upstream ACPICA
      ACPICA: Silence a -Wbad-function-cast warning when
acpi_uintptr_t is 'uintptr_t'

MyungJoo Ham (1):
      PM / devfreq: Do not show statistics if it's not ready.

Rafael J. Wysocki (5):
      platform: Do not detach from PM domains on shutdown
      driver core: Avoid NULL pointer dereferences in device_is_bound()
      cpuidle: menu: Fix menu_select() for CPUIDLE_DRIVER_STATE_START == 0
      sched / idle: Drop default_idle_call() fallback from call_cpuidle()
      cpuidle: menu: Avoid pointless checks in menu_select()

Shreyas B. Prabhu (1):
      cpupower: Fix build error in cpufreq-info

Tomeu Vizoso (4):
      device core: add device_is_bound()
      PM / Domains: add setter for dev.pm_domain
      PM / sleep: Go direct_complete if driver has no callbacks
      USB / PM: Allow USB devices to remain runtime-suspended when sleeping

---------------

 MAINTAINERS                                        | 13 ++++
 arch/arm/mach-omap2/omap_device.c                  |  7 +-
 drivers/acpi/acpi_lpss.c                           |  5 +-
 drivers/acpi/acpi_video.c                          | 52 +++++++++------
 drivers/acpi/acpica/acapps.h                       |  4 +-
 drivers/acpi/acpica/accommon.h                     |  2 +-
 drivers/acpi/acpica/acdebug.h                      |  2 +-
 drivers/acpi/acpica/acdispat.h                     |  2 +-
 drivers/acpi/acpica/acevents.h                     |  2 +-
 drivers/acpi/acpica/acglobal.h                     |  2 +-
 drivers/acpi/acpica/achware.h                      |  2 +-
 drivers/acpi/acpica/acinterp.h                     |  2 +-
 drivers/acpi/acpica/aclocal.h                      |  2 +-
 drivers/acpi/acpica/acmacros.h                     |  2 +-
 drivers/acpi/acpica/acnamesp.h                     |  2 +-
 drivers/acpi/acpica/acobject.h                     |  2 +-
 drivers/acpi/acpica/acopcode.h                     |  2 +-
 drivers/acpi/acpica/acparser.h                     |  2 +-
 drivers/acpi/acpica/acpredef.h                     |  2 +-
 drivers/acpi/acpica/acresrc.h                      |  2 +-
 drivers/acpi/acpica/acstruct.h                     |  2 +-
 drivers/acpi/acpica/actables.h                     |  2 +-
 drivers/acpi/acpica/acutils.h                      |  2 +-
 drivers/acpi/acpica/amlcode.h                      |  2 +-
 drivers/acpi/acpica/amlresrc.h                     |  2 +-
 drivers/acpi/acpica/dbcmds.c                       |  2 +-
 drivers/acpi/acpica/dbconvert.c                    |  2 +-
 drivers/acpi/acpica/dbdisply.c                     |  6 +-
 drivers/acpi/acpica/dbexec.c                       |  2 +-
 drivers/acpi/acpica/dbfileio.c                     |  2 +-
 drivers/acpi/acpica/dbhistry.c                     |  2 +-
 drivers/acpi/acpica/dbinput.c                      |  2 +-
 drivers/acpi/acpica/dbmethod.c                     |  2 +-
 drivers/acpi/acpica/dbnames.c                      |  2 +-
 drivers/acpi/acpica/dbobject.c                     |  2 +-
 drivers/acpi/acpica/dbstats.c                      |  2 +-
 drivers/acpi/acpica/dbtest.c                       |  2 +-
 drivers/acpi/acpica/dbutils.c                      |  2 +-
 drivers/acpi/acpica/dbxface.c                      |  2 +-
 drivers/acpi/acpica/dsargs.c                       |  2 +-
 drivers/acpi/acpica/dscontrol.c                    |  2 +-
 drivers/acpi/acpica/dsdebug.c                      |  2 +-
 drivers/acpi/acpica/dsfield.c                      |  2 +-
 drivers/acpi/acpica/dsinit.c                       |  2 +-
 drivers/acpi/acpica/dsmethod.c                     |  2 +-
 drivers/acpi/acpica/dsmthdat.c                     |  2 +-
 drivers/acpi/acpica/dsobject.c                     |  2 +-
 drivers/acpi/acpica/dsopcode.c                     |  2 +-
 drivers/acpi/acpica/dsutils.c                      |  2 +-
 drivers/acpi/acpica/dswexec.c                      |  2 +-
 drivers/acpi/acpica/dswload.c                      |  2 +-
 drivers/acpi/acpica/dswload2.c                     |  2 +-
 drivers/acpi/acpica/dswscope.c                     |  2 +-
 drivers/acpi/acpica/dswstate.c                     |  2 +-
 drivers/acpi/acpica/evevent.c                      |  2 +-
 drivers/acpi/acpica/evglock.c                      |  2 +-
 drivers/acpi/acpica/evgpe.c                        |  2 +-
 drivers/acpi/acpica/evgpeblk.c                     |  2 +-
 drivers/acpi/acpica/evgpeinit.c                    |  2 +-
 drivers/acpi/acpica/evgpeutil.c                    |  2 +-
 drivers/acpi/acpica/evhandler.c                    |  2 +-
 drivers/acpi/acpica/evmisc.c                       |  2 +-
 drivers/acpi/acpica/evregion.c                     |  2 +-
 drivers/acpi/acpica/evrgnini.c                     |  2 +-
 drivers/acpi/acpica/evsci.c                        |  2 +-
 drivers/acpi/acpica/evxface.c                      |  2 +-
 drivers/acpi/acpica/evxfevnt.c                     |  2 +-
 drivers/acpi/acpica/evxfgpe.c                      |  2 +-
 drivers/acpi/acpica/evxfregn.c                     |  2 +-
 drivers/acpi/acpica/exconfig.c                     |  2 +-
 drivers/acpi/acpica/exconvrt.c                     |  2 +-
 drivers/acpi/acpica/excreate.c                     |  2 +-
 drivers/acpi/acpica/exdebug.c                      |  2 +-
 drivers/acpi/acpica/exdump.c                       |  2 +-
 drivers/acpi/acpica/exfield.c                      |  2 +-
 drivers/acpi/acpica/exfldio.c                      |  2 +-
 drivers/acpi/acpica/exmisc.c                       |  2 +-
 drivers/acpi/acpica/exmutex.c                      |  2 +-
 drivers/acpi/acpica/exnames.c                      |  2 +-
 drivers/acpi/acpica/exoparg1.c                     |  2 +-
 drivers/acpi/acpica/exoparg2.c                     |  2 +-
 drivers/acpi/acpica/exoparg3.c                     |  2 +-
 drivers/acpi/acpica/exoparg6.c                     |  2 +-
 drivers/acpi/acpica/exprep.c                       |  2 +-
 drivers/acpi/acpica/exregion.c                     |  2 +-
 drivers/acpi/acpica/exresnte.c                     |  2 +-
 drivers/acpi/acpica/exresolv.c                     |  2 +-
 drivers/acpi/acpica/exresop.c                      |  2 +-
 drivers/acpi/acpica/exstore.c                      |  2 +-
 drivers/acpi/acpica/exstoren.c                     |  2 +-
 drivers/acpi/acpica/exstorob.c                     |  2 +-
 drivers/acpi/acpica/exsystem.c                     |  2 +-
 drivers/acpi/acpica/extrace.c                      |  2 +-
 drivers/acpi/acpica/exutils.c                      |  2 +-
 drivers/acpi/acpica/hwacpi.c                       |  2 +-
 drivers/acpi/acpica/hwesleep.c                     |  2 +-
 drivers/acpi/acpica/hwgpe.c                        |  2 +-
 drivers/acpi/acpica/hwpci.c                        |  2 +-
 drivers/acpi/acpica/hwregs.c                       |  2 +-
 drivers/acpi/acpica/hwsleep.c                      |  2 +-
 drivers/acpi/acpica/hwtimer.c                      |  2 +-
 drivers/acpi/acpica/hwvalid.c                      |  2 +-
 drivers/acpi/acpica/hwxface.c                      |  2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  2 +-
 drivers/acpi/acpica/nsaccess.c                     |  2 +-
 drivers/acpi/acpica/nsalloc.c                      |  2 +-
 drivers/acpi/acpica/nsarguments.c                  |  2 +-
 drivers/acpi/acpica/nsconvert.c                    |  2 +-
 drivers/acpi/acpica/nsdump.c                       |  2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |  2 +-
 drivers/acpi/acpica/nseval.c                       | 15 +++--
 drivers/acpi/acpica/nsinit.c                       |  2 +-
 drivers/acpi/acpica/nsload.c                       |  2 +-
 drivers/acpi/acpica/nsnames.c                      |  2 +-
 drivers/acpi/acpica/nsobject.c                     |  2 +-
 drivers/acpi/acpica/nsparse.c                      |  2 +-
 drivers/acpi/acpica/nspredef.c                     |  2 +-
 drivers/acpi/acpica/nsprepkg.c                     |  2 +-
 drivers/acpi/acpica/nsrepair.c                     |  2 +-
 drivers/acpi/acpica/nsrepair2.c                    |  2 +-
 drivers/acpi/acpica/nssearch.c                     |  2 +-
 drivers/acpi/acpica/nsutils.c                      |  2 +-
 drivers/acpi/acpica/nswalk.c                       |  2 +-
 drivers/acpi/acpica/nsxfeval.c                     |  2 +-
 drivers/acpi/acpica/nsxfname.c                     |  2 +-
 drivers/acpi/acpica/nsxfobj.c                      |  2 +-
 drivers/acpi/acpica/psargs.c                       |  2 +-
 drivers/acpi/acpica/psloop.c                       |  2 +-
 drivers/acpi/acpica/psobject.c                     |  2 +-
 drivers/acpi/acpica/psopcode.c                     |  2 +-
 drivers/acpi/acpica/psopinfo.c                     |  2 +-
 drivers/acpi/acpica/psparse.c                      |  2 +-
 drivers/acpi/acpica/psscope.c                      |  2 +-
 drivers/acpi/acpica/pstree.c                       |  2 +-
 drivers/acpi/acpica/psutils.c                      |  2 +-
 drivers/acpi/acpica/pswalk.c                       |  2 +-
 drivers/acpi/acpica/psxface.c                      |  2 +-
 drivers/acpi/acpica/rsaddr.c                       |  2 +-
 drivers/acpi/acpica/rscalc.c                       |  2 +-
 drivers/acpi/acpica/rscreate.c                     |  2 +-
 drivers/acpi/acpica/rsdump.c                       |  2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |  2 +-
 drivers/acpi/acpica/rsinfo.c                       |  2 +-
 drivers/acpi/acpica/rsio.c                         |  2 +-
 drivers/acpi/acpica/rsirq.c                        |  2 +-
 drivers/acpi/acpica/rslist.c                       |  2 +-
 drivers/acpi/acpica/rsmemory.c                     |  2 +-
 drivers/acpi/acpica/rsmisc.c                       |  2 +-
 drivers/acpi/acpica/rsserial.c                     |  2 +-
 drivers/acpi/acpica/rsutils.c                      |  2 +-
 drivers/acpi/acpica/rsxface.c                      |  2 +-
 drivers/acpi/acpica/tbdata.c                       |  2 +-
 drivers/acpi/acpica/tbfadt.c                       |  2 +-
 drivers/acpi/acpica/tbfind.c                       |  2 +-
 drivers/acpi/acpica/tbinstal.c                     |  2 +-
 drivers/acpi/acpica/tbprint.c                      |  2 +-
 drivers/acpi/acpica/tbutils.c                      |  2 +-
 drivers/acpi/acpica/tbxface.c                      |  2 +-
 drivers/acpi/acpica/tbxfload.c                     |  2 +-
 drivers/acpi/acpica/tbxfroot.c                     |  2 +-
 drivers/acpi/acpica/utaddress.c                    |  2 +-
 drivers/acpi/acpica/utalloc.c                      |  2 +-
 drivers/acpi/acpica/utbuffer.c                     |  2 +-
 drivers/acpi/acpica/utcache.c                      |  2 +-
 drivers/acpi/acpica/utcopy.c                       |  2 +-
 drivers/acpi/acpica/utdebug.c                      |  2 +-
 drivers/acpi/acpica/utdecode.c                     |  2 +-
 drivers/acpi/acpica/utdelete.c                     |  2 +-
 drivers/acpi/acpica/uterror.c                      |  2 +-
 drivers/acpi/acpica/uteval.c                       |  2 +-
 drivers/acpi/acpica/utexcep.c                      |  2 +-
 drivers/acpi/acpica/utglobal.c                     |  2 +-
 drivers/acpi/acpica/uthex.c                        |  2 +-
 drivers/acpi/acpica/utids.c                        |  2 +-
 drivers/acpi/acpica/utinit.c                       |  2 +-
 drivers/acpi/acpica/utlock.c                       |  2 +-
 drivers/acpi/acpica/utmath.c                       |  2 +-
 drivers/acpi/acpica/utmisc.c                       |  2 +-
 drivers/acpi/acpica/utmutex.c                      |  2 +-
 drivers/acpi/acpica/utnonansi.c                    |  2 +-
 drivers/acpi/acpica/utobject.c                     |  2 +-
 drivers/acpi/acpica/utosi.c                        |  2 +-
 drivers/acpi/acpica/utownerid.c                    |  2 +-
 drivers/acpi/acpica/utpredef.c                     |  2 +-
 drivers/acpi/acpica/utprint.c                      |  2 +-
 drivers/acpi/acpica/utresrc.c                      |  2 +-
 drivers/acpi/acpica/utstate.c                      |  2 +-
 drivers/acpi/acpica/utstring.c                     |  2 +-
 drivers/acpi/acpica/uttrack.c                      |  2 +-
 drivers/acpi/acpica/utuuid.c                       |  2 +-
 drivers/acpi/acpica/utxface.c                      |  2 +-
 drivers/acpi/acpica/utxferror.c                    |  2 +-
 drivers/acpi/acpica/utxfinit.c                     |  2 +-
 drivers/acpi/acpica/utxfmutex.c                    |  2 +-
 drivers/acpi/device_pm.c                           |  5 +-
 drivers/acpi/fan.c                                 |  2 +-
 drivers/base/dd.c                                  | 21 +++++-
 drivers/base/platform.c                            |  1 -
 drivers/base/power/clock_ops.c                     |  5 +-
 drivers/base/power/common.c                        | 24 +++++++
 drivers/base/power/domain.c                        |  8 ++-
 drivers/base/power/main.c                          | 35 ++++++++++
 drivers/base/power/power.h                         |  3 +
 drivers/cpuidle/Kconfig                            |  2 -
 drivers/cpuidle/cpuidle.c                          |  6 +-
 drivers/cpuidle/governors/ladder.c                 |  9 +++
 drivers/cpuidle/governors/menu.c                   | 23 ++++---
 drivers/devfreq/devfreq-event.c                    | 16 ++---
 drivers/devfreq/devfreq.c                          | 78 +++++++++++++++++-----
 drivers/gpu/vga/vga_switcheroo.c                   | 11 +--
 drivers/misc/mei/pci-me.c                          |  5 +-
 drivers/misc/mei/pci-txe.c                         |  5 +-
 drivers/platform/x86/thinkpad_acpi.c               |  2 +-
 drivers/usb/core/port.c                            |  6 ++
 drivers/usb/core/usb.c                             |  8 ++-
 include/acpi/acbuffer.h                            |  2 +-
 include/acpi/acconfig.h                            |  2 +-
 include/acpi/acexcep.h                             |  2 +-
 include/acpi/acnames.h                             |  2 +-
 include/acpi/acoutput.h                            |  2 +-
 include/acpi/acpi.h                                |  2 +-
 include/acpi/acpiosxf.h                            |  2 +-
 include/acpi/acpixf.h                              |  4 +-
 include/acpi/acrestyp.h                            |  2 +-
 include/acpi/actbl.h                               |  2 +-
 include/acpi/actbl1.h                              |  2 +-
 include/acpi/actbl2.h                              |  2 +-
 include/acpi/actbl3.h                              |  2 +-
 include/acpi/actypes.h                             |  2 +-
 include/acpi/acuuid.h                              |  2 +-
 include/acpi/platform/acenv.h                      |  2 +-
 include/acpi/platform/acenvex.h                    |  2 +-
 include/acpi/platform/acgcc.h                      |  2 +-
 include/acpi/platform/aclinux.h                    |  2 +-
 include/acpi/platform/aclinuxex.h                  |  2 +-
 include/acpi/platform/acmsvcex.h                   |  2 +-
 include/acpi/platform/acwinex.h                    |  2 +-
 include/acpi/video.h                               |  4 ++
 include/linux/devfreq.h                            |  2 +-
 include/linux/device.h                             |  2 +
 include/linux/pm.h                                 |  1 +
 include/linux/pm_domain.h                          |  3 +
 include/linux/tick.h                               |  2 +
 kernel/sched/idle.c                                |  6 --
 kernel/time/tick-sched.c                           |  2 +-
 tools/power/acpi/common/cmfsize.c                  |  2 +-
 tools/power/acpi/common/getopt.c                   |  2 +-
 .../acpi/os_specific/service_layers/oslibcfs.c     |  2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |  2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |  2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |  2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |  2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |  2 +-
 tools/power/cpupower/utils/cpufreq-info.c          |  1 +
 257 files changed, 516 insertions(+), 326 deletions(-)
