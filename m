From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: PROBLEM: Kernel OOPS and possible system freeze after concurrent
 writing to cpufreq/scaling_governor
Date: Wed, 16 Jul 2014 16:53:18 +0200
Message-ID: <1405522398.2348.42.camel@x200t>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha1"; protocol="application/x-pkcs7-signature";
	boundary="=-P1rtuu2ixH71NsS23g1j"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:35681 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754903AbaGPPNz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 11:13:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org


--=-P1rtuu2ixH71NsS23g1j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1. Summary:
When two or more processes concurrently activate the ondemand governor, Lin=
ux might crash.

2. Problem:
When I write concurrently to the cpufreq sysfs scaling_governor files, the =
kernel gives me first a warning and as a follow multiple oops'. Afterwards =
several systems within the kernel fail and I have to reboot the system. Whi=
le the bug report is based on the current Ubuntu kernel (3.13.0-27-generic)=
, it also appears on the latest mainline (3.16-rc5). However, I only manage=
d to get the kernel log from the older Ubuntu kernel.


3. Keywords: cpufreq, governor, policy, ondemand

4. Kernel Version
Linux version 3.13.0-27-generic (buildd@akateko) (gcc version 4.8.2 (Ubuntu=
 4.8.2-19ubuntu1) ) #50-Ubuntu SMP Thu May 15 18:06:16 UTC 2014

5. Warning message, followed by OOPS messages:

Jul 16 09:47:39 basti kernel: [  398.441455] ------------[ cut here ]------=
------
Jul 16 09:47:39 basti kernel: [  398.441462] WARNING: CPU: 5 PID: 4263 at /=
build/buildd/linux-3.13.0/drivers/cpufreq/cpufreq_governor.c:203 cpufreq_go=
vernor_dbs+0x682/0x6f0()
Jul 16 09:47:39 basti kernel: [  398.441494] Modules linked in: vtsspp(OF) =
sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfs=
d auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_c=
odec_conexant ppdev gpio_ich intel_rapl x86_pkg
_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc3=
2_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helpe=
r ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 =
snd_hwdep lpc_ich snd_pcm video drm_kms_helper=20
tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd i2c_algo_bit sound=
core mac_hid lp parport e1000e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.441496] CPU: 5 PID: 4263 Comm: tee Tai=
nted: GF          O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.441497] Hardware name: FUJITSU ESPRIMO=
 P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.441500]  0000000000000009 ffff8800b308=
1bc0 ffffffff817199c4 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441502]  ffff8800b3081bf8 ffffffff8106=
76bd 0000000000000000 ffff88022ebb4e00
Jul 16 09:47:39 basti kernel: [  398.441504]  0000000000000004 000000000000=
0002 ffffffff81cd3ae0 ffff8800b3081c08
Jul 16 09:47:39 basti kernel: [  398.441504] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.441509]  [<ffffffff817199c4>] dump_sta=
ck+0x45/0x56
Jul 16 09:47:39 basti kernel: [  398.441512]  [<ffffffff810676bd>] warn_slo=
wpath_common+0x7d/0xa0
Jul 16 09:47:39 basti kernel: [  398.441513]  [<ffffffff8106779a>] warn_slo=
wpath_null+0x1a/0x20
Jul 16 09:47:39 basti kernel: [  398.441515]  [<ffffffff815c7142>] cpufreq_=
governor_dbs+0x682/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441518]  [<ffffffff81725ebc>] ? notifi=
er_call_chain+0x4c/0x70
Jul 16 09:47:39 basti kernel: [  398.441520]  [<ffffffff815c4fc7>] od_cpufr=
eq_governor_dbs+0x17/0x20
Jul 16 09:47:39 basti kernel: [  398.441522]  [<ffffffff815c10cd>] __cpufre=
q_governor+0xfd/0x230
Jul 16 09:47:39 basti kernel: [  398.441524]  [<ffffffff815c1349>] cpufreq_=
set_policy+0x149/0x2e0
Jul 16 09:47:39 basti kernel: [  398.441526]  [<ffffffff815c28bd>] store_sc=
aling_governor+0xad/0xf0
Jul 16 09:47:39 basti kernel: [  398.441527]  [<ffffffff815c2260>] ? cpufre=
q_update_policy+0x170/0x170
Jul 16 09:47:39 basti kernel: [  398.441529]  [<ffffffff815c1a19>] store+0x=
79/0xc0
Jul 16 09:47:39 basti kernel: [  398.441532]  [<ffffffff812325b8>] sysfs_wr=
ite_file+0x128/0x1c0
Jul 16 09:47:39 basti kernel: [  398.441534]  [<ffffffff811bc664>] vfs_writ=
e+0xb4/0x1f0
Jul 16 09:47:39 basti kernel: [  398.441536]  [<ffffffff811bd099>] SyS_writ=
e+0x49/0xa0
Jul 16 09:47:39 basti kernel: [  398.441539]  [<ffffffff8172a5bf>] tracesys=
+0xe1/0xe6
Jul 16 09:47:39 basti kernel: [  398.441540] ---[ end trace 9a9b0afb92b8c41=
f ]---
Jul 16 09:47:39 basti kernel: [  398.441545] BUG: unable to handle kernel N=
ULL pointer dereference at           (null)
Jul 16 09:47:39 basti kernel: [  398.441547] IP: [<ffffffff815c6b12>] cpufr=
eq_governor_dbs+0x52/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441549] PGD b39cc067 PUD b30cb067 PMD =
0=20
Jul 16 09:47:39 basti kernel: [  398.441550] Oops: 0000 [#1] SMP=20
Jul 16 09:47:39 basti kernel: [  398.441571] Modules linked in: vtsspp(OF) =
sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfs=
d auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_c=
odec_conexant ppdev gpio_ich intel_rapl x86_pkg
_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc3=
2_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helpe=
r ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 =
snd_hwdep lpc_ich snd_pcm video drm_kms_helper=20
tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd i2c_algo_bit sound=
core mac_hid lp parport e1000e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.441573] CPU: 5 PID: 4263 Comm: tee Tai=
nted: GF       W  O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.441573] Hardware name: FUJITSU ESPRIMO=
 P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.441574] task: ffff88022e5f17f0 ti: fff=
f8800b3080000 task.ti: ffff8800b3080000
Jul 16 09:47:39 basti kernel: [  398.441576] RIP: 0010:[<ffffffff815c6b12>]=
  [<ffffffff815c6b12>] cpufreq_governor_dbs+0x52/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441577] RSP: 0018:ffff8800b3081c18  EF=
LAGS: 00010293
Jul 16 09:47:39 basti kernel: [  398.441577] RAX: 0000000000000024 RBX: 000=
0000000000000 RCX: 00000000000096aa
Jul 16 09:47:39 basti kernel: [  398.441578] RDX: 0000000096aa96aa RSI: 000=
0000000000000 RDI: 0000000000000009
Jul 16 09:47:39 basti kernel: [  398.441579] RBP: ffff8800b3081c88 R08: 000=
0000000000082 R09: ffffffff81ecdd30
Jul 16 09:47:39 basti kernel: [  398.441579] R10: 000000000002f8a0 R11: 000=
0000000040000 R12: ffff88022ebb4e00
Jul 16 09:47:39 basti kernel: [  398.441580] R13: 0000000000000004 R14: 000=
0000000000002 R15: ffffffff81cd3ae0
Jul 16 09:47:39 basti kernel: [  398.441580] FS:  00002b53b77acb80(0000) GS=
:ffff88023e340000(0000) knlGS:0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441581] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Jul 16 09:47:39 basti kernel: [  398.441582] CR2: 0000000000000000 CR3: 000=
00000b395c000 CR4: 00000000000407e0
Jul 16 09:47:39 basti kernel: [  398.441582] Stack:
Jul 16 09:47:39 basti kernel: [  398.441583]  0000000000000000 000000000000=
0002 ffff8800b3081d00 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441584]  ffff8800b3081c70 ffffffff8172=
5ebc ffffffff81cd3520 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441586]  0000000000000002 ffff88022ebb=
4e00 0000000000000002 ffffffff81cd3b40
Jul 16 09:47:39 basti kernel: [  398.441586] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.441587]  [<ffffffff81725ebc>] ? notifi=
er_call_chain+0x4c/0x70
Jul 16 09:47:39 basti kernel: [  398.441589]  [<ffffffff815c4fc7>] od_cpufr=
eq_governor_dbs+0x17/0x20
Jul 16 09:47:39 basti kernel: [  398.441590]  [<ffffffff815c10cd>] __cpufre=
q_governor+0xfd/0x230
Jul 16 09:47:39 basti kernel: [  398.441591]  [<ffffffff815c1349>] cpufreq_=
set_policy+0x149/0x2e0
Jul 16 09:47:39 basti kernel: [  398.441592]  [<ffffffff815c28bd>] store_sc=
aling_governor+0xad/0xf0
Jul 16 09:47:39 basti kernel: [  398.441593]  [<ffffffff815c2260>] ? cpufre=
q_update_policy+0x170/0x170
Jul 16 09:47:39 basti kernel: [  398.441594]  [<ffffffff815c1a19>] store+0x=
79/0xc0
Jul 16 09:47:39 basti kernel: [  398.441595]  [<ffffffff812325b8>] sysfs_wr=
ite_file+0x128/0x1c0
Jul 16 09:47:39 basti kernel: [  398.441597]  [<ffffffff811bc664>] vfs_writ=
e+0xb4/0x1f0
Jul 16 09:47:39 basti kernel: [  398.441600]  [<ffffffff811bd099>] SyS_writ=
e+0x49/0xa0
Jul 16 09:47:39 basti kernel: [  398.441601]  [<ffffffff8172a5bf>] tracesys=
+0xe1/0xe6
Jul 16 09:47:39 basti kernel: [  398.441611] Code: ff 84 c0 0f 84 40 02 00 =
00 49 8b 5c 24 70 48 85 db 0f 84 29 06 00 00 41 83 fe 04 0f 84 60 02 00 00 =
41 83 fe 05 0f 84 2e 02 00 00 <48> 8b 03 44 89 ef ff 50 20 48 89 45 c0 48 8=
b 03 83 38 01 0f 84=20
Jul 16 09:47:39 basti kernel: [  398.441612] RIP  [<ffffffff815c6b12>] cpuf=
req_governor_dbs+0x52/0x6f0
Jul 16 09:47:39 basti kernel: [  398.441613]  RSP <ffff8800b3081c18>
Jul 16 09:47:39 basti kernel: [  398.441613] CR2: 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.441615] ---[ end trace 9a9b0afb92b8c42=
0 ]---
Jul 16 09:47:39 basti kernel: [  398.444572] general protection fault: 0000=
 [#2] SMP=20
Jul 16 09:47:39 basti kernel: [  398.444628] Modules linked in: vtsspp(OF) =
sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfs=
d auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_c=
odec_conexant ppdev gpio_ich intel_rapl x86_pkg
_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc3=
2_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helpe=
r ablk_helper cryptd parport_pc serio_raw snd_hda_intel snd_hda_codec i915 =
snd_hwdep lpc_ich snd_pcm video drm_kms_helper tpm_infineon drm snd_page_al=
loc mei_me snd_timer mei snd i2c_algo_bit soundcore mac_hid lp parport e100=
0e ahci psmouse libahci ptp pps_core
Jul 16 09:47:39 basti kernel: [  398.444629] CPU: 4 PID: 126 Comm: kworker/=
4:1 Tainted: GF     D W  O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.444630] Hardware name: FUJITSU ESPRIMO=
 P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.444633] Workqueue: events od_dbs_timer
Jul 16 09:47:39 basti kernel: [  398.444634] task: ffff88022e5a97f0 ti: fff=
f88022e69e000 task.ti: ffff88022e69e000
Jul 16 09:47:39 basti kernel: [  398.444636] RIP: 0010:[<ffffffff815c5957>]=
  [<ffffffff815c5957>] od_dbs_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444636] RSP: 0000:ffff88022e69fde8  EF=
LAGS: 00010246
Jul 16 09:47:39 basti kernel: [  398.444637] RAX: ffff88022e5a97f0 RBX: fff=
f88023e310e20 RCX: 0000000000000004
Jul 16 09:47:39 basti kernel: [  398.444637] RDX: 0000000000000004 RSI: 000=
00000170e170c RDI: ffff88023e310ec8
Jul 16 09:47:39 basti kernel: [  398.444638] RBP: ffff88022e69fe20 R08: 200=
8f8c439200000 R09: 7240000000000000
Jul 16 09:47:39 basti kernel: [  398.444638] R10: dff68f3e05110e48 R11: 000=
0000000000004 R12: 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444639] R13: ffff880231144b80 R14: fff=
f88023e310e48 R15: dead000000100100
Jul 16 09:47:39 basti kernel: [  398.444640] FS:  0000000000000000(0000) GS=
:ffff88023e300000(0000) knlGS:0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444640] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Jul 16 09:47:39 basti kernel: [  398.444641] CR2: 00002b8959f3f1f0 CR3: 000=
000022e68f000 CR4: 00000000000407e0
Jul 16 09:47:39 basti kernel: [  398.444641] Stack:
Jul 16 09:47:39 basti kernel: [  398.444643]  000000042e61f700 ffff88023e31=
0ec8 ffff88022eb3c800 ffff88023e313cc0
Jul 16 09:47:39 basti kernel: [  398.444644]  ffff88023e310e48 000000000000=
0000 0000000000000100 ffff88022e69fe68
Jul 16 09:47:39 basti kernel: [  398.444645]  ffffffff810838a2 000000003e31=
3cd8 ffff88023e317e00 ffff88023e313cd8
Jul 16 09:47:39 basti kernel: [  398.444645] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.444649]  [<ffffffff810838a2>] process_=
one_work+0x182/0x450
Jul 16 09:47:39 basti kernel: [  398.444651]  [<ffffffff81084641>] worker_t=
hread+0x121/0x410
Jul 16 09:47:39 basti kernel: [  398.444652]  [<ffffffff81084520>] ? rescue=
r_thread+0x3e0/0x3e0
Jul 16 09:47:39 basti kernel: [  398.444654]  [<ffffffff8108b312>] kthread+=
0xd2/0xf0
Jul 16 09:47:39 basti kernel: [  398.444655]  [<ffffffff8108b240>] ? kthrea=
d_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444658]  [<ffffffff8172a2fc>] ret_from=
_fork+0x7c/0xb0
Jul 16 09:47:39 basti kernel: [  398.444659]  [<ffffffff8108b240>] ? kthrea=
d_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444668] Code: d1 4d 8b 7d 10 89 55 cc =
48 03 1c cd 60 28 d1 81 48 8d 83 a8 00 00 00 44 0f b6 a3 f0 00 00 00 48 89 =
c7 48 89 45 d0 e8 99 a8 15 00 <41> 8b 77 04 48 89 df 41 83 e4 01 e8 19 10 0=
0 00 84 c0 8b 55 cc=20
Jul 16 09:47:39 basti kernel: [  398.444670] RIP  [<ffffffff815c5957>] od_d=
bs_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444670]  RSP <ffff88022e69fde8>
Jul 16 09:47:39 basti kernel: [  398.444671] ---[ end trace 9a9b0afb92b8c42=
1 ]---
Jul 16 09:47:39 basti kernel: [  398.444703] BUG: unable to handle kernel p=
aging request at ffffffffffffffd8
Jul 16 09:47:39 basti kernel: [  398.444706] IP: [<ffffffff8108b9b0>] kthre=
ad_data+0x10/0x20
Jul 16 09:47:39 basti kernel: [  398.444710] PGD 1c11067 PUD 1c13067 PMD 0=
=20
Jul 16 09:47:39 basti kernel: [  398.444713] Oops: 0000 [#3] SMP=20
Jul 16 09:47:39 basti kernel: [  398.444725] Modules linked in: vtsspp(OF) =
sep3_15(OF) pax(OF) apwr3_1(OF) nfsv3 rfcomm bnep bluetooth binfmt_misc nfs=
d auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdmi snd_hda_c=
odec_conexant ppdev gpio_ich intel_rapl x86_pkg_temp_thermal intel_powercla=
mp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel=
 aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd parport=
_pc serio_raw snd_hda_intel snd_hda_codec i915 snd_hwdep lpc_ich snd_pcm vi=
deo drm_kms_helper tpm_infineon drm snd_page_alloc mei_me snd_timer mei snd=
 i2c_algo_bit soundcore mac_hid lp parport e1000e ahci psmouse libahci ptp =
pps_core
Jul 16 09:47:39 basti kernel: [  398.444726] CPU: 4 PID: 126 Comm: kworker/=
4:1 Tainted: GF     D W  O 3.13.0-27-generic #50-Ubuntu
Jul 16 09:47:39 basti kernel: [  398.444727] Hardware name: FUJITSU ESPRIMO=
 P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 16 09:47:39 basti kernel: [  398.444732] task: ffff88022e5a97f0 ti: fff=
f88022e69e000 task.ti: ffff88022e69e000
Jul 16 09:47:39 basti kernel: [  398.444733] RIP: 0010:[<ffffffff8108b9b0>]=
  [<ffffffff8108b9b0>] kthread_data+0x10/0x20
Jul 16 09:47:39 basti kernel: [  398.444734] RSP: 0000:ffff88022e69fba0  EF=
LAGS: 00010002
Jul 16 09:47:39 basti kernel: [  398.444734] RAX: 0000000000000000 RBX: 000=
0000000000004 RCX: 000000000000000d
Jul 16 09:47:39 basti kernel: [  398.444735] RDX: 0000000000000005 RSI: 000=
0000000000004 RDI: ffff88022e5a97f0
Jul 16 09:47:39 basti kernel: [  398.444735] RBP: ffff88022e69fba0 R08: 000=
0000000000000 R09: 0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444736] R10: ffffffff8106518c R11: fff=
fea0008c99800 R12: ffff88023e314440
Jul 16 09:47:39 basti kernel: [  398.444736] R13: 0000000000000004 R14: fff=
f88022e5a97e0 R15: ffff88022e5a97f0
Jul 16 09:47:39 basti kernel: [  398.444738] FS:  0000000000000000(0000) GS=
:ffff88023e300000(0000) knlGS:0000000000000000
Jul 16 09:47:39 basti kernel: [  398.444740] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Jul 16 09:47:39 basti kernel: [  398.444741] CR2: 0000000000000028 CR3: 000=
000022e68f000 CR4: 00000000000407e0
Jul 16 09:47:39 basti kernel: [  398.444742] Stack:
Jul 16 09:47:39 basti kernel: [  398.444748]  ffff88022e69fbb8 ffffffff8108=
4d51 ffff88022e5a97f0 ffff88022e69fc18
Jul 16 09:47:39 basti kernel: [  398.444753]  ffffffff8171db79 ffff88022e5a=
97f0 ffff88022e69ffd8 0000000000014440
Jul 16 09:47:39 basti kernel: [  398.444757]  0000000000014440 ffff88022e5a=
97f0 ffff88022e5a9e28 ffff88022e5a97e0
Jul 16 09:47:39 basti kernel: [  398.444757] Call Trace:
Jul 16 09:47:39 basti kernel: [  398.444759]  [<ffffffff81084d51>] wq_worke=
r_sleeping+0x11/0x90
Jul 16 09:47:39 basti kernel: [  398.444761]  [<ffffffff8171db79>] __schedu=
le+0x589/0x7d0
Jul 16 09:47:39 basti kernel: [  398.444762]  [<ffffffff8171dde9>] schedule=
+0x29/0x70
Jul 16 09:47:39 basti kernel: [  398.444764]  [<ffffffff8106a02f>] do_exit+=
0x6df/0xa50
Jul 16 09:47:39 basti kernel: [  398.444765]  [<ffffffff81722e79>] oops_end=
+0xa9/0x150
Jul 16 09:47:39 basti kernel: [  398.444767]  [<ffffffff810171cb>] die+0x4b=
/0x70
Jul 16 09:47:39 basti kernel: [  398.444768]  [<ffffffff8172280e>] do_gener=
al_protection+0x11e/0x1b0
Jul 16 09:47:39 basti kernel: [  398.444770]  [<ffffffff81722128>] general_=
protection+0x28/0x30
Jul 16 09:47:39 basti kernel: [  398.444773]  [<ffffffff815c5957>] ? od_dbs=
_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444776]  [<ffffffff815c5957>] ? od_dbs=
_timer+0x57/0x160
Jul 16 09:47:39 basti kernel: [  398.444779]  [<ffffffff810838a2>] process_=
one_work+0x182/0x450
Jul 16 09:47:39 basti kernel: [  398.444781]  [<ffffffff81084641>] worker_t=
hread+0x121/0x410
Jul 16 09:47:39 basti kernel: [  398.444784]  [<ffffffff81084520>] ? rescue=
r_thread+0x3e0/0x3e0
Jul 16 09:47:39 basti kernel: [  398.444787]  [<ffffffff8108b312>] kthread+=
0xd2/0xf0
Jul 16 09:47:39 basti kernel: [  398.444790]  [<ffffffff8108b240>] ? kthrea=
d_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444793]  [<ffffffff8172a2fc>] ret_from=
_fork+0x7c/0xb0
Jul 16 09:47:39 basti kernel: [  398.444795]  [<ffffffff8108b240>] ? kthrea=
d_create_on_node+0x1d0/0x1d0
Jul 16 09:47:39 basti kernel: [  398.444806] Code: 00 48 89 e5 5d 48 8b 40 =
c8 48 c1 e8 02 83 e0 01 c3 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 48 =
8b 87 a8 03 00 00 55 48 89 e5 <48> 8b 40 d8 5d c3 66 2e 0f 1f 84 00 00 00 0=
0 00 66 66 66 66 90=20
Jul 16 09:47:39 basti kernel: [  398.444807]  RSP <ffff88022e69fba0>
Jul 16 09:47:39 basti kernel: [  398.444808] CR2: ffffffffffffffd8
Jul 16 09:47:39 basti kernel: [  398.444808] ---[ end trace 9a9b0afb92b8c42=
2 ]---
Jul 16 09:47:39 basti kernel: [  398.444808] Fixing recursive fault but reb=
oot is needed!

6. Two small shell script to trigger the bug (on an 8 CPU machine)

crash_governor.sh:
#!/bin/sh
# this is called concurrently via runme.sh
for I in `seq 1000`
do
	echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_gove=
rnor
	echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_gov=
ernor
done

runme.sh:
#!/bin/sh
# run 8 concurrent instances
for I in `seq 8`
do
	./crash_governor.sh &
done

Just run runme.sh and crash your system :)

7. Environment
7.1. ver_linux

Linux basti 3.13.0-27-generic #50-Ubuntu SMP Thu May 15 18:06:16 UTC 2014 x=
86_64 x86_64 x86_64 GNU/Linux
=20
Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         sep3_15 pax apwr3_1 nfsv3 rfcomm bnep bluetooth binf=
mt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec_hdm=
i snd_hda_codec_conexant gpio_ich intel_rapl x86_pkg_temp_thermal intel_pow=
erclamp coretemp ppdev kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_cl=
mulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cry=
ptd parport_pc snd_hda_intel snd_hda_codec serio_raw i915 snd_hwdep snd_pcm=
 video snd_page_alloc tpm_infineon drm_kms_helper snd_timer drm snd lpc_ich=
 soundcore mei_me mac_hid mei i2c_algo_bit lp parport e1000e psmouse ahci p=
tp libahci pps_core

7.2. /proc/cpuinfo (first out of 8 CPUs (4 cores plus hyper threading))
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz
stepping	: 7
microcode	: 0x18
cpu MHz		: 1600.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexprior=
ity ept vpid
bogomips	: 6782.74
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

7.3. /proc/modules
sep3_15 517400 0 - Live 0x0000000000000000 (OF)
pax 13181 0 - Live 0x0000000000000000 (OF)
apwr3_1 56811 0 - Live 0x0000000000000000 (OF)
nfsv3 39326 1 - Live 0x0000000000000000
rfcomm 69160 0 - Live 0x0000000000000000
bnep 19624 2 - Live 0x0000000000000000
bluetooth 395423 10 rfcomm,bnep, Live 0x0000000000000000
binfmt_misc 17468 1 - Live 0x0000000000000000
nfsd 280297 2 - Live 0x0000000000000000
auth_rpcgss 59338 1 nfsd, Live 0x0000000000000000
nfs_acl 12837 2 nfsv3,nfsd, Live 0x0000000000000000
nfs 236636 2 nfsv3, Live 0x0000000000000000
lockd 93977 3 nfsv3,nfsd,nfs, Live 0x0000000000000000
sunrpc 284404 21 nfsv3,nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live 0x000000000=
0000000
fscache 63988 1 nfs, Live 0x0000000000000000
snd_hda_codec_hdmi 46207 1 - Live 0x0000000000000000
snd_hda_codec_conexant 57441 1 - Live 0x0000000000000000
gpio_ich 13476 0 - Live 0x0000000000000000
intel_rapl 18773 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14205 0 - Live 0x0000000000000000
intel_powerclamp 14705 0 - Live 0x0000000000000000
coretemp 13435 0 - Live 0x0000000000000000
ppdev 17671 0 - Live 0x0000000000000000
kvm_intel 143060 0 - Live 0x0000000000000000
kvm 451511 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14289 0 - Live 0x0000000000000000
crc32_pclmul 13113 0 - Live 0x0000000000000000
ghash_clmulni_intel 13216 0 - Live 0x0000000000000000
aesni_intel 55624 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13286 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 13990 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20359 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x00000000=
00000000
parport_pc 32701 1 - Live 0x0000000000000000
snd_hda_intel 52355 0 - Live 0x0000000000000000
snd_hda_codec 192906 3 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_in=
tel, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
i915 783485 1 - Live 0x0000000000000000
snd_hwdep 13602 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 102099 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0x000=
0000000000000
video 19476 1 i915, Live 0x0000000000000000
snd_page_alloc 18710 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
tpm_infineon 17372 0 - Live 0x0000000000000000
drm_kms_helper 52758 1 i915, Live 0x0000000000000000
snd_timer 29482 1 snd_pcm, Live 0x0000000000000000
drm 302817 2 i915,drm_kms_helper, Live 0x0000000000000000
snd 69238 7 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel,snd_hda=
_codec,snd_hwdep,snd_pcm,snd_timer, Live 0x0000000000000000
lpc_ich 21080 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
mei_me 18627 0 - Live 0x0000000000000000
mac_hid 13205 0 - Live 0x0000000000000000
mei 82274 1 mei_me, Live 0x0000000000000000
i2c_algo_bit 13413 1 i915, Live 0x0000000000000000
lp 17759 0 - Live 0x0000000000000000
parport 42348 3 ppdev,parport_pc,lp, Live 0x0000000000000000
e1000e 254433 0 - Live 0x0000000000000000
psmouse 102222 0 - Live 0x0000000000000000
ahci 25819 2 - Live 0x0000000000000000
ptp 18933 1 e1000e, Live 0x0000000000000000
libahci 32168 1 ahci, Live 0x0000000000000000
pps_core 19382 1 ptp, Live 0x0000000000000000


--=20

Dipl.-Inf. Robert Schoene
Computer Scientist - R&D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +49 (351) 463-42483
Fax : +49 (351) 463-37773
E-Mail: Robert.Schoene@tu-dresden.de


--=-P1rtuu2ixH71NsS23g1j
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIVMTCCBHQw
ggNcoAMCAQICCQCJkBEVWD6HmzANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJERTEcMBoGA1UE
ChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRydXN0IENlbnRlcjEj
MCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQwMjExMTMxMTQ1WhcNMTkw
NzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4GA1UECxMH
REZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTDllA1PWLpbkztlNcAW5UidNQg6zSP1uzA
MQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOC
JEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8Br3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJl
YE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuL
FlZWQ8/h1RM9ph8nMM1JVNvJEzSacXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IB
JDCCASAwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNV
HSMEGDAWgBQxw3kbuvVT1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMD8GA1UdHwQ4
MDYwNKAyoDCGLmh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmww
eQYIKwYBBQUHAQEEbTBrMCwGCCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9v
Y3NwcjA7BggrBgEFBQcwAoYvaHR0cDovL29jc3AwMzM2LnRlbGVzZWMuZGUvY3J0L0RUX1JPT1Rf
Q0FfMi5jZXIwDQYJKoZIhvcNAQELBQADggEBACwvqeBeQy8FcNxRlXVdgI47DMFjWFSBMIOcXalR
h8m21w8runhIJGBCzPGi4jPhMh4ym1ETlXnGtazQJO0YFLwvKuovq7ITrEkdXgALBBhqmmXU6Ec1
vK7t33S22PGAUGWgxtojm41TR8psu0DJlV1OYHor5LtmQFWvtjPB6iMhbvxUnd0zQm5Ma9Xkw/Lq
BrdaMmoyRXS2tW/+6v8cY6q7iNH4WK8gfo+///b3OHeLGrZQP609R3lGw1e0F2KHvZ6jNiUHaCSq
IvL2rynsN6UUma66AWCGdS1hFbp4loe1ks/hUJGeWToV7J5axob8KD5mutTZNa+tPEkihYfub48w
ggVhMIIESaADAgECAgcXpCR5aFyOMA0GCSqGSIb3DQEBCwUAMFoxCzAJBgNVBAYTAkRFMRMwEQYD
VQQKEwpERk4tVmVyZWluMRAwDgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtERk4tVmVyZWluIFBD
QSBHbG9iYWwgLSBHMDEwHhcNMTQwNTI3MTQ1MzI5WhcNMTkwNzA5MjM1OTAwWjCBhTELMAkGA1UE
BhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xDDAKBgNVBAsT
A1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBDQSAtIEcwMjEgMB4GCSqGSIb3DQEJARYRcGtpQHR1
LWRyZXNkZW4uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBDh6T80T27NAn91B6
YQsENBWT/LEfbGPagOzhM1w1Cjx3ICCilYCgJeIPQmBZT9RalxxF2z2OGDPcRTuqcaFPkgtdGaw1
BFEIX+kGe3Itz2GlaKLPnQBHwcp+ODj8OdgvD4wZqYkvsjaDx1ck2spHHVxLEh/7ybexJL3f1zat
qPJkK2fJuOeeUz3Ip74sPqhKn3QA5Q5E4JUHlvh3l4TDFrbmEIMntRqrJ+LaG2JCQ2G9hfEUvxeo
3Zr6y88IdG+d7Hbp+XJkZYoOenVItm9z+atzo+NBxdmW8nD00xJAG52xQSwN4HR+qtj0CcnMtj41
zXv6ul2E7ltRubqNM3snAgMBAAGjggH+MIIB+jASBgNVHRMBAf8ECDAGAQH/AgEBMA4GA1UdDwEB
/wQEAwIBBjARBgNVHSAECjAIMAYGBFUdIAAwHQYDVR0OBBYEFMUrU5MXg8n1RkLtQ2rftoCmR/Lg
MB8GA1UdIwQYMBaAFEm3xs/oPR9/6kR7Eyn38QpwPt5kMBwGA1UdEQQVMBOBEXBraUB0dS1kcmVz
ZGVuLmRlMIGIBgNVHR8EgYAwfjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDCB1wYIKwYBBQUHAQEEgcowgccwMwYIKwYB
BQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBHBggrBgEFBQcw
AoY7aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2Vy
dC5jcnQwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2Ev
cHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCJhMBD4Oh4PXhRwECrWgom
DDnELDDFh4FN1e2g0gYbKLg/kA0gw6RKImh4GhTRAbENxW2My+tHaKFjtwQdBaanilk4DN581jqx
jo37jPEwDmNNzT8U4ssiwmkMD2bWM2vTcc7lDj2g7w+sRzIJ8zi1AtCV43bJT8xBVj0PQpFuqYVv
YzgMq+KNtGn4YyiBAMyDY1EzPEgtOovN7sqXb3jGDa71gqdHWIKf9orfDWCZ/Y8d+Y+rSqtBAHj0
fnAzjnIgtJvUIif+Afx/4Rvxy0MHj3q6uHhPFcZ9QBPm+vxX2nWXEMlJcf1A/Igdah5hUpkmAQIU
UJso8QbE4gXBS/BPMIIFpjCCBI6gAwIBAgIHFSZS13FEIzANBgkqhkiG9w0BAQUFADCBhTELMAkG
A1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xDDAKBgNV
BAsTA1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBDQSAtIEcwMjEgMB4GCSqGSIb3DQEJARYRcGtp
QHR1LWRyZXNkZW4uZGUwHhcNMTMwMTI4MTk0NTExWhcNMTYwMTI4MTk0NTExWjBeMQswCQYDVQQG
EwJERTEoMCYGA1UEChMfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEMMAoGA1UECxMD
WklIMRcwFQYDVQQDEw5Sb2JlcnQgU2Nob2VuZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMWGkfZe+dO1uZb8XQk9wqyOI12lOwRONx9g5A64xUJ7BCH7PocFLf3TKMBhRyYTy0w3dHOd
B6SJrEfMPm/ioe7BhTL7Eejm3AEThAXAcox4oE8467c7zljb1dmImMwjOu4YzhoSHtKaOX5l6M6z
+QDeA9bdQw3oHRCm2uPYmIHfJJTlXNl/nfEsbdInofFjKG3nU9sZlPNUtpxrBc2p8UJw4TERIi2Z
YWc1NzZRffJjc9LWDGYN32hLyV/M/bDj52/UdqexORNj6KB6fFwjFYXekdc5KZecUKtrkc7mIn3k
nCnOwQsHhjmBHK0H6AEykrMKkbieKFA+7rZ6IVBAPksCAwEAAaOCAj8wggI7MC8GA1UdIAQoMCYw
EQYPKwYBBAGBrSGCLAEBBAMAMBEGDysGAQQBga0hgiwCAQQDADAJBgNVHRMEAjAAMAsGA1UdDwQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFPnXXpzeLkF3GQNu
qwqw7nBiTM3XMB8GA1UdIwQYMBaAFMUrU5MXg8n1RkLtQ2rftoCmR/LgMCcGA1UdEQQgMB6BHHJv
YmVydC5zY2hvZW5lQHR1LWRyZXNkZW4uZGUwgYsGA1UdHwSBgzCBgDA+oDygOoY4aHR0cDovL2Nk
cDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWNhL3B1Yi9jcmwvZ19jYWNybC5jcmwwPqA8oDqGOGh0
dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1jYS9wdWIvY3JsL2dfY2FjcmwuY3JsMIHZ
BggrBgEFBQcBAQSBzDCByTAzBggrBgEFBQcwAYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQ
LVNlcnZlci9PQ1NQMEgGCCsGAQUFBzAChjxodHRwOi8vY2RwMS5wY2EuZGZuLmRlL3R1LWRyZXNk
ZW4tY2EvcHViL2NhY2VydC9nX2NhY2VydC5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvdHUtZHJlc2Rlbi1jYS9wdWIvY2FjZXJ0L2dfY2FjZXJ0LmNydDANBgkqhkiG9w0B
AQUFAAOCAQEAcFQx6L5b5YOHN0yL6DiX9Sa3URExEaEonxp9S3Q9Nu8NDp/1h62y5KYxLudQEscU
zUdmAdPm7HRgWzdv/ogwtL94o0AkihfdAqZrXJERWsbNwerS2QgYoYmj2elFCyBt42MaJdg7beVh
PJVet1MDHTkKUM5uIRCLbs21oEoyJq4Lm6cC+xob6rYWRJaZIhys41CtT5oHroSbCPnlOrVruckL
wfJ4uaHGDdoIohP0bt/Id4sQ7o3GGdAQh64bevDtOjK2uN1mxVN6jpxdkgV2AwNQEygtFEL7kcQo
07+vL3AirtHcAk0OMUFmTwjb0ngEgiTBcin+macAx5CtcpQzzTCCBaYwggSOoAMCAQICBxUmUtdx
RCMwDQYJKoZIhvcNAQEFBQAwgYUxCzAJBgNVBAYTAkRFMSgwJgYDVQQKEx9UZWNobmlzY2hlIFVu
aXZlcnNpdGFldCBEcmVzZGVuMQwwCgYDVQQLEwNaSUgxHDAaBgNVBAMTE1RVIERyZXNkZW4gQ0Eg
LSBHMDIxIDAeBgkqhkiG9w0BCQEWEXBraUB0dS1kcmVzZGVuLmRlMB4XDTEzMDEyODE5NDUxMVoX
DTE2MDEyODE5NDUxMVowXjELMAkGA1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVy
c2l0YWV0IERyZXNkZW4xDDAKBgNVBAsTA1pJSDEXMBUGA1UEAxMOUm9iZXJ0IFNjaG9lbmUwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFhpH2XvnTtbmW/F0JPcKsjiNdpTsETjcfYOQO
uMVCewQh+z6HBS390yjAYUcmE8tMN3RznQekiaxHzD5v4qHuwYUy+xHo5twBE4QFwHKMeKBPOOu3
O85Y29XZiJjMIzruGM4aEh7Smjl+ZejOs/kA3gPW3UMN6B0Qptrj2JiB3ySU5VzZf53xLG3SJ6Hx
Yyht51PbGZTzVLacawXNqfFCcOExESItmWFnNTc2UX3yY3PS1gxmDd9oS8lfzP2w4+dv1HansTkT
Y+igenxcIxWF3pHXOSmXnFCra5HO5iJ95JwpzsELB4Y5gRytB+gBMpKzCpG4nihQPu62eiFQQD5L
AgMBAAGjggI/MIICOzAvBgNVHSAEKDAmMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIs
AgEEAwAwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUF
BwMEMB0GA1UdDgQWBBT5116c3i5BdxkDbqsKsO5wYkzN1zAfBgNVHSMEGDAWgBTFK1OTF4PJ9UZC
7UNq37aApkfy4DAnBgNVHREEIDAegRxyb2JlcnQuc2Nob2VuZUB0dS1kcmVzZGVuLmRlMIGLBgNV
HR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1jYS9wdWIv
Y3JsL2dfY2FjcmwuY3JsMD6gPKA6hjhodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4t
Y2EvcHViL2NybC9nX2NhY3JsLmNybDCB2QYIKwYBBQUHAQEEgcwwgckwMwYIKwYBBQUHMAGGJ2h0
dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBIBggrBgEFBQcwAoY8aHR0cDov
L2NkcDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWNhL3B1Yi9jYWNlcnQvZ19jYWNlcnQuY3J0MEgG
CCsGAQUFBzAChjxodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tY2EvcHViL2NhY2Vy
dC9nX2NhY2VydC5jcnQwDQYJKoZIhvcNAQEFBQADggEBAHBUMei+W+WDhzdMi+g4l/Umt1ERMRGh
KJ8afUt0PTbvDQ6f9YetsuSmMS7nUBLHFM1HZgHT5ux0YFs3b/6IMLS/eKNAJIoX3QKma1yREVrG
zcHq0tkIGKGJo9npRQsgbeNjGiXYO23lYTyVXrdTAx05ClDObiEQi27NtaBKMiauC5unAvsaG+q2
FkSWmSIcrONQrU+aB66Emwj55Tq1a7nJC8HyeLmhxg3aCKIT9G7fyHeLEO6NxhnQEIeuG3rw7Toy
trjdZsVTeo6cXZIFdgMDUBMoLRRC+5HEKNO/ry9wIq7R3AJNDjFBZk8I29J4BIIkwXIp/pmnAMeQ
rXKUM80xggNmMIIDYgIBATCBkTCBhTELMAkGA1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUg
VW5pdmVyc2l0YWV0IERyZXNkZW4xDDAKBgNVBAsTA1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBD
QSAtIEcwMjEgMB4GCSqGSIb3DQEJARYRcGtpQHR1LWRyZXNkZW4uZGUCBxUmUtdxRCMwCQYFKw4D
AhoFAKCCAakwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTQwNzE2
MTQ1MzE4WjAjBgkqhkiG9w0BCQQxFgQUTwn3RaYxPAHRVtTZMOAWkxkeV5EwgaIGCSsGAQQBgjcQ
BDGBlDCBkTCBhTELMAkGA1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0
IERyZXNkZW4xDDAKBgNVBAsTA1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBDQSAtIEcwMjEgMB4G
CSqGSIb3DQEJARYRcGtpQHR1LWRyZXNkZW4uZGUCBxUmUtdxRCMwgaQGCyqGSIb3DQEJEAILMYGU
oIGRMIGFMQswCQYDVQQGEwJERTEoMCYGA1UEChMfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJl
c2RlbjEMMAoGA1UECxMDWklIMRwwGgYDVQQDExNUVSBEcmVzZGVuIENBIC0gRzAyMSAwHgYJKoZI
hvcNAQkBFhFwa2lAdHUtZHJlc2Rlbi5kZQIHFSZS13FEIzANBgkqhkiG9w0BAQEFAASCAQChWkYp
cJqa+KSJQWvaFeT1E0z343Fz0NA0GZoHAhPPrdo9FsjV/OWgeemEIG4S/U5cRcLLSFA+plNwn6pg
i4HLh3E85ER1A5PvLKqhAx93u66ULYH3v9Mpvc5TGqgdrvX4eBdLR7IdPyXS+vxvDqDKaHmfncp8
Lior//lnX51k+K3wOq9U2xiPzsuxUMcCuqagEA3IbRzzYOw6n/GtWa4O7ezyaQ5PsPVdKEdn17If
RpCm5Yqx+v8xkzb6ZGq45F7OfIO+6kOIKFL/CwgzheRW55AlRWNsB5PrzH4mPyfWfUKsQP2fgpZg
Aog9Nr4Msv9UIi4KeyvfhnITjffd1Eh/AAAAAAAA


--=-P1rtuu2ixH71NsS23g1j--

