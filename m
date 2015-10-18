From: =?UTF-8?Q?Gast=C3=B3n_Tonietti?= <gaston.tonietti@gmail.com>
Subject: [BUG] Black screen when resuming after sleep
Date: Sun, 18 Oct 2015 11:22:18 +1100
Message-ID: <CADE_Am9ho4GEzFJpNNtT5CoX3BHAkbGVXNA7uAt==SvTBvnnfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f193.google.com ([209.85.214.193]:33669 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbJRAWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 20:22:19 -0400
Received: by obbhq1 with SMTP id hq1so8287939obb.0
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2015 17:22:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

1. Black screen when resuming after sleep

2. I have a Dell XPS 15 9530. When I suspend to RAM and then I want to
   resume back the laptop won't wake up. It seems it is trying tho, the
   power light and the keyboard backlight turn on but then nothing happ=
ens,
   the screen remains black and I cannot SSH on it neither.
   I don't know if it is related, but if the screen is turned off by th=
e
   power manager settings (away for a while) moving the cursor or press=
ing
   keys won't make the sreen to turn on again. But the system is functi=
onal,
   I still can hear notifications sounds for instance.
   Further to the below, I can "confirm" it's not related to X, I can
   reproduce the very same problem booting into terminal mode and remov=
ing
   i915 module.

4. Kernel version:
   Linux version 4.3.0-040300rc5-generic (kernel@tangerine)
   (gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) )
   #201510111530 SMP Sun Oct 11 19:31:35 UTC 2015

7. Environment
   Description:    Ubuntu Wily Werewolf (development branch)
   Release:        15.10

7.1. ver_linux script output:
     Linux tonga-kps 4.3.0-040300rc5-generic
     #201510111530 SMP Sun Oct 11 19:31:35 UTC 2015
     x86_64 x86_64 x86_64 GNU/Linux

     Gnu C                  5.2.1
     Gnu make               4.0
     binutils               2.25.1
     util-linux             2.26.2
     mount                  debug
     module-init-tools      21
     e2fsprogs              1.42.12
     pcmciautils            018
     PPP                    2.4.6
     Linux C Library        2.21
     Dynamic linker (ldd)   2.21
     Procps                 3.3.9
     Net-tools              1.60
     Kbd                    1.15.5
     Sh-utils               8.23
     wireless-tools         30
     Modules Loaded         rfcomm bnep pn544_mei mei_phy pn544 hci
nfc intel_rapl snd_hda_codec_hdmi uvcvideo x86_pkg_temp_thermal
intel_powerclamp dell_wmi coretemp sparse_keymap wl kvm_intel
snd_hda_codec_realtek btusb videobuf2_vmalloc btrtl
snd_hda_codec_generic videobuf2_memops btbcm kvm videobuf2_core
btintel bluetooth v4l2_common videodev crct10dif_pclmul snd_hda_intel
crc32_pclmul dell_laptop ghash_clmulni_intel snd_hda_codec media
hid_multitouch dcdbas snd_hda_core snd_hwdep aesni_intel rtsx_pci_ms
snd_pcm aes_x86_64 input_leds memstick lrw snd_seq_midi joydev
gf128mul cfg80211 snd_seq_midi_event glue_helper ablk_helper
snd_rawmidi serio_raw cryptd snd_seq snd_seq_device snd_timer snd
soundcore processor_thermal_device acpi_als mei_me intel_soc_dts_iosf
mei shpchp iosf_mbi kfifo_buf ie31200_edac int3400_thermal lpc_ich
edac_core int3403_thermal industrialio int3402_thermal
acpi_thermal_rel dell_rbtn dell_smo8800 mac_hid int340x_thermal_zone
parport_pc ppdev lp parport autofs4 dm_mirror dm_region_hash dm_log
usbhid hid rtsx_pci_sdmmc nouveau i915 mxm_wmi ttm i2c_algo_bit
drm_kms_helper psmouse syscopyarea sysfillrect ahci sysimgblt
fb_sys_fops libahci drm rtsx_pci wmi video fjes

7.2. /proc/cpuinfo:
     processor       : 0
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2334.410
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 0
     cpu cores       : 4
     apicid          : 0
     initial apicid  : 0
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 1
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2279.875
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 1
     cpu cores       : 4
     apicid          : 2
     initial apicid  : 2
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 2
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2334.230
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 2
     cpu cores       : 4
     apicid          : 4
     initial apicid  : 4
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 3
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2262.535
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 3
     cpu cores       : 4
     apicid          : 6
     initial apicid  : 6
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 4
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2293.261
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 0
     cpu cores       : 4
     apicid          : 1
     initial apicid  : 1
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 5
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2340.429
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 1
     cpu cores       : 4
     apicid          : 3
     initial apicid  : 3
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 6
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2510.683
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 2
     cpu cores       : 4
     apicid          : 5
     initial apicid  : 5
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

     processor       : 7
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 60
     model name      : Intel(R) Core(TM) i7-4712HQ CPU @ 2.30GHz
     stepping        : 3
     microcode       : 0x1c
     cpu MHz         : 2302.335
     cache size      : 6144 KB
     physical id     : 0
     siblings        : 8
     core id         : 3
     cpu cores       : 4
     apicid          : 7
     initial apicid  : 7
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 13
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt
     bugs            :
     bogomips        : 4589.55
     clflush size    : 64
     cache_alignment : 64
     address sizes   : 39 bits physical, 48 bits virtual
     power management:

7.3. /proc/modules:
     rfcomm 69632 14 - Live 0x0000000000000000
     bnep 20480 2 - Live 0x0000000000000000
     pn544_mei 16384 0 - Live 0x0000000000000000
     mei_phy 16384 1 pn544_mei, Live 0x0000000000000000
     pn544 20480 1 pn544_mei, Live 0x0000000000000000
     hci 45056 2 mei_phy,pn544, Live 0x0000000000000000
     nfc 102400 2 pn544,hci, Live 0x0000000000000000
     intel_rapl 20480 0 - Live 0x0000000000000000
     snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
     uvcvideo 90112 0 - Live 0x0000000000000000
     x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
     intel_powerclamp 16384 0 - Live 0x0000000000000000
     dell_wmi 16384 0 - Live 0x0000000000000000
     coretemp 16384 0 - Live 0x0000000000000000
     sparse_keymap 16384 1 dell_wmi, Live 0x0000000000000000
     wl 6365184 0 - Live 0x0000000000000000 (POE)
     kvm_intel 163840 0 - Live 0x0000000000000000
     snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
     btusb 45056 0 - Live 0x0000000000000000
     videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
     btrtl 16384 1 btusb, Live 0x0000000000000000
     snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live
0x0000000000000000
     videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x000000000000000=
0
     btbcm 16384 1 btusb, Live 0x0000000000000000
     kvm 507904 1 kvm_intel, Live 0x0000000000000000
     videobuf2_core 49152 1 uvcvideo, Live 0x0000000000000000
     btintel 16384 1 btusb, Live 0x0000000000000000
     bluetooth 516096 39 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
     v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
     videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live
0x0000000000000000
     crct10dif_pclmul 16384 0 - Live 0x0000000000000000
     snd_hda_intel 36864 5 - Live 0x0000000000000000
     crc32_pclmul 16384 0 - Live 0x0000000000000000
     dell_laptop 20480 0 - Live 0x0000000000000000
     ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
     snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_=
intel,
Live 0x0000000000000000
     media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
     hid_multitouch 20480 0 - Live 0x0000000000000000
     dcdbas 16384 1 dell_laptop, Live 0x0000000000000000
     snd_hda_core 65536 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_=
intel,snd_hda_codec,
Live 0x0000000000000000
     snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
     aesni_intel 167936 0 - Live 0x0000000000000000
     rtsx_pci_ms 20480 0 - Live 0x0000000000000000
     snd_pcm 102400 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0x0000000000000000
     aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
     input_leds 16384 0 - Live 0x0000000000000000
     memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
     lrw 16384 1 aesni_intel, Live 0x0000000000000000
     snd_seq_midi 16384 0 - Live 0x0000000000000000
     joydev 20480 0 - Live 0x0000000000000000
     gf128mul 16384 1 lrw, Live 0x0000000000000000
     cfg80211 540672 1 wl, Live 0x0000000000000000
     snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
     glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
     ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
     snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
     serio_raw 16384 0 - Live 0x0000000000000000
     cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
     snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000=
000000
     snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
     snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
     snd 81920 21
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_=
intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_devic=
e,snd_timer,
Live 0x0000000000000000
     soundcore 16384 1 snd, Live 0x0000000000000000
     processor_thermal_device 16384 0 - Live 0x0000000000000000
     acpi_als 16384 0 - Live 0x0000000000000000
     mei_me 28672 0 - Live 0x0000000000000000
     intel_soc_dts_iosf 16384 1 processor_thermal_device, Live
0x0000000000000000
     mei 98304 4 pn544_mei,mei_phy,mei_me, Live 0x0000000000000000
     shpchp 36864 0 - Live 0x0000000000000000
     iosf_mbi 16384 2 intel_rapl,intel_soc_dts_iosf, Live 0x00000000000=
00000
     kfifo_buf 16384 1 acpi_als, Live 0x0000000000000000
     ie31200_edac 16384 0 - Live 0x0000000000000000
     int3400_thermal 16384 0 - Live 0x0000000000000000
     lpc_ich 24576 0 - Live 0x0000000000000000
     edac_core 53248 1 ie31200_edac, Live 0x0000000000000000
     int3403_thermal 16384 0 - Live 0x0000000000000000
     industrialio 57344 2 acpi_als,kfifo_buf, Live 0x0000000000000000
     int3402_thermal 16384 0 - Live 0x0000000000000000
     acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
     dell_rbtn 16384 0 - Live 0x0000000000000000
     dell_smo8800 16384 0 - Live 0x0000000000000000
     mac_hid 16384 0 - Live 0x0000000000000000
     int340x_thermal_zone 16384 3
processor_thermal_device,int3403_thermal,int3402_thermal, Live
0x0000000000000000
     parport_pc 36864 0 - Live 0x0000000000000000
     ppdev 20480 0 - Live 0x0000000000000000
     lp 20480 0 - Live 0x0000000000000000
     parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
     autofs4 40960 2 - Live 0x0000000000000000
     dm_mirror 24576 0 - Live 0x0000000000000000
     dm_region_hash 20480 1 dm_mirror, Live 0x0000000000000000
     dm_log 20480 2 dm_mirror,dm_region_hash, Live 0x0000000000000000
     usbhid 49152 0 - Live 0x0000000000000000
     hid 118784 2 hid_multitouch,usbhid, Live 0x0000000000000000
     rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
     nouveau 1462272 1 - Live 0x0000000000000000
     i915 1138688 9 - Live 0x0000000000000000
     mxm_wmi 16384 1 nouveau, Live 0x0000000000000000
     ttm 94208 1 nouveau, Live 0x0000000000000000
     i2c_algo_bit 16384 2 nouveau,i915, Live 0x0000000000000000
     drm_kms_helper 131072 2 nouveau,i915, Live 0x0000000000000000
     psmouse 122880 0 - Live 0x0000000000000000
     syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
     sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
     ahci 36864 3 - Live 0x0000000000000000
     sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
     fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
     libahci 32768 1 ahci, Live 0x0000000000000000
     drm 352256 13 nouveau,i915,ttm,drm_kms_helper, Live 0x000000000000=
0000
     rtsx_pci 53248 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x00000000000000=
00
     wmi 20480 3 dell_wmi,nouveau,mxm_wmi, Live 0x0000000000000000
     video 36864 4 dell_wmi,dell_laptop,nouveau,i915, Live 0x0000000000=
000000
     fjes 28672 0 - Live 0x0000000000000000

7.4. /proc/ioports:
     0000-0cf7 : PCI Bus 0000:00
       0000-001f : dma1
       0020-0021 : pic1
       0040-0043 : timer0
       0050-0053 : timer1
       0060-0060 : keyboard
       0062-0062 : PNP0C09:00
         0062-0062 : EC data
       0064-0064 : keyboard
       0066-0066 : PNP0C09:00
         0066-0066 : EC cmd
       0070-0077 : rtc0
       0080-008f : dma page reg
       00a0-00a1 : pic2
       00c0-00df : dma2
       00f0-00ff : fpu
         00f0-00f0 : PNP0C04:00
       03c0-03df : vesafb
       04d0-04d1 : pnp 00:03
       0680-069f : pnp 00:00
     0cf8-0cff : PCI conf1
     0d00-ffff : PCI Bus 0000:00
       164e-164f : pnp 00:00
       1800-1803 : ACPI PM1a_EVT_BLK
       1804-1805 : ACPI PM1a_CNT_BLK
       1808-180b : ACPI PM_TMR
       1810-1815 : ACPI CPU throttle
       1820-182f : ACPI GPE0_BLK
       1830-1833 : iTCO_wdt.0.auto
       1850-1850 : ACPI PM2_CNT_BLK
       1854-1857 : pnp 00:02
       1860-187f : iTCO_wdt.0.auto
       1c00-1cfe : pnp 00:00
       1d00-1dfe : pnp 00:00
       1e00-1efe : pnp 00:00
       1f00-1ffe : pnp 00:00
       2000-2fff : PCI Bus 0000:04
       e000-efff : PCI Bus 0000:02
         e000-e07f : 0000:02:00.0
       f000-f03f : 0000:00:02.0
       f040-f05f : 0000:00:1f.3
       f060-f07f : 0000:00:1f.2
         f060-f07f : ahci
       f080-f083 : 0000:00:1f.2
         f080-f083 : ahci
       f090-f097 : 0000:00:1f.2
         f090-f097 : ahci
       f0a0-f0a3 : 0000:00:1f.2
         f0a0-f0a3 : ahci
       f0b0-f0b7 : 0000:00:1f.2
         f0b0-f0b7 : ahci
       ffff-ffff : pnp 00:00
         ffff-ffff : pnp 00:00
           ffff-ffff : pnp 00:00

     /proc/iomem:
     00000000-00000fff : reserved
     00001000-000917ff : System RAM
     00091800-0009ffff : reserved
     000a0000-000bffff : PCI Bus 0000:00
     000c0000-000cebff : Video ROM
     000cf000-000d8dff : Adapter ROM
     000dc000-000dffff : PCI Bus 0000:00
     000e0000-000fffff : reserved
       000e0000-000e3fff : PCI Bus 0000:00
       000e4000-000e7fff : PCI Bus 0000:00
       000f0000-000fffff : System ROM
     00100000-b7166fff : System RAM
       01000000-017b900b : Kernel code
       017b900c-01d3c4ff : Kernel data
       01eb3000-01ff7fff : Kernel bss
     b7167000-b716dfff : ACPI Non-volatile Storage
     b716e000-b75b1fff : System RAM
     b75b2000-b7bcdfff : reserved
     b7bce000-ca795fff : System RAM
     ca796000-cab48fff : reserved
     cab49000-cab69fff : ACPI Tables
     cab6a000-cb53efff : ACPI Non-volatile Storage
     cb53f000-cbffefff : reserved
     cbfff000-cbffffff : System RAM
     cd000000-cf1fffff : reserved
       cd200000-cf1fffff : Graphics Stolen Memory
     cf200000-feafffff : PCI Bus 0000:00
       cf200000-cf3fffff : PCI Bus 0000:04
       cf400000-cf5fffff : PCI Bus 0000:04
       d0000000-dfffffff : 0000:00:02.0
       e0000000-f1ffffff : PCI Bus 0000:02
         e0000000-efffffff : 0000:02:00.0
         f0000000-f1ffffff : 0000:02:00.0
       f6000000-f70fffff : PCI Bus 0000:02
         f6000000-f6ffffff : 0000:02:00.0
         f7000000-f707ffff : 0000:02:00.0
       f7400000-f77fffff : 0000:00:02.0
       f7800000-f7afffff : PCI Bus 0000:06
         f7800000-f79fffff : 0000:06:00.0
         f7a00000-f7a07fff : 0000:06:00.0
       f7b00000-f7bfffff : PCI Bus 0000:07
         f7b00000-f7b00fff : 0000:07:00.0
           f7b00000-f7b00fff : rtsx_pci
       f7c00000-f7c0ffff : 0000:00:14.0
         f7c00000-f7c0ffff : xhci-hcd
       f7c10000-f7c17fff : 0000:00:04.0
       f7c18000-f7c1bfff : 0000:00:1b.0
         f7c18000-f7c1bfff : ICH HD audio
       f7c1c000-f7c1ffff : 0000:00:03.0
         f7c1c000-f7c1ffff : ICH HD audio
       f7c20000-f7c20fff : 0000:00:1f.6
       f7c21000-f7c210ff : 0000:00:1f.3
       f7c22000-f7c227ff : 0000:00:1f.2
         f7c22000-f7c227ff : ahci
       f7c23000-f7c233ff : 0000:00:1d.0
         f7c23000-f7c233ff : ehci_hcd
       f7c24000-f7c243ff : 0000:00:1a.0
         f7c24000-f7c243ff : ehci_hcd
       f7c26000-f7c2600f : 0000:00:16.0
         f7c26000-f7c2600f : mei_me
       f7fd0000-f7fdffff : pnp 00:06
       f7fee000-f7feefff : pnp 00:06
       f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
         f8000000-fbffffff : reserved
           f8000000-fbffffff : pnp 00:06
     fec00000-fec00fff : reserved
       fec00000-fec003ff : IOAPIC 0
     fed00000-fed03fff : reserved
       fed00000-fed003ff : HPET 0
         fed00000-fed003ff : PNP0103:00
     fed10000-fed17fff : pnp 00:06
     fed18000-fed18fff : pnp 00:06
     fed19000-fed19fff : pnp 00:06
     fed1c000-fed1ffff : reserved
       fed1c000-fed1ffff : pnp 00:06
         fed1f410-fed1f414 : iTCO_wdt.0.auto
     fed20000-fed3ffff : pnp 00:06
     fed45000-fed8ffff : pnp 00:06
     fed90000-fed90fff : dmar0
     fed91000-fed91fff : dmar1
     fee00000-fee00fff : Local APIC
       fee00000-fee00fff : reserved
     ff000000-ffffffff : reserved
       ff000000-ffffffff : INT0800:00
         ff000000-ffffffff : pnp 00:06
     100000000-42fdfffff : System RAM
     42fe00000-42fffffff : RAM buffer


7.5. lspci -vvv:
     00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen
Core Processor DRAM Controller (rev 06)
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
             Latency: 0
             Capabilities: [e0] Vendor Specific Information: Len=3D0c <=
?>

     00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen
Core Processor PCI Express x16 Controller (rev 06) (prog-if 00 [Normal
decode])
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 26
             Bus: primary=3D00, secondary=3D02, subordinate=3D03, sec-l=
atency=3D0
             I/O behind bridge: 0000e000-0000efff
             Memory behind bridge: f6000000-f70fffff
             Prefetchable memory behind bridge:
00000000e0000000-00000000f1ffffff
             Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- <SERR- <PERR-
             BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB=
2B-
                     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn=
-
             Capabilities: [88] Subsystem: Dell Device 05fe
             Capabilities: [80] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee00238  Data: 0000
             Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
                     DevCap: MaxPayload 256 bytes, PhantFunc 0
                             ExtTag- RBE+
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 256 bytes, MaxReadReq 128 bytes
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                     LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s
L1, Exit Latency L0s <256ns, L1 <8us
                             ClockPM- Surprise- LLActRep- BwNot+ ASPMOp=
tComp+
                     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
Disabled- CommClk+
                             ExtSynch- ClockPM- AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train+
SlotClk+ DLActive- BWMgmt+ ABWMgmt+
                     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                             Slot #1, PowerLimit 75.000W; Interlock- No=
Compl+
                     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                             Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                             Changed: MRL- PresDet+ LinkState-
                     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                     RootCap: CRSVisible-
                     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                     DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
                     LnkCtl2: Target Link Speed: 8GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+, EqualizationPhase1+
                              EqualizationPhase2+,
EqualizationPhase3+, LinkEqualizationRequest-
             Capabilities: [100 v1] Virtual Channel
                     Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                     Arb:    Fixed- WRR32- WRR64- WRR128-
                     Ctrl:   ArbSelect=3DFixed
                     Status: InProgress-
                     VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
                             Arb:    Fixed+ WRR32- WRR64- WRR128-
TWRR128- WRR256-
                             Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed T=
C/VC=3Dff
                             Status: NegoPending- InProgress-
             Capabilities: [140 v1] Root Complex Link
                     Desc:   PortNumber=3D02 ComponentID=3D01 EltType=3D=
Config
                     Link0:  Desc:   TargetPort=3D00 TargetComponent=3D=
01
AssocRCRB- LinkType=3DMemMapped LinkValid+
                             Addr:   00000000fed19000
             Capabilities: [d94 v1] #19
             Kernel driver in use: pcieport

     00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
controller])
             Subsystem: Dell Device 05fe
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 34
             Region 0: Memory at f7400000 (64-bit, non-prefetchable) [s=
ize=3D4M]
             Region 2: Memory at d0000000 (64-bit, prefetchable) [size=3D=
256M]
             Region 4: I/O ports at f000 [size=3D64]
             Expansion ROM at <unassigned> [disabled]
             Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee00018  Data: 0000
             Capabilities: [d0] Power Management version 2
                     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [a4] PCI Advanced Features
                     AFCap: TP+ FLR+
                     AFCtrl: FLR-
                     AFStatus: TP-
             Kernel driver in use: i915

     00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen
Core Processor HD Audio Controller (rev 06)
             Subsystem: Intel Corporation Device 2010
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 37
             Region 0: Memory at f7c1c000 (64-bit, non-prefetchable) [s=
ize=3D16K]
             Capabilities: [50] Power Management version 2
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee003b8  Data: 0000
             Capabilities: [70] Express (v1) Root Complex Integrated
Endpoint, MSI 00
                     DevCap: MaxPayload 128 bytes, PhantFunc 0
                             ExtTag- RBE-
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 128 bytes, MaxReadReq 128 bytes
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
             Kernel driver in use: snd_hda_intel

     00:04.0 Signal processing controller: Intel Corporation Device
0c03 (rev 06)
             Subsystem: Intel Corporation Device 2010
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 11
             Region 0: Memory at f7c10000 (64-bit, non-prefetchable) [s=
ize=3D32K]
             Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bi=
t-
                     Address: 00000000  Data: 0000
             Capabilities: [d0] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [e0] Vendor Specific Information: Len=3D0c <=
?>

     00:14.0 USB controller: Intel Corporation 8 Series/C220 Series
Chipset Family USB xHCI (rev 05) (prog-if 30 [XHCI])
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 30
             Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [s=
ize=3D64K]
             Capabilities: [70] Power Management version 2
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bi=
t+
                     Address: 00000000fee002b8  Data: 0000
             Kernel driver in use: xhci_hcd

     00:16.0 Communication controller: Intel Corporation 8 Series/C220
Series Chipset Family MEI Controller #1 (rev 04)
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 35
             Region 0: Memory at f7c26000 (64-bit, non-prefetchable) [s=
ize=3D16]
             Capabilities: [50] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
                     Address: 00000000fee00358  Data: 0000
             Kernel driver in use: mei_me

     00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series
Chipset Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 16
             Region 0: Memory at f7c24000 (32-bit, non-prefetchable) [s=
ize=3D1K]
             Capabilities: [50] Power Management version 2
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
             Capabilities: [98] PCI Advanced Features
                     AFCap: TP+ FLR+
                     AFCtrl: FLR-
                     AFStatus: TP-
             Kernel driver in use: ehci-pci

     00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series
Chipset High Definition Audio Controller (rev 05)
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 36
             Region 0: Memory at f7c18000 (64-bit, non-prefetchable) [s=
ize=3D16K]
             Capabilities: [50] Power Management version 2
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
                     Address: 00000000fee00398  Data: 0000
             Capabilities: [70] Express (v1) Root Complex Integrated
Endpoint, MSI 00
                     DevCap: MaxPayload 128 bytes, PhantFunc 0
                             ExtTag- RBE-
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 128 bytes, MaxReadReq 128 bytes
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
             Capabilities: [100 v1] Virtual Channel
                     Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                     Arb:    Fixed- WRR32- WRR64- WRR128-
                     Ctrl:   ArbSelect=3DFixed
                     Status: InProgress-
                     VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
                             Arb:    Fixed- WRR32- WRR64- WRR128-
TWRR128- WRR256-
                             Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed T=
C/VC=3D01
                             Status: NegoPending- InProgress-
                     VC1:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
                             Arb:    Fixed- WRR32- WRR64- WRR128-
TWRR128- WRR256-
                             Ctrl:   Enable+ ID=3D2 ArbSelect=3DFixed T=
C/VC=3D04
                             Status: NegoPending- InProgress-
             Kernel driver in use: snd_hda_intel

     00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series
Chipset Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal
decode])
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 27
             Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-l=
atency=3D0
             I/O behind bridge: 00002000-00002fff
             Memory behind bridge: cf200000-cf3fffff
             Prefetchable memory behind bridge:
00000000cf400000-00000000cf5fffff
             Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
             BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB=
2B-
                     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn=
-
             Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                     DevCap: MaxPayload 128 bytes, PhantFunc 0
                             ExtTag- RBE+
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 128 bytes, MaxReadReq 128 bytes
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                     LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s
L1, Exit Latency L0s <1us, L1 <4us
                             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOp=
tComp-
                     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
Disabled- CommClk-
                             ExtSynch- ClockPM- AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise+
                             Slot #0, PowerLimit 0.000W; Interlock- NoC=
ompl+
                     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt- HPIrq+ LinkChg+
                             Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                             Changed: MRL- PresDet- LinkState-
                     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                     RootCap: CRSVisible-
                     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                     DevCap2: Completion Timeout: Range ABC,
TimeoutDis+, LTR+, OBFF Via WAKE# ARIFwd-
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                     LnkCtl2: Target Link Speed: 5GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                              EqualizationPhase2-,
EqualizationPhase3-, LinkEqualizationRequest-
             Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee00258  Data: 0000
             Capabilities: [90] Subsystem: Dell Device 05fe
             Capabilities: [a0] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Kernel driver in use: pcieport

     00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series
Chipset Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal
decode])
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin C routed to IRQ 28
             Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-l=
atency=3D0
             I/O behind bridge: 0000f000-00000fff
             Memory behind bridge: f7800000-f7afffff
             Prefetchable memory behind bridge:
00000000fff00000-00000000000fffff
             Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- <SERR- <PERR-
             BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB=
2B-
                     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn=
-
             Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                     DevCap: MaxPayload 128 bytes, PhantFunc 0
                             ExtTag- RBE+
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 128 bytes, MaxReadReq 128 bytes
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                     LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s
L1, Exit Latency L0s <512ns, L1 <16us
                             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOp=
tComp-
                     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
Disabled- CommClk+
                             ExtSynch- ClockPM- AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                             Slot #2, PowerLimit 10.000W; Interlock- No=
Compl+
                     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                             Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                             Changed: MRL- PresDet- LinkState-
                     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                     RootCap: CRSVisible-
                     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                     DevCap2: Completion Timeout: Range ABC,
TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                     LnkCtl2: Target Link Speed: 5GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                              EqualizationPhase2-,
EqualizationPhase3-, LinkEqualizationRequest-
             Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee00278  Data: 0000
             Capabilities: [90] Subsystem: Dell Device 05fe
             Capabilities: [a0] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Kernel driver in use: pcieport

     00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series
Chipset Family PCI Express Root Port #4 (rev d5) (prog-if 00 [Normal
decode])
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin D routed to IRQ 29
             Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-l=
atency=3D0
             I/O behind bridge: 0000f000-00000fff
             Memory behind bridge: f7b00000-f7bfffff
             Prefetchable memory behind bridge:
00000000fff00000-00000000000fffff
             Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- <SERR- <PERR-
             BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB=
2B-
                     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn=
-
             Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                     DevCap: MaxPayload 128 bytes, PhantFunc 0
                             ExtTag- RBE+
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 128 bytes, MaxReadReq 128 bytes
                     DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                     LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s
L1, Exit Latency L0s <512ns, L1 <16us
                             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOp=
tComp-
                     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
Disabled- CommClk+
                             ExtSynch- ClockPM- AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                             Slot #3, PowerLimit 10.000W; Interlock- No=
Compl+
                     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                             Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                             Changed: MRL- PresDet- LinkState-
                     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                     RootCap: CRSVisible-
                     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                     DevCap2: Completion Timeout: Range ABC,
TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                     LnkCtl2: Target Link Speed: 5GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                              EqualizationPhase2-,
EqualizationPhase3-, LinkEqualizationRequest-
             Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee00298  Data: 0000
             Capabilities: [90] Subsystem: Dell Device 05fe
             Capabilities: [a0] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Kernel driver in use: pcieport

     00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series
Chipset Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 23
             Region 0: Memory at f7c23000 (32-bit, non-prefetchable) [s=
ize=3D1K]
             Capabilities: [50] Power Management version 2
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
             Capabilities: [98] PCI Advanced Features
                     AFCap: TP+ FLR+
                     AFCtrl: FLR-
                     AFStatus: TP-
             Kernel driver in use: ehci-pci

     00:1f.0 ISA bridge: Intel Corporation HM87 Express LPC Controller =
(rev 05)
             Subsystem: Dell Device 05fe
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Capabilities: [e0] Vendor Specific Information: Len=3D0c <=
?>
             Kernel driver in use: lpc_ich

     00:1f.2 RAID bus controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 05)
             Subsystem: Dell Device 05fe
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin B routed to IRQ 32
             Region 0: I/O ports at f0b0 [size=3D8]
             Region 1: I/O ports at f0a0 [size=3D4]
             Region 2: I/O ports at f090 [size=3D8]
             Region 3: I/O ports at f080 [size=3D4]
             Region 4: I/O ports at f060 [size=3D32]
             Region 5: Memory at f7c22000 (32-bit, non-prefetchable) [s=
ize=3D2K]
             Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
                     Address: fee00338  Data: 0000
             Capabilities: [70] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
             Kernel driver in use: ahci

     00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset
=46amily SMBus Controller (rev 05)
             Subsystem: Dell Device 05fe
             Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Interrupt: pin C routed to IRQ 3
             Region 0: Memory at f7c21000 (64-bit, non-prefetchable) [s=
ize=3D256]
             Region 4: I/O ports at f040 [size=3D32]

     00:1f.6 Signal processing controller: Intel Corporation 8 Series
Chipset Family Thermal Management Controller (rev 05)
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin C routed to IRQ 3
             Region 0: Memory at f7c20000 (64-bit, non-prefetchable) [s=
ize=3D4K]
             Capabilities: [50] Power Management version 3
                     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bi=
t-
                     Address: 00000000  Data: 0000

     02:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 750M]=
 (rev a1)
             Subsystem: Dell Device 05fe
             Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 33
             Region 0: Memory at f6000000 (32-bit, non-prefetchable) [s=
ize=3D16M]
             Region 1: Memory at e0000000 (64-bit, prefetchable) [size=3D=
256M]
             Region 3: Memory at f0000000 (64-bit, prefetchable) [size=3D=
32M]
             Region 5: I/O ports at e000 [size=3D128]
             Expansion ROM at f7000000 [disabled] [size=3D512K]
             Capabilities: [60] Power Management version 3
                     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [68] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
                     Address: 00000000fee002f8  Data: 0000
             Capabilities: [78] Express (v2) Endpoint, MSI 00
                     DevCap: MaxPayload 256 bytes, PhantFunc 0,
Latency L0s unlimited, L1 <64us
                             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLR=
eset-
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoo=
p+
                             MaxPayload 256 bytes, MaxReadReq 512 bytes
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                     LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s
L1, Exit Latency L0s <512ns, L1 <4us
                             ClockPM+ Surprise- LLActRep- BwNot- ASPMOp=
tComp+
                     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
Disabled- CommClk+
                             ExtSynch- ClockPM- AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                     DevCap2: Completion Timeout: Range AB,
TimeoutDis+, LTR-, OBFF Not Supported
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                     LnkCtl2: Target Link Speed: 8GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+, EqualizationPhase1+
                              EqualizationPhase2+,
EqualizationPhase3+, LinkEqualizationRequest-
             Capabilities: [b4] Vendor Specific Information: Len=3D14 <=
?>
             Capabilities: [100 v1] Virtual Channel
                     Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                     Arb:    Fixed- WRR32- WRR64- WRR128-
                     Ctrl:   ArbSelect=3DFixed
                     Status: InProgress-
                     VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
                             Arb:    Fixed- WRR32- WRR64- WRR128-
TWRR128- WRR256-
                             Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed T=
C/VC=3D01
                             Status: NegoPending- InProgress-
             Capabilities: [128 v1] Power Budgeting <?>
             Capabilities: [600 v1] Vendor Specific Information:
ID=3D0001 Rev=3D1 Len=3D024 <?>
             Capabilities: [900 v1] #19
             Kernel driver in use: nouveau

     06:00.0 Network controller: Broadcom Corporation BCM4352 802.11ac
Wireless Network Adapter (rev 03)
             Subsystem: Dell Device 0019
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 18
             Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [s=
ize=3D32K]
             Region 2: Memory at f7800000 (64-bit, non-prefetchable) [s=
ize=3D2M]
             Capabilities: [48] Power Management version 3
                     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
2 PME-
             Capabilities: [58] MSI: Enable- Count=3D1/1 Maskable- 64bi=
t+
                     Address: 0000000000000000  Data: 0000
             Capabilities: [68] Vendor Specific Information: Len=3D44 <=
?>
             Capabilities: [ac] Express (v2) Endpoint, MSI 00
                     DevCap: MaxPayload 256 bytes, PhantFunc 0,
Latency L0s <4us, L1 unlimited
                             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLR=
eset-
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoo=
p+
                             MaxPayload 128 bytes, MaxReadReq 1024 byte=
s
                     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                     LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM
L0s L1, Exit Latency L0s <2us, L1 <32us
                             ClockPM+ Surprise- LLActRep- BwNot- ASPMOp=
tComp+
                     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
Disabled- CommClk+
                             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                     DevCap2: Completion Timeout: Range ABCD,
TimeoutDis+, LTR+, OBFF Via WAKE#
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled
                     LnkCtl2: Target Link Speed: 2.5GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                              EqualizationPhase2-,
EqualizationPhase3-, LinkEqualizationRequest-
             Capabilities: [100 v1] Advanced Error Reporting
                     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                     UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                     CESta:  RxErr- BadTLP- BadDLLP- Rollover-
Timeout- NonFatalErr-
                     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover-
Timeout- NonFatalErr+
                     AERCap: First Error Pointer: 00, GenCap+ CGenEn-
ChkCap+ ChkEn-
             Capabilities: [13c v1] Device Serial Number c4-8e-00-ff-ff=
-00-00-01
             Capabilities: [150 v1] Power Budgeting <?>
             Capabilities: [160 v1] Virtual Channel
                     Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                     Arb:    Fixed- WRR32- WRR64- WRR128-
                     Ctrl:   ArbSelect=3DFixed
                     Status: InProgress-
                     VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
                             Arb:    Fixed- WRR32- WRR64- WRR128-
TWRR128- WRR256-
                             Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed T=
C/VC=3D01
                             Status: NegoPending- InProgress-
             Capabilities: [1b0 v1] Latency Tolerance Reporting
                     Max snoop latency: 71680ns
                     Max no snoop latency: 71680ns
             Capabilities: [220 v1] #15
             Kernel driver in use: wl

     07:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5249 PCI Express Card Reader (rev 01)
             Subsystem: Dell Device 05fe
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0, Cache Line Size: 64 bytes
             Interrupt: pin A routed to IRQ 31
             Region 0: Memory at f7b00000 (32-bit, non-prefetchable) [s=
ize=3D4K]
             Capabilities: [40] Power Management version 3
                     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                     Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
             Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
                     Address: 00000000fee00318  Data: 0000
             Capabilities: [70] Express (v2) Endpoint, MSI 00
                     DevCap: MaxPayload 512 bytes, PhantFunc 0,
Latency L0s unlimited, L1 unlimited
                             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLR=
eset-
                     DevCtl: Report errors: Correctable- Non-Fatal-
=46atal- Unsupported-
                             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
                             MaxPayload 128 bytes, MaxReadReq 512 bytes
                     DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                     LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM
L0s L1, Exit Latency L0s unlimited, L1 <64us
                             ClockPM+ Surprise- LLActRep- BwNot- ASPMOp=
tComp+
                     LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Co=
mmClk+
                             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBW=
Int-
                     LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                     DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR+, OBFF Via message/WAKE#
                     DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled
                     LnkCtl2: Target Link Speed: 2.5GT/s,
EnterCompliance- SpeedDis-
                              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                              Compliance De-emphasis: -6dB
                     LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                              EqualizationPhase2-,
EqualizationPhase3-, LinkEqualizationRequest-
             Capabilities: [100 v2] Advanced Error Reporting
                     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                     UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                     CESta:  RxErr+ BadTLP- BadDLLP+ Rollover-
Timeout+ NonFatalErr-
                     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover-
Timeout- NonFatalErr+
                     AERCap: First Error Pointer: 00, GenCap+ CGenEn-
ChkCap+ ChkEn-
             Capabilities: [148 v1] Device Serial Number 00-00-00-01-00=
-4c-e0-00
             Capabilities: [158 v1] Latency Tolerance Reporting
                     Max snoop latency: 71680ns
                     Max no snoop latency: 71680ns
             Capabilities: [160 v1] L1 PM Substates
                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                               PortCommonModeRestoreTime=3D60us
PortTPowerOnTime=3D60us
             Kernel driver in use: rtsx_pci

7.6. /proc/scsi/scsi:
     Attached devices:
     Host: scsi0 Channel: 00 Id: 00 Lun: 00
       Vendor: ATA      Model: TOSHIBA MQ02ABF1 Rev: 1D
       Type:   Direct-Access                    ANSI  SCSI revision: 05
     Host: scsi1 Channel: 00 Id: 00 Lun: 00
       Vendor: ATA      Model: SAMSUNG SSD PM83 Rev: 3D1Q
       Type:   Direct-Access                    ANSI  SCSI revision: 05

7.7. ls /proc
     1     1177  132   16    1903  211   323   50    6731  8348  92
99             fs            scsi
     10    1178  1320  17    1904  2113  33    51    6739  8388  922
9908           interrupts    self
     100   12    1322  1794  1907  2128  35    52    7     849   926
9912           iomem         slabinfo
     101   1222  1324  1795  191   213   36    53    7172  852   93
9923           ioports       softirqs
     102   1231  1340  18    192   215   363   54    7503  858   94
9961           irq           stat
     103   1232  1342  180   193   2161  37    549   760   859   946
9964           kallsyms      swaps
     104   1233  1349  1800  1943  22    38    55    766   861   947
9979           kcore         sys
     1047  1235  1376  1803  1947  225   380   552   7672  8648  95
9981           keys          sysrq-trigger
     1048  1254  1386  1805  1950  226   392   553   7676  8682  957
9992           key-users     sysvipc
     1049  1257  1387  1809  1955  227   40    554   769   869   958
acpi           kmsg          thread-self
     105   1263  1388  1812  1959  23    41    556   770   87    959
asound         kpagecgroup   timer_list
     1056  1264  1389  182   1963  235   42    557   7747  872   96
brcm_monitor0  kpagecount    timer_stats
     1057  1266  1390  183   1967  2351  43    56    775   877   965
buddyinfo      kpageflags    tty
     1059  1271  1391  184   1971  2362  430   57    776   878   9670
bus            loadavg       uptime
     106   1272  1392  185   1975  25    432   58    780   879   9680
cgroups        locks         version
     107   1283  1393  186   2     26    433   59    781   8799  9686
cmdline        mdstat        vmallocinfo
     108   1287  1394  1864  20    27    4478  5926  789   880   9688
consoles       meminfo       vmstat
     109   1293  1402  1869  2018  28    45    5929  8     881   97
cpuinfo        misc          zoneinfo
     11    1294  1403  187   2028  295   452   611   800   884   9760
crypto         modules
     110   1295  1404  1871  2034  296   46    612   804   89    9762
devices        mounts
     1103  13    1405  188   2041  297   464   63    806   9     98
diskstats      mtrr
     1104  1300  1406  189   2047  3     47    6411  8134  90    9819
dma            net
     111   1303  15    1892  206   30    472   65    8170  903   9825
driver         pagetypeinfo
     112   131   1500  1899  2093  31    48    66    82    91    9835
execdomains    partitions
     116   1316  1510  190   21    32    49    67    820   910   9860
fb             sched_debug
     1174  1317  1529  1900  2109  322   5     6705  83    918   9871
filesystems    schedstat

Gast=C3=B3n.
TW: @ktonga
L-in: http://www.linkedin.com/in/gastontonietti
Meetup: http://www.meetup.com/scala_ar/
