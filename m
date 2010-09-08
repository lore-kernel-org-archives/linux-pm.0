From: Simon Kirby <sim@hostway.ca>
Subject: [2.6.36-rc3] unable to handle kernel NULL pointer
	dereference	(pm_qos_add_request)
Date: Wed, 8 Sep 2010 00:07:01 -0700
Message-ID: <20100908070701.GA28936@hostway.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This seems to be happening every time I try to use sound after resuming. 
I didn't see it in 2.6.35.  This is git HEAD as of a couple of days ago.

[154289.671842] BUG: unable to handle kernel NULL pointer dereference at (null)
[154289.671856] IP: [<ffffffff8137bd46>] plist_add+0x36/0xa0
[154289.671872] PGD 7bd9d067 PUD 7da28067 PMD 0 
[154289.671881] Oops: 0000 [#1] SMP 
[154289.671888] last sysfs file: /sys/devices/virtual/bdi/0:21/uevent
[154289.671894] CPU 2 
[154289.671897] Modules linked in: snd_ice1724 snd_rawmidi snd_ice17xx_ak4xxx snd_ac97_codec sco bnep rfcomm l2cap bluetooth ppdev hwmon_vid usb_storage tun i2c_viapro ac97_bus nvidia(P) snd_ak4xxx_adda snd_ak4114 parport_pc snd_pt2258 parport snd_i2c r8169 snd_ak4113 k10temp [last unloaded: snd_ac97_codec]
[154289.671938] 
[154289.671947] Pid: 3596, comm: mplayer Tainted: P            2.6.36-rc3-oof+ #24 M4A79T Deluxe/System Product Name
[154289.671954] RIP: 0010:[<ffffffff8137bd46>]  [<ffffffff8137bd46>] plist_add+0x36/0xa0
[154289.671966] RSP: 0018:ffff88005cecbcd8  EFLAGS: 00010002
[154289.671971] RAX: fffffffffffffff8 RBX: ffff880004728e40 RCX: ffff88007b4e3048
[154289.671977] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880004728e40
[154289.671983] RBP: ffff88005cecbcf8 R08: 0000000000005356 R09: 0000000000004000
[154289.671988] R10: 0000000000000000 R11: 00000000fffffffe R12: ffffffff819682a0
[154289.671994] R13: ffff880004728e58 R14: 0000000000000000 R15: ffffffff819682b0
[154289.672001] FS:  00007f1be83c5860(0000) GS:ffff880001d00000(0000) knlGS:00000000f74849d0
[154289.672007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[154289.672012] CR2: 0000000000000000 CR3: 000000007b6ca000 CR4: 00000000000006e0
[154289.672017] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[154289.672022] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[154289.672029] Process mplayer (pid: 3596, threadinfo ffff88005ceca000, task ffff88007dfec410)
[154289.672033] Stack:
[154289.672037]  ffff88005cecbd18 ffffffff819682a0 ffff880004728e40 00000000ffffffff
[154289.672045] <0> ffff88005cecbd48 ffffffff8105f2fb ffff880000000000 0000000000000292
[154289.672054] <0> ffff88005cecbd58 ffff880004728e40 ffff88001afeec00 ffff88001afec800
[154289.672063] Call Trace:
[154289.672074]  [<ffffffff8105f2fb>] update_target+0x12b/0x140
[154289.672082]  [<ffffffff8105f52a>] pm_qos_add_request+0x4a/0x80
[154289.672092]  [<ffffffff81580dc4>] snd_pcm_hw_params+0x2d4/0x3a0
[154289.672099]  [<ffffffff81581261>] snd_pcm_common_ioctl1+0xb1/0xb90
[154289.672108]  [<ffffffff810bc8c2>] ? handle_mm_fault+0x192/0xa50
[154289.672116]  [<ffffffff81581fed>] snd_pcm_playback_ioctl1+0x3d/0x220
[154289.672125]  [<ffffffff8169ae1f>] ? do_page_fault+0x17f/0x440
[154289.672133]  [<ffffffff8158287d>] snd_pcm_playback_ioctl+0x3d/0x50
[154289.672140]  [<ffffffff810e7f17>] do_vfs_ioctl+0x97/0x530
[154289.672149]  [<ffffffff810c463c>] ? do_mmap_pgoff+0x34c/0x3a0
[154289.672156]  [<ffffffff810e83fa>] sys_ioctl+0x4a/0x80
[154289.672165]  [<ffffffff81002ceb>] system_call_fastpath+0x16/0x1b
[154289.672169] Code: 54 49 89 f4 53 48 89 fb 48 83 ec 08 4c 3b 6f 18 75 69 49 8b 04 24 48 83 e8 08 eb 0f 90 8b 30 39 33 7c 18 66 90 74 4e 48 8d 42 f8 <48> 8b 50 08 48 8d 48 08 4c 39 e1 0f 18 0a 75 e2 48 8b 50 10 48 
[154289.672229] RIP  [<ffffffff8137bd46>] plist_add+0x36/0xa0
[154289.672237]  RSP <ffff88005cecbcd8>
[154289.672241] CR2: 0000000000000000
[154289.672246] ---[ end trace 15016f7e0b68fa93 ]---

I suspect this could have to do with "pm_qos: Reimplement using plists"
(5f279845f9d684661563894d44729a0c706375b4), but I can bisect if
necessary.

Simon-
