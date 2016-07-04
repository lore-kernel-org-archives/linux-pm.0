From: James Morse <james.morse@arm.com>
Subject: [PATCH v4 0/3] PM / Hibernate: Allow arch code to influence CPUs disabled during hibernate
Date: Mon,  4 Jul 2016 15:52:27 +0100
Message-ID: <1467643950-11034-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48262 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbcGDOzG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Jul 2016 10:55:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Chen Yu C <yu.c.chen@intel.com>

Hi all,

This series is a break-up/continuation of [v3]. These patches allow arm64 to
hibernate on any CPU saving the cpu-id in the arch header, then switch to it
during resume by hooking disable_nonboot_cpus(). Today we forbid
hibernate if CPU0 has been offlined but this is futile if we booted via
kexec, as this may have occured with CPU0 offline. The first sign something
has gone wrong is a hang during resume.

With this series applied I can offline CPU0, kexec, hibernate and then
resume[3], the implementation is as discussed on the list[2].

Patch one should be usable for Chen Yu's hlt/mwait problem too [1].

This series is aimed at the PM tree, is based on v4.7-rc6, and can be
retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/cpuN/v4

Changes since v3:
 * Split series, at the PM/Hibernate patch, merged arm64 patches to remove
   dependencies.
 * Changed Kconfig symbol name.
 * Fixed logic error '<= 0' when testing for an unrecognised CPU.

Changes since v2:
 * Split wrong-CPU logic into an earlier patch that just returns an error.
 * Changed core code patch to use macros instead of a weak function.
   CONFIG_ARCH_HIBERNATION_HEADER now implies an asm/suspend.h header.
 * Wording in error messages 'hibernate' not 'suspend'.

Changes since v1:
 * Fixed 'Brining' typo.


[v1] http://www.spinics.net/lists/arm-kernel/msg507805.html
[v2] http://permalink.gmane.org/gmane.linux.power-management.general/77467
[v3] http://www.spinics.net/lists/arm-kernel/msg514644.html

[0] http://www.spinics.net/lists/arm-kernel/msg499305.html
[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1176775.html
[2] http://www.spinics.net/lists/arm-kernel/msg499036.html
[3] offline cpu0, kexec, hibernate, resume
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

James Morse (3):
  PM / Hibernate: Allow arch code to influence CPUs disabled during
    hibernate
  arm64: hibernate: Resume when hibernate image created on non-boot CPU
  Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is
    offline"

 arch/arm64/Kconfig               |  4 ++
 arch/arm64/include/asm/suspend.h |  4 ++
 arch/arm64/kernel/hibernate.c    | 86 ++++++++++++++++++++++++++++++----------
 kernel/power/hibernate.c         | 14 +++++--
 4 files changed, 84 insertions(+), 24 deletions(-)

-- 
2.8.0.rc3

