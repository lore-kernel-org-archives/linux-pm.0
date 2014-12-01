From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Upstream bug report
Date: Mon, 1 Dec 2014 11:39:38 +0530
Message-ID: <CAOh2x=kmThmz+GnfbWLhnT9xG0w20C2b_jrpX0VGmrfY_umnTA@mail.gmail.com>
References: <54776476.9060603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:57914 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaLAGJk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 01:09:40 -0500
Received: by mail-vc0-f173.google.com with SMTP id im17so4279439vcb.4
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2014 22:09:39 -0800 (PST)
In-Reply-To: <54776476.9060603@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "globesurfer22@gmail.com" <globesurfer22@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

@Dirk: Any clues? Looks like the firmware hasn't provided the freq range here?

On Thu, Nov 27, 2014 at 11:20 PM, globesurfer22@gmail.com
<globesurfer22@gmail.com> wrote:
> [1] One line summary of the problem:
>
> Maximum CPU frequency incorrect and there is no CPU scaling
>
>
>
> [2] Full description of the problem/report:
>
> I have an Acer Aspire 5720 and it is set up to dual boot Vista and ubuntu
> 14.04 LTS. From new the laptop came with an Intel T7300 2.00 Ghz CPU and 1
> GB DDR2 RAM. A few weeks ago I upgraded to 4 GB RAM, which works perfectly,
> and a few days ago I upgraded to an Intel T9300 2.5 Ghz CPU.
>
> The BIOS (up to date), Vista and ubuntu all recognise the CPU correctly as:
>
> "Intel(R) Core(TM)2 Duo CPU T9300 @ 2.50 GHz".
>
> Vista allows the CPU to run correctly at up to 2.5 Ghz and will step the CPU
> speed lower when not needed, depending on which power settings are chosen.
>
> The problem is that ubuntu will only allow the CPU to run at a fixed
> frequency of 2.4 Ghz, which is incorrect as it's a 2.5Ghz CPU, and there is
> no stepping to lower the CPU frequency when max frequency is not needed.
>
> "cpupower frequency-info" in a terminal returns:
>
> analyzing CPU 0:
> driver: acpi-cpufreq
> CPUs which run at the same hardware frequency: 0
> CPUs which need to have their frequency coordinated by software: 0
> maximum transition latency: 10.0 us.
> hardware limits: 2.40 GHz - 2.40 GHz
> available frequency steps: 2.40 GHz, 2.40 GHz
> available cpufreq governors: conservative, ondemand, userspace, powersave,
> performance
> current policy: frequency should be within 2.40 GHz and 2.40 GHz.
> The governor "ondemand" may decide which speed to use
> within this range.
> current CPU frequency is 2.40 GHz.
> cpufreq stats: 2.40 GHz:10.47%, 2.40 GHz:89.53% (12799)
> boost state support:
> Supported: yes
> Active: yes
>
> I have tried using ondemand, performance and powersave - nothing makes any
> difference. I have also installed CPU Frequency Scaling Indicator (which
> shows only 2.4 Ghz and 2.4 Ghz (turbo mode) as available frequencies) and I
> have also tried TLP but nothing makes any difference.
>
> According to this website:
>
> http://www.phoronix.com/scan.php?page=article&item=mobile_penryn&num=3
>
> the T9300 CPU should have the following frequency steps:
>
> 2.50 GHz, 2.00 GHz, 1.60 GHz, 1.20 GHz and 800 MHz.
>
> I have also reproduced this issue on 12.04.3 LTS Precise Pangolin running
> from a USB stick, and also on 14.04 LTS with the latest mainstream kernel.
>
>
>
> [3] Keywords:
>
>
>
> [4] Kernel version (from /proc/version):
>
> Linux version 3.18.0-031800rc6-generic (apw@gomeisa) (gcc version 4.6.3
> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411231935 SMP Mon Nov 24 00:57:52 UTC
> 2014
>
>
>
> [5]
> n/a
>
>
>
> [6]
> n/a
>
>
>
> [7] Environment:
>
> Description:    Ubuntu 14.04.1 LTS
> Release:    14.04
>
>
>
> [7.1.] Software (add the output of the ver_linux script here):
>
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux ulap4 3.18.0-031800rc6-generic #201411231935 SMP Mon Nov 24 00:57:52
> UTC 2014 i686 i686 i686 GNU/Linux
>
> Gnu C                  4.8
> Gnu make               3.81
> binutils               2.24
> util-linux             2.20.1
> mount                  support
> module-init-tools      15
> e2fsprogs              1.42.9
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.19
> Dynamic linker (ldd)   2.19
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.21
> wireless-tools         30
> Modules Loaded         ctr ccm bnep rfcomm bluetooth binfmt_misc ip6t_REJECT
> nf_reject_ipv6 nf_log_ipv6 xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6
> ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit
> snd_hda_codec_realtek xt_tcpudp snd_hda_codec_generic xt_addrtype
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack snd_hda_intel
> snd_hda_controller snd_hda_codec snd_hwdep ip6table_filter snd_pcm
> ip6_tables arc4 snd_seq_midi snd_seq_midi_event nf_conntrack_netbios_ns
> snd_rawmidi uvcvideo iwl3945 snd_seq nf_conntrack_broadcast snd_seq_device
> videobuf2_vmalloc iwlegacy videobuf2_memops snd_timer videobuf2_core
> mac80211 v4l2_common videodev nf_nat_ftp media nf_nat snd cfg80211 r852
> soundcore nf_conntrack_ftp nf_conntrack i915 iptable_filter ip_tables
> sm_common coretemp nand x_tables nand_ecc nand_bch kvm_intel kvm bch r592
> nand_ids drm_kms_helper mtd drm memstick i2c_algo_bit serio_raw lpc_ich
> ir_lirc_codec lirc_dev ir_xmp_decoder ir_sanyo_decoder ir_jvc_decoder
> ir_sharp_decoder ir_mce_kbd_decoder ir_sony_decoder ir_rc6_decoder
> ir_rc5_decoder ir_nec_decoder parport_pc joydev ppdev rc_rc6_mce acer_wmi
> ene_ir sparse_keymap mac_hid rc_core lp parport mxm_wmi wmi video psmouse
> firewire_ohci ahci firewire_core libahci crc_itu_t sdhci_pci tg3 sdhci ptp
> pps_core
>
>
>
> [7.2.] Processor information (from /proc/cpuinfo):
>
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 23
> model name    : Intel(R) Core(TM)2 Duo CPU     T9300  @ 2.50GHz
> stepping    : 6
> cpu MHz        : 2400.000
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 2
> core id        : 0
> cpu cores    : 2
> apicid        : 0
> initial apicid    : 0
> fdiv_bug    : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 10
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc
> arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3
> cx16 xtpr pdcm sse4_1 lahf_lm ida dtherm tpr_shadow vnmi flexpriority
> bugs        :
> bogomips    : 4999.91
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
>
> processor    : 1
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 23
> model name    : Intel(R) Core(TM)2 Duo CPU     T9300  @ 2.50GHz
> stepping    : 6
> cpu MHz        : 2400.000
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 2
> core id        : 1
> cpu cores    : 2
> apicid        : 1
> initial apicid    : 1
> fdiv_bug    : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 10
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc
> arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3
> cx16 xtpr pdcm sse4_1 lahf_lm ida dtherm tpr_shadow vnmi flexpriority
> bugs        :
> bogomips    : 4999.91
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
>
>
>
> [7.3.] Module information (from /proc/modules):
>
> bnep 19107 2 - Live 0x00000000
> rfcomm 59288 0 - Live 0x00000000
> bluetooth 421512 10 bnep,rfcomm, Live 0x00000000
> binfmt_misc 13165 1 - Live 0x00000000
> ip6t_REJECT 12553 1 - Live 0x00000000
> nf_reject_ipv6 13315 1 ip6t_REJECT, Live 0x00000000
> nf_log_ipv6 12682 5 - Live 0x00000000
> snd_hda_codec_realtek 68787 1 - Live 0x00000000
> xt_hl 12465 6 - Live 0x00000000
> snd_hda_codec_generic 63667 2 snd_hda_codec_realtek, Live 0x00000000
> ip6t_rt 13259 3 - Live 0x00000000
> nf_conntrack_ipv6 18458 8 - Live 0x00000000
> nf_defrag_ipv6 26354 1 nf_conntrack_ipv6, Live 0x00000000
> ipt_REJECT 12485 1 - Live 0x00000000
> nf_reject_ipv4 13039 1 ipt_REJECT, Live 0x00000000
> nf_log_ipv4 12715 5 - Live 0x00000000
> nf_log_common 13249 2 nf_log_ipv6,nf_log_ipv4, Live 0x00000000
> xt_LOG 12602 10 - Live 0x00000000
> xt_limit 12541 13 - Live 0x00000000
> xt_tcpudp 12788 18 - Live 0x00000000
> xt_addrtype 12625 4 - Live 0x00000000
> uvcvideo 76687 0 - Live 0x00000000
> nf_conntrack_ipv4 14361 8 - Live 0x00000000
> nf_defrag_ipv4 12649 1 nf_conntrack_ipv4, Live 0x00000000
> videobuf2_vmalloc 13048 1 uvcvideo, Live 0x00000000
> xt_conntrack 12664 16 - Live 0x00000000
> videobuf2_memops 13170 1 videobuf2_vmalloc, Live 0x00000000
> snd_hda_intel 29543 3 - Live 0x00000000
> snd_hda_controller 30930 1 snd_hda_intel, Live 0x00000000
> snd_hda_codec 121018 4
> snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0x00000000
> videobuf2_core 45571 1 uvcvideo, Live 0x00000000
> snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
> ip6table_filter 12711 1 - Live 0x00000000
> v4l2_common 15158 1 videobuf2_core, Live 0x00000000
> snd_pcm 89138 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live
> 0x00000000
> ip6_tables 18136 1 ip6table_filter, Live 0x00000000
> arc4 12509 2 - Live 0x00000000
> snd_seq_midi 13324 0 - Live 0x00000000
> videodev 140643 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x00000000
> snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
> media 21030 2 uvcvideo,videodev, Live 0x00000000
> snd_rawmidi 25786 1 snd_seq_midi, Live 0x00000000
> nf_conntrack_netbios_ns 12585 0 - Live 0x00000000
> iwl3945 64660 0 - Live 0x00000000
> snd_seq 56978 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
> nf_conntrack_broadcast 12541 1 nf_conntrack_netbios_ns, Live 0x00000000
> snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
> nf_nat_ftp 12692 0 - Live 0x00000000
> coretemp 13358 0 - Live 0x00000000
> iwlegacy 88297 1 iwl3945, Live 0x00000000
> snd_timer 29036 2 snd_pcm,snd_seq, Live 0x00000000
> nf_nat 21218 1 nf_nat_ftp, Live 0x00000000
> nf_conntrack_ftp 14117 1 nf_nat_ftp, Live 0x00000000
> mac80211 593840 2 iwl3945,iwlegacy, Live 0x00000000
> snd 67102 16
> snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0x00000000
> kvm_intel 143291 0 - Live 0x00000000
> i915 905336 3 - Live 0x00000000
> nf_conntrack 88172 8
> nf_conntrack_ipv6,nf_conntrack_ipv4,xt_conntrack,nf_conntrack_netbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrack_ftp,
> Live 0x00000000
> soundcore 14635 2 snd_hda_codec,snd, Live 0x00000000
> iptable_filter 12706 1 - Live 0x00000000
> kvm 411210 1 kvm_intel, Live 0x00000000
> r852 17822 0 - Live 0x00000000
> cfg80211 440091 3 iwl3945,iwlegacy,mac80211, Live 0x00000000
> ip_tables 18304 1 iptable_filter, Live 0x00000000
> sm_common 16772 1 r852, Live 0x00000000
> nand 67999 2 r852,sm_common, Live 0x00000000
> x_tables 22103 13
> ip6t_REJECT,xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_limit,xt_tcpudp,xt_addrtype,xt_conntrack,ip6table_filter,ip6_tables,iptable_filter,ip_tables,
> Live 0x00000000
> r592 17829 0 - Live 0x00000000
> drm_kms_helper 87512 1 i915, Live 0x00000000
> nand_ecc 13136 1 nand, Live 0x00000000
> drm 263568 5 i915,drm_kms_helper, Live 0x00000000
> nand_bch 13067 1 nand, Live 0x00000000
> bch 21767 1 nand_bch, Live 0x00000000
> memstick 16176 1 r592, Live 0x00000000
> nand_ids 8547 1 nand, Live 0x00000000
> mtd 53476 2 sm_common,nand, Live 0x00000000
> joydev 17311 0 - Live 0x00000000
> i2c_algo_bit 13316 1 i915, Live 0x00000000
> ir_lirc_codec 12739 0 - Live 0x00000000
> serio_raw 13251 0 - Live 0x00000000
> lpc_ich 17000 0 - Live 0x00000000
> ir_rc5_decoder 12459 0 - Live 0x00000000
> ir_xmp_decoder 12459 0 - Live 0x00000000
> lirc_dev 19354 1 ir_lirc_codec, Live 0x00000000
> ir_sanyo_decoder 12465 0 - Live 0x00000000
> ir_mce_kbd_decoder 12730 0 - Live 0x00000000
> ir_nec_decoder 12459 0 - Live 0x00000000
> ir_rc6_decoder 12459 0 - Live 0x00000000
> ir_sony_decoder 12462 0 - Live 0x00000000
> ir_jvc_decoder 12459 0 - Live 0x00000000
> ir_sharp_decoder 12465 0 - Live 0x00000000
> rc_rc6_mce 12454 0 - Live 0x00000000
> ene_ir 18229 0 - Live 0x00000000
> acer_wmi 19307 0 - Live 0x00000000
> rc_core 26291 14
> ir_lirc_codec,ir_rc5_decoder,ir_xmp_decoder,lirc_dev,ir_sanyo_decoder,ir_mce_kbd_decoder,ir_nec_decoder,ir_rc6_decoder,ir_sony_decoder,ir_jvc_decoder,ir_sharp_decoder,rc_rc6_mce,ene_ir,
> Live 0x00000000
> parport_pc 32154 0 - Live 0x00000000
> sparse_keymap 13658 1 acer_wmi, Live 0x00000000
> ppdev 17423 0 - Live 0x00000000
> mac_hid 13099 0 - Live 0x00000000
> lp 13359 0 - Live 0x00000000
> parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
> mxm_wmi 12893 0 - Live 0x00000000
> wmi 18843 2 acer_wmi,mxm_wmi, Live 0x00000000
> video 19969 2 i915,acer_wmi, Live 0x00000000
> ahci 25756 3 - Live 0x00000000
> firewire_ohci 36248 0 - Live 0x00000000
> psmouse 106553 0 - Live 0x00000000
> tg3 159838 0 - Live 0x00000000
> sdhci_pci 18748 0 - Live 0x00000000
> libahci 31003 1 ahci, Live 0x00000000
> sdhci 38482 1 sdhci_pci, Live 0x00000000
> firewire_core 62418 1 firewire_ohci, Live 0x00000000
> ptp 18938 1 tg3, Live 0x00000000
> crc_itu_t 12627 1 firewire_core, Live 0x00000000
> pps_core 18768 1 ptp, Live 0x00000000
>
>
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
>
> Result of cat /proc/ioports :
>
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>     00f0-00f0 : PNP0C04:00
>   0170-0177 : 0000:00:1f.1
>     0170-0177 : ata_piix
>   01f0-01f7 : 0000:00:1f.1
>     01f0-01f7 : ata_piix
>   0376-0376 : 0000:00:1f.1
>     0376-0376 : ata_piix
>   03c0-03df : vesafb
>   03f6-03f6 : 0000:00:1f.1
>     03f6-03f6 : ata_piix
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0408-040b : ACPI PM_TMR
>   0410-0415 : ACPI CPU throttle
>   0420-0420 : ACPI PM2_CNT_BLK
>   0428-042f : ACPI GPE0_BLK
>   0430-0433 : iTCO_wdt
>   0460-047f : iTCO_wdt
>   0500-053f : 0000:00:1f.0
>     0500-053f : pnp 00:00
>   0600-060f : pnp 00:00
>   0610-0610 : pnp 00:00
>   0800-080f : pnp 00:00
>   0810-0817 : pnp 00:00
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   1000-1fff : PCI Bus 0000:06
>   2000-2fff : PCI Bus 0000:05
>   3000-3fff : PCI Bus 0000:04
>   4000-4fff : PCI Bus 0000:02
>   5000-501f : 0000:00:1f.3
>   5020-503f : 0000:00:1f.2
>     5020-503f : ahci
>   5040-505f : 0000:00:1d.2
>     5040-505f : uhci_hcd
>   5060-507f : 0000:00:1d.1
>     5060-507f : uhci_hcd
>   5080-509f : 0000:00:1d.0
>     5080-509f : uhci_hcd
>   50a0-50bf : 0000:00:1a.1
>     50a0-50bf : uhci_hcd
>   50c0-50df : 0000:00:1a.0
>     50c0-50df : uhci_hcd
>   50e0-50ef : 0000:00:1f.1
>     50e0-50ef : ata_piix
>   50f0-50f7 : 0000:00:1f.2
>     50f0-50f7 : ahci
>   50f8-50ff : 0000:00:1f.2
>     50f8-50ff : ahci
>   5110-5117 : 0000:00:02.0
>   5118-511b : 0000:00:1f.2
>     5118-511b : ahci
>   511c-511f : 0000:00:1f.2
>     511c-511f : ahci
>   ff2c-ff2f : ene_ir
>
>
>
> Result of cat /proc/iomem :
>
> 00000000-00000fff : reserved
> 00001000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
>   000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000cf000-000d09ff : Adapter ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-bf4cffff : System RAM
>   01000000-016d1b62 : Kernel code
>   016d1b63-01a7173f : Kernel data
>   01b61000-01c27fff : Kernel bss
> bf4d0000-bf4dafff : reserved
> bf4db000-bf551fff : System RAM
> bf552000-bf554fff : reserved
> bf555000-bf5bafff : System RAM
> bf5bb000-bf5befff : reserved
> bf5bf000-bf66ffff : System RAM
> bf670000-bf6befff : ACPI Non-volatile Storage
> bf6bf000-bf6fffff : ACPI Tables
> bf700000-bfffffff : reserved
>   bf800000-bff7ffff : Graphics Stolen Memory
> c0000000-febfffff : PCI Bus 0000:00
>   c0000000-cfffffff : 0000:00:02.0
>   d0000000-d0ffffff : PCI Bus 0000:02
>   d1000000-d1ffffff : PCI Bus 0000:04
>   d2000000-d2ffffff : PCI Bus 0000:05
>   d3000000-d3ffffff : PCI Bus 0000:06
>   d4000000-d40fffff : 0000:00:02.0
>   d4100000-d41fffff : PCI Bus 0000:07
>     d4100000-d41007ff : 0000:07:00.0
>       d4100000-d41007ff : firewire_ohci
>     d4100800-d41008ff : 0000:07:00.3
>       d4100800-d41008ff : r852
>     d4100900-d41009ff : 0000:07:00.2
>       d4100900-d41009ff : r592
>     d4100a00-d4100aff : 0000:07:00.1
>       d4100a00-d4100aff : mmc0
>   d4200000-d52fffff : PCI Bus 0000:06
>     d4200000-d4200fff : 0000:06:00.0
>       d4200000-d4200fff : iwl3945
>   d5300000-d63fffff : PCI Bus 0000:05
>     d5300000-d530ffff : 0000:05:00.0
>       d5300000-d530ffff : tg3
>   d6400000-d73fffff : PCI Bus 0000:04
>   d7400000-d83fffff : PCI Bus 0000:02
>   d8400000-d8403fff : 0000:00:1b.0
>     d8400000-d8403fff : ICH HD audio
>   d8404000-d84047ff : 0000:00:1f.2
>     d8404000-d84047ff : ahci
>   d8404800-d8404bff : 0000:00:1d.7
>     d8404800-d8404bff : ehci_hcd
>   d8404c00-d8404fff : 0000:00:1a.7
>     d8404c00-d8404fff : ehci_hcd
>   d8405000-d84050ff : 0000:00:1f.3
>   d8406000-d8406fff : Intel Flush Page
>   d8500000-d85fffff : 0000:00:02.1
>   e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>     e0000000-efffffff : reserved
>       e0000000-efffffff : pnp 00:00
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed14000-fed19fff : reserved
>   fed14000-fed17fff : pnp 00:00
>   fed18000-fed18fff : pnp 00:00
>   fed19000-fed19fff : pnp 00:00
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:00
>     fed1f410-fed1f414 : iTCO_wdt
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
>     fee00000-fee00fff : pnp 00:00
> fff00000-ffffffff : reserved
>   fff00000-ffffffff : INT0800:00
> 100000000-13fffffff : System RAM
>
>
>
> [7.5.] PCI information ('lspci -vvv' as root):
>
> 00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory
> Controller Hub (rev 03)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0a <?>
>     Kernel driver in use: agpgart-intel
>
> 00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960
> Integrated Graphics Controller (primary) (rev 03) (prog-if 00 [VGA
> controller])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 29
>     Region 0: Memory at d4000000 (64-bit, non-prefetchable) [size=1M]
>     Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
>     Region 4: I/O ports at 5110 [size=8]
>     Expansion ROM at <unassigned> [disabled]
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0300c  Data: 41c2
>     Capabilities: [d0] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Bridge: PM- B3+
>     Kernel driver in use: i915
>
> 00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integrated
> Graphics Controller (secondary) (rev 03)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Region 0: Memory at d8500000 (64-bit, non-prefetchable) [size=1M]
>     Capabilities: [d0] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Bridge: PM- B3+
>
> 00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #4 (rev 03) (prog-if 00 [UHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 16
>     Region 4: I/O ports at 50c0 [size=32]
>     Kernel driver in use: uhci_hcd
>
> 00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #5 (rev 03) (prog-if 00 [UHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 21
>     Region 4: I/O ports at 50a0 [size=32]
>     Kernel driver in use: uhci_hcd
>
> 00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
> Controller #2 (rev 03) (prog-if 20 [EHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 18
>     Region 0: Memory at d8404c00 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Kernel driver in use: ehci-pci
>
> 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
> Controller (rev 03)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 31
>     Region 0: Memory at d8400000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0300c  Data: 41e2
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=00
>             Status:    NegoPending- InProgress-
>     Capabilities: [130 v1] Root Complex Link
>         Desc:    PortNumber=0f ComponentID=02 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port
> 1 (rev 03) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>     I/O behind bridge: 00004000-00004fff
>     Memory behind bridge: d7400000-d83fffff
>     Prefetchable memory behind bridge: 00000000d0000000-00000000d0ffffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #0, PowerLimit 6.500W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0300c  Data: 41c1
>     Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011e
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=01 ComponentID=02 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c001
>     Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port
> 2 (rev 03) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>     I/O behind bridge: 00003000-00003fff
>     Memory behind bridge: d6400000-d73fffff
>     Prefetchable memory behind bridge: 00000000d1000000-00000000d1ffffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #1, PowerLimit 6.500W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0300c  Data: 41e1
>     Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011e
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=02 ComponentID=02 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c001
>     Kernel driver in use: pcieport
>
> 00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port
> 3 (rev 03) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: 00002000-00002fff
>     Memory behind bridge: d5300000-d63fffff
>     Prefetchable memory behind bridge: 00000000d2000000-00000000d2ffffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0300c  Data: 4142
>     Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011e
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=03 ComponentID=02 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c001
>     Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port
> 4 (rev 03) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>     I/O behind bridge: 00001000-00001fff
>     Memory behind bridge: d4200000-d52fffff
>     Prefetchable memory behind bridge: 00000000d3000000-00000000d3ffffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
> Surprise+
>             Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0300c  Data: 4162
>     Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011e
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [180 v1] Root Complex Link
>         Desc:    PortNumber=04 ComponentID=02 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c001
>     Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #1 (rev 03) (prog-if 00 [UHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 4: I/O ports at 5080 [size=32]
>     Kernel driver in use: uhci_hcd
>
> 00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #2 (rev 03) (prog-if 00 [UHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 19
>     Region 4: I/O ports at 5060 [size=32]
>     Kernel driver in use: uhci_hcd
>
> 00:1d.2 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #3 (rev 03) (prog-if 00 [UHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 18
>     Region 4: I/O ports at 5040 [size=32]
>     Kernel driver in use: uhci_hcd
>
> 00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
> Controller #1 (rev 03) (prog-if 20 [EHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 0: Memory at d8404800 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Kernel driver in use: ehci-pci
>
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3)
> (prog-if 01 [Subtractive decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: d4100000-d41fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [50] Subsystem: Acer Incorporated [ALI] Device 011e
>
> 00:1f.0 ISA bridge: Intel Corporation 82801HM (ICH8M) LPC Interface
> Controller (rev 03)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: lpc_ich
>
> 00:1f.1 IDE interface: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) IDE
> Controller (rev 03) (prog-if 8a [Master SecP PriP])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 18
>     Region 0: I/O ports at 01f0 [size=8]
>     Region 1: I/O ports at 03f4
>     Region 2: I/O ports at 0170 [size=8]
>     Region 3: I/O ports at 0374
>     Region 4: I/O ports at 50e0 [size=16]
>     Kernel driver in use: ata_piix
>
> 00:1f.2 SATA controller: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) SATA
> Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 28
>     Region 0: I/O ports at 50f8 [size=8]
>     Region 1: I/O ports at 511c [size=4]
>     Region 2: I/O ports at 50f0 [size=8]
>     Region 3: I/O ports at 5118 [size=4]
>     Region 4: I/O ports at 5020 [size=32]
>     Region 5: Memory at d8404000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [80] MSI: Enable+ Count=1/4 Maskable- 64bit-
>         Address: fee0300c  Data: 41a2
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>     Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev
> 03)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin B routed to IRQ 11
>     Region 0: Memory at d8405000 (32-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at 5000 [size=32]
>
> 05:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5787M Gigabit
> Ethernet PCI Express (rev 02)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 32
>     Region 0: Memory at d5300000 (64-bit, non-prefetchable) [size=64K]
>     Expansion ROM at <ignored> [disabled]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [50] Vital Product Data
>         Product Name: Broadcom NetLink Gigabit Ethernet Controller
>         Read-only fields:
>             [PN] Part number: BCM95787m
>             [EC] Engineering changes: 106679-15
>             [SN] Serial number: 0123456789
>             [MN] Manufacture ID: 31 34 65 34
>             [RV] Reserved: checksum good, 29 byte(s) reserved
>         Read/write fields:
>             [YA] Asset tag: XYZ01234567
>             [RW] Read-write area: 107 byte(s) free
>         End
>     Capabilities: [58] Vendor Specific Information: Len=78 <?>
>     Capabilities: [e8] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0300c  Data: 4123
>     Capabilities: [d0] Express (v1) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <4us, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [13c v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [160 v1] Device Serial Number 00-16-d4-ff-fe-d9-69-0d
>     Kernel driver in use: tg3
>
> 06:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG [Golan]
> Network Connection (rev 02)
>     Subsystem: Intel Corporation PRO/Wireless 3945ABG Network Connection
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 30
>     Region 0: Memory at d4200000 (32-bit, non-prefetchable) [size=4K]
>     Capabilities: [c8] Power Management version 2
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0100c  Data: 41d2
>     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1
> unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
> TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <128ns, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>         AERCap:    First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
>     Capabilities: [140 v1] Device Serial Number 00-19-d2-ff-ff-65-f0-08
>     Kernel driver in use: iwl3945
>
> 07:00.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev
> 05) (prog-if 10 [OHCI])
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64 (500ns min, 1000ns max)
>     Interrupt: pin A routed to IRQ 20
>     Region 0: Memory at d4100000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [dc] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME+
>     Kernel driver in use: firewire_ohci
>
> 07:00.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
> Adapter (rev 22)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64
>     Interrupt: pin B routed to IRQ 22
>     Region 0: Memory at d4100a00 (32-bit, non-prefetchable) [size=256]
>     Capabilities: [80] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>     Kernel driver in use: sdhci-pci
>
> 07:00.2 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter
> (rev 12)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64
>     Interrupt: pin B routed to IRQ 22
>     Region 0: Memory at d4100900 (32-bit, non-prefetchable) [size=256]
>     Capabilities: [80] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>     Kernel driver in use: r592
>
> 07:00.3 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 12)
>     Subsystem: Acer Incorporated [ALI] Device 011e
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64
>     Interrupt: pin B routed to IRQ 22
>     Region 0: Memory at d4100800 (32-bit, non-prefetchable) [size=256]
>     Capabilities: [80] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>     Kernel driver in use: r852
>
>
>
> [7.6.] SCSI information (from /proc/scsi/scsi):
>
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: HL-DT-ST Model: DVDRAM GSA-T20N  Rev: WP03
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: Hitachi HTS54161 Rev: C70P
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>
>
>
> [7.7.] Result of ls /proc :
>
> 1     132   1774  1960  2069  2153  2367  26   468  78 acpi         kallsyms
> scsi
> 10    133   18    1962  2070  2168  2372  27   476  79 asound       kcore
> self
> 1038  134   1826  1964  2071  2177  2377  276  48   797 buddyinfo    keys
> slabinfo
> 1073  135   1827  1992  2072  22    24    28   49   8 bus          key-users
> softirqs
> 11    136   1830  2     2073  2207  2437  282  5    80 cgroups      kmsg
> stat
> 1110  137   1839  20    2074  2249  2474  29   50   801 cmdline
> kpagecount    swaps
> 1124  1374  1843  2017  2075  2254  2481  3    51   807 consoles
> kpageflags    sys
> 1166  138   1849  2021  2076  2273  2482  30   517  81 cpuinfo      loadavg
> sysrq-trigger
> 1167  1389  1857  2034  2077  2278  2497  31   52   846 crypto       locks
> sysvipc
> 1180  139   1864  2043  2078  2282  25    32   54   858 devices      mdstat
> thread-self
> 1187  14    1866  2046  2079  2285  2500  33   55   872 diskstats    meminfo
> timer_list
> 12    140   1872  2050  2080  2286  2501  34   56   882 dma          misc
> timer_stats
> 1207  141   1877  2057  2081  2294  2510  346  57   884 driver       modules
> tty
> 1220  15    1885  2061  21    23    2523  35   58   9 execdomains  mounts
> uptime
> 1223  150   1889  2062  2129  2302  2539  36   59   956 fb           mtd
> version
> 1263  151   1893  2063  2133  2307  2562  4    6    962 filesystems  mtrr
> vmallocinfo
> 129   152   19    2064  2135  2314  2565  406  667  964 fs           net
> vmstat
> 13    153   1909  2065  2139  2323  2573  461  668  968 interrupts
> pagetypeinfo  zoneinfo
> 130   16    1913  2066  2143  2329  2590  462  683  974 iomem
> partitions
> 131   17    1919  2067  2147  2335  2598  463  7    975 ioports
> sched_debug
> 1319  1747  1930  2068  2152  2360  2599  464  771  980 irq
> schedstat
>
>
>
> [X.] Other notes, patches, fixes, workarounds:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1396291
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
