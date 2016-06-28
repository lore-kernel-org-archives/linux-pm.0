From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 0/7] arm64: hibernate: Support DEBUG_PAGEALLOC and hibernate on non-boot cpu
Date: Tue, 28 Jun 2016 15:51:43 +0100
Message-ID: <1467125510-18758-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48032 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbcF1OyH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 10:54:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Chen Yu C <yu.c.chen@intel.com>, linux-pm@vger.kernel.org

Hi all,

These patches improve arm64's hibernate support:
* Patches 1-3 fix the hibernate problem with DEBUG_PAGEALLOC reported by Will.
  This also addresses the outstanding comment from Catalin [0] regarding
  cleaning of the whole kernel to the PoC. Now we clean two new sections
  .mmuoff.{data,text}.

* Patch 4 detects the 'resume on the wrong CPU' condition that we may
  experience with kexec, and prints an error message. (data still gets lost)

* Patches 5 & 6 improve on this error message by causing resume to occur on the
  same CPU that we hibernated on.

* Patch 7 reverts the code that tries to prevent hibernate with no CPU0,
  which isn't safe against kexec shuffling the CPU order.

The patch to core hibernate code now uses a macro and a kconfig symbol
(in the same way as config_arch_hibernate_header) to avoid the header
include problem. It should be possible to use this approach with
Chen Yu's hlt/mwait problem too [1].

With this series applied I can hotplug CPU0, kexec, hibernate and then
resume[3], the implementation is s discussed on the list[2].

Patch 4 will cause a trivial merge conflict with mainline, due to a fix
for hibernate which added an include for asm/smp.h. The fix is to keep
both hunks.

This series is based on arm64/for-next/core, and can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/update/v3

Changes since v2:
 * Split wrong-CPU logic into an earlier patch that just returns an error.
 * Moved secondary_holding_pen and friends into the .mmuoff.text section.
 * Added a mmuoff.data section for secondary_holding_pen_release etc.
 * Changed core code patch to use macros instead of a weak function.
   CONFIG_ARCH_HIBERNATION_HEADER now implies an asm/suspend.h header.
 * Wording in error messages 'hibernate' not 'suspend'.

Changes since v1:
 * Fixed 'Brining' typo.
 * Added .mmuoff.text section and gathered functions together.
 * Put sections.h in alphabetical order.


[v1] http://www.spinics.net/lists/arm-kernel/msg507805.html
[v2] http://permalink.gmane.org/gmane.linux.power-management.general/77467

[0] http://www.spinics.net/lists/arm-kernel/msg499305.html
[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1176775.html
[2] http://www.spinics.net/lists/arm-kernel/msg499036.html
[3] hotplug cpu0, kexec, hibernate, resume
-------------------------%<-------------------------
root@ubuntu:~# echo disk > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.007 seconds) done.
PM: Preallocating image memory... done (allocated 10112 pages)
PM: Allocated 647168 kbytes in 2.69 seconds (240.58 MB/s)
Freezing remaining freezable tasks ... (elapsed 0.005 seconds) done.
PM: freeze of devices complete after 27.013 msecs
PM: late freeze of devices complete after 20.624 msecs
PM: noirq freeze of devices complete after 22.211 msecs
Disabling non-boot CPUs ...
PM: Creating hibernation image:
PM: Need to copy 10103 pages
PM: Hibernation image created (10103 pages copied)
PM: noirq thaw of devices complete after 22.350 msecs
PM: early thaw of devices complete after 23.680 msecs
PM: thaw of devices complete after 98.331 msecs
hibernate: Suspending on cpu 0 [mpidr:0x103]
PM: Using 1 thread(s) for compression.
PM: Compressing and saving image data (10105 pages)...
PM: Image saving progress:   0%
atkbd serio0: keyboard reset failed on 1c060000.kmi
atkbd serio1: keyboard reset failed on 1c070000.kmi
PM: Image saving progress:  10%
PM: Image saving progress:  20%
PM: Image saving progress:  30%
PM: Image saving progress:  40%
PM: Image saving progress:  50%
PM: Image saving progress:  60%
PM: Image saving progress:  70%
PM: Image saving progress:  80%
PM: Image saving progress:  90%
PM: Image saving progress: 100%
PM: Image saving done.
PM: Wrote 646720 kbytes in 93.08 seconds (6.94 MB/s)
PM: S|
reboot: Power down

[ ... ]

Freezing user space processes ... (elapsed 0.000 seconds) done.
PM: Using 1 thread(s) for decompression.
PM: Loading and decompressing image data (10105 pages)...
hibernate: Suspended on cpu 5 [mpidr:0x103]
hibernate: Suspended on a CPU that is offline! Brining CPU up.
Detected VIPT I-cache on CPU5
CPU5: Booted secondary processor [410fd033]
random: nonblocking pool is initialized
PM: Image loading progress:   0%
PM: Image loading progress:  10%
PM: Image loading progress:  20%
PM: Image loading progress:  30%
PM: Image loading progress:  40%
PM: Image loading progress:  50%
PM: Image loading progress:  60%
PM: Image loading progress:  70%
PM: Image loading progress:  80%
PM: Image loading progress:  90%
PM: Image loading progress: 100%
PM: Image loading done.
PM: Read 646720 kbytes in 30.47 seconds (21.22 MB/s)
PM: quiesce of devices complete after 32.958 msecs
PM: late quiesce of devices complete after 11.574 msecs
PM: noirq quiesce of devices complete after 24.918 msecs
hibernate: Disabling secondary CPUs ...
IRQ1 no longer affine to CPU0
IRQ6 no longer affine to CPU0
IRQ28 no longer affine to CPU0
IRQ29 no longer affine to CPU0
IRQ32 no longer affine to CPU0
IRQ34 no longer affine to CPU0
IRQ35 no longer affine to CPU0
IRQ37 no longer affine to CPU0
IRQ41 no longer affine to CPU0
IRQ48 no longer affine to CPU0
CPU0: shutdown

psci: CPU0 killed.
PM: noirq restore of devices complete after 27.419 msecs
PM: early restore of devices complete after 23.554 msecs
PM: restore of devices complete after 113.188 msecs
Restarting tasks ... done.
root@ubuntu:~# atkbd serio0: keyboard reset failed on 1c060000.kmi
atkbd serio1: keyboard reset failed on 1c070000.kmi
root@ubuntu:~# cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 100.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 3

root@ubuntu:~#
-------------------------%<-------------------------


James Morse (7):
  arm64: Create sections.h
  arm64: vmlinux.ld: Add .mmuoff.{text,data} sections
  arm64: hibernate: Support DEBUG_PAGEALLOC
  arm64: hibernate: Detect hibernate image created on non-boot CPU
  PM / Hibernate: Allow arch code to influence CPU hotplug during
    hibernate
  arm64: hibernate: Resume on the CPU that created the hibernate image
  Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is
    offline"

 arch/arm64/Kconfig                 |   5 +-
 arch/arm64/include/asm/Kbuild      |   1 -
 arch/arm64/include/asm/sections.h  |  30 ++++++++
 arch/arm64/include/asm/suspend.h   |   4 ++
 arch/arm64/include/asm/traps.h     |   3 +-
 arch/arm64/include/asm/virt.h      |   5 +-
 arch/arm64/kernel/alternative.c    |   7 +-
 arch/arm64/kernel/head.S           |  10 ++-
 arch/arm64/kernel/hibernate.c      | 137 +++++++++++++++++++++++++++----------
 arch/arm64/kernel/sleep.S          |   2 +
 arch/arm64/kernel/smp_spin_table.c |   2 +-
 arch/arm64/kernel/vmlinux.lds.S    |   8 +++
 arch/arm64/kvm/reset.c             |   3 +-
 arch/arm64/mm/pageattr.c           |  40 ++++++++++-
 arch/arm64/mm/proc.S               |   4 ++
 kernel/power/hibernate.c           |  14 +++-
 16 files changed, 219 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/include/asm/sections.h

-- 
2.8.0.rc3

