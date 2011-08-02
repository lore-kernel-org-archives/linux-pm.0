From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] ACPI patches for Linux 3.1
Date: Tue, 02 Aug 2011 17:35:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108021733460.25237__19525.2384910875$1312321050$gmane$org@x980>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-490606887-1312320916=:25237"
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-490606887-1312320916=:25237
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id p72La2A2028820

Hi Linus,

please pull from:=20

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git rel=
ease

This will update the files shown below.

thanks!

Len Brown
Intel Open Source Technology Center

ps. individual patches are available on linux-acpi@vger.kernel.org

 Documentation/feature-removal-schedule.txt |    9 --
 Documentation/kernel-parameters.txt        |    5 +
 drivers/acpi/acpica/acglobal.h             |    6 +
 drivers/acpi/acpica/aclocal.h              |    1 +
 drivers/acpi/acpica/acpredef.h             |    1 +
 drivers/acpi/acpica/nspredef.c             |   19 +++-
 drivers/acpi/acpica/nsrepair2.c            |   15 +++
 drivers/acpi/acpica/tbinstal.c             |   27 +++++-
 drivers/acpi/battery.c                     |   82 ++++++++++------
 drivers/acpi/dock.c                        |    4 +-
 drivers/acpi/ec_sys.c                      |    2 +-
 drivers/acpi/fan.c                         |    2 +-
 drivers/acpi/osl.c                         |   25 +++++-
 drivers/acpi/pci_irq.c                     |   58 +++++++++++
 drivers/acpi/pci_root.c                    |    3 +-
 drivers/acpi/processor_thermal.c           |    2 +-
 drivers/acpi/sbs.c                         |   13 ++-
 drivers/acpi/sleep.c                       |   16 +++
 drivers/acpi/sysfs.c                       |    4 +-
 drivers/acpi/thermal.c                     |    2 +-
 drivers/acpi/video.c                       |    2 +-
 drivers/ata/libata-acpi.c                  |    4 +-
 drivers/pci/hotplug/acpiphp_glue.c         |    2 +-
 drivers/thermal/Kconfig                    |    8 +-
 drivers/thermal/thermal_sys.c              |  142 ++++++++++++++++++++++=
------
 include/acpi/acpi_drivers.h                |    2 +-
 include/acpi/acpixf.h                      |    3 +-
 include/acpi/processor.h                   |    2 +-
 include/linux/acpi.h                       |    1 -
 include/linux/thermal.h                    |   22 -----
 30 files changed, 352 insertions(+), 132 deletions(-)

through these commits:

Bob Moore (5):
      ACPICA: Load operator: re-instate most restrictions on incoming tab=
le signature
      ACPICA: Add missing _TDL to list of predefined names
      ACPICA: Update to version 20110527
      ACPICA: Add option to disable method return value validation and re=
pair
      ACPICA: Update to version 20110623

David Rientjes (1):
      ACPI: remove NID_INVAL

Fenghua Yu (1):
      ACPICA: Do not repair _TSS return package if _PSS is present

Jean Delvare (3):
      thermal: hide CONFIG_THERMAL_HWMON
      thermal: split hwmon lookup to a separate function
      thermal: make THERMAL_HWMON implementation fully internal

Jon Mason (1):
      ACPI: fix 80 char overflow

Lan Tianyu (8):
      ACPI / SBS: Add getting state operation in the acpi_sbs_battery_get=
_property()
      ACPI / SBS: Correct the value of power_now and power_avg in the sys=
fs
      ACPI / Battery: Add the power unit macro
      ACPI / Battery: Change 16-bit signed negative battery current into =
correct value
      ACPI / Battery: Rename acpi_battery_quirks2 with acpi_battery_quirk=
s
      ACPI / Battery: Add the hibernation process in the battery_notify()
      ACPI / Battery: Add the check before refresh sysfs in the battery_n=
otify()
      ACPI / Battery: Resolve the race condition in the sysfs_remove_batt=
ery()

Len Brown (2):
      ACPI print OSI(Linux) warning only once
      ACPI:  delete stale reference in kernel-parameters.txt

Shaohua Li (1):
      ACPI: add missing _OSI strings

Stefan Assmann (1):
      ACPI: fix CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS

Stefan Hajnoczi (2):
      ACPI / Battery: avoid acpi_battery_add() use-after-free
      ACPI / Battery: propagate sysfs error in acpi_battery_add()

Takao Indoh (1):
      ACPI: introduce "acpi_rsdp=3D" parameter for kdump

Vasiliy Kulikov (1):
      ACPI: constify ops structs

Zhang Rui (1):
      ACPI: DMI workaround for Asus A8N-SLI Premium and Asus A8N-SLI DELU=
X

with this log:

commit 4a8f5058bde15d737abe39b5bed3f21dcb6599d2
Merge: 3eb208f eb03cb0 d7f6169 e410829 bb0c5ed aa16597 4996c02 6c8111e
Author: Len Brown <len.brown@intel.com>
Date:   Tue Aug 2 17:22:09 2011 -0400

    Merge branches 'acpica', 'battery', 'boot-irqs', 'bz-24492', 'bz-9528=
', 'from-akpm', 'kexec-param' and 'misc' into release
   =20
    Conflicts:
    	Documentation/kernel-parameters.txt
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6c8111e9a0e73ef1e58a1bf0a10c23ee1512e7a2
Author: Len Brown <len.brown@intel.com>
Date:   Tue Aug 2 17:15:33 2011 -0400

    ACPI:  delete stale reference in kernel-parameters.txt
   =20
    Says for acpi=3D
                            See also Documentation/power/pm.txt, pci=3Dno=
acpi
   =20
    but this file does not exist
   =20
    Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aa165971c2923d05988f920c978e438dbc7b0de6
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Thu Jul 28 13:48:43 2011 -0700

    ACPI: add missing _OSI strings
   =20
    Linux supports some optional features, but it should notify the BIOS =
about
    them via the _OSI method.  Currently Linux doesn't notify any, which =
might
    make such features not work because the BIOS doesn't know about them.
   =20
    Jarosz has a system which needs this to make ACPI processor aggregato=
r
    device work.
   =20
    Reported-by: "Jarosz, Sebastian" <sebastian.jarosz@intel.com>
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Acked-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f52e00c668669c9c290e84adf859c76db6d92a5a
Author: David Rientjes <rientjes@google.com>
Date:   Thu Jul 28 13:48:43 2011 -0700

    ACPI: remove NID_INVAL
   =20
    b552a8c56db8 ("ACPI: remove NID_INVAL") removed the left over uses of
    NID_INVAL, but didn't actually remove the definition.  Remove it.
   =20
    Signed-off-by: David Rientjes <rientjes@google.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 31f5396ad3bde23c8416e8d23ba425e27f413314
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Jul 28 13:48:42 2011 -0700

    thermal: make THERMAL_HWMON implementation fully internal
   =20
    THERMAL_HWMON is implemented inside the thermal_sys driver and has no
    effect on drivers implementing thermal zones, so they shouldn't see
    anything related to it in <linux/thermal.h>.  Making the THERMAL_HWMO=
N
    implementation fully internal has two advantages beyond the cleaner
    design:
   =20
    * This avoids rebuilding all thermal drivers if the THERMAL_HWMON
      implementation changes, or if CONFIG_THERMAL_HWMON gets enabled or
      disabled.
   =20
    * This avoids breaking the thermal kABI in these cases too, which sho=
uld
      make distributions happy.
   =20
    The only drawback I can see is slightly higher memory fragmentation, =
as
    the number of kzalloc() calls will increase by one per thermal zone. =
 But
    I doubt it will be a problem in practice, as I've never seen a system=
 with
    more than two thermal zones.
   =20
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Cc: Rene Herman <rene.herman@gmail.com>
    Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0d97d7a494d43be77f57e688369be0aae33d1ade
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Jul 28 13:48:41 2011 -0700

    thermal: split hwmon lookup to a separate function
   =20
    We'll soon need to reuse it.
   =20
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Cc: Rene Herman <rene.herman@gmail.com>
    Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ab92402af04c151c26541eb28e1c26286a429db5
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Jul 28 13:48:40 2011 -0700

    thermal: hide CONFIG_THERMAL_HWMON
   =20
    It's about time to revert 16d752397301b9 ("thermal: Create
    CONFIG_THERMAL_HWMON=3Dn").  Anybody running a kernel >=3D 2.6.40 wou=
ld also
    be running a recent enough version of lm-sensors.
   =20
    Actually having CONFIG_THERMAL_HWMON is pretty convenient so instead =
of
    dropping it, we keep it but hide it.
   =20
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Cc: Rene Herman <rene.herman@gmail.com>
    Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8997621bb2daaf19a4e9d82f118224159d8054e2
Author: Len Brown <len.brown@intel.com>
Date:   Tue Aug 2 00:45:48 2011 -0400

    ACPI print OSI(Linux) warning only once
   =20
    This message gets repeated on some machines:
    https://bugzilla.kernel.org/show_bug.cgi?id=3D29292
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bb0c5ed6ec523199e34e81dcef8e987507553b63
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Sat Jul 30 01:40:48 2011 -0400

    ACPI: DMI workaround for Asus A8N-SLI Premium and Asus A8N-SLI DELUX
   =20
    DMI workaround for A8N-SLI Premium and A8N-SLI DELUXE
    to enable the s3 suspend old ordering.
    http://bugzilla.kernel.org/show_bug.cgi?id=3D9528
   =20
    Tested-by: Heiko Ettelbr=FCck <hbruckynews@gmx.de>
    Tested-by: Brian Beardall <brian@rapsure.net>
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eb03cb02b74df6dd0b653d5f6d976f16a434dfaf
Author: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Date:   Tue Jul 12 09:03:29 2011 +0100

    ACPI / Battery: propagate sysfs error in acpi_battery_add()
   =20
    Make sure the error return from sysfs_add_battery() is checked and
    propagated out from acpi_battery_add().
   =20
    Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e80bba4b5108c6479379740201b0a5d9da5ffbac
Author: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Date:   Tue Jul 12 09:03:28 2011 +0100

    ACPI / Battery: avoid acpi_battery_add() use-after-free
   =20
    When acpi_battery_add_fs() fails the error handling code does not cle=
an
    up completely.  Moreover, it does not return resulting in a
    use-after-free.
   =20
    Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4996c02306a25def1d352ec8e8f48895bbc7dea9
Author: Takao Indoh <indou.takao@jp.fujitsu.com>
Date:   Thu Jul 14 18:05:21 2011 -0400

    ACPI: introduce "acpi_rsdp=3D" parameter for kdump
   =20
    There is a problem with putting the first kernel in EFI virtual mode,
    it is that when the second kernel comes up it tries to initialize the
    EFI again and once we have put EFI in virtual mode we can not really
    do that.
   =20
    Actually, EFI is not necessary for kdump, we can boot the second kern=
el
    with "noefi" parameter, but the boot will mostly fail because 2nd ker=
nel
    cannot find RSDP.
   =20
    In this situation, we introduced "acpi_rsdp=3D" kernel parameter, so =
that
    kexec-tools can pass the "noefi acpi_rsdp=3DX" to the second kernel t=
o
    make kdump works. The physical address of the RSDP can be got from
    sysfs(/sys/firmware/efi/systab).
   =20
    Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
    Reviewed-by: WANG Cong <amwang@redhat.com>
    Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9c8b04be443b33939f374a811c82abeebe0a61d1
Author: Vasiliy Kulikov <segoon@openwall.com>
Date:   Sat Jun 25 21:07:52 2011 +0400

    ACPI: constify ops structs
   =20
    Structs battery_file, acpi_dock_ops, file_operations,
    thermal_cooling_device_ops, thermal_zone_device_ops, kernel_param_ops
    are not changed in runtime.  It is safe to make them const.
    register_hotplug_dock_device() was altered to take const "ops" argume=
nt
    to respect acpi_dock_ops' const notion.
   =20
    Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
    Acked-by: Jeff Garzik <jgarzik@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d7f6169a0d32002657886fee561c641acddb9a75
Author: Stefan Assmann <sassmann@kpanic.de>
Date:   Fri Jul 15 14:52:30 2011 +0200

    ACPI: fix CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
   =20
    The following was observed by Steve Rostedt on 3.0.0-rc5
    Backtrace:
    irq 16: nobody cared (try booting with the "irqpoll" option)
    Pid: 65, comm: irq/16-uhci_hcd Not tainted 3.0.0-rc5-test+ #94
    Call Trace:
     [<ffffffff810aa643>] __report_bad_irq+0x37/0xc1
     [<ffffffff810aaa2d>] note_interrupt+0x14e/0x1c9
     [<ffffffff810a9a05>] ? irq_thread_fn+0x3c/0x3c
     [<ffffffff810a990e>] irq_thread+0xf6/0x1b1
     [<ffffffff810a9818>] ? irq_finalize_oneshot+0xb3/0xb3
     [<ffffffff8106b4d6>] kthread+0x9f/0xa7
     [<ffffffff814f1f04>] kernel_thread_helper+0x4/0x10
     [<ffffffff8103ca09>] ? finish_task_switch+0x7b/0xc0
     [<ffffffff814eac78>] ? retint_restore_args+0x13/0x13
     [<ffffffff8106b437>] ? __init_kthread_worker+0x5a/0x5a
     [<ffffffff814f1f00>] ? gs_change+0x13/0x13
    handlers:
    [<ffffffff810a912d>] irq_default_primary_handler threaded [<ffffffff8=
135eaa6>] usb_hcd_irq
    [<ffffffff810a912d>] irq_default_primary_handler threaded [<ffffffff8=
135eaa6>] usb_hcd_irq
    Disabling IRQ #16
   =20
    The problem being that a device triggers boot interrupts (due to thre=
aded
    interrupt handling and masking of the IO-APIC), which are forwarded
    to the PIRQ line of the device. These interrupts are not handled on t=
he PIRQ
    line because the interrupt handler is not present there.
    This should have already been fixed by CONFIG_X86_REROUTE_FOR_BROKEN_=
BOOT_IRQS.
    However some parts of the quirk got lost in the ACPI merge. This is a=
 resent of
    the patch proposed in 2009.
    See http://lkml.org/lkml/2009/9/7/192
   =20
    Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
    Tested-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e545b55a1e980cbb6a158886286106bbf39722b1
Author: Jon Mason <jdmason@kudzu.us>
Date:   Sun Jun 19 18:51:37 2011 -0500

    ACPI: fix 80 char overflow
   =20
    Trivial fix for 80 char line overflow in drivers/acpi/pci_root.c
   =20
    Signed-off-by: Jon Mason <jdmason@kudzu.us>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9c921c22a7f33397a6774d7fa076db9b6a0fd669
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Thu Jun 30 11:34:12 2011 +0800

    ACPI / Battery: Resolve the race condition in the sysfs_remove_batter=
y()
   =20
    Use battery->lock in sysfs_remove_battery() to make
    checking, removing, and clearing bat.dev atomic.
    This is necessary because sysfs_remove_battery() may
    be invoked concurrently from different paths.
   =20
        https://bugzilla.kernel.org/show_bug.cgi?id=3D35642
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6e17fb6aa1a67afa1827ae317c3594040f055730
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Thu Jun 30 11:33:58 2011 +0800

    ACPI / Battery: Add the check before refresh sysfs in the battery_not=
ify()
   =20
    In the commit 25be5821, add the refresh sysfs when system resumes
    from suspending. But it didn't check that the battery exists. This
    will cause battery sysfs files added when the battery doesn't exist.
    This patch add the check before refreshing.
   =20
    	https://bugzilla.kernel.org/show_bug.cgi?id=3D35642
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d5a5911b3278bad6515a9958f7318f74d534ef64
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Thu Jun 30 11:33:40 2011 +0800

    ACPI / Battery: Add the hibernation process in the battery_notify()
   =20
    The Commit 25be58215 has added a PM notifier to refresh the sys in or=
der
    to deal with the unit change of the Battery Present Rate. But it just
    consided the suspend situation. The problem also will happen during t=
he
    hibernation according the bug 28192.
   =20
        https://bugzilla.kernel.org/show_bug.cgi?id=3D28192
   =20
    This patch adds the hibernation process and fix the bug.
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7b78622d0f9df9f274a319eea1494240119d3734
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Thu Jun 30 11:33:27 2011 +0800

    ACPI / Battery: Rename acpi_battery_quirks2 with acpi_battery_quirks
   =20
    This patch is cosmetic only, and makes no functional change.
    Since the acpi_battery_quirks has been deleted, rename
    acpi_battery_quirks2 with acpi_battery_quirks to clean the code.
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 55003b2105a4578736f3e868fbaa889bb1ff3ce0
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Thu Jun 30 11:33:12 2011 +0800

    ACPI / Battery: Change 16-bit signed negative battery current into co=
rrect value
   =20
    This patch is for some machines which report the battery current
    as a 16-bit signed negative when it is charging. This is caused
    by DSDT bug. The commit bc76f90b8a5cf4aceedf210d08d5e8292f820cec
    has resolved the problem for Acer laptops. But some other machines
    also have such problem.
   =20
        https://bugzilla.kernel.org/show_bug.cgi?id=3D33722
   =20
    Since it is improper that the current is above 32A on laptops
    whether on AC or on battery, this patch is to check the current and
     take its absolute value as current and producing a message when it
    is negative in s16.
   =20
    Remove Acer quirk, as this workaround handles Acer too.
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ae6f61870490c10a0b0436e5afffa00c9dacffef
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Thu Jun 30 11:32:40 2011 +0800

    ACPI / Battery: Add the power unit macro
   =20
    This patch is cosmetic only, and makes no functional change.
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e4108292cc5b5ca07abc83af31a78338362810ca
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Fri Jul 1 16:03:39 2011 +0800

    ACPI / SBS: Correct the value of power_now and power_avg in the sysfs
   =20
    https://bugzilla.kernel.org/show_bug.cgi?id=3D24492
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1dd5c715e5b7524da8c1030f5cf1ea903e45c457
Author: Lan Tianyu <tianyu.lan@intel.com>
Date:   Fri Jul 1 16:03:15 2011 +0800

    ACPI / SBS: Add getting state operation in the acpi_sbs_battery_get_p=
roperty()
   =20
    https://bugzilla.kernel.org/show_bug.cgi?id=3D24492
   =20
    Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3eb208f0a36cf7a86953afa7a4eb6776294e6768
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Jul 4 08:38:51 2011 +0000

    ACPICA: Update to version 20110623
   =20
    Version 20110623.
   =20
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8f9c91273e36e5762c617c23e4fd48d5172e0dac
Author: Fenghua Yu <fenghua.yu@intel.com>
Date:   Mon Jul 4 08:36:16 2011 +0000

    ACPICA: Do not repair _TSS return package if _PSS is present
   =20
    We can only sort the _TSS return package if there is no _PSS
    in the same scope. This is because if _PSS is present, the ACPI
    specification dictates that the _TSS Power Dissipation field is
    to be ignored, and therefore some BIOSs leave garbage values in
    the _TSS Power field(s).  In this case, it is best to just return
    the _TSS package as-is.
   =20
    Reported-by: Fenghua Yu <fenghua.yu@intel.com>
    Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d57b23ad0ca7a46931e4d98eb6b4b73b112f0969
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Jul 4 08:24:03 2011 +0000

    ACPICA: Add option to disable method return value validation and repa=
ir
   =20
    Runtime option can be used to disable return value repair if this
    is causing a problem on a particular machine.
   =20
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 80f40ce0f10e87d9a27f1e29325c6f39245fbcb1
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Jun 14 10:45:57 2011 +0800

    ACPICA: Update to version 20110527
   =20
    Version 20110527.
   =20
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f631f9cafbc47bbfe5eb2aa831cd323175298448
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Jun 14 10:44:51 2011 +0800

    ACPICA: Add missing _TDL to list of predefined names
   =20
    Affects both iASL and core ACPICA.
   =20
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c8cefe307d79c57b32ca1d4c9ebff528f8dd914c
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Jun 14 10:42:53 2011 +0800

    ACPICA: Load operator: re-instate most restrictions on incoming table=
 signature
   =20
    Now, only allow "SSDT" "OEM", and a null signature.
   =20
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
--8323328-490606887-1312320916=:25237
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-490606887-1312320916=:25237--
