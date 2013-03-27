From: Kelly Hyde <polarimetric@gmail.com>
Subject: Re: PROBLEM: [Apple Inc. MacBookPro8,2] suspend/resume failure
Date: Wed, 27 Mar 2013 15:31:11 -0400
Message-ID: <1364412671.3816.2.camel@polarimetric-MacBookPro>
References: <1364410601.4713.3.camel@polarimetric-MacBookPro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48252 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab3C0TbM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 15:31:12 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so10854561ieb.31
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 12:31:11 -0700 (PDT)
In-Reply-To: <1364410601.4713.3.camel@polarimetric-MacBookPro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

After a little more testing, I've just determined the cause of the
problem: Resuming from suspend fails when a FireWire drive is plugged in
with mounted partitions at the time of suspend and then is
unplugged/otherwise disconnected while the computer is suspended. If the
FireWire drive is disconnected before the computer resumes, resuming
from suspend fails 100% of the time.

On Wed, 2013-03-27 at 14:56 -0400, Kelly Hyde wrote:
> [Apple Inc. MacBookPro8,2] suspend/resume failure
> 
> Resume is failing unpredictably. When it fails, attempting to resume
> from suspend results in a black screen with a frozen terminal cursor.
> Apport reports that the issue occurred during a previous suspend and
> prevented the system from resuming. There are no apparent errors in
> pm-suspend.log. When resume fails, I can drop to TTY and it asks me for
> my login name, but putting it in results in no further output (it never
> asks for password). This began occurring on 3.8.2 (Ubuntu's 3.8.0-12),
> appeared fixed on 3.8.3 (Ubuntu's 3.8.0-13), and recurred on 3.8.4
> (Ubuntu's 3.8.0-14). I also observed this bug in the latest mainline
> kernel 3.9-rc4.
> Link to Launchpad bug report:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1154242
> 
> Kernel version: Linux version 3.9.0-030900rc4-generic (apw@gomeisa) (gcc
> version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201303232035 SMP Sun Mar
> 24 00:36:21 UTC 2013
> 
> Environment: Ubuntu Raring Ringtail (development branch)
> Release:	13.04
> 
> Software:
> 
> Linux polarimetric-MacBookPro 3.9.0-030900rc4-generic #201303232035 SMP
> Sun Mar 24 00:36:21 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>  
> Gnu C                  4.7
> Gnu make               3.81
> binutils               2.23.1
> util-linux             2.20.1
> mount                  support
> module-init-tools      9
> e2fsprogs              1.42.5
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.17
> Dynamic linker (ldd)   2.17
> Procps                 3.3.3
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.20
> wireless-tools         30
> Modules Loaded         nls_utf8 hfsplus parport_pc ppdev rfcomm bnep
> binfmt_misc nls_iso8859_1 uvcvideo arc4 videobuf2_vmalloc coretemp
> kvm_intel videobuf2_memops videobuf2_core kvm videodev btusb i915
> ghash_clmulni_intel bcm5974 bluetooth aesni_intel aes_x86_64 b43 xts
> snd_hda_codec_cirrus lrw snd_hda_intel gf128mul ablk_helper cryptd
> snd_hda_codec snd_hwdep hid_generic mac80211 snd_pcm cfg80211
> snd_page_alloc ssb snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> drm_kms_helper drm mei apple_gmux snd_seq_device joydev snd_timer snd
> soundcore i2c_algo_bit lpc_ich mac_hid applesmc bcma apple_bl
> input_polldev microcode video lp parport firewire_sbp2 hid_apple usbhid
> hid tg3 firewire_ohci ptp ahci sdhci_pci firewire_core pps_core sdhci
> libahci crc_itu_t
> 
> Processor information:
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 0
> cpu cores	: 4
> apicid		: 0
> initial apicid	: 0
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 1
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 1
> cpu cores	: 4
> apicid		: 2
> initial apicid	: 2
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 2
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 2
> cpu cores	: 4
> apicid		: 4
> initial apicid	: 4
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 3
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 3
> cpu cores	: 4
> apicid		: 6
> initial apicid	: 6
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 4
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 0
> cpu cores	: 4
> apicid		: 1
> initial apicid	: 1
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 5
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 1
> cpu cores	: 4
> apicid		: 3
> initial apicid	: 3
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 6
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 2
> cpu cores	: 4
> apicid		: 5
> initial apicid	: 5
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> processor	: 7
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz
> stepping	: 7
> microcode	: 0x1a
> cpu MHz		: 800.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 8
> core id		: 3
> cpu cores	: 4
> apicid		: 7
> initial apicid	: 7
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
> smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln pts
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 4400.14
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> Module information:
> 
> nls_utf8 12557 1 - Live 0x0000000000000000
> hfsplus 103443 1 - Live 0x0000000000000000
> parport_pc 32866 0 - Live 0x0000000000000000
> ppdev 17106 0 - Live 0x0000000000000000
> rfcomm 47863 12 - Live 0x0000000000000000
> bnep 18258 2 - Live 0x0000000000000000
> binfmt_misc 17540 1 - Live 0x0000000000000000
> nls_iso8859_1 12713 1 - Live 0x0000000000000000
> uvcvideo 82296 0 - Live 0x0000000000000000
> arc4 12573 2 - Live 0x0000000000000000
> videobuf2_vmalloc 13056 1 uvcvideo, Live 0x0000000000000000
> coretemp 13596 0 - Live 0x0000000000000000
> kvm_intel 138733 0 - Live 0x0000000000000000
> videobuf2_memops 13202 1 videobuf2_vmalloc, Live 0x0000000000000000
> videobuf2_core 40785 1 uvcvideo, Live 0x0000000000000000
> kvm 452835 1 kvm_intel, Live 0x0000000000000000
> videodev 131329 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
> btusb 18291 0 - Live 0x0000000000000000
> i915 631460 3 - Live 0x0000000000000000
> ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
> bcm5974 17477 0 - Live 0x0000000000000000
> bluetooth 251354 22 rfcomm,bnep,btusb, Live 0x0000000000000000
> aesni_intel 55449 2 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> b43 391985 0 - Live 0x0000000000000000
> xts 12922 1 aesni_intel, Live 0x0000000000000000
> snd_hda_codec_cirrus 14090 1 - Live 0x0000000000000000
> lrw 13294 1 aesni_intel, Live 0x0000000000000000
> snd_hda_intel 44397 3 - Live 0x0000000000000000
> gf128mul 14951 2 xts,lrw, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> cryptd 20501 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> snd_hda_codec 190010 2 snd_hda_codec_cirrus,snd_hda_intel, Live
> 0x0000000000000000
> snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
> hid_generic 12548 0 - Live 0x0000000000000000
> mac80211 656112 1 b43, Live 0x0000000000000000
> snd_pcm 102477 2 snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
> cfg80211 547072 2 b43,mac80211, Live 0x0000000000000000
> snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
> ssb 57592 1 b43, Live 0x0000000000000000
> snd_seq_midi 13324 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> snd_rawmidi 30417 1 snd_seq_midi, Live 0x0000000000000000
> snd_seq 61930 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> drm_kms_helper 49082 1 i915, Live 0x0000000000000000
> drm 295908 4 i915,drm_kms_helper, Live 0x0000000000000000
> mei 46555 0 - Live 0x0000000000000000
> apple_gmux 13406 0 - Live 0x0000000000000000
> 
> Loaded driver and hardware information:
> 
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>   0300-031f : applesmc
>   0400-047f : pnp 00:04
>     0400-0403 : ACPI PM1a_EVT_BLK
>     0404-0405 : ACPI PM1a_CNT_BLK
>     0408-040b : ACPI PM_TMR
>     0410-0415 : ACPI CPU throttle
>     0420-042f : ACPI GPE0_BLK
>     0430-0433 : iTCO_wdt
>     0450-0450 : ACPI PM2_CNT_BLK
>     0460-047f : iTCO_wdt
>   0500-057f : pnp 00:04
>   0680-069f : pnp 00:04
>   0700-07fd : Apple gmux
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   1000-100f : pnp 00:04
>   164e-164f : pnp 00:04
>   2000-2fff : PCI Bus 0000:01
>   3000-303f : 0000:00:02.0
>   3060-307f : 0000:00:1f.2
>     3060-307f : ahci
>   30c0-30df : 0000:00:1d.0
>     30c0-30df : uhci_hcd
>   3120-313f : 0000:00:1a.0
>     3120-313f : uhci_hcd
>   3140-3147 : 0000:00:1f.2
>     3140-3147 : ahci
>   3148-314f : 0000:00:1f.2
>     3148-314f : ahci
>   3158-315b : 0000:00:1f.2
>     3158-315b : ahci
>   315c-315f : 0000:00:1f.2
>     315c-315f : ahci
>   4000-4fff : PCI Bus 0000:05
>   efa0-efbf : 0000:00:1f.3
>   ffff-ffff : pnp 00:04
>     ffff-ffff : pnp 00:04
> 
> 00000000-00000fff : reserved
> 00001000-0008dfff : System RAM
> 0008e000-0008ffff : reserved
> 00090000-0009ffff : System RAM
> 000a0000-000bffff : PCI Bus 0000:00
>   000a0000-000bffff : reserved
> 000c0000-000c3fff : PCI Bus 0000:00
> 000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000cbfff : PCI Bus 0000:00
> 000cc000-000cffff : PCI Bus 0000:00
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000e0000-000e3fff : PCI Bus 0000:00
> 000e4000-000e7fff : PCI Bus 0000:00
> 000e8000-000ebfff : PCI Bus 0000:00
> 000ec000-000effff : PCI Bus 0000:00
> 000f0000-000fffff : PCI Bus 0000:00
>   000f0000-000fffff : System ROM
> 00100000-1fffffff : System RAM
>   02000000-02710dd0 : Kernel code
>   02710dd1-02cf3b7f : Kernel data
>   02e3c000-02f75fff : Kernel bss
> 20000000-201fffff : reserved
>   20000000-201fffff : pnp 00:09
> 20200000-3fffffff : System RAM
> 40000000-401fffff : reserved
>   40000000-401fffff : pnp 00:09
> 40200000-8ad33fff : System RAM
> 8ad34000-8ad5efff : ACPI Non-volatile Storage
> 8ad5f000-8ad6ffff : System RAM
> 8ad70000-8ad8efff : ACPI Tables
> 8ad8f000-8ae53fff : System RAM
> 8ae54000-8ae8efff : reserved
> 8ae8f000-8aed6fff : System RAM
> 8aed7000-8aefefff : reserved
> 8aeff000-8afa2fff : System RAM
> 8afa3000-8f9fffff : reserved
> 8fa00000-feafffff : PCI Bus 0000:00
>   90000000-9fffffff : PCI Bus 0000:01
>     90010000-906fffff : efifb
>   a0000000-afffffff : 0000:00:02.0
>   b0000000-b03fffff : 0000:00:02.0
>   b0400000-b04fffff : PCI Bus 0000:02
>     b0400000-b040ffff : 0000:02:00.0
>       b0400000-b040ffff : tg3
>     b0410000-b041ffff : 0000:02:00.0
>       b0410000-b041ffff : tg3
>     b0420000-b042ffff : 0000:02:00.1
>       b0420000-b042ffff : mmc0
>   b0500000-b05fffff : PCI Bus 0000:04
>     b0500000-b0500fff : 0000:04:00.0
>       b0500000-b0500fff : firewire_ohci
>   b0600000-b06fffff : PCI Bus 0000:03
>     b0600000-b0603fff : 0000:03:00.0
>       b0600000-b0603fff : bcma-pci-bridge
>   b0700000-b07fffff : PCI Bus 0000:02
>   b0800000-b08fffff : PCI Bus 0000:01
>   b0900000-b0903fff : 0000:00:1b.0
>     b0900000-b0903fff : ICH HD audio
>   b0906000-b09067ff : 0000:00:1f.2
>     b0906000-b09067ff : ahci
>   b0906800-b0906bff : 0000:00:1d.7
>     b0906800-b0906bff : ehci_hcd
>   b0906c00-b0906fff : 0000:00:1a.7
>     b0906c00-b0906fff : ehci_hcd
>   b0907000-b09070ff : 0000:00:1f.3
>   b0907100-b090710f : 0000:00:16.0
>     b0907100-b090710f : mei
>   b0a00000-b4efffff : PCI Bus 0000:05
>   b4f00000-b8efffff : PCI Bus 0000:05
>   e0000000-e9bfffff : PCI MMCONFIG 0000 [bus 00-9b]
>     e00f8000-e00f8fff : reserved
> fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : pnp 00:02
> fed10000-fed17fff : pnp 00:08
> fed18000-fed18fff : pnp 00:08
> fed19000-fed19fff : pnp 00:08
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:08
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:08
> fed40000-fed44fff : PCI Bus 0000:00
> fed45000-fed8ffff : pnp 00:08
> fed90000-fed93fff : pnp 00:08
> fee00000-feefffff : pnp 00:08
>   fee00000-fee00fff : Local APIC
> ffed8000-ffefffff : reserved
> 100000000-16fdfffff : System RAM
> 16fe00000-16fffffff : RAM buffer
> 
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
> 0x0000000000000000
> joydev 17613 0 - Live 0x0000000000000000
> snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
> snd 69533 15
> snd_hda_codec_cirrus,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
> soundcore 12680 1 snd, Live 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> lpc_ich 17060 0 - Live 0x0000000000000000
> mac_hid 13253 0 - Live 0x0000000000000000
> applesmc 19564 0 - Live 0x0000000000000000
> bcma 41434 1 b43, Live 0x0000000000000000
> apple_bl 13673 1 apple_gmux, Live 0x0000000000000000
> input_polldev 13896 1 applesmc, Live 0x0000000000000000
> microcode 22923 0 - Live 0x0000000000000000
> video 19467 2 i915,apple_gmux, Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> parport 46562 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> firewire_sbp2 22679 2 - Live 0x0000000000000000
> hid_apple 13389 0 - Live 0x0000000000000000
> usbhid 47346 0 - Live 0x0000000000000000
> hid 101248 3 hid_generic,hid_apple,usbhid, Live 0x0000000000000000
> tg3 165632 0 - Live 0x0000000000000000
> firewire_ohci 44864 0 - Live 0x0000000000000000
> ptp 18668 1 tg3, Live 0x0000000000000000
> ahci 30063 5 - Live 0x0000000000000000
> sdhci_pci 18720 0 - Live 0x0000000000000000
> firewire_core 64836 2 firewire_sbp2,firewire_ohci, Live
> 0x0000000000000000
> pps_core 14080 1 ptp, Live 0x0000000000000000
> sdhci 33227 1 sdhci_pci, Live 0x0000000000000000
> libahci 32088 1 ahci, Live 0x0000000000000000
> crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
> 
> PCI information:
> 
> 00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor
> Family DRAM Controller (rev 09)
> 	Subsystem: Apple Inc. MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR- INTx-
> 	Latency: 0
> 	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> 
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
> Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal
> decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 00002000-00002fff
> 	Memory behind bridge: b0800000-b08fffff
> 	Prefetchable memory behind bridge: 0000000090000000-000000009fffffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [88] Subsystem: Apple Inc. MacBookPro8,2 [Core i7, 15",
> 2011]
> 	Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: feeff00c  Data: 41b1
> 	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 		LnkCap:	Port #2, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0
> <256ns, L1 <4us
> 			ClockPM- Surprise- LLActRep- BwNot+
> 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive-
> BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> 			Changed: MRL- PresDet+ LinkState-
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [100 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [140 v1] Root Complex Link
> 		Desc:	PortNumber=02 ComponentID=01 EltType=Config
> 		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
> 			Addr:	00000000fed19000
> 	Kernel driver in use: pcieport
> 
> 00:01.1 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
> Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal
> decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Bus: primary=00, secondary=05, subordinate=9b, sec-latency=0
> 	I/O behind bridge: 00004000-00004fff
> 	Memory behind bridge: b0a00000-b4efffff
> 	Prefetchable memory behind bridge: 00000000b4f00000-00000000b8efffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [88] Subsystem: Apple Inc. MacBookPro8,2 [Core i7, 15",
> 2011]
> 	Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: feeff00c  Data: 41c1
> 	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 		LnkCap:	Port #3, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0
> <256ns, L1 <4us
> 			ClockPM- Surprise- LLActRep- BwNot+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled+ Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt
> + ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet+ LinkState-
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [100 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [140 v1] Root Complex Link
> 		Desc:	PortNumber=03 ComponentID=01 EltType=Config
> 		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
> 			Addr:	00000000fed19000
> 	Kernel driver in use: pcieport
> 
> 00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core
> Processor Family Integrated Graphics Controller (rev 09) (prog-if 00
> [VGA controller])
> 	Subsystem: Apple Inc. Device 00dc
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 49
> 	Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
> 	Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
> 	Region 4: I/O ports at 3000 [size=64]
> 	Expansion ROM at <unassigned> [disabled]
> 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: feeff00c  Data: 4182
> 	Capabilities: [d0] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [a4] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: i915
> 
> 00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series
> Chipset Family MEI Controller #1 (rev 04)
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 47
> 	Region 0: Memory at b0907100 (64-bit, non-prefetchable) [size=16]
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 00000000feeff00c  Data: 4162
> 	Kernel driver in use: mei
> 
> 00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
> Family USB Universal Host Controller #5 (rev 05) (prog-if 00 [UHCI])
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 21
> 	Region 4: I/O ports at 3120 [size=32]
> 	Capabilities: [50] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: uhci_hcd
> 
> 00:1a.7 USB controller: Intel Corporation 6 Series/C200 Series Chipset
> Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 23
> 	Region 0: Memory at b0906c00 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ehci-pci
> 
> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
> Family High Definition Audio Controller (rev 05)
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Interrupt: pin A routed to IRQ 48
> 	Region 0: Memory at b0900000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 00000000feeff00c  Data: 4172
> 	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI
> 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE- FLReset+
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
> <64ns, L1 <1us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
> BWMgmt- ABWMgmt-
> 	Capabilities: [100 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> 			Status:	NegoPending- InProgress-
> 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [130 v1] Root Complex Link
> 		Desc:	PortNumber=0f ComponentID=00 EltType=Config
> 		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
> 			Addr:	00000000fed1c000
> 	Kernel driver in use: snd_hda_intel
> 
> 00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
> Family PCI Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: b0700000-b07fffff
> 	Prefetchable memory behind bridge: 00000000b0400000-00000000b04fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep+ BwNot-
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> 		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: feeff00c  Data: 41d1
> 	Capabilities: [90] Subsystem: Intel Corporation Apple MacBookPro8,2
> [Core i7, 15", 2011]
> 	Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Kernel driver in use: pcieport
> 
> 00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
> Family PCI Express Root Port 2 (rev b5) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: b0600000-b06fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep+ BwNot-
> 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> 		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: feeff00c  Data: 41e1
> 	Capabilities: [90] Subsystem: Intel Corporation Apple MacBookPro8,2
> [Core i7, 15", 2011]
> 	Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Kernel driver in use: pcieport
> 
> 00:1c.2 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
> Family PCI Express Root Port 3 (rev b5) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: b0500000-b05fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep+ BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> 		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: feeff00c  Data: 4122
> 	Capabilities: [90] Subsystem: Intel Corporation Apple MacBookPro8,2
> [Core i7, 15", 2011]
> 	Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Kernel driver in use: pcieport
> 
> 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
> Family USB Universal Host Controller #1 (rev 05) (prog-if 00 [UHCI])
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 19
> 	Region 4: I/O ports at 30c0 [size=32]
> 	Capabilities: [50] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: uhci_hcd
> 
> 00:1d.7 USB controller: Intel Corporation 6 Series/C200 Series Chipset
> Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 22
> 	Region 0: Memory at b0906800 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ehci-pci
> 
> 00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC
> Controller (rev 05)
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> 	Kernel driver in use: lpc_ich
> 
> 00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset
> Family 6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 45
> 	Region 0: I/O ports at 3148 [size=8]
> 	Region 1: I/O ports at 315c [size=4]
> 	Region 2: I/O ports at 3140 [size=8]
> 	Region 3: I/O ports at 3158 [size=4]
> 	Region 4: I/O ports at 3060 [size=32]
> 	Region 5: Memory at b0906000 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: fee8800c  Data: 4142
> 	Capabilities: [70] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
> +,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
> 	Capabilities: [b0] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ahci
> 
> 00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family
> SMBus Controller (rev 05)
> 	Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin C routed to IRQ 0
> 	Region 0: Memory at b0907000 (64-bit, non-prefetchable) [disabled]
> [size=256]
> 	Region 4: I/O ports at efa0 [disabled] [size=32]
> 
> 02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57765
> Gigabit Ethernet PCIe (rev 10)
> 	Subsystem: Broadcom Corporation NetXtreme BCM57765 Gigabit Ethernet
> PCIe
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Interrupt: pin A routed to IRQ 16
> 	Region 0: Memory at b0400000 (64-bit, prefetchable) [size=64K]
> 	Region 2: Memory at b0410000 (64-bit, prefetchable) [size=64K]
> 	Capabilities: [48] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [a0] MSI-X: Enable+ Count=6 Masked-
> 		Vector table: BAR=2 offset=00000000
> 		PBA: BAR=2 offset=00000120
> 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <2us, L1 <64us
> 			ClockPM+ Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [13c v1] Device Serial Number 00-00-70-cd-60-f1-b6-3b
> 	Capabilities: [150 v1] Power Budgeting <?>
> 	Capabilities: [160 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Kernel driver in use: tg3
> 
> 02:00.1 SD Host controller: Broadcom Corporation NetXtreme BCM57765
> Memory Card Reader (rev 10) (prog-if 01)
> 	Subsystem: Broadcom Corporation Device 0000
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Interrupt: pin B routed to IRQ 17
> 	Region 0: Memory at b0420000 (64-bit, prefetchable) [size=64K]
> 	Capabilities: [48] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> 	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <2us, L1 <64us
> 			ClockPM+ Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [150 v1] Power Budgeting <?>
> 	Capabilities: [160 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Kernel driver in use: sdhci-pci
> 
> 03:00.0 Network controller: Broadcom Corporation BCM4331 802.11a/b/g/n
> (rev 02)
> 	Subsystem: Broadcom Corporation BCM4331 802.11a/b/g/n
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Interrupt: pin A routed to IRQ 17
> 	Region 0: Memory at b0600000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
> 	Capabilities: [58] Vendor Specific Information: Len=78 <?>
> 	Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [d0] Express (v1) Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <2us, L1 <32us
> 			ClockPM+ Surprise- LLActRep+ BwNot-
> 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt- ABWMgmt-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr+ BadTLP+ BadDLLP+ Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [13c v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [160 v1] Device Serial Number 00-00-00-ff-ff-00-00-00
> 	Capabilities: [16c v1] Power Budgeting <?>
> 	Kernel driver in use: bcma-pci-bridge
> 
> 04:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe
> 1394b Controller (rev 08) (prog-if 10 [OHCI])
> 	Subsystem: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 256 bytes
> 	Interrupt: pin A routed to IRQ 46
> 	Region 0: Memory at b0500000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot
> +,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
> 	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 00000000fee4400c  Data: 4152
> 	Capabilities: [60] Express (v1) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 2048 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <64us
> 			ClockPM+ Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [140 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [170 v1] Device Serial Number 00-00-00-00-00-00-00-00
> 	Kernel driver in use: firewire_ohci
> 
> SCSI information:
> 
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: TOSHIBA MK7559GS Rev: GQ00
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: MATSHITA Model: DVD-R   UJ-898   Rev: HE13
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> Host: scsi6 Channel: 00 Id: 00 Lun: 00
>   Vendor: Hitachi  Model: HTS545050B9A300  Rev:     
>   Type:   Direct-Access                    ANSI  SCSI revision: 04
> 
> 
> 
> 
> 


