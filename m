From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 17:51:52 +0200
Message-ID: <CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
	<4187911.uaFVupaTVL@vostro.rjw.lan>
	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>
	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
	<1459352017.13525.45.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34110 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbcC3Pvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 11:51:54 -0400
In-Reply-To: <1459352017.13525.45.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

2016-03-30 17:33 GMT+02:00 Pandruvada, Srinivas <srinivas.pandruvada@in=
tel.com>:
> On Wed, 2016-03-30 at 13:05 +0200, Rafael J. Wysocki wrote:
>> On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte@gmail.com=
>
>> wrote:
>> >
>> > 2016-03-29 23:34 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > >
>> > > On Tuesday, March 29, 2016 07:32:27 PM J=C3=B6rg Otte wrote:
>> > > >
>> > > > 2016-03-29 19:24 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>=
:
>> > > > >
>> > > > > in v4.5 and earlier intel-pstate downscaled idle processors
>> > > > > (load
>> > > > > 0.1-0.2%) to minumum frequency, in my case 800MHz.
>> > > > >
>> > > > > Now in v4.6-rc1 the characteristic has dramatically changed.
>> > > > > If in
>> > > > > idle the processor frequency is more or less a few MHz aroun=
d
>> > > > > 2500Mhz.
>> > > > > This is the maximum non turbo frequency.
>> > > > >
>> > > > > No difference between powersafe or performance governor.
>> > > > >
>> > > > > I currently use acpi_cpufreq which works as usual.
>> > > > >
>> > > > > Processor:
>> > > > > Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz (family: 0x6, model=
:
>> > > > > 0x3c,
>> > > > > stepping: 0x3)
>> > > > >
>> > > > > Last known good kernel is: 4.5.0-01127-g9256d5a
>> > > > > First known bad kernel is: 4.5.0-02535-g09fd671
>> > > > >
>> > > > > There is
>> > > > > commit 277edba Merge tag 'pm+acpi-4.6-rc1-1' of
>> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m
>> > > > > in between, which brought a few changes in intel_pstate.
>> > > Can you please check commit a4675fbc4a7a (cpufreq: intel_pstate:
>> > > Replace timers
>> > > with utilization update callbacks)?
>> > >
>> > Yes , this solved the problem for me.
>> > I had to resolve some conflicts myself when reverting that
>> > commit. Hard work :).
>> Thanks for doing this.  Can you please post the revert patch you hav=
e
>> used?
>>
>> >
>> > Here is a 10-seconds trace of the used frequencies when
>> > in "desktop-idle":
>> >
>> > driver          cpu0 cpu1 cpu2 cpu3
>> > -------------------------------------
>> > intel_pstate (  800  928  941 1200) MHz   load:( 0.2)%
>> > intel_pstate (  800  928 1181 1800) MHz   load:( 0.0)%
>> > intel_pstate ( 1675 1576 1347  800) MHz   load:( 0.0)%
>> > intel_pstate ( 1198 1576  842  800) MHz   load:( 0.5)%
>> > intel_pstate (  800 1181 1113 1600) MHz   load:( 0.0)%
>> > intel_pstate (  808 1181  805  800) MHz   load:( 0.5)%
>> > intel_pstate (  844 1191  900 1082) MHz   load:( 0.3)%
>> > intel_pstate (  816 1191  800  800) MHz   load:( 0.0)%
>> > intel_pstate (  800  905  892 1082) MHz   load:( 0.2)%
>> > intel_pstate (  945  905 1340  800) MHz   load:( 0.3)%
>> Please also run turbostat with and without your revert patch applied=
=2E
> I want to reproduce this if I can. Can you give us info about your
> setup (Linux distribution, laptop model etc.)?
>
> Thanks,
> Srinivas

Distro: Ubuntu 14.04.4 LTS
Laptop: FUJITSU LIFEBOOK A544

lspci:
=3D=3D=3D=3D=3D=3D=3D
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor DRAM Controller (rev 06)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor PCI Express x16 Controller (rev 06)
00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
Processor Integrated Graphics Controller (rev 06)
00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller (rev 06)
00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
=46amily USB xHCI (rev 04)
00:16.0 Communication controller: Intel Corporation 8 Series/C220
Series Chipset Family MEI Controller #1 (rev 04)
00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
=46amily PCI Express Root Port #1 (rev d4)
00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
=46amily PCI Express Root Port #3 (rev d4)
00:1c.5 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
=46amily PCI Express Root Port #6 (rev d4)
00:1f.0 ISA bridge: Intel Corporation HM86 Express LPC Controller (rev =
04)
00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller (rev 04)
00:1f.6 Signal processing controller: Intel Corporation 8 Series
Chipset Family Thermal Management Controller (rev 04)
03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

lshw:
=3D=3D=3D=3D=3D=3D=3D=3D
    description: Notebook
    product: LIFEBOOK A544 ()
    vendor: FUJITSU
    serial: YLUA094704
    width: 64 bits
    capabilities: smbios-2.7 dmi-2.7
    configuration: administrator_password=3Ddisabled boot=3Dnormal
chassis=3Dnotebook frontpanel_password=3Ddisabled
keyboard_password=3Ddisabled power-on_password=3Ddisabled
uuid=3DF4FC89BC-8701-1230-8B14-E01877C1801D
  *-core
       description: Motherboard
       product: FJNBB35
       vendor: FUJITSU
       physical id: 0
       serial: 651583-01R4712766
     *-cpu
          description: CPU
          product: Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
          vendor: Intel Corp.
          physical id: 0
          bus info: cpu@0
          version: Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
          serial: To Be Filled By O.E.M.
          slot: On Board
          size: 2500MHz
          capacity: 2500MHz
          width: 64 bits
          clock: 100MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr
pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx
fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp constant_tsc
arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf
eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg
fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer
aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority
ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
dtherm ida arat pln pts cpufreq
          configuration: cores=3D2 enabledcores=3D2 threads=3D4
        *-cache:0
             description: L1 cache
             physical id: 2
             slot: L1-Cache
             size: 32KiB
             capacity: 32KiB
             capabilities: asynchronous internal write-back instruction
        *-cache:1
             description: L2 cache
             physical id: 3
             slot: L2-Cache
             size: 256KiB
             capacity: 256KiB
             capabilities: asynchronous internal write-back unified
        *-cache:2
             description: L3 cache
             physical id: 4
             slot: L3-Cache
             size: 3MiB
             capacity: 3MiB
             capabilities: asynchronous internal write-back unified
     *-cache
          description: L1 cache
          physical id: 1
          slot: L1-Cache
          size: 32KiB
          capacity: 32KiB
          capabilities: asynchronous internal write-back data
     *-memory
          description: System Memory
          physical id: 5
          slot: System board or motherboard
          size: 8GiB
        *-bank:0
             description: SODIMM DDR3 Synchronous 1600 MHz (0,6 ns)
             product: M471B1G73DB0-YK0
             vendor: Samsung
             physical id: 0
             serial: 57641925
             slot: ChannelA-DIMM0
             size: 8GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
        *-bank:1
             description: DIMM [empty]
             physical id: 1
             slot: ChannelA-DIMM1
        *-bank:2
             description: DIMM [empty]
             physical id: 2
             slot: ChannelB-DIMM0
        *-bank:3
             description: DIMM [empty]
             physical id: 3
             slot: ChannelB-DIMM1
     *-firmware
          description: BIOS
          vendor: FUJITSU // Phoenix Technologies Ltd.
          physical id: 25
          version: Version 1.17
          date: 05/09/2014
          size: 128KiB
          capacity: 4032KiB
          capabilities: pci pcmcia pnp upgrade shadowing cdboot
bootselect acpi usb biosbootspecification netboot
     *-pci
          description: Host bridge
          product: Xeon E3-1200 v3/4th Gen Core Processor DRAM Controll=
er
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 06
          width: 32 bits
          clock: 33MHz
        *-pci:0
             description: PCI bridge
             product: Xeon E3-1200 v3/4th Gen Core Processor PCI
Express x16 Controller
             vendor: Intel Corporation
             physical id: 1
             bus info: pci@0000:00:01.0
             version: 06
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm msi pciexpress normal_decode
bus_master cap_list
             configuration: driver=3Dpcieport
             resources: irq:16
        *-display
             description: VGA compatible controller
             product: 4th Gen Core Processor Integrated Graphics Contro=
ller
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 06
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm vga_controller bus_master cap_list ro=
m
             configuration: driver=3Di915 latency=3D0
             resources: irq:24 memory:f0000000-f03fffff
memory:e0000000-efffffff ioport:4000(size=3D64) memory:c0000-dffff
        *-multimedia:0 UNCLAIMED
             description: Audio device
             product: Xeon E3-1200 v3/4th Gen Core Processor HD Audio C=
ontroller
             vendor: Intel Corporation
             physical id: 3
             bus info: pci@0000:00:03.0
             version: 06
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: latency=3D0
             resources: memory:f0710000-f0713fff
        *-usb
             description: USB controller
             product: 8 Series/C220 Series Chipset Family USB xHCI
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=3Dxhci_hcd latency=3D0
             resources: irq:28 memory:f0700000-f070ffff
        *-communication UNCLAIMED
             description: Communication controller
             product: 8 Series/C220 Series Chipset Family MEI Controlle=
r #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: latency=3D0
             resources: memory:f0719000-f071900f
        *-multimedia:1 UNCLAIMED
             description: Audio device
             product: 8 Series/C220 Series Chipset High Definition
Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: latency=3D0
             resources: memory:f0714000-f0717fff
        *-pci:1
             description: PCI bridge
             product: 8 Series/C220 Series Chipset Family PCI Express
Root Port #1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: d4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode
bus_master cap_list
             configuration: driver=3Dpcieport
             resources: irq:16
        *-pci:2
             description: PCI bridge
             product: 8 Series/C220 Series Chipset Family PCI Express
Root Port #3
             vendor: Intel Corporation
             physical id: 1c.2
             bus info: pci@0000:00:1c.2
             version: d4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode
bus_master cap_list
             configuration: driver=3Dpcieport
             resources: irq:18 memory:f0600000-f06fffff
           *-network DISABLED
                description: Ethernet interface
                product: Wireless 7260
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:03:00.0
                logical name: wlan0
                version: 73
                serial: 80:19:34:4d:31:40
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
ethernet physical
                configuration: broadcast=3Dyes driver=3Diwlwifi
driverversion=3D4.5.0-reva4675fbc4a7a-02536-g77 firmware=3D16.242414.0
latency=3D0 link=3Dno multicast=3Dyes
                resources: irq:27 memory:f0600000-f0601fff
        *-pci:3
             description: PCI bridge
             product: 8 Series/C220 Series Chipset Family PCI Express
Root Port #6
             vendor: Intel Corporation
             physical id: 1c.5
             bus info: pci@0000:00:1c.5
             version: d4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode
bus_master cap_list
             configuration: driver=3Dpcieport
             resources: irq:17 ioport:3000(size=3D4096)
memory:f0500000-f05fffff ioport:f0400000(size=3D1048576)
           *-network
                description: Ethernet interface
                product: RTL8111/8168/8411 PCI Express Gigabit
Ethernet Controller
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:04:00.0
                logical name: eth0
                version: 07
                serial: e0:18:77:c1:80:1d
                size: 1Gbit/s
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress msix vpd bus_master
cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt
1000bt-fd autonegotiation
                configuration: autonegotiation=3Don broadcast=3Dyes
driver=3Dr8169 driverversion=3D2.3LK-NAPI duplex=3Dfull
firmware=3Drtl8168e-3_0.0.4 03/27/12 ip=3D192.168.0.18 latency=3D0 link=
=3Dyes
multicast=3Dyes port=3DMII speed=3D1Gbit/s
                resources: irq:26 ioport:3000(size=3D256)
memory:f0500000-f0500fff memory:f0400000-f0403fff
        *-isa
             description: ISA bridge
             product: HM86 Express LPC Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: latency=3D0
        *-storage
             description: SATA controller
             product: 8 Series/C220 Series Chipset Family 6-port SATA
Controller 1 [AHCI mode]
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 04
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm ahci_1.0 bus_master cap_list
             configuration: driver=3Dahci latency=3D0
             resources: irq:25 ioport:4088(size=3D8) ioport:4094(size=3D=
4)
ioport:4080(size=3D8) ioport:4090(size=3D4) ioport:4060(size=3D32)
memory:f071c000-f071c7ff
        *-serial UNCLAIMED
             description: SMBus
             product: 8 Series/C220 Series Chipset Family SMBus Control=
ler
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 04
             width: 64 bits
             clock: 33MHz
             configuration: latency=3D0
             resources: memory:f0718000-f07180ff ioport:efa0(size=3D32)
        *-generic UNCLAIMED
             description: Signal processing controller
             product: 8 Series Chipset Family Thermal Management Contro=
ller
             vendor: Intel Corporation
             physical id: 1f.6
             bus info: pci@0000:00:1f.6
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: latency=3D0
             resources: memory:f071b000-f071bfff
     *-scsi:0
          physical id: 2
          bus info: usb@2:1
          logical name: scsi6
          capabilities: emulated scsi-host
          configuration: driver=3Dusb-storage
        *-disk
             description: SCSI Disk
             product: ASM1153E
             vendor: asmedia
             physical id: 0.0.0
             bus info: scsi@6:0.0.0
             logical name: /dev/sda
             version: 0
             serial: 2109876543210
             size: 698GiB (750GB)
             capabilities: partitioned partitioned:dos
             configuration: ansiversion=3D6 sectorsize=3D4096 signature=
=3D000a8c30
           *-volume
                description: EXT4 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@6:0.0.0,1
                logical name: /dev/sda1
                logical name: /media/jojo/deftoshiba
                version: 1.0
                serial: b5dcbf60-26b0-42b5-af73-ce0cb2f8dbcb
                size: 698GiB
                capacity: 698GiB
                capabilities: primary journaled extended_attributes
large_files huge_files dir_nlink recover extents ext4 ext2 initialized
                configuration: created=3D2016-03-07 17:41:49
filesystem=3Dext4 label=3Ddeftoshiba lastmountpoint=3D/media/jojo/defto=
shiba
modified=3D2016-03-30 17:05:24 mount.fstype=3Dext4
mount.options=3Drw,nosuid,nodev,relatime,data=3Dordered mounted=3D2016-=
03-30
17:05:24 state=3Dmounted
     *-scsi:1
          physical id: 3
          logical name: scsi2
          capabilities: emulated
        *-cdrom
             description: DVD-RAM writer
             product: CDDVDW SU-208CB
             vendor: TSSTcorp
             physical id: 0.0.0
             bus info: scsi@2:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/sr0
             version: FU01
             capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
             configuration: ansiversion=3D5 status=3Dnodisc
     *-scsi:2
          physical id: 4
          logical name: scsi4
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: ST500LM000-1EJ16
             vendor: Seagate
             physical id: 0.0.0
             bus info: scsi@4:0.0.0
             logical name: /dev/sdb
             version: FJ14
             serial: W761H3BD
             size: 465GiB (500GB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=3D5
guid=3Da08a4503-fae4-4a5b-b677-5c66cbbff634 sectorsize=3D4096
           *-volume:0
                description: Windows FAT volume
                vendor: mkfs.fat
                physical id: 1
                bus info: scsi@4:0.0.0,1
                logical name: /dev/sdb1
                logical name: /boot/efi
                version: FAT32
                serial: 8b74-4e15
                size: 510MiB
                capacity: 511MiB
                capabilities: boot fat initialized
                configuration: FATs=3D2 filesystem=3Dfat mount.fstype=3D=
vfat
mount.options=3Drw,relatime,fmask=3D0022,dmask=3D0022,codepage=3D437,io=
charset=3Diso8859-1,shortname=3Dmixed,errors=3Dremount-ro
state=3Dmounted
           *-volume:1
                description: EXT4 volume
                vendor: Linux
                physical id: 2
                bus info: scsi@4:0.0.0,2
                logical name: /dev/sdb2
                logical name: /
                version: 1.0
                serial: 17ed5f3c-77aa-4dbe-992b-88c943eb9c4e
                size: 457GiB
                capabilities: journaled extended_attributes
large_files huge_files dir_nlink recover extents ext4 ext2 initialized
                configuration: created=3D2015-10-22 11:13:27
filesystem=3Dext4 lastmountpoint=3D/ modified=3D2016-03-30 17:04:26
mount.fstype=3Dext4
mount.options=3Drw,relatime,errors=3Dremount-ro,data=3Dordered
mounted=3D2016-03-30 17:04:26 state=3Dmounted
           *-volume:2
                description: Linux swap volume
                vendor: Linux
                physical id: 3
                bus info: scsi@4:0.0.0,3
                logical name: /dev/sdb3
                version: 1
                serial: 8c1aad5c-b153-46db-884b-d0d38ba2f9ee
                size: 8097MiB
                capacity: 8098MiB
                capabilities: nofs swap initialized
                configuration: filesystem=3Dswap pagesize=3D4095
  *-battery
       description: Lithium Ion Battery
       product: CP671396-01
       vendor: FUJITSU
       physical id: 1
       version: 2014/ 7/14
       serial: 01A-Z140714001338Z
       slot: Internal Battery
       capacity: 48600mWh
       configuration: voltage=3D10,8V
