From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Tue, 23 Sep 2014 16:50:25 +0200
Message-ID: <87zjdq8k7i.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:53648 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbaIWOu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 10:50:28 -0400
Received: from nemi.mork.no (nemi.mork.no [IPv6:2001:4641:0:2:e8b:fdff:fe08:971])
	(authenticated bits=0)
	by canardo.mork.no (8.14.4/8.14.4) with ESMTP id s8NEoQPu023241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2014 16:50:26 +0200
Received: from bjorn by nemi.mork.no with local (Exim 4.80)
	(envelope-from <bjorn@mork.no>)
	id 1XWRQA-0001VW-5U
	for linux-pm@vger.kernel.org; Tue, 23 Sep 2014 16:50:26 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I just tested Debians experimental v3.17-rc5 build and got this after
resuming from hibernation:

BUG: unable to handle kernel NULL pointer dereference at           (nul=
l)
IP: [<ffffffff810a8cc1>] swsusp_free+0x21/0x190
PGD b39c2067 PUD b39c1067 PMD 0=20
Oops: 0000 [#1] SMP=20
Modules linked in: ctr ccm xt_multiport iptable_filter ip_tables bridge=
 aufs(C) bnep xt_hl nf_log_ipv6 nf_log_common xt_LOG binfmt_misc ip6tab=
le_filter ip6_tables x_tables nfsd auth_rpcgss oid_registry nfs_acl nfs=
 lockd fscache sunrpc 8021q garp stp mrp llc tun loop fuse joydev arc4 =
iwlmvm mac80211 snd_hda_codec_conexant iwlwifi snd_hda_codec_generic iT=
CO_wdt iTCO_vendor_support cfg80211 coretemp kvm_intel kvm psmouse evde=
v serio_raw cdc_acm cdc_mbim cdc_wdm uvcvideo cdc_ncm videobuf2_vmalloc=
 videobuf2_memops usbnet mii videobuf2_core v4l2_common videodev media =
i2c_i801 lpc_ich mfd_core snd_hda_intel snd_hda_controller snd_hda_code=
c snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm shpchp snd_timer mei_me m=
ei wmi thinkpad_acpi nvram i915 snd soundcore ac battery ecb drm_kms_he=
lper drm tpm_tis acpi_cpufreq tpm i2c_algo_bit i2ccore video btusb blue=
tooth processor rfkill button ext4 crc16 mbcache jbd2 nbd sd_mod crc_t1=
0dif crct10dif_generic sg sr_mod cdrom crct10dif_common ahci libahci li=
bata scsi_mod thermal thermal_sys uhci_hcd ehci_pci ehci_hcd usbcore us=
b_common e1000e ptp pps_core
CPU: 1 PID: 4898 Comm: s2disk Tainted: G         C     3.17-rc5-amd64 #=
1 Debian 3.17~rc5-1~exp1
Hardware name: LENOVO 2776LEG/2776LEG, BIOS 6EET55WW (3.15 ) 12/19/2011
task: ffff88023155ea40 ti: ffff8800b3b14000 task.ti: ffff8800b3b14000
RIP: 0010:[<ffffffff810a8cc1>]  [<ffffffff810a8cc1>] swsusp_free+0x21/0=
x190
RSP: 0018:ffff8800b3b17ea8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8800b39bab00 RCX: 0000000000000001
RDX: ffff8800b39bab10 RSI: ffff8800b39bab00 RDI: 0000000000000000
RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8800b39bab10 R11: 0000000000000246 R12: ffffea0000000000
R13: ffff880232f485a0 R14: ffff88023ac27cd8 R15: ffff880232927590
=46S:  00007f406d83b700(0000) GS:ffff88023bc80000(0000) knlGS:000000000=
0000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000b3a62000 CR4: 00000000000007e0
Stack:
 ffff8800b39bab00 0000000000000010 ffff880232927590 ffffffff810acb4a
 ffff8800b39bab00 ffffffff811a955a ffff8800b39bab10 0000000000000000
 ffff88023155f098 ffffffff81a6b8c0 ffff88023155ea40 0000000000000007
Call Trace:
 [<ffffffff810acb4a>] ? snapshot_release+0x2a/0xb0
 [<ffffffff811a955a>] ? __fput+0xca/0x1d0
 [<ffffffff81080627>] ? task_work_run+0x97/0xd0
 [<ffffffff81012d89>] ? do_notify_resume+0x69/0xa0
 [<ffffffff8151452a>] ? int_signal+0x12/0x17
Code: 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 41 54 48 8b 05 ba 62=
 9c 00 49 bc 00 00 00 00 00 ea ff ff 48 8b 3d a1 62 9c 00 55 53 <48> 8b=
 10 48 89 50 18 48 8b 52 20 48 c7 40 28 00 00 00 00 c7 40=20
RIP  [<ffffffff810a8cc1>] swsusp_free+0x21/0x190
 RSP <ffff8800b3b17ea8>
CR2: 0000000000000000
---[ end trace f02be86a1ec0cccb ]---


This is the first 3.17-rc I try, so it might be an issue from 3.17-rc1.
v3.16 is fine.

This problem seems to be reliably repeatable so I can try to narrow it
down a bit.


Bj=C3=B8rn (not subscribed, so please CC me)
