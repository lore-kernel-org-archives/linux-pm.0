From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull] ACPI & driver patches for 2.6.30-rc0
Date: Sun, 05 Apr 2009 03:05:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904050303460.24737@localhost.localdomain>
References: <alpine.LFD.2.00.0904050255340.24737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_LP5OyJzs5PNKyhN72CvFOg)"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <alpine.LFD.2.00.0904050255340.24737@localhost.localdomain>
Content-id: <alpine.LFD.2.00.0904050305350.24737@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_LP5OyJzs5PNKyhN72CvFOg)
Content-id: <alpine.LFD.2.00.0904050305351.24737@localhost.localdomain>
Content-type: TEXT/PLAIN; CHARSET=UTF-8
Content-transfer-encoding: 8BIT

> The full log is just about 100K, so I'll reply to this message with that
> in case it gets filtered from the list.


commit 7ec0a7290797f57b780f792d12f4bcc19c83aa4f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Mar 30 17:48:24 2009 +0000

    ACPI: processor: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Zhang Rui <rui.zhang@intel.com>
    CC: Zhao Yakui <yakui.zhao@intel.com>
    CC: Venki Pallipadi <venkatesh.pallipadi@intel.com>
    CC: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 373cfc360ec773be2f7615e59a19f3313255db7c
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Mar 30 17:48:18 2009 +0000

    ACPI: button: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Note that events from fixed hardware buttons now show up as a special
    notify event, so to preserve user-space backward compatibility, we
    convert that back to ACPI_BUTTON_NOTIFY_STATUS.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Reviewed-by: Alex Chiang <achiang@hp.com>
    CC: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 46ec8598fde74ba59703575c22a6fb0b6b151bb6
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Mar 30 17:48:13 2009 +0000

    ACPI: support acpi_device_ops .notify methods
    
    This patch adds support for ACPI device driver .notify() methods.  If
    such a method is present, Linux/ACPI installs a handler for device
    notifications (but not for system notifications such as Bus Check,
    Device Check, etc).  When a device notification occurs, Linux/ACPI
    passes it on to the driver's .notify() method.
    
    In most cases, this removes the need for drivers to install their own
    handlers for device-specific notifications.
    
    For fixed hardware devices like some power and sleep buttons, there's
    no notification value because there's no control method to execute a
    Notify opcode.  When a fixed hardware device generates an event, we
    handle it the same as a regular device notification, except we send
    a ACPI_FIXED_HARDWARE_EVENT value.  This is outside the normal 0x0-0xff
    range used by Notify opcodes.
    
    Several drivers install their own handlers for system Bus Check and
    Device Check notifications so they can support hot-plug.  This patch
    doesn't affect that usage.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Reviewed-by: Alex Chiang <achiang@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 478c6a43fcbc6c11609f8cee7c7b57223907754f
Merge: 8a3f257 6bb5975
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 02:14:15 2009 -0400

    Merge branch 'linus' into release
    
    Conflicts:
    	arch/x86/kernel/cpu/cpufreq/longhaul.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8a3f257c704e02aee9869decd069a806b45be3f1
Merge: 33526a5 1506553
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:52:07 2009 -0400

    Merge branch 'misc' into release

commit 33526a53600ac887d100e3c9b4be3637ac8ae3a5
Merge: 47ae106 786c221
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:51:51 2009 -0400

    Merge branch 'x2apic' into release

commit 47ae106d3f37e1fd715975eaf8130e20e171cf52
Merge: 2e33b23 6328a57
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:51:38 2009 -0400

    Merge branch 'pnpacpi' into release

commit 2e33b234abbb9a77806115d30c3084992a98973c
Merge: e2fae0a 0b3f610
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:51:22 2009 -0400

    Merge branch 'dell-wmi' into release

commit e2fae0abf6a9c7a2da1a481b7adb4e24f7778992
Merge: fff251f c07c9a7
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:51:16 2009 -0400

    Merge branch 'constify' into release

commit fff251f6b26bb8f4de15fa5906cf2611623b3661
Merge: 3b4dadf a5032bf 34ff4db
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:51:10 2009 -0400

    Merge branches 'bugzilla-12461' and 'bugzilla-9998' into release

commit 3b4dadf05d177289c279c50030c7c75e004952bb
Merge: 59b17bf 7e90560
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:50:46 2009 -0400

    Merge branch 'acpi_enforce_resources' into release

commit 59b17bf6ea06abed519dfc788fff1b6b9499d23f
Merge: edd8469 0f66af5
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:48:46 2009 -0400

    Merge branch 'async-battery' into release
    
    Conflicts:
    	drivers/acpi/Makefile
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit edd84690d15e4cb144cc60b754d4eaf8fac0a711
Merge: 7c27fd1 ae7d515
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:45:50 2009 -0400

    Merge branch 'acpi-modparam' into release
    
    Conflicts:
    	drivers/acpi/Makefile
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7c27fd19b6d985957424348361afa066ff4c74d8
Merge: 336d63b 16dd55f
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:42:14 2009 -0400

    Merge branch 'sony-laptop' into release

commit 336d63b8a3cadc1c678f4b16d6105633c7f6af75
Merge: 07290be 0e50183
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:42:09 2009 -0400

    Merge branch 'thinkpad-acpi' into release

commit 07290bed7968c0e08fb3efe193fb148f1fea5e08
Merge: 1264881 4f0175d
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:42:03 2009 -0400

    Merge branch 'acer' into release

commit 12648810506eaa063dc23b66514fbb4796f34312
Merge: 7329e93 03ae61d
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:40:06 2009 -0400

    Merge branch 'video' into release
    
    Conflicts:
    	drivers/acpi/video.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7329e9356e5b46e11a1781dff2dc64c2e3284884
Merge: 3266d63 e1eb477
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:39:33 2009 -0400

    Merge branch 'psd' into release

commit 3266d63c0684138f4900d4e5c6fbfab59e054afc
Merge: 4926a23 7faa144
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:39:26 2009 -0400

    Merge branch 'battery' into release

commit 4926a236396ffc82be004cc89223a7f2747a44dc
Merge: 4f3bff7 4c395bd
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:39:20 2009 -0400

    Merge branch 'hp-wmi' into release

commit 4f3bff70a64b105921dac8630bc4381567b21ebd
Merge: 2ddb9f1 03a971a
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:39:12 2009 -0400

    Merge branch 'thermal' into release

commit 2ddb9f17ba026122b53b34fb4182ece91e24cf92
Merge: a3b2c5e ff69f2b
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:39:07 2009 -0400

    Merge branch 'pmtimer-overflow' into release

commit a3b2c5e413ce500d19cb776662ae0ea405cdd994
Merge: 4938370 4658e4e
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:39:00 2009 -0400

    Merge branch 'dynamic-ssdt' into release

commit 493837009665a5ea1d91ed5fe4bab0ed546cae86
Merge: e857b33 8308e8a
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:38:51 2009 -0400

    Merge branch 'driver-ops-cleanup' into release

commit e857b33d1879fc4284e3151222eee2415c1de88a
Merge: 9a38f4e 1c48aa3
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:38:42 2009 -0400

    Merge branch 'bjorn-cleanups' into release

commit 9a38f4eec57cc5104b6a85bc6d0a91b268fbe803
Merge: 67dc092 018f452
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 5 01:38:31 2009 -0400

    Merge branch 'bjorn-initcall-cleanup' into release

commit 15065531c1c5902775ae3ade24eb37d0e688353b
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Mon Mar 30 12:02:35 2009 +0200

    toshiba-acpi: remove MAINTAINERS entry
    
    "I'm not much opposed to marking this driver orphaned.  I haven't used
    a Toshiba laptop in four years or so, and disagree with the recent
    additions of bluetooth and wireless control to the driver.
    
    --John"
    
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: John Belmonte <john@neggie.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0f66af530116e9f4dd97f328d91718b56a6fc5a4
Author: Arjan van de Ven <arjan@linux.intel.com>
Date:   Sat Jan 10 14:19:05 2009 -0500

    ACPI: battery: asynchronous init
    
    The battery driver tends to take quite some time to initialize
    (100ms-300ms is quite typical).
    This patch initializes the batter driver asynchronously, so that other
    things in the kernel can initialize in parallel to this 300 msec.
    
    As part of this, the battery driver had to move to the back
    of the ACPI init order (hence the Makefile change).
    Without this move, the next ACPI driver would just block
    on the ACPI/devicee layer semaphores until the battery driver was
    done anyway, not gaining any boot time.
    
    Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4f0175dc13a57cb5d2abef44eb4394b0b964bdad
Author: Carlos Corbacho <carlos@strangeworlds.co.uk>
Date:   Sat Apr 4 09:33:39 2009 +0100

    acer-wmi: Update copyright notice & documentation
    
    Explicitly note in the documentation that the Acer Aspire One is not
    supported.
    
    Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 350e32907cf72ef82bbe7d72525fa2d9dcf64682
Author: Andy Whitcroft <apw@canonical.com>
Date:   Sat Apr 4 09:33:34 2009 +0100

    acer-wmi: Cleanup the failure cleanup handling
    
    Cleanup the failure cleanup handling for brightness and email led.
    
    [cc: Split out from another patch]
    
    Signed-off-by: Andy Whitcroft <apw@canonical.com>
    Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a74dd5fdabcd34c93e17e9c7024eeb503c92b048
Author: Carlos Corbacho <carlos@strangeworlds.co.uk>
Date:   Sat Apr 4 09:33:29 2009 +0100

    acer-wmi: Blacklist Acer Aspire One
    
    The Aspire One's ACPI-WMI interface is a placeholder that does nothing,
    and the invalid results that we get from it are now causing userspace
    problems as acer-wmi always returns that the rfkill is enabled (i.e. the
    radio is off, when it isn't). As it's hardware controlled, acer-wmi
    isn't needed on the Aspire One either.
    
    Thanks to Andy Whitcroft at Canonical for tracking down Ubuntu's userspace
    issues to this.
    
    Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
    Reported-by: Andy Whitcroft <apw@canonical.com>
    Cc: stable@kernel.org
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c07c9a78a95cab0a9bf0b253d0c52e7798af38c5
Author: Len Brown <len.brown@intel.com>
Date:   Sat Apr 4 03:33:45 2009 -0400

    video: build fix
    
    acpi_video_device_write_state() and friends now return ssize_t,
    while the constify patch assumed it was still int.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0e501834f8c2ba7de2a56e332d346dcf4ac0b593
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:53 2009 +0000

    thinkpad-acpi: rework brightness support
    
    Refactor and redesign the brightness control backend...
    
    In order to fix bugzilla #11750...
    
    Add a new brightness control mode: support direct NVRAM checkpointing
    of the backlight level (i.e. store directly to NVRAM without the need
    for UCMS calls), and use that together with the EC-based control.
    Disallow UCMS+EC, thus avoiding races with the SMM firmware.
    
    Switch the models that define HBRV (EC Brightness Value) in the DSDT
    to the new mode.  These are: T40-T43, R50-R52, R50e, R51e, X31-X41.
    
    Change the default for all other IBM ThinkPads to UCMS-only.  The
    Lenovo models already default to UCMS-only.
    
    Reported-by: Alexey Fisher <bug-track@fisher-privat.net>
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 74a60c0f828016456fc635feae388ffd12bb3bb9
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:52 2009 +0000

    thinkpad-acpi: enhanced debugging messages for the fan subdriver
    
    Enhance debugging messages for the fan subdriver.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 56e2c200945dafafb86169762eb1e88aed0ce69e
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:51 2009 +0000

    thinkpad-acpi: enhanced debugging messages for the hotkey subdriver
    
    Enhance debugging messages for the hotkey subdriver.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bee4cd9b9eaa8c72832e1ee7f4940604e94beb27
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:50 2009 +0000

    thinkpad-acpi: enhanced debugging messages for rfkill subdrivers
    
    Enhance debugging messages for all rfkill subdrivers in thinkpad-acpi.
    
    Also, log a warning if the deprecated sysfs attributes are in use.
    These attributes are going to be removed sometime in 2010.
    
    There is an user-visible side-effect: we now coalesce attempts to
    enable/disable bluetooth or WWAN in the procfs interface, instead of
    hammering the firmware with multiple requests.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a4d5effcc73749ee3ebbf578d162905e6fa4e07d
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:49 2009 +0000

    thinkpad-acpi: restrict access to some firmware LEDs
    
    Some of the ThinkPad LEDs indicate critical conditions that can cause
    data loss or cause hardware damage when ignored (e.g. force-ejecting
    a powered up bay; ignoring a failing battery, or empty battery; force-
    undocking with the dock buses still active, etc).
    
    On almost all ThinkPads, LED access is write-only, and the firmware
    usually does fire-and-forget signaling on them, so you effectively
    lose whatever message the firmware was trying to convey to the user
    when you override the LED state, without any chance to restore it.
    
    Restrict access to all LEDs that can convey important alarms, or that
    could mislead the user into incorrectly operating the hardware.  This
    will make the Lenovo engineers less unhappy about the whole issue.
    
    Allow users that really want it to still control all LEDs, it is the
    unaware user that we have to worry about.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2586d5663d0a17d69383acf6110f16a979a07c4e
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:48 2009 +0000

    thinkpad-acpi: remove HKEY disable functionality
    
    The HKEY disable functionality basically cripples the entire event
    model of the ThinkPad firmware and of the thinkpad-acpi driver.
    Remove this functionality from the driver.  HKEY must be enabled at
    all times while thinkpad-acpi is loaded, and disabled otherwise.
    
    For sysfs, according to the sysfs ABI and the thinkpad-acpi sysfs
    rules of engagement, we will just remove the attributes.  This will be
    done in two stages: disable their function now, after two kernel
    releases, remove the attributes.
    
    For procfs, we call WARN().  If nothing triggers it, I will simply
    remove the enable/disable commands entirely in the future along with
    the sysfs attributes.
    
    I don't expect much, if any fallout from this.  There really isn't any
    reason to mess with hotkey_enable or with the enable/disable commands
    to /proc/acpi/ibm/hotkey, and this has been true for years...
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 73a94d86a8625371f76de0ee12dc5bacd3ed42c0
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:47 2009 +0000

    thinkpad-acpi: add new debug helpers and warn of deprecated atts
    
    Add a debug helper that discloses the TGID of the userspace task
    attempting to access the driver.  This is highly useful when dealing
    with bug reports, since often the user has no idea that some userspace
    application is accessing thinkpad-acpi...
    
    Also add a helper to log warnings about sysfs attributes that are
    deprecated.
    
    Use the new helpers to issue deprecation warnings for bluetooth_enable
    and wwan_enabled, that have been deprecated for a while, now.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7ff8d62f7f055aaffbeb493863136c1b876bbe2e
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:46 2009 +0000

    thinkpad-acpi: add missing log levels
    
    Add missing log levels in a standalone commit, to avoid dependencies in
    future unrelated changes, just because they wanted to use one of the
    missing log levels.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3dcc2c3b00cad01a0e3667607f8644e891e4dc8b
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:45 2009 +0000

    thinkpad-acpi: cleanup debug helpers
    
    Fix the vdbg_printk macro definition to be sane when
    CONFIG_THINKPAD_ACPI_DEBUG is undefined, and move the mess into a file
    section of its own.
    
    This doesn't change anything in the current code, but future code will
    need the proper behaviour.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 078ac19ed8f476a7c2d729712e15f5ab516ff491
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:44 2009 +0000

    thinkpad-acpi: documentation cleanup
    
    Some cleanups to the documentation of the driver.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 257bc1cb3e29c8da62b9c9e0a4505011776c7040
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:43 2009 +0000

    thinkpad-acpi: drop ibm-acpi alias
    
    The driver was renamed two years ago, on 2.6.21.  Drop the old
    compatibility alias, we have given everybody quite enough time
    to update their configs to the new name.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1c762ca438447fa3525d84f4a0784a2021a66200
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Apr 4 04:25:42 2009 +0000

    thinkpad-acpi: update copyright notices
    
    It is that time of the year again...
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ba256b41bd58f0821c9c0e203982fb260f09bdeb
Author: Harald Welte <laforge@gnumonks.org>
Date:   Wed Jan 14 14:01:17 2009 +0800

    panasonic-laptop: use snprintf with PAGE_SIZE in sysfs attributes
    
    Instead of just sprintf() into the page-sized buffer provided
    by the sysfs/device_attribute API, we use snprintf with PAGE_SIZE
    as an additional safeguard.
    
    Signed-off-by: Martin Lucina <mato@kotelna.sk>
    Signed-off-by: Harald Welte <laforge@gnumonks.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c542aadeb4700bc316834d862d52ba3d2664f13a
Author: Harald Welte <laforge@gnumonks.org>
Date:   Wed Jan 14 13:59:50 2009 +0800

    panasonic-laptop: Fix autoloading
    
    This patch adds MODULE_DEVICE_TABLE() to panasonic-laptop.c in order
    to ensure automatic loading of the module on systems with the respective
    "MAT*" ACPI devices.
    
    Signed-off-by: Martin Lucina <mato@kotelna.sk>
    Signed-off-by: Harald Welte <laforge@gnumonks.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b7171ae74b1741245835444bd98a7217958cf929
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Jan 12 00:08:19 2009 +0100

    ACPI: constify VFTs (2/2)
    
    Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 070d8eb1f6b789206486ea6a4a1bb7745d86d314
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Jan 12 00:07:55 2009 +0100

    ACPI: constify VFTs (1/2)
    
    Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0b3f6109f0c9ff926b5ffc80dc1cebb24f192b35
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Fri Jan 9 20:17:11 2009 +0000

    dell-wmi: new driver for hotkey control
    
    Add a WMI driver for Dell laptops. Currently it does nothing but send a
    generic input event when a button with a picture of a battery on it is
    pressed, but maybe other uses will appear over time.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Cc: Dmitry Torokhov <dtor@mail.ru>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 609d4bc949a9175a6c8ba9dc1b6fdb4d9dab0427
Author: Jan Beulich <jbeulich@novell.com>
Date:   Thu Mar 12 11:58:25 2009 +0000

    ACPI: constify tables in pci_irq.c
    
    Signed-off-by: Jan Beulich <jbeulich@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6328a57401dc5f5cf9931738eb7268fcd8058c49
Author: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Date:   Mon Mar 30 19:31:06 2009 +0200

    Enable PNPACPI _PSx Support, v3
    
    (This is an update to the patch presented earlier in
    http://lkml.org/lkml/2008/12/8/284, with new error handling.)
    
    This patch sets the power of PnP ACPI devices to D0 when they
    are activated and to D3 when they are disabled.  The latter is
    in correspondence with the ACPI 3.0 specification, whereas the
    former is added in order to be able to power up a device after
    it has been previously disabled (or when booting up a system).
    (As a consequence, the patch makes the PnP ACPI code more ACPI
    compliant.)
    
    Section 6.2.2 of the ACPI Specification (at least versions 1.0b
    and 3.0a) states: "Prior to running this control method [_DIS],
    the OS[PM] will have already put the device in the D3 state."
    Unfortunately, there is no clear statement as to when to put
    a device in the D0 state. :-( Therefore, the patch executes the
    method calls as _PS3/_DIS and _SRS/_PS0. What is clear: "If the
    device is disabled, _SRS enables the device at the specified
    resources." (From the ACPI 3.0a Specification.)
    
    The patch fixes a problem with some IBM ThinkPads (at least the
    600E and the 600X) where the serial ports have a dedicated
    power source that needs to be brought up before the serial port
    can be used.  Without this patch, the serial port is enabled
    but has no power. (In the past, the tpctl utility had to be
    utilized to turn on the power, but support for this feature
    stopped with version 5.9 as it did not support the more recent
    kernel versions.)
    
    The error handlers that handle any errors that can occur during
    the power up/power down phases return the error codes to the
    caller directly.  Comments welcome! :-)
    
    No regressions were observed on hardware that does not require
    this patch.
    
    The patch is applied against 2.6.27.x.
    
    Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>
    Acked-by: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 786c221a37d3931189d9c9421f63dec92f4d698b
Author: Suresh Siddha <suresh.b.siddha@intel.com>
Date:   Mon Mar 30 14:05:50 2009 -0800

    ACPI: update x2apic comments
    
    Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7237d3de78ff89ec2e18eae5fe962d063024fef5
Author: Suresh Siddha <suresh.b.siddha@intel.com>
Date:   Mon Mar 30 13:55:30 2009 -0800

    x86, ACPI: add support for x2apic ACPI extensions
    
    All logical processors with APIC ID values of 255 and greater will have their
    APIC reported through Processor X2APIC structure (type-9 entry type) and all
    logical processors with APIC ID less than 255 will have their APIC reported
    through legacy Processor Local APIC (type-0 entry type) only. This is the
    same case even for NMI structure reporting.
    
    The Processor X2APIC Affinity structure provides the association between the
    X2APIC ID of a logical processor and the proximity domain to which the logical
    processor belongs.
    
    For OSPM, Procssor IDs outside the 0-254 range are to be declared as Device()
    objects in the ACPI namespace.
    
    Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 16dd55f309cf69a648ca3b1fc04b3b6f079c8be0
Author: Matthias Welwarsky <matze@welwarsky.de>
Date:   Wed Apr 1 22:10:47 2009 +0900

    sony-laptop: fix event reporting for new style events
    
    In short Fn key events are always reported through acpi.
    The input layer gets all the old style events and only those new style
    events that, after being decoded, are mapped to an locally represented
    events.
    rfkill only update the rfkill device status.
    
    Signed-off-by: Matthias Welwarsky <matze@welwarsky.de>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 14bd31365fbeeccee72b0aead3baa4e5da208281
Author: Alexander Beregalov <a.beregalov@gmail.com>
Date:   Wed Apr 1 22:10:46 2009 +0900

    sony-laptop should depend on RFKILL
    
    Fixes this build error when RFKILL is not set:
    
    drivers/platform/x86/sony-laptop.c:1050: undefined reference to `rfkill_unregister'
    and so on..
    
    Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
    Acked-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6479efb68dce48fa52aed6ff876d8d102f200527
Author: Matthias Welwarsky <matze@welwarsky.de>
Date:   Wed Apr 1 22:10:45 2009 +0900

    sony-laptop: new style events typo fixes
    
    Signed-off-by: Matthias Welwarsky <matze@welwarsky.de>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ff07a53a33cff2733c2c20fc75e84e75c2572889
Author: Alessio Igor Bogani <abogani@texware.it>
Date:   Wed Apr 1 22:10:44 2009 +0900

    sony-laptop: Fix some typos in log messages (Unabe/Unable)
    
    Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f240729832dff3785104d950dad2d3ced4387f6d
Author: Dan Carpenter <error27@gmail.com>
Date:   Thu Apr 2 08:29:56 2009 +0300

    dock: fix dereference after kfree()
    
    dock_remove() calls kfree() on dock_station so we should use
    list_for_each_entry_safe() to avoid dereferencing freed memory.
    
    Found by smatch (http://repo.or.cz/w/smatch.git/).  Compile tested.
    
    Signed-off-by: Dan Carpenter <error27@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 67dc092187626ac55a60877485f78bc291cbfa81
Author: Thomas Renninger <trenn@suse.de>
Date:   Thu Apr 2 14:11:20 2009 +0200

    ACPI: Remove R40e c-state blacklist
    
    The recent ACPICA patch
    (ACPICA: FADT: Favor 32-bit register addresses for compatibility)
    makes machine to use the right FADT HW addresses
    and C-states now work fine.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=8246
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Tested-by: Mark Doughty <me@markdoughty.co.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5b4c0b6fffb91b07a6f85dabbdfbd5abab61d9db
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Apr 1 01:49:42 2009 -0400

    ACPI: update comment
    
    update ACPI Development Discussion List
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 53af9cfb37af5e03ee2b24c5d5c4963c34e5b765
Author: Len Brown <lenb@kernel.org>
Date:   Sun Mar 15 23:36:38 2009 -0400

    ACPI: get_throttling_state() cannot be larger than state_count
    
    Reported-by: Roel Kluin <roel.kluin@gmail.com>
    Acked-by: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2a9ef8e1a856be8e526bb9b10fb98c5012f6e3f8
Author: Zhao Yakui <yakui.zhao@intel.com>
Date:   Wed Mar 18 16:36:25 2009 +0800

    ACPI: suspend: Add the Pansonic CF51 box to the dmi check table
    
    The Pansonic CF51-2L requires "acpi_sleep=old_ordering",
    so invoke it automatically via DMI.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=12561
    
    Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07de5bdb7bad607e29dc17c345717403a76a334c
Author: Krzysztof Kosiński <tweenk.pl@gmail.com>
Date:   Thu Mar 19 23:22:31 2009 +0100

    tc1100-wmi: Fix state reporting
    
    The tc1100-wmi driver should print the current states of wireless LAN and
    jogdial brightness control when "cat /sys/devices/platform/tc1100-wmi/wireless"
    and "cat /sys/devices/platform/tc1100-wmi/jogdial" are executed, respectively.
    What actually happens is that both of those commands print 0 regardless of the
    hardware state. The cause is that wmi_query_block returns an ACPI_TYPE_INTEGER
    rather than ACPI_TYPE_BUFFER as the driver assumes. Additionally, the driver
    intends to return a jogdial state that is inverted with respect to the commands
    required to set it (e.g. it intends to return 1 after the jogdial file was
    written with 0).
    
    This patch fixes both of those issues - the commands to query the
    state now work, and should return the same state that was written.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=12286
    
    Signed-off-by: Krzysztof Kosiński <tweenk.pl@gmail.com>
    Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ae7d51517bc3b0fe10c6af38234ef0f92bbae6a4
Author: Len Brown <len.brown@intel.com>
Date:   Thu Apr 2 22:49:43 2009 -0400

    ACPI: simplify processor lines in Makefile
    
    Suggested-by: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7e90560c50f754d65884e251e94c1efa2a4b5784
Author: Luca Tettamanti <kronos.it@gmail.com>
Date:   Mon Mar 30 00:01:27 2009 +0200

    ACPI: acpi_enforce_resource=strict by default
    
    Enforce strict resource checking - disallowing access by native
    drivers to IO ports and memory regions claimed by ACPI firmware.
    
    The patch is mainly aimed to block native hwmon drivers from touching
    monitoring chips that ACPI thinks it own.
    
    If this causes a regression, boot with "acpi_enforce_resources=lax"
    which was the previous default.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=12376
    http://bugzilla.kernel.org/show_bug.cgi?id=12541
    
    Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Acked-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5b5d9117407e790ade594687010343c5d559a1f4
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Thu Mar 12 09:07:19 2009 +1030

    ACPI: simplify module_param namespace
    
    Impact: cleanup
    
    Rather than overriding MODULE_PARAM_PREFIX, build via acpi.o so
    KBUILD_MODNAME is set to "acpi".
    
    This is the logical way to do it, even though acpi cannot be a module
    due to these config options being bool.  Those parts of ACPI which can
    be modular are not built into the acpi "module".
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a5032bfdd9c80e0231a6324661e123818eb46ecd
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Wed Apr 1 01:33:15 2009 -0400

    ACPI: EC: Always parse EC device
    
    If ECDT info is not valid, we have last chance to configure
    EC driver properly at this point, don't miss it.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=12461
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 34ff4dbccccce54c83b1234d39b7ad9e548a75dd
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Wed Apr 1 00:25:10 2009 -0400

    ACPI: EC: Separate delays for MSI hardware
    
    MSI notebooks require very strict delays, while all others
    are happy with msleep().
    
    References: http://bugzilla.kernel.org/show_bug.cgi?id=9998
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 03ae61dd5701092aabb60a8cae9929dbf8dc25c6
Author: Len Brown <len.brown@intel.com>
Date:   Sat Mar 28 01:41:14 2009 -0400

    ACPI: fix CONFIG_ACPI=n build
    
    drivers/gpu/drm/i915/i915_drv.c:102: error: too many arguments to
    function ‘intel_opregion_init’
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 98758faffc86ee6fe9504eeab75481ee7c1aa860
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Thu Mar 12 16:57:11 2009 +0800

    ACPI video: add a warning message if _BQC is not found
    
    ACPI backlight control w/o _BQC support is kinda firmware bug.
    Add a warning if _BQC is not implemented.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7faa144a518c456e2057918f030f50100144ccc6
Author: Alexey Starikovskiy <astarikovskiy@suse.de>
Date:   Fri Mar 27 22:23:52 2009 -0400

    ACPI: battery: add power_{now,avg} properties to power_class
    
    ACPI has smart batteries, which work in units of energy and measure
    rate of (dis)charge as power, thus it is not appropriate to export it
    as a current_now. Current_now will still be exported to allow
    for userland applications to match.
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 74a365b3f354fafc537efa5867deb7a9fadbfe27
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Mar 19 21:35:39 2009 +0000

    ACPI: Populate DIDL before registering ACPI video device on Intel
    
    Intel graphics hardware that implements the ACPI IGD OpRegion spec
    requires that the list of display devices be populated before any ACPI
    video methods are called. Detect when this is the case and defer
    registration until the opregion code calls it. Fixes crashes on HP
    laptops.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=11259
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Acked-by: Eric Anholt <eric@anholt.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c60d638e29c780b75b648283a197d0226e3576c3
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Mar 18 16:27:18 2009 +0800

    ACPI video: support buggy BIOSes with _BCQ implemented
    
    Some buggy BIOSes implements _BCQ instead of _BQC.
    Male ACPI video driver support these buggy BIOS.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1a7c618a3f7bef1a20ae740df512eeba21397fa5
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Mar 18 16:27:16 2009 +0800

    ACPI video: support _BQC/_BCL/_BCM methods that use index values
    
    The input/output of _BQC/_BCL/_BCM control methods should be represented
    by a number between 0 and 100, and can be thought of as a percentage.
    But some buggy _BQC/_BCL/_BCM methods use the index values instead.
    http://bugzilla.kernel.org/show_bug.cgi?id=12302
    http://bugzilla.kernel.org/show_bug.cgi?id=12249
    http://bugzilla.kernel.org/show_bug.cgi?id=12037
    
    Add the functionality to support such kind of BIOSes in ACPI video driver.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d80fb99fdcd56f4934f11cc44ca016463842dc8b
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Mar 18 16:27:14 2009 +0800

    ACPI video: support reversed _BCL method in  ACPI video driver
    
    The brightness levels returned by _BCL package are in a reversed order
    on some laptops.
    http://bugzilla.kernel.org/show_bug.cgi?id=12037
    http://bugzilla.kernel.org/show_bug.cgi?id=12302
    http://bugzilla.kernel.org/show_bug.cgi?id=12235
    
    sort the _BCL packge in case it's reversed.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d32f69470c2081ffdfd82740ac19f940790f9e93
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Mar 18 16:27:12 2009 +0800

    ACPI video: support _BCL packages that don't export brightness levels when machine is on AC/Battery
    
    Many buggy BIOSes don't export the brightness levels when machine
    is on AC/Battery in the _BCL method.
    
    Reformat the _BCL package for these laptops:
    now the elements in device->brightness->levels[] are like:
    levels[0]: brightness level when on AC power.
    levels[1]: brightness level when on Battery power.
    levels[2]: supported brightness level 1.
    levels[3]: supported brightness level 2.
    ...
    levels[n]: supported brightness level n-1.
    levels[n + 1]: supported brightness level n.
    So if there are n supported brightness levels on this laptop,
    we will have n+2 entries in device->brightnes->levels[].
    
    level[0] and level[1] are invalid on the laptops that don't
    export the brightness levels on AC/Battery.
    Fortunately, we never use these two values at all, even for the
    valid ones.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=12249
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 24450c7add575cef53097738f16a4c1a720fa5cb
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Mar 18 16:27:10 2009 +0800

    ACPI video: check the return value of acpi_video_device_lcd_set_level
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c8890f903a6fdf5711726e8e8d65cb13423f8833
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Mar 18 16:27:08 2009 +0800

    ACPI video: check the return value of acpi_video_device_lcd_get_level_current
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a59d1637eb0e0a37ee0e5c92800c60abe3624e24
Author: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
Date:   Thu Mar 19 14:41:40 2009 -0700

    ACPI: cap off P-state transition latency from buggy BIOSes
    
    Some BIOSes report very high frequency transition latency which are plainly
    wrong on CPus that can change frequency using native MSR interface.
    
    One such system is IBM T42 (2327-8ZU) as reported by Owen Taylor and
    Rik van Riel.
    
    cpufreq_ondemand driver uses this transition latency to come up with a
    reasonable sampling interval to sample CPU usage and with such high
    latency value, ondemand sampling interval ends up being very high
    (0.5 sec, in this particular case), resulting in performance impact due to
    slow response to increasing frequency.
    
    Fix it by capping-off the transition latency to 20uS for native MSR based
    frequency transitions.
    
    mjg: We've confirmed that this also helps on the X31
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Acked-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e1eb47797ac0773cb3efe7495e14fc26e18a23c2
Author: Stanislaw Gruszka <sgruszka@redhat.com>
Date:   Tue Mar 24 13:41:59 2009 +0100

    ACPI: Avoid wiping out pr->performance during preregistering
    
    When cpufreq driver call acpi_processor_preregister_performance() , function
    will clean up pr->performance even if there is possibly already registered
    other cpufreq driver. The patch fix this potential problem. It also remove
    double checks in P domain basic validity code and move these checks to function
    where _PSD data is captured.
    
    Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8308e8ab70fd5d7b78afb133c51c5079548ba84f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 10:55:33 2009 -0600

    ACPI: remove unused acpi_bus_ops flags
    
    In acpi_bus_ops, only the acpi_op_add and acpi_op_start flags are used,
    so remove all the rest.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c0ce093f5b8bc3262c51bd0b5900424a67909831
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 10:55:27 2009 -0600

    ACPI: remove unused acpi_device_ops .shutdown method
    
    No drivers use the .shutdown method, so remove it.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 93b3e78a93a2f49415608929f9ffeb60adc8a4a8
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 10:55:22 2009 -0600

    ACPI: remove unused acpi_device_ops .lock and .scan methods
    
    No drivers use the .lock and .scan methods, and the Linux/ACPI
    code doesn't even provide a way to invoke them, so remove them.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 03a971a2899886006f19f3495973bbd646d8bdae
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Wed Dec 3 18:00:38 2008 +0000

    thermal: support forcing support for passive cooling
    
    Due to poor thermal design or Linux driving hardware outside its thermal
    envelope, some systems will reach critical temperature and shut down
    under high load. This patch adds support for forcing a polling-based
    passive trip point if the firmware doesn't provide one. The assumption
    is made that the processor is the most practical means to reduce the
    dynamic heat generation, so hitting the passive thermal limit will cause
    the CPU to be throttled until the temperature stabalises around the
    defined value.
    
    UI is provided via a "passive" sysfs entry in the thermal zone
    directory. It accepts a decimal value in millidegrees celsius, or "0" to
    disable the functionality. Default behaviour is for this functionality
    to be disabled.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f6f5c45e06e86d94621cd5c1c4508bdee1952fc8
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Mar 3 12:47:17 2009 +1100

    ACPI: update thermal for bus_id removal
    
    > drivers/acpi/thermal.c: In function 'thermal_notify':
    > drivers/acpi/thermal.c:768: error: 'struct device' has no member named 'bus_id'
    >
    > Caused by commit b1569e99c795bf83b4ddf41c4f1c42761ab7f75e ("ACPI: move
    > thermal trip handling to generic thermal layer") interacting with commit
    > d4a078fca590911cdf87a8eaffee1b6e643c2558 ("driver core: get rid of struct
    > device's bus_id string array").
    >
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fb318cbff40964999f303d50bcf541dd9ead6780
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Wed Mar 18 09:09:01 2009 +0800

    ACPI: cpufreq: use new bit register access function
    
    > arch/x86/kernel/cpu/cpufreq/longhaul.c: In function 'longhaul_setstate':
    > arch/x86/kernel/cpu/cpufreq/longhaul.c:308: error: implicit declaration of function 'acpi_set_register'
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Compile-tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 018f452e9d9d0cb5c3e8d33fd94dc6cd3c520a8f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:50:24 2009 -0600

    ACPI: tidy up makefile
    
    This patch removes the suggestion that ec.o link order is important,
    because it doesn't matter since acpi_ec_init() is no longer an initcall.
    And it puts together most of the core modules that are not configurable.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 201b8c655f7a48563f6a0b66f9e388460a1ea611
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:50:19 2009 -0600

    ACPI: call acpi_wakeup_device_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_wakeup_device_init() directly.
    Previously, acpi_wakeup_device_init() was a late_initcall (sequence 7).
    
    acpi_wakeup_device_init() depends on acpi_wakeup_device_list, which
    is populated when ACPI devices are enumerated by acpi_init() ->
    acpi_scan_init().  Using late_initcall is certainly enough to make
    sure acpi_wakeup_device_list is populated, but it is more than
    necessary.  We can just as easily call acpi_wakeup_device_init()
    directly from acpi_init(), which avoids the initcall magic.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Li Shaohua <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9cee43e07940bee13462e63bd75ce4430b155886
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:50:14 2009 -0600

    ACPI: call acpi_sleep_proc_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_sleep_proc_init() directly.
    Previously, acpi_sleep_proc_init() was a late_initcall (sequence 7),
    apparently to make sure that the /proc hierarchy already exists:
    
        2003/02/13 12:38:03-06:00 mochel
        acpi sleep: demote sleep proc file creation.
    
        - Make acpi_sleep_proc_init() a late_initcall(), and not called from
          acpi_sleep_init(). This guarantees that the acpi proc hierarchy is at
          least there when we create the dang file.
    
    This should no longer be an issue because acpi_bus_init() (called early
    in acpi_init()) creates acpi_root_dir (/proc/acpi).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0e46517d9660ee6ae0a0c5d8a4e50451bc84d61d
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:50:09 2009 -0600

    ACPI: call init_acpi_device_notify() explicitly rather than as initcall
    
    This patch makes acpi_init() call init_acpi_device_notify() directly.
    Previously, init_acpi_device_notify() was an arch_initcall (sequence 3),
    so it was called before acpi_init() (a subsys_initcall at sequence 4).
    
    init_acpi_device_notify() sets the platform_notify and
    platform_notify_remove function pointers.  These pointers
    are not used until acpi_init() enumerates ACPI devices in
    this path:
    
        acpi_init()
    	    acpi_scan_init()
    		acpi_bus_scan()
    		    acpi_add_single_object()
    			acpi_device_register()
    			    device_add()
    				<use platform_notify>
    
    So it is sufficient to have acpi_init() call init_acpi_device_notify()
    directly before it enumerates devices.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 84f810c33f695e020776ce66c903e0b41872f1b2
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:50:03 2009 -0600

    ACPI: call acpi_debug_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_debug_init() directly.
    Previously, both were subsys_initcalls.  acpi_debug_init()
    must happen after acpi_init(), and it's better to call it
    explicitly rather than rely on link ordering.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 141a0af3cab7de690816b17aad1682050219f774
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:49:58 2009 -0600

    ACPI: call acpi_system_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_system_init() directly.
    Previously, both were subsys_initcalls.  acpi_system_init()
    must happen after acpi_init(), and it's better to call it
    explicitly rather than rely on link ordering.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 44515374cba9e46d5622256b43eb06b9c349cee1
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:49:53 2009 -0600

    ACPI: call acpi_power_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_power_init() directly.
    Previously, both were subsys_initcalls.  acpi_power_init()
    must happen after acpi_init(), and it's better to call it
    explicitly rather than rely on link ordering.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a5f820feb54a59fcdaf4a67a6381ea1ddb36cc6e
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:49:48 2009 -0600

    ACPI: call acpi_ec_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_ec_init() directly.
    Previously, both were subsys_initcalls.  acpi_ec_init()
    must happen after acpi_init(), and it's better to call it
    explicitly rather than rely on link ordering.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e747f274951507b5a0850155c3d709e26d20de5b
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:49:43 2009 -0600

    ACPI: call acpi_scan_init() explicitly rather than as initcall
    
    This patch makes acpi_init() call acpi_scan_init() directly.
    
    Previously, both acpi_init() and acpi_scan_init() were subsys_initcalls,
    and acpi_init() was called first based on the link order from the
    makefile (bus.o before scan.o).
    
    acpi_scan_init() registers the ACPI bus type, creates the root device,
    and enumerates fixed-feature and namespace devices.  All of this must
    be done after acpi_init(), and it's better to call acpi_scan_init()
    explicitly rather than rely on the link ordering.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 81d0273df20edff275e2eefe6b50436af3bdf9e8
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 24 16:49:38 2009 -0600

    ACPI: skip DMI power state check when ACPI disabled
    
    This patch makes acpi_init() exit early when ACPI is disabled.
    This skips a DMI check that affects ACPI power management.   The
    DMI check prints a notice that is misleading when ACPI is disabled.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4ef4cbb3686f9265da87bc6e482162c96f415427
Author: Alessio Igor Bogani <abogani@texware.it>
Date:   Thu Mar 26 21:58:25 2009 +0900

    sony-laptop: Kill the BKL
    
    Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3741834775de035bdf0cd1ce44862bb8c775a4fa
Author: Mattia Dongili <malattia@linux.it>
Date:   Thu Mar 26 21:58:24 2009 +0900

    sony-laptop: update copyright
    
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c9f1e6f67ad6d16c11586a4550fd054d7538eb92
Author: Mattia Dongili <malattia@linux.it>
Date:   Thu Mar 26 21:58:23 2009 +0900

    sony-laptop: Make sony_pic_set_wwanpower not take mutexes
    
    For consistency with __sony_pic_set_bluetoothpower, this is also needed
    later to allow setting the wwanpower attribute from the resume path and
    only lock the mutex once.
    
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f5acf5e898618295895b61d81681ae3115d94b96
Author: Anton Veretenenko <anton@veretenenko.ru>
Date:   Thu Mar 26 22:44:26 2009 +0900

    sony-laptop: Add FW specific hotkey events
    
    Signed-off-by: Anton Veretenenko <anton@veretenenko.ru>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3ad1b7619959c0387a30e05c6f36537190b6da7b
Author: Sergey Yanovich <ynvich@gmail.com>
Date:   Thu Mar 26 21:58:21 2009 +0900

    sony-laptop: notify the hardware of a state change in wwanpower
    
    Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d5b02695d5471b38064efeba2b102bd5ead55297
Author: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
Date:   Thu Mar 26 21:58:20 2009 +0900

    sony-laptop: detect the ICH9 chipset as Type3
    
    Signed-off-by: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2b24ef093aec6d7b9c18af75644ec22b4069b283
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Thu Mar 26 21:58:19 2009 +0900

    sony-laptop: Eliminate BKL in ioctls
    
    Signed-off-by: Alan Cox <alan@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1cae71032183776e833036fe828315dcd3444df1
Author: Harald Jenny <harald@a-little-linux-box.at>
Date:   Thu Mar 26 21:58:18 2009 +0900

    sony-laptop: VGN-A317M hotkey support
    
    This laptop has 5 SPIC managed buttons above the keyboard:
    sound + and - as well as brightness, zoom and S1.
    Possibly the entire VGN-A serie behaves the same.
    
    Signed-off-by: Harald Jenny <harald@a-little-linux-box.at>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e93c8a6819b217f4f4a490f67f26e02ff6b23b44
Author: Mattia Dongili <malattia@linux.it>
Date:   Thu Mar 26 21:58:17 2009 +0900

    sony-laptop: merge Type4 into Type3
    
    Creating Type4 was a mistake in the first place. Some users report that
    also Type3 vaios require the same extra hotkey handling which the Type4
    for was menat to guard from.
    Merging down Type4 into Type3 will just remove a useless distinction.
    
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 45c7942ba8f6b7d5d1147c10f84f0cbf5fa3a2b8
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Mar 26 21:58:16 2009 +0900

    sony-laptop: Add support for extended hotkeys
    
    Recent Sony SR-series machines have an additional set of buttons accessed
    via the 0x127 method rather than the 0x100 method. Add support for these.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6cc056bc31ea9910afb01adc0848bb6ae68e0205
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Mar 26 21:58:15 2009 +0900

    sony-laptop: Add rfkill support on new models
    
    Newer Vaios provide a full featured rfkill implementation via their
    platform methods. Add support for enumerating the available devices and
    providing rfkill access to them. Support for the physical kill switch is
    added, with the devices moving into the HARD_BLOCKED state when toggled.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9b57896e62bfa752ee7435e6cfe57fb210c0db8c
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Mar 26 21:58:14 2009 +0900

    sony-laptop: Add support for extra keyboard events
    
    The current sony-laptop code assumes that the keyboard event method is
    always located at slot 2 in the platform code. Remove this assumption and
    add support for some additional hotkeys.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 82734bfc8622f3e8f015a5783b739739f97f89f9
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Mar 26 21:58:13 2009 +0900

    sony-laptop: Enable EC on newer hardware
    
    The latest Vaios can execute certain codepaths in two ways - either using
    system management mode or using pure ACPI methods. The latter is only used
    if the OS has called the ECON method. Ensure that this is done where the
    method is available.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit badf26f00f2ed80615206d07bcfc2e3b78af5441
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Mar 26 21:58:12 2009 +0900

    sony-laptop: Add support for new Sony platform API
    
    Newer Sony Vaios provide a new API for accessing platform functionality. It
    consists of a set of standardised methods for enabling events and performing
    queries. These are each identified by a unique handle. This patch adds
    support for calling functions based on their handle and ports the existing
    code for these machines over to it.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 14eecfc1195a9d16999157591ffce23acd6df8c1
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Mar 23 09:30:27 2009 +0800

    ACPICA: Update version to 20090320
    
    Version 20090320.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 03ef132b7258bbea4858be4b1bd6cb6c3fdd3253
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 10:14:45 2009 +0800

    ACPICA: Fix index value in package warning message
    
    For predefined method validation. Index value in warning message
    could be off by one.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f65563063375b05898a94ab71b52612cbe3a789b
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 10:13:40 2009 +0800

    ACPICA: FADT: Favor 32-bit FACS and DSDT addresses
    
    If both the 32-bit and 64-bit addresses are non-null, use the
    32-bit address. Provides Windows compatibility.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 31fbc073a35a017e34840deb9e865a701e986002
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 10:12:13 2009 +0800

    ACPICA: FADT: Favor 32-bit register addresses for compatibility
    
    Use the 32-bit register addresses whenever they are non-zero. This
    means that the 32-bit addresses are favored over the 64-bit
    (GAS) addresses. The 64-bit addresses are only used if the 32-bit
    addresses are zero. This change provides compatibility with all
    versions of Windows. The worst case that this solves is when both
    the 32-bit and 64-bit addresses are non-zero, but only the 32-bit
    addresses are actually valid. This appears to happen in some
    BIOSes because in this case, Windows uses the 32-bit addresses.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f28ad2c3daf0691081d91488df4d9d101e1a2b5d
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 09:54:31 2009 +0800

    ACPICA: Fix PCI configuration space port address range
    
    Microsoft website uses 0xCF8-0xD00. Should be 0xCF8-0xCFF (Two
    32-bit registers.)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ee6a0fbd0ccb7736a3be56630e3ad65ceddfb5bd
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 09:53:35 2009 +0800

    ACPICA: Condense some protected ports
    
    One entry in the protected port table eliminated. Added extra
    comments to describe each table entry.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 91a56e631fc837852304ee7bc2876d6e444b7fdb
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 09:52:34 2009 +0800

    ACPICA: Remove unused code, no functional change
    
    Removed unused code for dump of args and locals. General cleanup
    and splitting of long lines.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c3dd25f4c1ca84baa170c0a3a15a884f4f06297e
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Thu Mar 19 09:51:01 2009 +0800

    ACPICA: Clear PM register write-only bits on reading
    
    Affects PM1 Control register only. When reading the register, zero
    the write-only bits as per the ACPI spec.  ACPICA BZ 443. Lin Ming.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=443
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f9ca058430333c9a24c5ca926aa445125f88df18
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 09:47:16 2009 +0800

    ACPICA: Remove obsolete acpi_os_validate_address interface
    
    This interface is no longer necessary. Requests should be validated
    on a per-field basis, not on the entire operation region.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7f0719039085cc40114abce84cf29fe57da226f4
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 09:37:47 2009 +0800

    ACPICA: New: I/O port protection
    
    Protect certain I/O ports from reads/writes. Provides MS
    compatibility. New module, hwvalid.c
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 20869dcfde204e1c21b642608d708d82472fee2b
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Mar 13 09:10:46 2009 +0800

    ACPICA: Preserve all PM control reserved and ignored bits
    
    As per the ACPI specification, preserve (read/modify/write) all
    bits that are defined as either reserved or ignored (PM control
    control registers only.)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8636f8d257b3edf5a1529df93119cdc630ed85c7
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Mar 9 16:32:20 2009 +0800

    ACPICA: Change handling of PM1 Status register ignored bit
    
    Ignored bits must be preserved according to the ACPI spec.
    Usually this means a read/modify/write when writing to the
    register.  However, for status registers, writing a one means
    clear the event.  Writing a zero means preserve the event (do not
    clear.) This behavior is clarified in the ACPI 4.0 spec, and the
    ACPICA code now simply always writes a zero to the ignored bit.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8a335a2331c72e60c6b3ef09b2dedd3ba00da1b1
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Mar 9 16:31:04 2009 +0800

    ACPICA: Fix AcpiWalkNamespace race condition with table unload
    
    Added a reader/writer locking mechanism to allow multiple
    concurrent namespace walks (readers), but a dynamic table unload
    will have exclusive access to the namespace. This fixes a problem
    where a table unload could delete the portion of the namespace that
    is currently being examined by a walk.  Adds a new file, utlock.c
    that implements the reader/writer lock mechanism. ACPICA BZ 749.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=749
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aab61b676a024d3527f6201e2b31285a96f7a1d2
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Mar 6 10:09:00 2009 +0800

    ACPICA: FADT: Fix extraneous length mismatch warning
    
    Incorrect register length mismatch between the 32 and 64 bit
    registers in some cases. Code was was checking the wrong pointer
    for non-zero, should be looking at the address within the GAS
    structure.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d4913dc6d0c680aa106d1d80b5ad2a9325367afd
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Mar 6 10:05:18 2009 +0800

    ACPICA: Formatting update - no functional changes
    
    Split long lines, update comments.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 768aaaf196e8a40f5cfc792d9d365795cc52ed13
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Mar 6 09:49:25 2009 +0800

    ACPICA: Add manifest constants for bit register values
    
    Add and deploy constants for the PM status/enable/control
    registers.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2affa28605fa5387192c72d9889a00c9c51aa712
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Feb 23 10:27:07 2009 +0800

    ACPICA: Update version to 20090220
    
    Version 20090220.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b6bc342dd543f40b6feccbaf6719d9f836c9964a
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Feb 23 10:26:19 2009 +0800

    ACPICA: Update table header print function
    
    Cleanup table header output.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 88dcb04a813265e1a5a1bc74af2db7efa7d62ee6
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 16:01:04 2009 +0800

    ACPICA: Restructure bit register access functions
    
    Update code for acpi_read_bit_register and acpi_write_bit_register.
    Simplified code path, condensed duplicate code.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 50ffba1bd3120b069617455545bc27bcf3cf7579
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Feb 23 15:02:07 2009 +0800

    ACPICA: Rename ACPI bit register access functions
    
    Rename acpi_get_register and acpi_set_register to clarify the
    purpose of these functions. New names are acpi_read_bit_register
    and acpi_write_bit_register.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9892dd23cbbfab1f7d4818622296e415979a9c77
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 15:10:07 2009 +0800

    ACPICA: Optimize ACPI register locking
    
    Removed locking for reads from the ACPI bit registers in PM1
    Status, Enable, Control, and PM2 Control. The lock is not required
    when reading the single-bit registers. The acpi_get_register_unlocked
    function is no longer needed and has been removed. This will
    improve performance for reads on these registers.  ACPICA BZ 760.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=760
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ec41f193eadb6301f3c052b5e0dbc0b5636982e8
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 15:03:30 2009 +0800

    ACPICA: Formatting update - no functional changes
    
    Split some long lines.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7bcc06e845479bde939059bafa088bf25ede9dbf
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:58:08 2009 +0800

    ACPICA: Debug output: decrease verbosity of DB_INFO debug level
    
    Removed some of the extraneous debug prints using the DB_INFO
    level.  This should make the DB_INFO more useful.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c114e4b6c606c7f174b752f946fcfb0e7e61a347
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Feb 23 11:00:00 2009 +0800

    ACPICA: Debug output: print result of _OSI invocations
    
    Print input strings and the result (supported or not supported)
    for invocations of the _OSI method.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4f70e371cdf6ab4f988fbaf2257e6259422ba662
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:52:43 2009 +0800

    ACPICA: Conditionally compile acpi_set_firmware_waking_vector64
    
    This function is only needed on 64-bit host operating systems.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3371c19c294a4cb3649aa4e84606be8a1d999e61
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:44:03 2009 +0800

    ACPICA: Remove ACPI_GET_OBJECT_TYPE macro
    
    Remove all instances of this obsolete macro, since it is now a
    simple reference to ->common.type. There were about 150 invocations
    of the macro across 41 files. ACPICA BZ 755.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=755
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 32c9ef994d91352b710b948ec369cd18d6bca51b
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:36:05 2009 +0800

    ACPICA: Add function to handle PM1 control registers
    
    Added acpi_hw_write_pm1_control. This function writes both of the PM1
    control registers (A/B). These registers are different than than
    the PM1 A/B status and enable registers in that different values
    can be written to the A/B registers.  Most notably, the SLP_TYP
    bits can be different, as per the values returned from the _Sx
    predefined methods.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 82d79b86646504a0ab97fe50ac137df65f651a27
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:31:05 2009 +0800

    ACPICA: Remove redundant ACPI_BITREG_SLEEP_TYPE_B
    
    This type is the same as TYPE_A. Removed this and all related
    instances.  Renamed SLEEP_TYPE_A to simply SLEEP_TYPE.
    ACPICA BZ 754.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=754
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ac0c84502697114a378057eed83a9baba879cfc9
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:28:02 2009 +0800

    ACPICA: Fix parameter validation for acpi_read/write
    
    Now return AE_BAD_PARAMETER if the input register pointer is
    null, and AE_BAD_ADDRESS if the register has an address of zero.
    Previously, these cases simply returned AE_OK. For optional
    registers such as PM1B status/enable/control, the caller should
    check for a valid register address before calling.  ACPICA BZ 748.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=748
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aefc7f9a0220a40beff9b6b3b320cbeae128d0e3
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:26:02 2009 +0800

    ACPICA: For PM1B registers, do not shift value read or written
    
    The PM1B registers are mirrors of the PM1A registers with
    different bits actually implemented. From the ACPI specification:
    "Although the bits can be split between the two register blocks
    (each register block has a unique pointer within the FADT), the bit
    positions are maintained. The register block with unimplemented
    bits (that is, those implemented in the other register block)
    always returns zeros, and writes have no side effects"
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 227243a04d645377d09eda0dc8501e0d9c26ab89
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:24:50 2009 +0800

    ACPICA: Remove extra write for acpi_hw_clear_acpi_status
    
    This function was writing an optional PM1B status register
    twice.  The existing call to the low-level acpi_hw_register_write
    automatically handles a possibly split PM1 A/B register.
    ACPICA BZ 751.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=751
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c520abadbc56a2740021910d2c6412f826a10059
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:20:12 2009 +0800

    ACPICA: Fix writes to optional PM1B registers
    
    On read, shift B register bits above the A bits. On write,
    shift B bits down to zero before writing the B register. New:
    acpi_hw_read_multiple, acpi_hw_write_multiple. These two functions now
    transparently handle the (possible) split registers for PM1 Status,
    Enable, and Control.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d3319d1717a250e92be66a487dc3e0429112c284
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:07:58 2009 +0800

    ACPICA: Update comments in module header
    
    Enhance the explanations of the various package return types
    for clarity.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5e053e77f233342b56fda419d347fd2c958b9849
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Wed Mar 4 14:31:25 2009 +0800

    ACPICA: Check for non-zero address before being converted to GAS
    
    Reported-by: FreeBSD community
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 531c633d2be8e79087335a46d3c017ca5837e588
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Feb 18 14:06:12 2009 +0800

    ACPICA: Split out PM1 status registers from the FADT
    
    Add new globals for the PM1 status registers (A/B), similar to the
    way the PM1 enable registers are handled. Instead of overloading
    the FADT Event Register blocks. This makes the code clearer and
    less prone to error.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6fc69d8beb0c16311f737df2c6f677057d50ab05
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 3 15:16:51 2009 +0800

    ACPICA: Update version to 20090123
    
    Update version to 20090123.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 993958fecab6eabc6ee5b7ed65c56d716fd5cfe3
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 3 15:14:33 2009 +0800

    ACPICA: Update FADT flag definitions
    
    Add new flags in the Boot Architecture flags field. Update comments
    for all FADT flags. Add FADT version when each flag was defined.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d3ccaff827cef5a5c5a0f3c97e1e2e6d99f618cb
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 3 14:43:04 2009 +0800

    ACPICA: Add override for dynamic tables
    
    Add a call to acpi_os_table_override during the installation of a
    dynamic table (loaded via the Load or LoadTable AML operators).
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 97cbb7d196845ec9a6c0e3cc33ec20503f8c4e73
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 3 14:41:03 2009 +0800

    ACPICA: Remove extraneous parameter in table manager
    
    Removed the Flags parameter from several internal functions since
    it was not being used.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ac5f98db7be34cefc244026f882cf030debb7431
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 3 14:35:25 2009 +0800

    ACPICA: Allow OS override of all ACPI tables
    
    Previously, the table override mechanism was implemented for the
    DSDT only. Now, any table in the RSDT/XSDT can be replaced by
    the host OS. (including the DSDT).
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4bbfb85da27c27e9cc9a7fef4bd75df6361152ff
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 3 14:17:29 2009 +0800

    ACPICA: Add error check to debug object dump routine
    
    Add check for invalid handle in acpi_ns_dump_one_object.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e60cc7a6f02598fc23c68a656fe9c263d6531ca0
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Fri Mar 13 12:08:26 2009 -0600

    ACPI: move private declarations to internal.h
    
    A number of things that shouldn't be exposed outside the ACPI core
    were declared in include/acpi/acpi_drivers.h, where anybody can
    see them.  This patch moves those declarations to a new "internal.h"
    inside drivers/acpi.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1c48aa36ef301d7b07674313bae65ef2496801a7
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Thu Feb 19 14:45:47 2009 -0700

    ACPI: update Kconfig help texts (no functional changes)
    
    Use "help" (not "---help---") consistently throughout.
    
    ACPI can't be a module, so if both ACPI & APM are configured,
    we use ACPI.
    
    Update pointers to ACPI CA and Linux ACPI projects.
    
    Replace "Compaq" with "Hewlett-Packard" in the spec developer list.
    
    Fix typo in /sys/module path.
    
    The user-space daemon is "acpid", not "acpi".
    
    Add standard "To compile this driver as a module ..." help text.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c686d141c7c668ac186015841a1ccd285a1f3362
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Feb 17 13:49:10 2009 -0700

    ACPI: PCI: use generic pci_swizzle_interrupt_pin()
    
    Use the generic pci_swizzle_interrupt_pin() instead of ACPI-specific code.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5f0dccaa81e239477413d0def1133850530f1bbe
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Feb 17 14:00:55 2009 -0700

    ACPI: pci_link: simplify list of link devices
    
    We don't need a struct containing a count and a list_head; a simple
    list_head is sufficient.  The list iterators handle empty lists
    fine.
    
    Furthermore, we don't need to check for null list entries because we
    only add non-null entries.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6eca4b4ca168981d7648be371945c2a21f463a45
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Feb 17 14:00:50 2009 -0700

    ACPI: pci_link: remove unnecessary null pointer checks
    
    Better to oops and learn about a bug than to silently cover it up.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c9d6244329c8149312dba27e78dc4a83b35a6ae5
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Feb 17 14:00:45 2009 -0700

    ACPI: pci_link: remove unnecessary casts and initializations
    
    Remove unnecessary casts and initializations.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1c9ca3a7d41b5db884033900b539b9aeb61a399e
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Feb 17 14:00:40 2009 -0700

    ACPI: pci_link: clean up whitespace
    
    This patch makes whitespace and indentation more consistent.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ff69f2bba67bd45514923aaedbf40fe351787c59
Author: alex.shi <alex.shi@intel.com>
Date:   Wed Mar 4 11:55:26 2009 -0800

    acpi: fix of pmtimer overflow that make Cx states time incorrect
    
    We found Cx states time abnormal in our some of machines which have 16
    LCPUs, the C0 take too many time while system is really idle when kernel
    enabled tickless and highres.  powertop output is below:
    
         PowerTOP version 1.9       (C) 2007 Intel Corporation
    
    Cn                Avg residency       P-states (frequencies)
    C0 (cpu running)        (40.5%)         2.53 Ghz     0.0%
    C1                0.0ms ( 0.0%)         2.53 Ghz     0.0%
    C2              128.8ms (59.5%)         2.40 Ghz     0.0%
                                            1.60 Ghz   100.0%
    
    Wakeups-from-idle per second :  4.7     interval: 20.0s
    no ACPI power usage estimate available
    
    Top causes for wakeups:
      41.4% ( 24.9)       <interrupt> : extra timer interrupt
      20.2% ( 12.2)     <kernel core> : usb_hcd_poll_rh_status
    (rh_timer_func)
    
    After tacking detailed for this issue, Yakui and I find it is due to 24
    bit PM timer overflows when some of cpu sleep more than 4 seconds.  With
    tickless kernel, the CPU want to sleep as much as possible when system
    idle.  But the Cx sleep time are recorded by pmtimer which length is
    determined by BIOS.  The current Cx time was gotten in the following
    function from driver/acpi/processor_idle.c:
    
    static inline u32 ticks_elapsed(u32 t1, u32 t2)
    {
           if (t2 >= t1)
                   return (t2 - t1);
           else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
                   return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
           else
                   return ((0xFFFFFFFF - t1) + t2);
    }
    
    If pmtimer is 24 bits and it take 5 seconds from t1 to t2, in above
    function, just about 1 seconds ticks was recorded.  So the Cx time will be
    reduced about 4 seconds.  and this is why we see above powertop output.
    
    To resolve this problem, Yakui and I use ktime_get() to record the Cx
    states time instead of PM timer as the following patch.  the patch was
    tested with i386/x86_64 modes on several platforms.
    
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Tested-by: Alex Shi <alex.shi@intel.com>
    Signed-off-by: Alex Shi <alex.shi@intel.com>
    Signed-off-by: Yakui.zhao <yakui.zhao@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca
Author: Frans Pop <elendil@planet.nl>
Date:   Wed Mar 4 11:55:28 2009 -0800

    hp-wmi: notify of a potential docking state change on resume
    
    It is possible that the system gets docked or undocked while it's
    suspended. Generate an input event on resume to notify user space
    if there was a state change.
    
    As it is a switch, we can generate the event unconditionally; the
    input layer will only pass it on if there is an actual change.
    
    Signed-off-by: Frans Pop <elendil@planet.nl>
    Cc: Matthew Garrett <mjg59@srcf.ucam.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4658e4ef9d252c26630268b20ceab78b3952db41
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Thu Feb 26 11:27:23 2009 +0800

    ACPI: introduce sysfs I/F for dynamic tables
    
    SSDT tables may be loaded at runtime.
    create sysfs I/F for these dynamic tables in
    /sys/firmware/acpi/tables/dynamic/.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Wed Dec 3 17:55:32 2008 +0000

    ACPI: move thermal trip handling to generic thermal layer
    
    The ACPI code currently carries its own thermal trip handling, meaning that
    any other thermal implementation will need to reimplement it. Move the code
    to the generic thermal layer.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6503e5df08008b9a47022b5e9ebba658c8fa69af
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Thu Nov 27 17:48:13 2008 +0000

    thermal: use integers rather than strings for thermal values
    
    The thermal API currently uses strings to pass values to userspace. This
    makes it difficult to use from within the kernel. Change the interface
    to use integers and fix up the consumers.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Acked-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

--Boundary_(ID_LP5OyJzs5PNKyhN72CvFOg)--
