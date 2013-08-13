From: Tobiasz 'dotnokato' Jarczyk <dotnokato@prokonto.pl>
Subject: Re: [Hewlett-Packard HP Compaq nx6325 (EY349EA#AKD)] suspend/resume
 failure
Date: Tue, 13 Aug 2013 15:29:47 +0200
Message-ID: <520A34CB.9040809@prokonto.pl>
References: <520A2358.6090804@prokonto.pl> <2413831.lgLFglVszz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moh2-ve2.go2.pl ([193.17.41.200]:38597 "EHLO moh2-ve2.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757955Ab3HMNaC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Aug 2013 09:30:02 -0400
Received: from moh2-ve2.go2.pl (unknown [10.0.0.200])
	by moh2-ve2.go2.pl (Postfix) with ESMTP id 4F0EEB0037E
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2013 15:29:51 +0200 (CEST)
Received: from unknown (unknown [10.0.0.108])
	by moh2-ve2.go2.pl (Postfix) with SMTP
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2013 15:29:51 +0200 (CEST)
In-Reply-To: <2413831.lgLFglVszz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, 1175504@bugs.launchpad.net

Hi,
I have tested it with the most recent kernel (3.11.rc5) and I am still 
experiencing this issue.

$ uname -a
Linux none 3.11.0-031100rc5-generic #201308112135 SMP Mon Aug 12 
01:35:49 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Pozdrawiam / Regards
Tobiasz "dotnokato" Jarczyk

W dniu 13.08.2013 15:32, Rafael J. Wysocki pisze:
> On Tuesday, August 13, 2013 02:15:20 PM Tobiasz 'dotnokato' Jarczyk wrote:
>> [1.] One line summary of the problem:
>> [Hewlett-Packard HP Compaq nx6325 (EY349EA#AKD)] suspend/resume failure
> As it happens I have that machine and suspend/resume works on it for me
> with 3.10.y at least.
>
> Care to test a more recent kernel?
>
> Rafael
>
>
>> [2.] Full description of the problem/report:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1175504
>>
>> Laptop fails to suspend to RAM after being waken up from such a suspend
>> (always hangs during second suspend).
>>
>> To reproduce on my laptop HP Compaq nx6325 EY349EA#AKD:
>> 1. Suspend to RAM.
>> 2. Wake up from suspend.
>> 3. Suspend to RAM again.
>> 4. During this suspend computer hangs - monitor is blank, power light is
>> on, processor becomes very hot so the cooler is on full speed. At this
>> point I have to hard reset it.
>>
>>
>> ProblemType: KernelOops
>> DistroRelease: Ubuntu 13.04
>> Package: linux-image-3.8.0-19-generic 3.8.0-19.29
>> ProcVersionSignature: Ubuntu 3.8.0-19.29-generic 3.8.8
>> Uname: Linux 3.8.0-19-generic x86_64
>> Annotation: This occured during a previous suspend and prevented it from
>> resuming properly.
>> ApportVersion: 2.9.2-0ubuntu8
>> Architecture: amd64
>> AudioDevicesInUse:
>>    USER PID ACCESS COMMAND
>>    /dev/snd/controlC0: dotnokato 1756 F.... pulseaudio
>> Date: Thu May 2 10:11:29 2013
>> ExecutablePath: /usr/share/apport/apportcheckresume
>> Failure: suspend/resume
>> HibernationDevice: RESUME=UUID=ce4acd9b-ecba-4931-baa2-0c2d6409dbf6
>> InstallationDate: Installed on 2012-10-06 (207 days ago)
>> InstallationMedia: Ubuntu 12.10 "Quantal Quetzal" - Beta amd64 (20120926)
>> InterpreterPath: /usr/bin/python3.3
>> Lsusb:
>>    Bus 003 Device 002: ID 08ff:2580 AuthenTec, Inc. AES2501 Fingerprint
>> Sensor
>>    Bus 003 Device 003: ID 04b4:0033 Cypress Semiconductor Corp. Mouse
>>    Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>    Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>>    Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> MachineType: Hewlett-Packard HP Compaq nx6325 (EY349EA#AKD)
>> MarkForUpload: True
>> PccardctlIdent:
>>    Socket 0:
>>      no product info available
>> PccardctlStatus:
>>    Socket 0:
>>      no card
>> ProcCmdline: /usr/bin/python3 /usr/share/apport/apportcheckresume
>> ProcEnviron:
>>    TERM=linux
>>    PATH=(custom, no user)
>> ProcFB: 0 radeondrmfb
>> ProcKernelCmdLine: BOOT_IMAGE=/boot/vmlinuz-3.8.0-19-generic
>> root=UUID=4f0c1391-e243-4e37-aaab-52625df3e3bd ro quiet splash vt.handoff=7
>> PulseList: Error: command ['pacmd', 'list'] failed with exit code 1: No
>> PulseAudio daemon running, or not running as session daemon.
>> RelatedPackageVersions:
>>    linux-restricted-modules-3.8.0-19-generic N/A
>>    linux-backports-modules-3.8.0-19-generic N/A
>>    linux-firmware 1.106
>> SourcePackage: linux
>> Title: [Hewlett-Packard HP Compaq nx6325 (EY349EA#AKD)] suspend/resume
>> failure
>> UpgradeStatus: Upgraded to raring on 2013-03-09 (53 days ago)
>> UserGroups:
>>
>> dmi.bios.date: 05/08/2007
>> dmi.bios.vendor: Hewlett-Packard
>> dmi.bios.version: 68TT2 Ver. F.07
>> dmi.board.name: 30B0
>> dmi.board.vendor: Hewlett-Packard
>> dmi.board.version: KBC Version 40.15
>> dmi.chassis.asset.tag: CNU7110B09
>> dmi.chassis.type: 10
>> dmi.chassis.vendor: Hewlett-Packard
>> dmi.modalias:
>> dmi:bvnHewlett-Packard:bvr68TT2Ver.F.07:bd05/08/2007:svnHewlett-Packard:pnHPCompaqnx6325(EY349EA#AKD):pvrF.07:rvnHewlett-Packard:rn30B0:rvrKBCVersion40.15:cvnHewlett-Packard:ct10:cvr:
>> dmi.product.name: HP Compaq nx6325 (EY349EA#AKD)
>> dmi.product.version: F.07
>> dmi.sys.vendor: Hewlett-Packard
>>
>> [3.] Keywords (i.e., modules, networking, kernel):
>>
>> [4.] Kernel version (from /proc/version):
>> $ cat /proc/version
>> Linux version 3.11.0-031100rc5-generic (apw@gomeisa) (gcc version 4.6.3
>> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201308112135 SMP Mon Aug 12 01:35:49
>> UTC 2013
>>
>> [5.] Output of Oops.. message (if applicable) with symbolic information
>> resolved (see Documentation/oops-tracing.txt)
>>
>> [6.] A small shell script or example program which triggers the problem
>> (if possible)
>>
>> [7.] Environment
>> $ lsb_release -rd
>> Description:    Ubuntu Saucy Salamander (development branch)
>> Release:    13.10
>>
>> [7.1.] Software (add the output of the ver_linux script here)
>> $ sh ver_linux
>> If some fields are empty or look unusual you may have an old version.
>> Compare to the current minimal requirements in Documentation/Changes.
>>
>> Linux none 3.11.0-031100rc5-generic #201308112135 SMP Mon Aug 12
>> 01:35:49 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>>
>> Gnu C                  4.8
>> Gnu make               3.81
>> binutils               2.23.52.20130727
>> util-linux             2.20.1
>> mount                  support
>> module-init-tools      9
>> e2fsprogs              1.42.8
>> pcmciautils            018
>> PPP                    2.4.5
>> Linux C Library        2.17
>> Dynamic linker (ldd)   2.17
>> Procps                 3.3.3
>> Net-tools              1.60
>> Kbd                    1.15.5
>> Sh-utils               8.20
>> wireless-tools         30
>> Modules Loaded         rfcomm bnep bluetooth binfmt_misc hid_generic
>> usbhid hid arc4 joydev hp_wmi radeon sparse_keymap ppdev
>> snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_hwdep kvm_amd
>> tpm_infineon snd_pcm b43 kvm snd_page_alloc ttm snd_seq_midi
>> snd_seq_midi_event drm_kms_helper drm snd_rawmidi psmouse bcma snd_seq
>> mac80211 snd_seq_device i2c_algo_bit pcmcia snd_timer serio_raw snd
>> soundcore cfg80211 edac_core yenta_socket tifm_7xx1 pcmcia_rsrc
>> edac_mce_amd tifm_core k8temp pcmcia_core i2c_piix4 shpchp ssb_hcd
>> ohci_pci lm90 tpm_tis wmi mac_hid lp video parport_pc parport tg3
>> sdhci_pci ptp pps_core sdhci pata_atiixp ssb pata_acpi sata_sil
>>
>> [7.2.] Processor information (from /proc/cpuinfo):
>> $ cat /proc/cpuinfo
>> processor    : 0
>> vendor_id    : AuthenticAMD
>> cpu family    : 15
>> model        : 72
>> model name    : AMD Turion(tm) 64 X2 Mobile Technology TL-52
>> stepping    : 2
>> cpu MHz        : 800.000
>> cache size    : 512 KB
>> physical id    : 0
>> siblings    : 2
>> core id        : 0
>> cpu cores    : 2
>> apicid        : 0
>> initial apicid    : 0
>> fpu        : yes
>> fpu_exception    : yes
>> cpuid level    : 1
>> wp        : yes
>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>> rdtscp lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 lahf_lm
>> cmp_legacy svm extapic cr8_legacy
>> bogomips    : 1596.00
>> TLB size    : 1024 4K pages
>> clflush size    : 64
>> cache_alignment    : 64
>> address sizes    : 40 bits physical, 48 bits virtual
>> power management: ts fid vid ttp tm stc
>>
>> processor    : 1
>> vendor_id    : AuthenticAMD
>> cpu family    : 15
>> model        : 72
>> model name    : AMD Turion(tm) 64 X2 Mobile Technology TL-52
>> stepping    : 2
>> cpu MHz        : 800.000
>> cache size    : 512 KB
>> physical id    : 0
>> siblings    : 2
>> core id        : 1
>> cpu cores    : 2
>> apicid        : 1
>> initial apicid    : 1
>> fpu        : yes
>> fpu_exception    : yes
>> cpuid level    : 1
>> wp        : yes
>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>> rdtscp lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 lahf_lm
>> cmp_legacy svm extapic cr8_legacy
>> bogomips    : 1596.00
>> TLB size    : 1024 4K pages
>> clflush size    : 64
>> cache_alignment    : 64
>> address sizes    : 40 bits physical, 48 bits virtual
>> power management: ts fid vid ttp tm stc
>>
>> [7.3.] Module information (from /proc/modules):
>> $ cat /proc/modules
>> rfcomm 74589 0 - Live 0x0000000000000000
>> bnep 23966 2 - Live 0x0000000000000000
>> bluetooth 391564 10 rfcomm,bnep, Live 0x0000000000000000
>> binfmt_misc 17508 1 - Live 0x0000000000000000
>> hid_generic 12548 0 - Live 0x0000000000000000
>> usbhid 53329 0 - Live 0x0000000000000000
>> hid 105557 2 hid_generic,usbhid, Live 0x0000000000000000
>> arc4 12573 2 - Live 0x0000000000000000
>> joydev 17613 0 - Live 0x0000000000000000
>> hp_wmi 18202 0 - Live 0x0000000000000000
>> radeon 1437967 3 - Live 0x0000000000000000
>> sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
>> ppdev 17711 0 - Live 0x0000000000000000
>> snd_hda_codec_analog 94101 1 - Live 0x0000000000000000
>> snd_hda_intel 53038 2 - Live 0x0000000000000000
>> snd_hda_codec 194727 2 snd_hda_codec_analog,snd_hda_intel, Live
>> 0x0000000000000000
>> snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
>> kvm_amd 60482 0 - Live 0x0000000000000000
>> tpm_infineon 17410 0 - Live 0x0000000000000000
>> snd_pcm 107140 2 snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
>> b43 397252 0 - Live 0x0000000000000000
>> kvm 447883 1 kvm_amd, Live 0x0000000000000000
>> snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
>> ttm 84705 1 radeon, Live 0x0000000000000000
>> snd_seq_midi 13324 0 - Live 0x0000000000000000
>> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
>> drm_kms_helper 53178 1 radeon, Live 0x0000000000000000
>> drm 298236 5 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
>> snd_rawmidi 30416 1 snd_seq_midi, Live 0x0000000000000000
>> psmouse 104015 0 - Live 0x0000000000000000
>> bcma 47065 1 b43, Live 0x0000000000000000
>> snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
>> mac80211 619047 1 b43, Live 0x0000000000000000
>> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
>> 0x0000000000000000
>> i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
>> pcmcia 62188 0 - Live 0x0000000000000000
>> snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
>> serio_raw 13413 0 - Live 0x0000000000000000
>> snd 69657 14
>> snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,Live
>> 0x0000000000000000
>> soundcore 12680 1 snd, Live 0x0000000000000000
>> cfg80211 494624 2 b43,mac80211, Live 0x0000000000000000
>> edac_core 62914 0 - Live 0x0000000000000000
>> yenta_socket 45426 0 - Live 0x0000000000000000
>> tifm_7xx1 13418 0 - Live 0x0000000000000000
>> pcmcia_rsrc 18591 1 yenta_socket, Live 0x0000000000000000
>> edac_mce_amd 22792 0 - Live 0x0000000000000000
>> tifm_core 15624 1 tifm_7xx1, Live 0x0000000000000000
>> k8temp 13064 0 - Live 0x0000000000000000
>> pcmcia_core 23715 3 pcmcia,yenta_socket,pcmcia_rsrc, Live 0x0000000000000000
>> i2c_piix4 22299 0 - Live 0x0000000000000000
>> shpchp 37201 0 - Live 0x0000000000000000
>> ssb_hcd 12909 0 - Live 0x0000000000000000
>> ohci_pci 13561 0 - Live 0x0000000000000000
>> lm90 20371 0 - Live 0x0000000000000000
>> tpm_tis 19255 0 - Live 0x0000000000000000
>> wmi 19256 1 hp_wmi, Live 0x0000000000000000
>> mac_hid 13253 0 - Live 0x0000000000000000
>> lp 17799 0 - Live 0x0000000000000000
>> video 19574 0 - Live 0x0000000000000000
>> parport_pc 32866 1 - Live 0x0000000000000000
>> parport 42466 3 ppdev,lp,parport_pc, Live 0x0000000000000000
>> tg3 170347 0 - Live 0x0000000000000000
>> sdhci_pci 19116 0 - Live 0x0000000000000000
>> ptp 18627 1 tg3, Live 0x0000000000000000
>> pps_core 19027 1 ptp, Live 0x0000000000000000
>> sdhci 43126 1 sdhci_pci, Live 0x0000000000000000
>> pata_atiixp 13242 0 - Live 0x0000000000000000
>> ssb 62890 2 b43,ssb_hcd, Live 0x0000000000000000
>> pata_acpi 13038 0 - Live 0x0000000000000000
>> sata_sil 13550 5 - Live 0x0000000000000000
>>
>> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>> $ cat /proc/ioports
>> 0000-ffff : PCI Bus #00
>>     0000-001f : dma1
>>     0020-0021 : pic1
>>     0040-0043 : timer0
>>     0050-0053 : timer1
>>     0060-0060 : keyboard
>>     0062-0062 : EC data
>>     0064-0064 : keyboard
>>     0066-0066 : EC cmd
>>     0070-0071 : rtc0
>>     0080-008f : dma page reg
>>     00a0-00a1 : pic2
>>     00c0-00df : dma2
>>     00f0-00ff : fpu
>>     0170-0177 : 0000:00:14.1
>>       0170-0177 : pata_atiixp
>>     01f0-01f7 : 0000:00:14.1
>>       01f0-01f7 : pata_atiixp
>>     0376-0376 : 0000:00:14.1
>>       0376-0376 : pata_atiixp
>>     0378-037a : parport0
>>     037b-037f : parport0
>>     03f6-03f6 : 0000:00:14.1
>>       03f6-03f6 : pata_atiixp
>>     040b-040b : pnp 00:09
>>     04d0-04d1 : pnp 00:09
>>     04d6-04d6 : pnp 00:09
>>     0500-051f : pnp 00:09
>>     0c00-0c01 : pnp 00:09
>>     0c14-0c14 : pnp 00:09
>>     0c50-0c51 : pnp 00:09
>>     0c52-0c52 : pnp 00:09
>>     0c6c-0c6c : pnp 00:09
>>     0c6f-0c6f : pnp 00:09
>>     0cd4-0cdf : pnp 00:09
>>     0cf8-0cff : PCI conf1
>>     1000-1fff : PCI Bus 0000:02
>>       1000-10ff : PCI CardBus 0000:03
>>       1400-14ff : PCI CardBus 0000:03
>>     6000-6fff : PCI Bus 0000:01
>>       6000-60ff : 0000:01:05.0
>>     7018-701b : 0000:00:12.0
>>     7020-702f : 0000:00:12.0
>>     7040-704f : 0000:00:14.1
>>       7040-704f : pata_atiixp
>>     8000-8003 : ACPI PM1a_EVT_BLK
>>     8004-8005 : ACPI PM1a_CNT_BLK
>>     8008-800b : ACPI PM_TMR
>>     8010-8015 : ACPI CPU throttle
>>     8020-8027 : ACPI GPE0_BLK
>>     8100-811f : pnp 00:0a
>>       8100-8100 : ACPI PM2_CNT_BLK
>>       8104-8107 : ACPI PM1b_EVT_BLK
>>     8200-820f : 0000:00:14.0
>>       8200-8207 : piix4_smbus
>>     9000-9007 : 0000:00:12.0
>>     9008-900b : 0000:00:12.0
>>     9010-9017 : 0000:00:12.0
>>
>> $ cat /proc/iomem
>> 00000000-00000fff : reserved
>> 00001000-0009fbff : System RAM
>> 0009fc00-0009ffff : reserved
>> 000a0000-000bffff : PCI Bus #00
>> 000c0000-000cffff : Video ROM
>> 000e0000-000fffff : reserved
>>     000f0000-000fffff : System ROM
>> 00100000-77fcffff : System RAM
>>     01000000-01738813 : Kernel code
>>     01738814-01d0e73f : Kernel data
>>     01e70000-01fe2fff : Kernel bss
>> 77fd0000-77fe55ff : reserved
>> 77fe5600-77ff7fff : ACPI Non-volatile Storage
>> 77ff8000-7fffffff : reserved
>>     78000000-7fffffff : pnp 00:0b
>> 80000000-fcffffffff : PCI Bus #00
>>     80000000-83ffffff : PCI Bus 0000:02
>>       80000000-83ffffff : PCI CardBus 0000:03
>>     84000000-8407ffff : 0000:00:12.0
>>     84080000-84083fff : 0000:00:14.2
>>       84080000-84083fff : ICH HD audio
>>     88000000-8bffffff : PCI CardBus 0000:03
>>     c0000000-c7ffffff : PCI Bus 0000:01
>>       c0000000-c7ffffff : 0000:01:05.0
>>     c8000000-c80fffff : PCI Bus 0000:30
>>       c8000000-c8003fff : 0000:30:00.0
>>         c8000000-c8003fff : b43-pci-bridge
>>     d4000000-d42fffff : PCI Bus 0000:02
>>       d4000000-d400ffff : 0000:02:01.0
>>         d4000000-d400ffff : tg3
>>       d4010000-d4010fff : 0000:02:04.0
>>         d4010000-d4010fff : yenta_socket
>>       d4018000-d4018fff : 0000:02:04.2
>>         d4018000-d4018fff : tifm_7xx1
>>       d4019000-d40190ff : 0000:02:04.3
>>         d4019000-d40190ff : mmc0
>>     d4300000-d43fffff : PCI Bus 0000:01
>>       d4300000-d430ffff : 0000:01:05.0
>>       d4320000-d433ffff : 0000:01:05.0
>>     d4401000-d4401fff : 0000:00:13.0
>>       d4401000-d4401fff : ohci_hcd
>>     d4402000-d4402fff : 0000:00:13.1
>>       d4402000-d4402fff : ohci_hcd
>>     d4403000-d4403fff : 0000:00:13.2
>>       d4403000-d4403fff : ehci_hcd
>>     d4404000-d44043ff : 0000:00:14.0
>>     d4409000-d44091ff : 0000:00:12.0
>>       d4409000-d44091ff : sata_sil
>>     e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>>       e0000000-efffffff : reserved
>>         e0000000-efffffff : pnp 00:0a
>>     fec00000-fec01fff : reserved
>>       fec00000-fec003ff : IOAPIC 0
>>     fee00000-fee00fff : Local APIC
>>       fee00000-fee00fff : pnp 00:0b
>>     ffbc0000-ffcbffff : reserved
>>     fff00000-ffffffff : reserved
>>       fff00000-ffffffff : pnp 00:09
>>
>> [7.5.] PCI information ('lspci -vvv' as root)
>> $ sudo lspci -vvv
>> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI]
>> RS480/RS482/RS485 Host Bridge (rev 10)
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>>       Latency: 64
>>
>> 00:01.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RC4xx/RS4xx
>> PCI Bridge [int gfx] (prog-if 00 [Normal decode])
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64
>>       Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>       I/O behind bridge: 00006000-00006fff
>>       Memory behind bridge: d4300000-d43fffff
>>       Prefetchable memory behind bridge: 00000000c0000000-00000000c7ffffff
>>       Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- <SERR- <PERR-
>>       BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>>           PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>       Capabilities: [44] HyperTransport: MSI Mapping Enable+ Fixed+
>>       Capabilities: [b0] Subsystem: Hewlett-Packard Company Device 30b0
>>
>> 00:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RC4xx/RS4xx
>> PCI Express Port 3 (prog-if 00 [Normal decode])
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 0, Cache Line Size: 64 bytes
>>       Bus: primary=00, secondary=30, subordinate=30, sec-latency=0
>>       I/O behind bridge: 0000f000-00000fff
>>       Memory behind bridge: c8000000-c80fffff
>>       Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>>       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- <SERR- <PERR-
>>       BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>>           PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>       Capabilities: [50] Power Management version 3
>>           Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>       Capabilities: [58] Express (v1) Root Port (Slot+), MSI 00
>>           DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
>> <64ns, L1 <1us
>>               ExtTag+ RBE- FLReset-
>>           DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>> Unsupported-
>>               RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>               MaxPayload 128 bytes, MaxReadReq 128 bytes
>>           DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
>> TransPend-
>>           LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1,
>> Latency L0 <64ns, L1 <1us
>>               ClockPM- Surprise- LLActRep- BwNot-
>>           LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>>               ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>           LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
>> DLActive- BWMgmt- ABWMgmt-
>>           SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
>> Surprise-
>>               Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
>>           SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
>> HPIrq- LinkChg-
>>               Control: AttnInd Off, PwrInd Off, Power- Interlock-
>>           SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
>> Interlock-
>>               Changed: MRL- PresDet+ LinkState-
>>           RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
>> CRSVisible-
>>           RootCap: CRSVisible-
>>           RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>       Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>>           Address: 00000000  Data: 0000
>>       Capabilities: [b0] Subsystem: Hewlett-Packard Company Device 30b0
>>       Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
>>       Kernel driver in use: pcieport
>>
>> 00:12.0 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> Serial ATA Controller (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 16
>>       Region 0: I/O ports at 9000 [size=8]
>>       Region 1: I/O ports at 9008 [size=4]
>>       Region 2: I/O ports at 9010 [size=8]
>>       Region 3: I/O ports at 7018 [size=4]
>>       Region 4: I/O ports at 7020 [size=16]
>>       Region 5: Memory at d4409000 (32-bit, non-prefetchable) [size=512]
>>       [virtual] Expansion ROM at 84000000 [disabled] [size=512K]
>>       Capabilities: [60] Power Management version 2
>>           Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>>       Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
>>           Address: 00000000  Data: 0000
>>       Kernel driver in use: sata_sil
>>
>> 00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> USB Host Controller (rev 80) (prog-if 10 [OHCI])
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 19
>>       Region 0: Memory at d4401000 (32-bit, non-prefetchable) [size=4K]
>>       Kernel driver in use: ohci-pci
>>
>> 00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> USB Host Controller (rev 80) (prog-if 10 [OHCI])
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 19
>>       Region 0: Memory at d4402000 (32-bit, non-prefetchable) [size=4K]
>>       Kernel driver in use: ohci-pci
>>
>> 00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> USB2 Host Controller (rev 80) (prog-if 20 [EHCI])
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 19
>>       Region 0: Memory at d4403000 (32-bit, non-prefetchable) [size=4K]
>>       Capabilities: [dc] Power Management version 2
>>           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
>>           Bridge: PM- B3+
>>       Kernel driver in use: ehci-pci
>>
>> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0 SMBus
>> Controller (rev 82)
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Region 0: I/O ports at 8200 [size=16]
>>       Region 1: Memory at d4404000 (32-bit, non-prefetchable) [size=1K]
>>       Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
>>       Kernel driver in use: piix4_smbus
>>
>> 00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> IDE Controller (rev 80) (prog-if 82 [Master PriP])
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 16
>>       Region 0: I/O ports at 01f0 [size=8]
>>       Region 1: I/O ports at 03f4 [size=1]
>>       Region 2: I/O ports at 0170 [size=8]
>>       Region 3: I/O ports at 0374 [size=1]
>>       Region 4: I/O ports at 7040 [size=16]
>>       Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
>>           Address: 00000000  Data: 0000
>>       Kernel driver in use: pata_atiixp
>>
>> 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> High Definition Audio Controller (rev 01)
>>       Subsystem: Device 30b0:103c
>>       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 16
>>       Region 0: Memory at 84080000 (64-bit, non-prefetchable) [size=16K]
>>       Capabilities: [50] Power Management version 2
>>           Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>       Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
>>           Address: 0000000000000000  Data: 0000
>>       Kernel driver in use: snd_hda_intel
>>
>> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> PCI-ISA Bridge (rev 80)
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 0
>>
>> 00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] IXP SB4x0
>> PCI-PCI Bridge (rev 80) (prog-if 01 [Subtractive decode])
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64
>>       Bus: primary=00, secondary=02, subordinate=06, sec-latency=64
>>       I/O behind bridge: 00001000-00001fff
>>       Memory behind bridge: d4000000-d42fffff
>>       Prefetchable memory behind bridge: 80000000-83ffffff
>>       Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>>       BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>>           PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>
>> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8
>> [Athlon64/Opteron] HyperTransport Technology Configuration
>>       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Capabilities: [80] HyperTransport: Host or Secondary Interface
>>           Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave-
>> <EOCErr- DUL-
>>           Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
>> <CRCErr=8 IsocEn- LSEn+ ExtCTL- 64b+
>>           Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit
>> DwFcInEn- LWO=16bit DwFcOutEn-
>>           Revision ID: 1.02
>>           Link Frequency: 800MHz
>>           Link Error: <Prot- <Ovfl- <EOC- CTLTm-
>>           Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz-
>> 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>>           Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
>> ExtRS- UCnfE-
>>
>> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8
>> [Athlon64/Opteron] Address Map
>>       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>
>> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8
>> [Athlon64/Opteron] DRAM Controller
>>       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>
>> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8
>> [Athlon64/Opteron] Miscellaneous Control
>>       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Capabilities: [f0] Secure device <?>
>>       Kernel driver in use: k8temp
>>
>> 01:05.0 VGA compatible controller: Advanced Micro Devices, Inc.
>> [AMD/ATI] RS482M [Mobility Radeon Xpress 200] (prog-if 00 [VGA controller])
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B+ DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64 (2000ns min), Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 17
>>       Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
>>       Region 1: I/O ports at 6000 [size=256]
>>       Region 2: Memory at d4300000 (32-bit, non-prefetchable) [size=64K]
>>       [virtual] Expansion ROM at d4320000 [disabled] [size=128K]
>>       Capabilities: [50] Power Management version 2
>>           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>       Kernel driver in use: radeon
>>
>> 02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788
>> Gigabit Ethernet (rev 03)
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Physical Slot: 1
>>       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64 (16000ns min), Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 23
>>       Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=64K]
>>       Expansion ROM at <ignored> [disabled]
>>       Capabilities: [48] Power Management version 2
>>           Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>       Capabilities: [50] Vital Product Data
>> pcilib: sysfs_read_vpd: read failed: Connection timed out
>>           Not readable
>>       Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
>>           Address: ffefbbddfffaa5f8  Data: 7bf7
>>       Kernel driver in use: tg3
>>
>> 02:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 168, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 20
>>       Region 0: Memory at d4010000 (32-bit, non-prefetchable) [size=4K]
>>       Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>>       Memory window 0: 80000000-83ffffff (prefetchable)
>>       Memory window 1: 88000000-8bffffff
>>       I/O window 0: 00001000-000010ff
>>       I/O window 1: 00001400-000014ff
>>       BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
>>       16-bit legacy interface ports at 0001
>>       Kernel driver in use: yenta_cardbus
>>
>> 02:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia
>> Card Reader (SD/MMC/MS/MS PRO/xD)
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 20
>>       Region 0: Memory at d4018000 (32-bit, non-prefetchable) [size=4K]
>>       Capabilities: [44] Power Management version 2
>>           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>       Kernel driver in use: tifm_7xx1
>>
>> 02:04.3 SD Host controller: Texas Instruments PCIxx12 SDA Standard
>> Compliant SD Host Controller
>>       Subsystem: Hewlett-Packard Company Device 30b0
>>       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 20
>>       Region 0: Memory at d4019000 (32-bit, non-prefetchable) [size=256]
>>       Capabilities: [80] Power Management version 2
>>           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>       Kernel driver in use: sdhci-pci
>>
>> 30:00.0 Network controller: Broadcom Corporation BCM4311 802.11a/b/g
>> (rev 01)
>>       Subsystem: Hewlett-Packard Company Broadcom 802.11a/b/g WLAN
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 0, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 18
>>       Region 0: Memory at c8000000 (32-bit, non-prefetchable) [size=16K]
>>       Capabilities: [40] Power Management version 2
>>           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>>       Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit-
>>           Address: 00000000  Data: 0000
>>       Capabilities: [d0] Express (v1) Legacy Endpoint, MSI 00
>>           DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,
>> L1 unlimited
>>               ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>>           DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>> Unsupported-
>>               RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>               MaxPayload 128 bytes, MaxReadReq 128 bytes
>>           DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
>> TransPend-
>>           LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency
>> L0 <4us, L1 <64us
>>               ClockPM- Surprise- LLActRep- BwNot-
>>           LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>>               ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>           LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
>> DLActive- BWMgmt- ABWMgmt-
>>       Capabilities: [100 v1] Advanced Error Reporting
>>           UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF- MalfTLP- ECRC- UnsupReq-ACSViol-
>>           UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF- MalfTLP- ECRC- UnsupReq-ACSViol-
>>           UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF+ MalfTLP+ ECRC- UnsupReq-ACSViol-
>>           CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>           CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>           AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>>       Capabilities: [13c v1] Virtual Channel
>>           Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>>           Arb:    Fixed- WRR32- WRR64- WRR128-
>>           Ctrl:    ArbSelect=Fixed
>>           Status:    InProgress-
>>           VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>               Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>               Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>>               Status:    NegoPending- InProgress-
>>       Kernel driver in use: b43-pci-bridge
>>
>> [7.6.] SCSI information (from /proc/scsi/scsi)
>> $ cat /proc/scsi/scsi
>> Attached devices:
>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>     Vendor: ATA      Model: FUJITSU MHV2080B Rev: 892C
>>     Type:   Direct-Access                    ANSI  SCSI revision: 05
>> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>>     Vendor: HL-DT-ST Model: DVDRAM GSA-T10N  Rev: PC05
>>     Type:   CD-ROM                           ANSI  SCSI revision: 05
>>
>> [7.7.] Other information that might be relevant to the problem (please
>> look in /proc and include all information that you think to be relevant):
>> $ ls /proc
>> 1     1214  140   1551  1660  19    2130  3    363   6     724 804
>> 931        devices      kallsyms       mounts        sys
>> 10    1217  1400  1576  1665  1900  22    31   37    614   727 807
>> 967        diskstats    kcore          mtrr sysrq-trigger
>> 1000  1218  1404  1592  1675  1962  2248  32   443   680   7280 824
>> 995        dma          key-users      net           sysvipc
>> 1069  1229  141   1612  1678  1970  23    33   469   6862  732 825
>> 998        dri          kmsg           pagetypeinfo  timer_list
>> 1085  1233  142   1618  1679  1977  24    331  48    6977  7367 834
>> acpi       driver       kpagecount     partitions timer_stats
>> 1088  1236  1420  1622  1680  1992  2401  333  4893  6980  7391 881
>> asound     execdomains  kpageflags     sched_debug   tty
>> 11    1237  1422  1630  1681  1994  25    334  5     7     7396 891
>> buddyinfo  fb           latency_stats  schedstat     uptime
>> 110   124   1426  1634  17    2     26    339  51    7007  7411 899
>> bus        filesystems  loadavg        scsi          version
>> 111   125   143   1636  1735  20    269   34   546   707   742 9
>> cgroups    fs           locks          self vmallocinfo
>> 1153  13    1450  1640  1739  2011  27    349  547   71    745 901
>> cmdline    interrupts   mdstat         slabinfo      vmstat
>> 1159  1353  1457  1647  1770  208   274   35   548   7166  752 903
>> consoles   iomem        meminfo        softirqs      zoneinfo
>> 1162  1382  15    1652  18    21    28    36   553   72    799 904
>> cpuinfo    ioports      misc           stat
>> 12    14    1534  1656  1843  2115  29    360  557   722   8 915
>> crypto     irq          modules        swaps
>>
>> [X.] Other notes, patches, fixes, workarounds:
>>
>>

