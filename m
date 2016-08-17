From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 0/3] arm64: hibernate: Resume when hibernate image created on non-boot CPU
Date: Wed, 17 Aug 2016 13:50:24 +0100
Message-ID: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

These patches allow arm64 to hibernate on any CPU saving the cpu-id in the
arch header, then switch to it during resume using
hibernate_resume_nonboot_cpu_disable().

I hoped to avoid patch 1 by duplicating the logic in the arch code, but
Lorenzo pointed out using cpu_down() indicates that tasks are not frozen,
whereas in reality they are. [0]
Patch 1 lets us specify which cpu disable_nonboot_cpus() should leave
standing.

(All three patches need to be merged together, this series doesn't conflict
 with [1].)

Comments welcome,

This series is based on v4.8-rc2 and can be retrieved from:
git://linux-arm.org/linux-jm.git hibernate/cpuN/v5

Changes since v4:
 * Added freeze_secondary_cpus().
 * Wired up hibernate_resume_nonboot_cpu_disable(), removing macros and
   kconfig symbols from previous approaches.
 * Added check for sleep_cpu being uninitialised when we come to save the
   arch header.

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
[v2] https://www.spinics.net/lists/arm-kernel/msg511654.html
[v3] https://www.spinics.net/lists/arm-kernel/msg514644.html
[v4] https://www.spinics.net/lists/arm-kernel/msg515978.html

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/441305.html
[1] https://www.spinics.net/lists/arm-kernel/msg523933.html
[2] hotplug cpu0, kexec, hibernate, resume
-------------------------%<-------------------------
root@ubuntu:~# echo disk > /sys/power/state
[   76.768682] PM: Syncing filesystems ... done.
[   76.774872] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   76.783253] Double checking all user space processes after OOM killer disable
... (elapsed 0.000 seconds)
[   76.794214] PM: Preallocating image memory... done (allocated 84746 pages)
[   80.454878] PM: Allocated 338984 kbytes in 3.65 seconds (92.87 MB/s)
[   80.461269] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   80.491476] PM: freeze of devices complete after 21.037 msecs
[   80.498053] PM: late freeze of devices complete after 0.789 msecs
[   80.505563] PM: noirq freeze of devices complete after 1.387 msecs
[   80.511777] Disabling non-boot CPUs ...
[   80.540044] CPU1: shutdown
[   80.542755] psci: CPU1 killed.
[   80.611931] CPU2: shutdown
[   80.614646] psci: CPU2 killed.
[   80.687816] IRQ11 no longer affine to CPU3
[   80.687831] IRQ20 no longer affine to CPU3
[   80.687872] CPU3: shutdown
[   80.698806] psci: CPU3 killed.
[   80.725600] PM: Creating hibernation image:
[   80.725600] PM: Need to copy 84054 pages
[   80.725600] PM: Hibernation image created (84054 pages copied)
[   80.725609] Enabling non-boot CPUs ...
[   80.758320] Detected VIPT I-cache on CPU1
[   80.758381] CPU1: Booted secondary processor [410fd033]
[   80.758946] CPU1 is up
[   80.810889] Detected VIPT I-cache on CPU2
[   80.810932] CPU2: Booted secondary processor [410fd033]
[   80.811598] CPU2 is up
[   80.863596] Detected VIPT I-cache on CPU3
[   80.863640] CPU3: Booted secondary processor [410fd033]
[   80.864256] CPU3 is up
[   80.876712] PM: noirq thaw of devices complete after 0.802 msecs
[   80.883475] PM: early thaw of devices complete after 0.699 msecs
[   80.947177] PM: thaw of devices complete after 57.665 msecs
[   80.953222] hibernate: Hibernating on CPU 0 [mpidr:0x101]
[   80.961099] PM: Using 3 thread(s) for compression.
[   80.961099] PM: Compressing and saving image data (84219 pages)...
[   80.972154] PM: Image saving progress:   0%
[   81.270381] PM: Image saving progress:  10%
[   81.498242] PM: Image saving progress:  20%
[   81.789014] PM: Image saving progress:  30%
[   84.844984] PM: Image saving progress:  40%
[   87.657013] PM: Image saving progress:  50%
[   88.933987] PM: Image saving progress:  60%
[   90.597472] PM: Image saving progress:  70%
[   92.362916] PM: Image saving progress:  80%
[   93.622648] PM: Image saving progress:  90%
[   95.468855] PM: Image saving progress: 100%
[   99.073785] PM: Image saving done.
[   99.077240] PM: Wrote 336876 kbytes in 18.10 seconds (18.61 MB/s)
[   99.092099] PM: S|
[   99.370393] kvm: exiting hardware virtualization
[   99.535936] reboot: Restarting system

[ ... ]

[    6.074235] Freezing user space processes ... (elapsed 0.000 seconds) done.
[    6.081540] Double checking all user space processes after OOM killer disable
... (elapsed 0.000 seconds)
[    6.119415] random: fast init done
[    6.133638] PM: Using 1 thread(s) for decompression.
[    6.133638] PM: Loading and decompressing image data (84219 pages)...
[    6.145079] hibernate: Hibernated on CPU 1 [mpidr:0x101]
[    6.150412] hibernate: Hibernated on a CPU that is offline! Bringing CPU up.
[    6.198971] Detected VIPT I-cache on CPU1
[    6.199036] CPU1: Booted secondary processor [410fd033]
[    7.177507] PM: Image loading progress:   0%
[    7.816126] PM: Image loading progress:  10%
[    8.176005] PM: Image loading progress:  20%
[    8.568329] PM: Image loading progress:  30%
[    8.991993] PM: Image loading progress:  40%
[    9.385313] PM: Image loading progress:  50%
[    9.708479] PM: Image loading progress:  60%
[   10.082700] PM: Image loading progress:  70%
[   10.478748] PM: Image loading progress:  80%
[   10.876730] PM: Image loading progress:  90%
[   11.275249] PM: Image loading progress: 100%
[   11.280021] PM: Image loading done.
[   11.283534] PM: Read 336876 kbytes in 5.13 seconds (65.66 MB/s)
[   11.316174] PM: quiesce of devices complete after 19.385 msecs
[   11.322864] PM: late quiesce of devices complete after 0.825 msecs
[   11.349479] PM: noirq quiesce of devices complete after 20.401 msecs
[   11.355864] Disabling non-boot CPUs ...
[   11.372531] IRQ7 no longer affine to CPU0
[   11.372537] IRQ9 no longer affine to CPU0
[   11.372544] IRQ11 no longer affine to CPU0
[   11.372559] IRQ20 no longer affine to CPU0
[   11.372595] CPU0: shutdown
[   11.391601] psci: CPU0 killed.
[   80.725613] Enabling non-boot CPUs ...
[   80.758314] Detected VIPT I-cache on CPU1
[   80.758375] CPU1: Booted secondary processor [410fd033]
[   80.758939] CPU1 is up
[   80.810877] Detected VIPT I-cache on CPU2
[   80.810917] CPU2: Booted secondary processor [410fd033]
[   80.811581] CPU2 is up
[   80.859588] Detected VIPT I-cache on CPU3
[   80.859628] CPU3: Booted secondary processor [410fd033]
[   80.860246] CPU3 is up
[   80.873337] PM: noirq restore of devices complete after 1.434 msecs
[   80.880381] PM: early restore of devices complete after 0.701 msecs
[   81.231471] PM: restore of devices complete after 71.157 msecs
[   81.238336] Restarting tasks ... done.
root@ubuntu:~#
-------------------------%<-------------------------

James Morse (3):
  cpu/hotplug: Allow suspend/resume CPU to be specified
  arm64: hibernate: Resume when hibernate image created on non-boot CPU
  Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is
    offline"

 arch/arm64/include/asm/suspend.h |  3 ++
 arch/arm64/kernel/hibernate.c    | 67 +++++++++++++++++++++++++++-------------
 include/linux/cpu.h              |  6 +++-
 kernel/cpu.c                     |  9 +++---
 4 files changed, 59 insertions(+), 26 deletions(-)

-- 
2.8.0.rc3
