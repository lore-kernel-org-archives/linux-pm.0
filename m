From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Wed, 08 Oct 2014 08:46:27 -0400
Message-ID: <54353223.7080704@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55533 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137AbaJHMqo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Oct 2014 08:46:44 -0400
In-Reply-To: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/08/2014 03:04 AM, Viresh Kumar wrote:
> On 25 September 2014 11:37, Robert Sch=C3=B6ne <robert.schoene@tu-dre=
sden.de> wrote:
>> We had some iterations of patches, but the only solution that works =
for
>> me is the patch with the coarse-grained lock that I sent at Mon, 08 =
Sep
>> 2014 10:16:48 CEST [1]
>> Viresh is pretty occupied lately, but he told me that he might do th=
e
>> tests himself when the current period of busyness is over as he is
>> supplied with a test system. I'm not sure about his current status (=
busy
>> or testing).
>=20
> Hi Robert/Prarit,
>=20
> The last state of my branch: cpufreq/governor-fixes you tested had
> few bugs in it and so you weren't able to even tests things up.
>=20
> I couldn't manage to test my patches on a multi-cluster system
> (couldn't get it up yet :( ), but was able to do that on a dual-core
> ARM-cortexA15 board. And could simply find the bugs there.
>=20
> I have updated my branch with the changes now and it would be
> great if you can confirm if they fix your issues or not.
>=20
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/governor-f=
ixes

Hey Viresh, this is on my plate for today.  It does look like the panic=
 I sent
you yesterday in email does occur when your patches are put into the la=
test
upstream kernel :(.

I'm going to debug shortly ... for anyone interested the panic is:

[   30.402052] Modules linked in: rfkill nfsd auth_rpcgss nfs_acl lockd=
 sunrpc
e1000e x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
crct10dif_pclmul iTCO_wdt iTCO_vendor_support i2c_i801 ptp crc32_pclmul
crc32c_intel ghash_clmulni_intel sb_edac pps_core aesni_intel lrw gf128=
mul
glue_helper ablk_helper cryptd pcspkr lpc_ich edac_core shpchp mfd_core=
 wmi
ipmi_si ipmi_msghandler acpi_pad acpi_cpufreq xfs libcrc32c sd_mod sr_m=
od cdrom
crc_t10dif crct10dif_common mgag200 syscopyarea sysfillrect sysimgblt
i2c_algo_bit drm_kms_helper ttm drm ahci libahci libata usb_storage i2c=
_core
dm_mirror dm_region_hash dm_log dm_mod
[   30.464642] CPU: 106 PID: 2074 Comm: cpupower Not tainted 3.17.0+ #2
[   30.471743] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BI=
OS
BIVTSDP1.86B.0049.R00.1403081207 03/08/2014
[   30.483308] task: ffff88104fafec80 ti: ffff88104f914000 task.ti: fff=
f88104f914000
[   30.491669] RIP: 0010:[<ffffffff810a8a05>]  [<ffffffff810a8a05>]
update_blocked_averages+0x205/0x740
[   30.501897] RSP: 0018:ffff88205f203df8  EFLAGS: 00010002
[   30.507831] RAX: 000000000000006a RBX: ffff882050181e00 RCX: 2030203=
020302030
[   30.515803] RDX: 2030203020302030 RSI: 0000000000000000 RDI: 0000000=
000000000
[   30.523777] RBP: ffff88205f203e60 R08: ffffffffffffffff R09: ffff882=
05f214800
[   30.531750] R10: 0000000000000000 R11: 000000000000b4d1 R12: ffff882=
05078fc00
[   30.539721] R13: ffff882043e07c00 R14: ffff88205f214780 R15: ffff882=
05f215028
[   30.547694] FS:  00007f1bf54a4740(0000) GS:ffff88205f200000(0000)
knlGS:0000000000000000
[   30.556733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.563154] CR2: 00007f1bf4a01900 CR3: 0000002048160000 CR4: 0000000=
0001407e0
[   30.571127] Stack:
[   30.573372]  00002362000f4240 000000000000013b 0000000000000066 ffff=
882043e07c00
[   30.581677]  ffff88205f214800 0000000000000246 ffff88205078fcc0 0000=
000011e9d93e
[   30.589988]  00000000fffcc75f ffff88205f214780 0000000000014780 0000=
000000000001
[   30.598294] Call Trace:
[   30.601025]  <IRQ>
[   30.603173]  [<ffffffff810af9b4>] rebalance_domains+0x54/0x290
[   30.609916]  [<ffffffff810afc34>] run_rebalance_domains+0x44/0x1d0
[   30.616827]  [<ffffffff810797a5>] __do_softirq+0xf5/0x2e0
[   30.622861]  [<ffffffff81079c6d>] irq_exit+0x10d/0x120
[   30.628608]  [<ffffffff81656155>] smp_apic_timer_interrupt+0x45/0x60
[   30.635710]  [<ffffffff8165425d>] apic_timer_interrupt+0x6d/0x80
[   30.642418]  <EOI>
[   30.644566]  [<ffffffff813043e2>] ? number.isra.2+0x62/0x360
[   30.651121]  [<ffffffff813046a3>] ? number.isra.2+0x323/0x360
[   30.657545]  [<ffffffff81306755>] vsnprintf+0x3e5/0x5c0
[   30.663385]  [<ffffffff81306ab6>] sprintf+0x56/0x80
[   30.668841]  [<ffffffff814e42be>] show_available_freqs.isra.1+0xae/0=
xc0
[   30.676235]  [<ffffffff814e42e7>] scaling_available_frequencies_show=
+0x17/0x20
[   30.684307]  [<ffffffff814e04ac>] show+0x5c/0x90
[   30.689472]  [<ffffffff8125df6c>] sysfs_kf_seq_show+0xcc/0x1e0
[   30.695992]  [<ffffffff8125c663>] kernfs_seq_show+0x23/0x30
[   30.702224]  [<ffffffff8120970a>] seq_read+0xfa/0x3a0
[   30.707870]  [<ffffffff8125ced5>] kernfs_fop_read+0xf5/0x160
[   30.714198]  [<ffffffff811e5b28>] vfs_read+0x98/0x170
[   30.719844]  [<ffffffff811e6805>] SyS_read+0x55/0xd0
[   30.725394]  [<ffffffff81653369>] system_call_fastpath+0x16/0x1b
[   30.732104] Code: c7 4c 8d a0 40 ff ff ff 0f 84 c0 00 00 00 49 8b 94=
 24 d0 00
00 00 49 63 86 70 09 00 00 48 8b 8a a8 00 00 00 48 8b 92 b0 00 00 00 <4=
8> 8b 1c
c1 4c 8b 2c c2 0f 1f 44 00 00 be 01 00 00 00 4c 89 ef
[   30.753924] RIP  [<ffffffff810a8a05>] update_blocked_averages+0x205/=
0x740
[   30.761523]  RSP <ffff88205f203df8>
[   30.765421] ---[ end trace c3a68cab33090779 ]---
[   30.770579] Kernel panic - not syncing: Fatal exception in interrupt
[   30.773853] general protection fault: 0000 [#2] SMP
[   30.773900] Modules linked in: rfkill nfsd auth_rpcgss nfs_acl lockd=
 sunrpc
e1000e x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
crct10dif_pclmul iTCO_wdt iTCO_vendor_support i2c_i801 ptp crc32_pclmul
crc32c_intel ghash_clmulni_intel sb_edac pps_core aesni_intel lrw gf128=
mul
glue_helper ablk_helper cryptd pcspkr lpc_ich edac_core shpchp mfd_core=
 wmi
ipmi_si ipmi_msghandler acpi_pad acpi_cpufreq xfs libcrc32c sd_mod sr_m=
od cdrom
crc_t10dif crct10dif_common mgag200 syscopyarea sysfillrect sysimgblt
i2c_algo_bit drm_kms_helper ttm drm ahci libahci libata usb_storage i2c=
_core
dm_mirror dm_region_hash dm_log dm_mod
[   30.773905] CPU: 32 PID: 0 Comm: swapper/32 Tainted: G      D       =
 3.17.0+ #2
[   30.773907] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BI=
OS
BIVTSDP1.86B.0049.R00.1403081207 03/08/2014
[   30.773909] task: ffff882053e93640 ti: ffff880853610000 task.ti: fff=
f880853610000
[   30.773923] RIP: 0010:[<ffffffff810a8a05>]  [<ffffffff810a8a05>]
update_blocked_averages+0x205/0x740
[   30.773925] RSP: 0018:ffff88185f843df8  EFLAGS: 00010002
[   30.773926] RAX: 0000000000000020 RBX: ffff88184d6a4a80 RCX: 2030203=
020302030
[   30.773928] RDX: 2030203020302030 RSI: 0000000000000000 RDI: ffff881=
85173f4c0
[   30.773929] RBP: ffff88185f843e60 R08: ffff88185173f4c0 R09: ffff881=
85f854800
[   30.773930] R10: 0000000000000000 R11: 000000000000be09 R12: ffff881=
85081f400
[   30.773931] R13: ffff88185173f400 R14: ffff88185f854780 R15: ffff881=
85f855028
[   30.773934] FS:  0000000000000000(0000) GS:ffff88185f840000(0000)
knlGS:0000000000000000
[   30.773935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.773937] CR2: 00007f5090003308 CR3: 000000000197c000 CR4: 0000000=
0001407e0
[   30.773938] Stack:
[   30.773942]  0000000154104f38 0000000000000389 0000000000000000 ffff=
88185173f400
[   30.773945]  ffff88185f854800 0000000000000246 ffff88185081f4c0 a8dd=
852b1b50c0c9
[   30.773947]  00000000fffcc8d8 ffff88185f854780 0000000000014780 0000=
000000000000
[   30.773948] Call Trace:
[   30.773952]  <IRQ>
[   30.773957]  [<ffffffff810af9b4>] rebalance_domains+0x54/0x290
[   30.773967]  [<ffffffff810d7066>] ? call_timer_fn+0x36/0x100
[   30.773971]  [<ffffffff810afc34>] run_rebalance_domains+0x44/0x1d0
[   30.773979]  [<ffffffff810797a5>] __do_softirq+0xf5/0x2e0
[   30.773982]  [<ffffffff81079c6d>] irq_exit+0x10d/0x120
[   30.773991]  [<ffffffff81656155>] smp_apic_timer_interrupt+0x45/0x60
[   30.773994]  [<ffffffff8165425d>] apic_timer_interrupt+0x6d/0x80
[   30.773996]  <EOI>
[   30.774005]  [<ffffffff814e8ac0>] ? cpuidle_enter_state+0x70/0x170
[   30.774008]  [<ffffffff814e8c77>] cpuidle_enter+0x17/0x20
[   30.774014]  [<ffffffff810b5d5d>] cpu_startup_entry+0x37d/0x3a0
[   30.774021]  [<ffffffff81048550>] start_secondary+0x210/0x2d0
[   30.774045] Code: c7 4c 8d a0 40 ff ff ff 0f 84 c0 00 00 00 49 8b 94=
 24 d0 00
00 00 49 63 86 70 09 00 00 48 8b 8a a8 00 00 00 48 8b 92 b0 00 00 00 <4=
8> 8b 1c
c1 4c 8b 2c c2 0f 1f 44 00 00 be 01 00 00 00 4c 89 ef
[   30.774049] RIP  [<ffffffff810a8a05>] update_blocked_averages+0x205/=
0x740
[   30.774050]  RSP <ffff88185f843df8>
[   30.774054] ---[ end trace c3a68cab3309077a ]---
[   32.189638] Shutting down cpus with NMI
[   32.193941] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation r=
ange:
0xffffffff80000000-0xffffffff9fffffff)
[   32.205301] drm_kms_helper: panic occurred, switching back to text c=
onsole
[   32.213005] ---[ end Kernel panic - not syncing: Fatal exception in =
interrup

P.

>=20
> --
> viresh
>=20
