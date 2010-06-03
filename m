From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: How to disable async resume for few selected devices
 (does it work?)
Date: Thu, 03 Jun 2010 04:08:07 +0300
Message-ID: <1275527287.2664.10.camel@maxim-laptop>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I have a card reader on which one function implements SDHCI and other
MMC (to workaround windows bug....)

There is a way to disable MMC function, but is causes the device
sometimes to die on resume from disk/ram.

I today was told that MMC function is in fact _almost_ standard SDHCI
controller, and in fact now sdhci binds to it and works just fine.

However since both devices share same hardware they appear to have need
to be resumed one after another, and definitely not in parallel.
I tried to use device_disable_async_suspend on both pci devices and
indeed both power/async turns to false.

But they are still resumed in parallel:
(look how well mmc0 and mmc1 interleave...)
Why?

(The fact that everything hangs is another bug that is triggered by
removing the card during suspend. That what happens here although I
didn't remove it.)

<7>[  255.812271] Back to C!
<6>[  255.812271] PM: Restoring platform NVS memory
<7>[  255.812271] CPU0: Thermal monitoring handled by SMI
<4>[  255.812271] Enabling non-boot CPUs ...
<4>[  255.831150] lockdep: fixing up alternatives.
<6>[  255.831155] SMP alternatives: switching to SMP code
<6>[  255.836332] Booting Node 0 Processor 1 APIC 0x1
<3>[  256.035141] BUG: using smp_processor_id() in preemptible [00000000] code: pm-suspend/2948
<4>[  256.035151] caller is nr_iowait_cpu+0x15/0x30
<4>[  256.035156] Pid: 2948, comm: pm-suspend Not tainted 2.6.35-rc1+ #44
<4>[  256.035161] Call Trace:
<4>[  256.035169]  [<ffffffff811dbcd2>] debug_smp_processor_id+0xd2/0xf0
<4>[  256.035175]  [<ffffffff81031135>] nr_iowait_cpu+0x15/0x30
<4>[  256.035182]  [<ffffffff8106a34a>] update_ts_time_stats+0x6a/0x90
<4>[  256.035189]  [<ffffffff81064eeb>] ? ktime_get+0x5b/0xe0
<4>[  256.035195]  [<ffffffff8106a53d>] get_cpu_idle_time_us+0x4d/0x70
<4>[  256.035203]  [<ffffffff812cd4eb>] cpufreq_governor_dbs+0x20b/0x4a0
<4>[  256.035210]  [<ffffffff812c993d>] __cpufreq_governor+0xad/0x140
<4>[  256.035216]  [<ffffffff812cadef>] __cpufreq_set_policy+0x13f/0x180
<4>[  256.035223]  [<ffffffff812cb0fa>] cpufreq_add_dev_interface+0x2ca/0x320
<4>[  256.035230]  [<ffffffff812cbae0>] ? handle_update+0x0/0x10
<4>[  256.035237]  [<ffffffff812cb88d>] cpufreq_add_dev+0x39d/0x4d0
<4>[  256.035244]  [<ffffffff8139e24b>] cpufreq_cpu_callback+0x6c/0x7a
<4>[  256.035251]  [<ffffffff810612f1>] notifier_call_chain+0x51/0x80
<4>[  256.035257]  [<ffffffff810613a9>] __raw_notifier_call_chain+0x9/0x10
<4>[  256.035264]  [<ffffffff8104327b>] __cpu_notify+0x1b/0x30
<4>[  256.035269]  [<ffffffff8139c4f7>] _cpu_up+0xd1/0x118
<4>[  256.035276]  [<ffffffff8138ec35>] enable_nonboot_cpus+0x95/0xc0
<4>[  256.035283]  [<ffffffff8107d6ac>] suspend_devices_and_enter+0x19c/0x220
<4>[  256.035290]  [<ffffffff8107d85a>] enter_state+0x12a/0x150
<4>[  256.035295]  [<ffffffff8107ce61>] state_store+0x91/0x100
<4>[  256.035301]  [<ffffffff811cd9d7>] kobj_attr_store+0x17/0x20
<4>[  256.035308]  [<ffffffff81144e02>] sysfs_write_file+0xf2/0x170
<4>[  256.035316]  [<ffffffff810dce78>] vfs_write+0xb8/0x170
<4>[  256.035322]  [<ffffffff813a1c2a>] ? lockdep_sys_exit_thunk+0x35/0x67
<4>[  256.035328]  [<ffffffff810dd00c>] sys_write+0x4c/0x80
<4>[  256.035335]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
<4>[  256.042551] CPU1 is up
<6>[  256.045410] ACPI: Waking up from system sleep state S3
<7>[  256.055713] uhci_hcd 0000:00:1a.0: restoring config space at offset 0x1 (was 0x2800005, writing 0x2800001)
<7>[  256.055817] uhci_hcd 0000:00:1a.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2800001)
<7>[  256.055939] ehci_hcd 0000:00:1a.7: restoring config space at offset 0x1 (was 0x2900006, writing 0x2900002)
<7>[  256.056037] HDA Intel 0000:00:1b.0: restoring config space at offset 0xf (was 0x100, writing 0x10b)
<7>[  256.056109] HDA Intel 0000:00:1b.0: restoring config space at offset 0x1 (was 0x100006, writing 0x100002)
<7>[  256.056204] pcieport 0000:00:1c.0: restoring config space at offset 0xf (was 0x100, writing 0x10b)
<7>[  256.056244] pcieport 0000:00:1c.0: restoring config space at offset 0x9 (was 0x10001, writing 0x93f19301)
<7>[  256.056264] pcieport 0000:00:1c.0: restoring config space at offset 0x8 (was 0x0, writing 0x9b209a30)
<7>[  256.056284] pcieport 0000:00:1c.0: restoring config space at offset 0x7 (was 0x20000000, writing 0x20004040)
<7>[  256.056325] pcieport 0000:00:1c.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
<7>[  256.056464] pcieport 0000:00:1c.1: restoring config space at offset 0xf (was 0x200, writing 0x20b)
<7>[  256.056504] pcieport 0000:00:1c.1: restoring config space at offset 0x9 (was 0x10001, writing 0x94f19401)
<7>[  256.056524] pcieport 0000:00:1c.1: restoring config space at offset 0x8 (was 0x0, writing 0x9a209930)
<7>[  256.056544] pcieport 0000:00:1c.1: restoring config space at offset 0x7 (was 0x20000000, writing 0x20003030)
<7>[  256.056584] pcieport 0000:00:1c.1: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
<7>[  256.056723] pcieport 0000:00:1c.2: restoring config space at offset 0xf (was 0x300, writing 0x30b)
<7>[  256.056763] pcieport 0000:00:1c.2: restoring config space at offset 0x9 (was 0x10001, writing 0x95f19501)
<7>[  256.056783] pcieport 0000:00:1c.2: restoring config space at offset 0x8 (was 0x0, writing 0x99209820)
<7>[  256.056803] pcieport 0000:00:1c.2: restoring config space at offset 0x7 (was 0x0, writing 0x2020)
<7>[  256.056843] pcieport 0000:00:1c.2: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
<7>[  256.056982] pcieport 0000:00:1c.3: restoring config space at offset 0xf (was 0x400, writing 0x40b)
<7>[  256.057022] pcieport 0000:00:1c.3: restoring config space at offset 0x9 (was 0x10001, writing 0x96f19601)
<7>[  256.057042] pcieport 0000:00:1c.3: restoring config space at offset 0x8 (was 0x0, writing 0x98109710)
<7>[  256.057062] pcieport 0000:00:1c.3: restoring config space at offset 0x7 (was 0x20000000, writing 0x20001010)
<7>[  256.057102] pcieport 0000:00:1c.3: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
<7>[  256.057272] uhci_hcd 0000:00:1d.0: restoring config space at offset 0x1 (was 0x2800005, writing 0x2800001)
<7>[  256.057373] uhci_hcd 0000:00:1d.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2800001)
<7>[  256.057475] uhci_hcd 0000:00:1d.2: restoring config space at offset 0x1 (was 0x2800005, writing 0x2800001)
<7>[  256.057596] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x1 (was 0x2900006, writing 0x2900002)
<7>[  256.057699] pci 0000:00:1e.0: restoring config space at offset 0x9 (was 0x10001, writing 0x1fff1)
<7>[  256.057719] pci 0000:00:1e.0: restoring config space at offset 0x8 (was 0x0, writing 0x97009700)
<7>[  256.057738] pci 0000:00:1e.0: restoring config space at offset 0x7 (was 0x22800000, writing 0x28000f0)
<7>[  256.057778] pci 0000:00:1e.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100007)
<7>[  256.058001] ata_piix 0000:00:1f.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2880005)
<7>[  256.058124] ahci 0000:00:1f.2: restoring config space at offset 0x1 (was 0x2b00007, writing 0x2b00407)
<6>[  256.059100] nouveau 0000:01:00.0: power state changed by ACPI to D0
<6>[  256.070098] nouveau 0000:01:00.0: BAR 0: set to [mem 0x92000000-0x92ffffff] (PCI address [0x92000000-0x92ffffff]
<6>[  256.070138] nouveau 0000:01:00.0: BAR 1: set to [mem 0x80000000-0x8fffffff 64bit pref] (PCI address [0x80000000-0x8fffffff]
<6>[  256.070178] nouveau 0000:01:00.0: BAR 3: set to [mem 0x90000000-0x91ffffff 64bit] (PCI address [0x90000000-0x91ffffff]
<6>[  256.070205] nouveau 0000:01:00.0: BAR 5: set to [io  0x5000-0x507f] (PCI address [0x5000-0x507f]
<6>[  256.070414] nouveau 0000:01:00.0: power state changed by ACPI to D0
<7>[  256.070589] nouveau 0000:01:00.0: restoring config space at offset 0x1 (was 0x100003, writing 0x100007)
<7>[  256.090259] tg3 0000:05:00.0: restoring config space at offset 0xc (was 0x0, writing 0xa44c0000)
<7>[  256.090630] iwl3945 0000:06:00.0: restoring config space at offset 0xf (was 0x100, writing 0x10b)
<7>[  256.090738] iwl3945 0000:06:00.0: restoring config space at offset 0x4 (was 0x0, writing 0x97100000)
<7>[  256.090781] iwl3945 0000:06:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100406)
<7>[  256.091135] sdhci-pci 0000:07:00.1: restoring config space at offset 0x3 (was 0x800000, writing 0x804000)
<7>[  256.091256] sdhci-pci 0000:07:00.2: restoring config space at offset 0x3 (was 0x800000, writing 0x804000)
<7>[  256.091484] r852 0000:07:00.4: restoring config space at offset 0x3 (was 0x800000, writing 0x804000)
<6>[  256.091577] PM: early resume of devices complete after 36.194 msecs
<6>[  256.096083] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>[  256.096107] uhci_hcd 0000:00:1a.0: setting latency timer to 64
<6>[  256.096132] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
<4>[  256.096154] usb usb3: root hub lost power or was reset
<7>[  256.096160] uhci_hcd 0000:00:1a.1: setting latency timer to 64
<4>[  256.096206] usb usb4: root hub lost power or was reset
<6>[  256.096297] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
<7>[  256.096319] ehci_hcd 0000:00:1a.7: setting latency timer to 64
<6>[  256.096384] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
<7>[  256.096407] HDA Intel 0000:00:1b.0: setting latency timer to 64
<7>[  256.096548] HDA Intel 0000:00:1b.0: irq 46 for MSI/MSI-X
<6>[  256.097189] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
<7>[  256.097212] uhci_hcd 0000:00:1d.0: setting latency timer to 64
<4>[  256.097261] usb usb5: root hub lost power or was reset
<6>[  256.097389] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
<7>[  256.097411] uhci_hcd 0000:00:1d.1: setting latency timer to 64
<4>[  256.097456] usb usb6: root hub lost power or was reset
<6>[  256.097580] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
<7>[  256.097603] uhci_hcd 0000:00:1d.2: setting latency timer to 64
<4>[  256.097647] usb usb7: root hub lost power or was reset
<6>[  256.097710] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
<7>[  256.097732] ehci_hcd 0000:00:1d.7: setting latency timer to 64
<7>[  256.098816] pci 0000:00:1e.0: setting latency timer to 64
<6>[  256.098889] ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
<7>[  256.098908] ata_piix 0000:00:1f.1: setting latency timer to 64
<7>[  256.099007] ahci 0000:00:1f.2: setting latency timer to 64
<6>[  256.099147] [drm] nouveau 0000:01:00.0: We're back, enabling device...
<6>[  256.099351] nouveau 0000:01:00.0: power state changed by ACPI to D0
<6>[  256.100143] nouveau 0000:01:00.0: power state changed by ACPI to D0
<6>[  256.100353] nouveau 0000:01:00.0: power state changed by ACPI to D0
<6>[  256.100482] pcieport 0000:00:1c.2: wake-up capability disabled by ACPI
<7>[  256.100507] tg3 0000:05:00.0: PME# disabled
<6>[  256.100550] nouveau 0000:01:00.0: power state changed by ACPI to D0
<6>[  256.100588] nouveau 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>[  256.100611] nouveau 0000:01:00.0: setting latency timer to 64
<6>[  256.100625] [drm] nouveau 0000:01:00.0: POSTing device...
<6>[  256.100643] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 0 at offset 0xCDB0
<5>[  256.112961] sd 0:0:0:0: [sda] Starting disk
<6>[  256.182746] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 1 at offset 0xD127
<6>[  256.264491] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 2 at offset 0xDD68
<6>[  256.264540] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 3 at offset 0xDE5A
<6>[  256.284204] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 4 at offset 0xE054
<6>[  256.284214] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table at offset 0xE0B9
<6>[  256.312577] [drm] nouveau 0000:01:00.0: 0xB736: parsing output script 0
<6>[  256.312587] [drm] nouveau 0000:01:00.0: 0xB8AC: parsing output script 0
<6>[  256.312594] [drm] nouveau 0000:01:00.0: 0xAF1C: parsing output script 0
<6>[  256.312620] [drm] nouveau 0000:01:00.0: Reinitialising engines...
<6>[  256.316452] [drm] nouveau 0000:01:00.0: Restoring GPU objects...
<6>[  256.337332] sdhci-pci 0000:07:00.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
<4>[  256.337343] sdhci-pci 0000:07:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
<6>[  256.338448] sdhci-pci 0000:07:00.2: PCI INT B -> GSI 22 (level, low) -> IRQ 22
<7>[  256.338516] mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
<7>[  256.340090] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
<7>[  256.351060] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
<7>[  256.360176] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>[  256.370069] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
<7>[  256.370086] mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
<7>[  256.371106] mmc1: starting CMD0 arg 00000000 flags 000000c0
<6>[  256.377566] [drm] nouveau 0000:01:00.0: Restoring mode...
<7>[  256.380119] mmc0: starting CMD52 arg 00000c00 flags 00000195
<7>[  256.382191] mmc0: req done (CMD52): -123: 00000000 00000000 00000000 00000000
<7>[  256.382228] mmc0: starting CMD52 arg 80000c08 flags 00000195
<7>[  256.384270] mmc0: req done (CMD52): -123: 00000000 00000000 00000000 00000000
<7>[  256.384305] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
<7>[  256.385338] mmc0: starting CMD0 arg 00000000 flags 000000c0
<7>[  256.387399] mmc0: req done (CMD0): -123: 00000000 00000000 00000000 00000000
<6>[  256.387430] [drm] nouveau 0000:01:00.0: 0xB73A: parsing output script 1
<6>[  256.387459] [drm] nouveau 0000:01:00.0: 0xB59B: parsing clock script 0
<7>[  256.388443] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>[  256.389452] mmc0: starting CMD8 arg 000001aa flags 000002f5
<6>[  256.390138] usb 2-4: reset high speed USB device using ehci_hcd and address 2
<7>[  256.391478] mmc0: req done (CMD8): -123: 00000000 00000000 00000000 00000000
<7>[  256.391490] mmc0: starting CMD5 arg 00000000 flags 000002e1
<7>[  256.393530] mmc0: req failed (CMD5): -123, retrying...
<7>[  256.395562] mmc0: req failed (CMD5): -123, retrying...
<7>[  256.397578] mmc0: req failed (CMD5): -123, retrying...
<7>[  256.399593] mmc0: req done (CMD5): -123: 00000000 00000000 00000000 00000000
<7>[  256.399632] mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>[  256.401684] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
<7>[  256.401725] mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>[  256.403763] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
<7>[  256.403793] mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>[  256.405817] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
<7>[  256.405851] mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>[  256.407874] mmc0: req done (CMD55): -123: 00000000 00000000 00000000 00000000
<7>[  256.407908] mmc0: starting CMD1 arg 00000000 flags 000000e1
<7>[  256.409931] mmc0: req done (CMD1): -123: 00000000 00000000 00000000 00000000
<7>[  256.409966] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
<6>[  256.410341] [drm] nouveau 0000:01:00.0: 0xB6F9: parsing clock script 1
<6>[  256.442731] ata3: SATA link down (SStatus 0 SControl 300)
<6>[  256.590509] ata4.00: configured for UDMA/33
<6>[  256.632732] ata2: SATA link down (SStatus 0 SControl 300)
<6>[  258.032708] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<6>[  258.035402] ata1.00: configured for UDMA/100
<3>[  266.400290] mmc1: Timeout waiting for hardware interrupt.
<7>[  266.400299] sdhci: ============== REGISTER DUMP ==============
<7>[  266.400310] sdhci: Sys addr: 0x00000000 | Version:  0x00000401
<7>[  266.400320] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
<7>[  266.400330] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
<7>[  266.400340] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
<7>[  266.400350] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
<7>[  266.400360] sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
<7>[  266.400369] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
<7>[  266.400379] sdhci: Int enab: 0x00f00002 | Sig enab: 0x00ff0003
<7>[  266.400389] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
<7>[  266.400398] sdhci: Caps:     0x00000000 | Max curr: 0x00000000
<7>[  266.400405] sdhci: ===========================================
<7>[  266.402432] mmc1: req done (CMD0): -110: 00000000 00000000 00000000 00000000
<7>[  266.403482] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
<7>[  266.404500] mmc1: starting CMD1 arg 40300000 flags 000000e1
<3>[  276.420146] mmc1: Timeout waiting for hardware interrupt.
<7>[  276.420156] sdhci: ============== REGISTER DUMP ==============
<7>[  276.420167] sdhci: Sys addr: 0x00000000 | Version:  0x00000401
<7>[  276.420177] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
<7>[  276.420187] sdhci: Argument: 0x40300000 | Trn mode: 0x00000000
<7>[  276.420197] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
<7>[  276.420207] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
<7>[  276.420217] sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
<7>[  276.420226] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
<7>[  276.420236] sdhci: Int enab: 0x00f00002 | Sig enab: 0x00ff0003
<7>[  276.420246] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
<7>[  276.420255] sdhci: Caps:     0x00000000 | Max curr: 0x00000000
<7>[  276.420262] sdhci: ===========================================
<7>[  276.422289] mmc1: req done (CMD1): -110: 00000000 00000000 00000000 00000000
<4>[  276.422337] mmc1: error -110 during resume (card was removed?)
<6>[  276.422615] mmc1: card 0001 removed
<3>[  482.650336] INFO: task pm-suspend:2948 blocked for more than 120 seconds.
<3>[  482.650345] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>[  482.650356] pm-suspend    D 0000000000000000     0  2948   2941 0x00000000
<4>[  482.650370]  ffff88004631b938 0000000000000046 ffff88004e080000 00000000001d27c0
<4>[  482.650385]  ffff88004631bfd8 ffff88004e080000 00000000001d27c0 0000000000004000
<4>[  482.650398]  ffff88004631bfd8 00000000001d27c0 ffff88006f762280 ffff88004e080000
<4>[  482.650412] Call Trace:
<4>[  482.650428]  [<ffffffff813a2a63>] ? _raw_spin_unlock_irqrestore+0x33/0x60
<4>[  482.650443]  [<ffffffff810fda70>] ? bdi_sched_wait+0x0/0x10
<4>[  482.650454]  [<ffffffff810fda79>] bdi_sched_wait+0x9/0x10
<4>[  482.650464]  [<ffffffff8139f8d7>] __wait_on_bit+0x57/0x80
<4>[  482.650477]  [<ffffffff8103e0a9>] ? try_to_wake_up+0x289/0x3d0
<4>[  482.650488]  [<ffffffff810fda70>] ? bdi_sched_wait+0x0/0x10
<4>[  482.650498]  [<ffffffff8139f973>] out_of_line_wait_on_bit+0x73/0x90
<4>[  482.650510]  [<ffffffff8105bcc0>] ? wake_bit_function+0x0/0x40
<4>[  482.650521]  [<ffffffff810fd9be>] ? bdi_queue_work+0x9e/0xd0
<4>[  482.650532]  [<ffffffff810fdecf>] bdi_alloc_queue_work+0xcf/0xe0
<4>[  482.650543]  [<ffffffff810fdf2a>] bdi_start_writeback+0x4a/0x50
<4>[  482.650554]  [<ffffffff813a0bfb>] ? down_read+0x6b/0xa0
<4>[  482.650565]  [<ffffffff810fdf7a>] writeback_inodes_sb_locked+0x4a/0x50
<4>[  482.650575]  [<ffffffff81102939>] __sync_filesystem+0x49/0x90
<4>[  482.650586]  [<ffffffff81102a32>] sync_filesystem+0x32/0x60
<4>[  482.650596]  [<ffffffff8110c8f9>] fsync_bdev+0x29/0x60
<4>[  482.650607]  [<ffffffff811c3749>] invalidate_partition+0x29/0x50
<4>[  482.650619]  [<ffffffff8113fadf>] del_gendisk+0x3f/0x160
<4>[  482.650643]  [<ffffffffa01ec1fe>] mmc_blk_remove+0x2e/0x60 [mmc_block]
<4>[  482.650662]  [<ffffffffa01681f2>] mmc_bus_remove+0x12/0x20 [mmc_core]
<4>[  482.650674]  [<ffffffff8126c6d0>] __device_release_driver+0x70/0xe0
<4>[  482.650685]  [<ffffffff8126c83a>] device_release_driver+0x2a/0x40
<4>[  482.650695]  [<ffffffff8126ba01>] bus_remove_device+0xb1/0x130
<4>[  482.650706]  [<ffffffff81269657>] device_del+0x127/0x1d0
<4>[  482.650722]  [<ffffffffa01682db>] mmc_remove_card+0x5b/0xb0 [mmc_core]
<4>[  482.650741]  [<ffffffffa0168ab2>] mmc_remove+0x22/0x40 [mmc_core]
<4>[  482.650758]  [<ffffffffa0167678>] mmc_resume_host+0x118/0x150 [mmc_core]
<4>[  482.650773]  [<ffffffffa01fbf36>] sdhci_resume_host+0x76/0xb0 [sdhci]
<4>[  482.650787]  [<ffffffffa02553c6>] sdhci_pci_resume+0x86/0xb0 [sdhci_pci]
<4>[  482.650800]  [<ffffffff811edfbd>] pci_legacy_resume+0x3d/0x60
<4>[  482.650810]  [<ffffffff811ee1a0>] pci_pm_resume+0x80/0xb0
<4>[  482.650821]  [<ffffffff81271e6b>] pm_op+0xfb/0x1c0
<4>[  482.650830]  [<ffffffff81272473>] device_resume+0x83/0x1c0
<4>[  482.650840]  [<ffffffff81272e44>] dpm_resume_end+0x114/0x410
<4>[  482.650853]  [<ffffffff8107d5c0>] suspend_devices_and_enter+0xb0/0x220
<4>[  482.650864]  [<ffffffff8107d85a>] enter_state+0x12a/0x150
<4>[  482.650874]  [<ffffffff8107ce61>] state_store+0x91/0x100
<4>[  482.650885]  [<ffffffff811cd9d7>] kobj_attr_store+0x17/0x20
<4>[  482.650895]  [<ffffffff81144e02>] sysfs_write_file+0xf2/0x170
<4>[  482.650907]  [<ffffffff810dce78>] vfs_write+0xb8/0x170
<4>[  482.650918]  [<ffffffff813a1c2a>] ? lockdep_sys_exit_thunk+0x35/0x67
<4>[  482.650929]  [<ffffffff810dd00c>] sys_write+0x4c/0x80
<4>[  482.650941]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
<4>[  482.650951] 6 locks held by pm-suspend/2948:
<4>[  482.650957]  #0:  (&buffer->mutex){......}, at: [<ffffffff81144d4f>] sysfs_write_file+0x3f/0x170
<4>[  482.650975]  #1:  (s_active#89){......}, at: [<ffffffff81144de9>] sysfs_write_file+0xd9/0x170
<4>[  482.650993]  #2:  (pm_mutex){......}, at: [<ffffffff8107d77c>] enter_state+0x4c/0x150
<4>[  482.651008]  #3:  (&__lockdep_no_validate__){......}, at: [<ffffffff8127242a>] device_resume+0x3a/0x1c0
<4>[  482.651025]  #4:  (&__lockdep_no_validate__){......}, at: [<ffffffff8126c832>] device_release_driver+0x22/0x40
<4>[  482.651042]  #5:  (&type->s_umount_key#30){......}, at: [<ffffffff810dedae>] get_super+0x9e/0xd0
<0>[  482.651061] Kernel panic - not syncing: hung_task: blocked tasks
<4>[  482.651072] Pid: 376, comm: khungtaskd Not tainted 2.6.35-rc1+ #44
<4>[  482.651079] Call Trace:
<4>[  482.651088]  [<ffffffff8139e3c7>] panic+0x90/0x10a
<4>[  482.651098]  [<ffffffff810930e9>] watchdog+0x2a9/0x2e0
<4>[  482.651107]  [<ffffffff81092ead>] ? watchdog+0x6d/0x2e0
<4>[  482.651118]  [<ffffffff813a2a63>] ? _raw_spin_unlock_irqrestore+0x33/0x60
<4>[  482.651128]  [<ffffffff81092e40>] ? watchdog+0x0/0x2e0
<4>[  482.651138]  [<ffffffff8105b7fe>] kthread+0xae/0xc0
<4>[  482.651150]  [<ffffffff81003b94>] kernel_thread_helper+0x4/0x10
<4>[  482.651161]  [<ffffffff8105b750>] ? kthread+0x0/0xc0
<4>[  482.651171]  [<ffffffff81003b90>] ? kernel_thread_helper+0x0/0x10
<3>[  482.651368] [drm:drm_fb_helper_panic] *ERROR* panic occurred, switching back to text console
<0>[  482.655692] Rebooting in 10 seconds..
