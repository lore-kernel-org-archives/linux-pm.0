From: Len Brown <lenb@kernel.org>
Subject: [git pull] ACPI & driver patches for 2.6.30-rc1
Date: Tue, 07 Apr 2009 19:09:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904071820510.4799@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Two regression fixes (battery driver oops on load, ACPI warnings on
sony laptops), a couple of merge-window stragglers, and some cleanups.

This will update the files shown below.

thanks!

--
Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.30/acpi-release-20090320-2.6.30-rc1.diff.gz

 arch/x86/include/asm/cpufeature.h          |    1 +
 arch/x86/kernel/apic/apic.c                |    6 +++
 arch/x86/kernel/cpu/addon_cpuid_features.c |    1 +
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   55 ++++++++++++-----------
 arch/x86/kernel/cpu/cpufreq/longhaul.c     |    1 -
 drivers/acpi/acpica/hwvalid.c              |    1 -
 drivers/acpi/battery.c                     |    2 +-
 drivers/acpi/proc.c                        |   13 ++----
 drivers/acpi/processor_idle.c              |    3 +
 drivers/acpi/scan.c                        |   31 +++++--------
 drivers/acpi/sleep.h                       |    3 +
 drivers/acpi/thermal.c                     |   68 +++++++++++++++------------
 drivers/acpi/video.c                       |   30 ++----------
 drivers/acpi/wakeup.c                      |   30 +++---------
 drivers/platform/x86/fujitsu-laptop.c      |   60 ++++---------------------
 drivers/platform/x86/panasonic-laptop.c    |   28 +++---------
 drivers/platform/x86/sony-laptop.c         |   30 ++-----------
 drivers/platform/x86/wmi.c                 |   15 +-----
 include/acpi/acpi_bus.h                    |    1 -
 19 files changed, 131 insertions(+), 248 deletions(-)

through these commits:

Bjorn Helgaas (7):
      ACPI: thermal: use .notify method instead of installing handler directly
      ACPI: video: use .notify method instead of installing handler directly
      fujitsu-laptop: use .notify method instead of installing handler directly
      fujitsu-laptop: use .notify method instead of installing hotkey handler directly
      panasonic-laptop: use .notify method instead of installing handler directly
      sony-laptop: use .notify method instead of installing handler directly
      ACPI: WMI: use .notify method instead of installing handler directly

Hannes Eder (1):
      NULL noise: drivers/platform/x86/panasonic-laptop.c

Huang Weiyi (1):
      ACPI: cpufreq: remove dupilcated #include

Jean Delvare (1):
      ACPI: Adjust Kelvin offset to match local implementation

Len Brown (2):
      ACPI: delete acpi_device.g_list
      ACPICA: delete check for AML access to port 0x81-83

Shaohua Li (1):
      ACPI: convert acpi_device_lock spinlock to mutex

Vegard Nossum (1):
      ACPI battery: fix async boot oops

Venkatesh Pallipadi (3):
      ACPI x86: Cleanup acpi_cpufreq structures related to aperf/mperf
      ACPI x86: Make aperf/mperf MSR access in acpi_cpufreq read_only
      x86 ACPI: Add support for Always Running APIC timer

with this log:

commit 8897c1859521cf33077256725b2377164b130c75
Merge: 18b2646 db954b5 fdbdc7f 13614e3 33b5715 f61bb93
Author: Len Brown <len.brown@intel.com>
Date:   Tue Apr 7 18:18:42 2009 -0400

    Merge branches 'release', 'APERF', 'ARAT', 'misc', 'kelvin', 'device-lock' and 'bjorn.notify' into release

commit db954b5898dd3ef3ef93f4144158ea8f97deb058
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Apr 6 18:51:29 2009 -0700

    x86 ACPI: Add support for Always Running APIC timer
    
    Add support for Always Running APIC timer, CPUID_0x6_EAX_Bit2.
    This bit means the APIC timer continues to run even when CPU is
    in deep C-states.
    
    The advantage is that we can use LAPIC timer on these CPUs
    always, and there is no need for "slow to read and program"
    external timers (HPET/PIT) and the timer broadcast logic
    and related code in C-state entry and exit.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Acked-by: H. Peter Anvin <hpa@zytor.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 18b2646fe3babeb40b34a0c1751e0bf5adfdc64c
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Apr 6 11:26:08 2009 -0700

    ACPI x86: Make aperf/mperf MSR access in acpi_cpufreq read_only
    
    Do not write zeroes to APERF and MPERF by ondemand governor. With this
    change, other users can share these MSRs for reads.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e4f6937222dbb61b8b8e62caca3d32e648b3b14b
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Apr 6 11:26:07 2009 -0700

    ACPI x86: Cleanup acpi_cpufreq structures related to aperf/mperf
    
    Change structure name to make the code cleaner and simpler. No
    functionality change in this patch.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fdbdc7fc79c02ae4ede869d514179a2c65633d28
Author: Len Brown <len.brown@intel.com>
Date:   Tue Apr 7 17:33:58 2009 -0400

    ACPICA: delete check for AML access to port 0x81-83
    
    Sony laptops apparently write 4-bytes (rather than 1 byte)
    to debug port 0x80, which spews error messages:
    
    Denied AML access to port 0x00000080/4 (DMA1 0x0081-0x0083) [20090320]
    
    http://bugzilla.kernel.org/show_bug.cgi?id=13036
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f61bb93927fbc2933abe870813daba9d331aa121
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:37 2009 +0000

    ACPI: WMI: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8037d6e67709cf497134bbabd77b07dfc7c31fd6
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:32 2009 +0000

    sony-laptop: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cddd1f71d972a43c88f0ef91e1b71023539cd6e0
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:27 2009 +0000

    panasonic-laptop: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Harald Welte <laforge@gnumonks.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b4ec0275464756f4fd4108b4a4ca7aff61358ad3
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:22 2009 +0000

    fujitsu-laptop: use .notify method instead of installing hotkey handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Tested by Tony on Fujitsu-Siemens Lifebook S6420 [FJNB1E6] with
    BIOS 1.18 (01/09/2009).  Tested by Jonathan on Fujitsu S7020.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Acked-By: Tony Vroon <tony@linx.net>
    Tested-By: Tony Vroon <tony@linx.net>
    Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
    Tested-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 700b6721cd1b891b67c2dcee046be12154a21fd6
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:16 2009 +0000

    fujitsu-laptop: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Tested by Tony on Fujitsu-Siemens Lifebook S6420 [FJNB1E6] with
    BIOS 1.18 (01/09/2009).  Tested by Jonathan on Fujitsu S7020.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Acked-By: Tony Vroon <tony@linx.net>
    Tested-By: Tony Vroon <tony@linx.net>
    Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
    Tested-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7015558fca5ee82fc17227b61d88ddaa02d82242
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:11 2009 +0000

    ACPI: video: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 342d550db1bc0b879007a8cdb38645558e839680
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Apr 7 15:37:06 2009 +0000

    ACPI: thermal: use .notify method instead of installing handler directly
    
    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    CC: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d38258ec026921a7b266f4047ebeaa75db358e5
Author: Vegard Nossum <vegard.nossum@gmail.com>
Date:   Tue Apr 7 10:55:38 2009 +0200

    ACPI battery: fix async boot oops
    
    > BUG: unable to handle kernel NULL pointer dereference at (null)
    
    What happens is that the battery module's init sections are being freed
    before the async callback (which was marked __init) has run. This theory
    is supported by the fact that the bad RIP value is a vmalloc address.
    
    The immediate fix is to make this a non-init call.
    
    (A better long-term fix is of course to wait with init-section unloading
    until a module's async initcalls have been run, which would allow us to
    discard this function which is still only run once, after all. Perhaps a
    new async_initcall() function for the async/module API, if this is needed
    for other modules in the future?)
    
    Reported-by: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
    Signed-off-by: Vegard Nossum <vegard.nossum@gmail.com>
    Tested-by: Alessandro Suardi <alessandro.suardi@gmail.com>
    Tested-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 33b571501553ceb008c0aef8b89e932d4efda2a2
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 15 22:09:26 2008 -0500

    ACPI: delete acpi_device.g_list
    
    unused
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a3c270561ea4455cbcea0ac2b53335655d9fc805
Author: Hannes Eder <hannes@hanneseder.net>
Date:   Thu Mar 5 20:15:44 2009 +0100

    NULL noise: drivers/platform/x86/panasonic-laptop.c
    
    Fix this sparse warning:
      drivers/platform/x86/panasonic-laptop.c:273:70: warning: Using plain integer as NULL pointer
    
    Signed-off-by: Hannes Eder <hannes@hanneseder.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d22616942804798105e61428afa41a9132421bb9
Author: Huang Weiyi <weiyi.huang@gmail.com>
Date:   Mon Apr 6 17:16:46 2009 +0800

    ACPI: cpufreq: remove dupilcated #include
    
    Remove dupilicated #include in arch/x86/kernel/cpu/cpufreq/longhaul.c.
    
    Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 13614e37e94da4606a300ee6fe25c8c4a19ee670
Author: Jean Delvare <khali@linux-fr.org>
Date:   Mon Apr 6 16:01:46 2009 +0200

    ACPI: Adjust Kelvin offset to match local implementation
    
    The exact offset between Kelvin and degree Celsius is 273.15. However
    ACPI handles temperature values with a single decimal place. As a
    consequence, some implementations use an offset of 273.1 and others
    use an offset of 273.2. Try to find out which one is being used, to
    present the most accurate and visually appealing number.
    
    Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
    Thinkpad T60p (which uses 273.2).
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Acked-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9090589d87506c578ea1523ffd7ae7fd9424fb28
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Tue Apr 7 10:24:29 2009 +0800

    ACPI: convert acpi_device_lock spinlock to mutex
    
    Convert acpi_device_lock to a mutex to avoid
    a potential race upon access to /proc/acpi/wakeup
    
    Delete the lock entirely in wakeup.c
    since it is not necessary (and can not sleep)
    
    Found-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
