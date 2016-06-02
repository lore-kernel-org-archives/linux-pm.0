From: James Morse <james.morse@arm.com>
Subject: [PATCH 0/5] arm64: hibernate: Fix DEBUG_PAGEALLOC and hibernate on non-boot cpu
Date: Thu,  2 Jun 2016 15:10:52 +0100
Message-ID: <1464876657-6692-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45210 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126AbcFBOND (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 10:13:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org

Hi all,

These patches improve the hibernate support for v4.8.

Patches 1&2 fix the hibernate problem with DEBUG_PAGEALLOC reported by Will.
This also addresses the outstanding comment from Catalin [0] regarding cleaning
of the whole kernel to the PoC. Now we clean just the sections grouped by
'TEXT_TEXT'.

Patch one adds sections.h to avoid duplicate definitions of
__hyp_idmap_text_start. (it looks like kprobes will duplicate this too [1)

The rest of the patches fix hibernate/resume on any CPU as discussed on the
list[2]. Suzuki's maxcpus improvements mean the CPU we hibernated on may be
offline during boot, and kexec will allow the CPUs logical order to be shuffled.
Log output below[3], suspend happens on cpu0, with mpidr 0x103. For
resume, cpu5 is brought up as it has mpidr 0x103, and cpu0 is taken down.
After resume, /proc/cpuinfo shows only the original cpu0.


[0] http://www.spinics.net/lists/arm-kernel/msg499305.html
[1] http://www.spinics.net/lists/arm-kernel/msg506451.html
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

James Morse (5):
  arm64: Add markers around .text section and create sections.h
  arm64: hibernate: Support DEBUG_PAGEALLOC
  PM / Hibernate: Allow architectures to specify the hibernate/resume
    CPU
  arm64: hibernate: Identify the CPU to resume on by its MPIDR
  Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is
    offline"

 arch/arm64/Kconfig                |   1 -
 arch/arm64/include/asm/Kbuild     |   1 -
 arch/arm64/include/asm/sections.h |  29 ++++++++
 arch/arm64/include/asm/suspend.h  |   1 +
 arch/arm64/include/asm/traps.h    |   3 +-
 arch/arm64/include/asm/virt.h     |   5 +-
 arch/arm64/kernel/alternative.c   |   7 +-
 arch/arm64/kernel/hibernate.c     | 137 ++++++++++++++++++++++++++++----------
 arch/arm64/kernel/vmlinux.lds.S   |   2 +
 arch/arm64/kvm/reset.c            |   3 +-
 arch/arm64/mm/pageattr.c          |  40 ++++++++++-
 kernel/power/hibernate.c          |  16 ++++-
 12 files changed, 191 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm64/include/asm/sections.h

-- 
2.8.0.rc3

