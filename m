Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579715;
	b=WlQDkqmfTxJ0yVeRRtEpU9joz3xNHt6WpGz+tVyWIY9frPlhxMZayirjK/dDP3DV4G/6
	 nAz3p7dxe2HzrvLryW39Xwd0bC0qb/aGgV75XyAQfpZHiPDNVprV6iUeL/gBf6jj2/rOE
	 WnN55MUD+hKfvc5m+PaGqgNzsrI2imXNjBIYgG2rdxsFJ5ycK8z2fPsXVBtzGlSWu1GVL
	 hb6zMotSKIplu+Ani9CGyaxHOCt4GGDF9X30mtzPSgRfA0u+9xSORak7fk4rys77SbyyD
	 PxxTMJd+dSoNmPbPL+tOnwm6Wysueq/BgpbStMjeNwpgVSe4h4MV8GqA9W4dppzXLew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579715;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=lIsqmU5SUVko/uhMS35xh7s+l+LKIbMrUQfnpSqdza8=;
	b=Vah8NIdGeS/QsdOqkYGkINorXxM5KNl+DSN22/GLgJsBJVqC3KqDSWuDnF6pRgghSiag
	 nB/+RgjpXzj+yDeWIf1N9dKdTelPiR3JVgeES7FzxbCLvul58DTInJweFyyu3Dved4M+F
	 2h4+w3OxmldkMX3CzwS2YmWCeoB80tRtJu8a2EevZEPh2CUVVLmd0jbBJRfKUm0su9eaZ
	 lXDOzRHkEqZsGwQY5yqL6l63+sv7u6Vs55yB/nantdLZyYje+OTQ5S4rHPWXTjLJEaDrA
	 BhjgAtwBaORGSRZ1aeSeWp3NlnIPSZr/FVAS/uowPRFEWjrq2UzkZjHqWfZhIVAu6gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC0606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64BC0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4db3db8687fso729608b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579714; x=1793184514;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIsqmU5SUVko/uhMS35xh7s+l+LKIbMrUQfnpSqdza8=;
        b=ft2mCZYUsN/iJ8+v+ajTss6GYiYKu6VtFFP/jFfbDljk8w+lZ/tdMxxpbO4c2QTprg
         9S1ESNEGjHbsMIll3BWL2ZE40b3xa1BZ8+B1Xq7cNPwV1MOZZd3/qtkQ0+txYecA6tEi
         aA62j0q0a/iHBleYfntIE6uqh3lJe8eMaXLPHXHcQuFr0ECcIUgbuZbjKXzJJ2E1deYb
         9+GHOPdH7YTGzSoJ9zVCqGMuJhWARBi2imnqsd7KgLiGcIE7jpDgpcaj7Pi/Iw15RR2y
         LA8lG35Du1Xp0AOa53inZo3e03ZwNRieftjdVtdwERRqCHixGPhfOk+epVIXtpu5hUKb
         srmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoTs/Hanf3ZI3Q5RPY6DVBhrk8crVyKx7JrB2XPXvvvkrIrCoG0mXkznmWVZpdeldAEdZApcXzng==@vger.kernel.org
X-Gm-Message-State: AFq9FYIAj5ke26z+/SioWCvnoxiXb2WhT1q9ar9c1kzqiZDqQ6dSjzUK
	h6rFByHYshj88MhijDlvZjFRjwGMjhc1JJnoC/2pSwzig7GhhctH1mDBCgt0FreecvX0Rs6I8CZ
	zvkPMWPSyjuJthggwcpd2LchQhm+nw2ucmT3ELmBH4pG4d7ya7Z92qt49xOI=
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3086:b0:4e4:627a:e0a5 with SMTP id
 5614622812f47-5535c846d28mr942301b6e.40.1792579714307; Wed, 21 Oct 2026
 03:48:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:48:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad89882.5c73e770.1a06c9.0144.GAE@google.com>
Subject: [syzbot] [pm?] BUG: scheduling while atomic in trace_suspend_resume
From: syzbot <syzbot+3ae5f6fdc78789d76c5d@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a8bdffce502 Merge tag 'x86_tdx_for_7.4-rc1' of git://git...
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=17ff3b71580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b53513c2c9c13c87
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae5f6fdc78789d76c5d
compiler:       arm-linux-gnueabi-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-4a8bdffc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/864987094664/vmlinux-4a8bdffc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11b0b41bd985/zImage-4a8bdffc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae5f6fdc78789d76c5d@syzkaller.appspotmail.com

BUG: scheduling while atomic: swapper/0/0/0x00000102
Modules linked in:
Preemption disabled at:
[<81bb8634>] schedule_preempt_disabled+0x20/0x24 kernel/sched/core.c:7434
Kernel panic - not syncing: scheduling while atomic: panic_on_warn set ...
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Call trace: 
[<80201a08>] (dump_backtrace) from [<80201afc>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:8321c4bc r6:00000000 r5:82328c7c r4:00000001
[<80201ae4>] (show_stack) from [<8021e858>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201ae4>] (show_stack) from [<8021e858>] (dump_stack_lvl+0x5c/0x70 lib/dump_stack.c:120)
[<8021e7fc>] (dump_stack_lvl) from [<8021e884>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r7:8321c4bc r6:00000000 r5:83218380 r4:83483d7c
[<8021e86c>] (dump_stack) from [<802026b8>] (vpanic+0x114/0x320 kernel/panic.c:651)
[<802025a4>] (vpanic) from [<802028f8>] (trace_suspend_resume+0x0/0x100 kernel/panic.c:788)
 r7:830d7880
[<802028c4>] (panic) from [<80251b58>] (check_panic_on_warn kernel/panic.c:525 [inline])
[<802028c4>] (panic) from [<80251b58>] (get_taint+0x0/0x1c kernel/panic.c:520)
 r3:8320b188 r2:00000001 r1:82319200 r0:82316170
[<80251ae0>] (check_panic_on_warn) from [<8028fe80>] (__schedule_bug+0x80/0x94 kernel/sched/core.c:6090)
[<8028fe00>] (__schedule_bug) from [<81bb7d60>] (schedule_debug kernel/sched/core.c:6119 [inline])
[<8028fe00>] (__schedule_bug) from [<81bb7d60>] (__schedule+0xd20/0x147c kernel/sched/core.c:7133)
 r5:83201b98 r4:00000000
[<81bb7040>] (__schedule) from [<81bb84e8>] (__schedule_loop kernel/sched/core.c:7361 [inline])
[<81bb7040>] (__schedule) from [<81bb84e8>] (schedule+0x2c/0xec kernel/sched/core.c:7376)
 r10:00000000 r9:7fffffff r8:83201b3c r7:00000002 r6:83218380 r5:83201b98
 r4:83218380
[<81bb84bc>] (schedule) from [<81bbff50>] (schedule_timeout+0xcc/0x114 kernel/time/sleep_timeout.c:75)
 r5:83201b98 r4:7fffffff
[<81bbfe84>] (schedule_timeout) from [<81bb909c>] (do_wait_for_common kernel/sched/completion.c:100 [inline])
[<81bbfe84>] (schedule_timeout) from [<81bb909c>] (__wait_for_common+0x90/0x1b8 kernel/sched/completion.c:121)
 r6:83201b94 r5:83201b98 r4:83218380
[<81bb900c>] (__wait_for_common) from [<81bb91e4>] (wait_for_common kernel/sched/completion.c:132 [inline])
[<81bb900c>] (__wait_for_common) from [<81bb91e4>] (wait_for_completion+0x20/0x24 kernel/sched/completion.c:153)
 r10:83201d34 r9:00002e00 r8:00000101 r7:00000000 r6:dddcff80 r5:83361770
 r4:00000000
[<81bb91c4>] (wait_for_completion) from [<8030596c>] (__synchronize_srcu+0x9c/0xcc kernel/rcu/srcutree.c:1477)
[<803058d0>] (__synchronize_srcu) from [<80305a38>] (synchronize_srcu_expedited kernel/rcu/srcutree.c:1502 [inline])
[<803058d0>] (__synchronize_srcu) from [<80305a38>] (synchronize_srcu+0x78/0x14c kernel/rcu/srcutree.c:1558)
 r5:60000113 r4:83361770
[<803059c0>] (synchronize_srcu) from [<80c27800>] (wakeup_source_remove drivers/base/power/wakeup.c:201 [inline])
[<803059c0>] (synchronize_srcu) from [<80c27800>] (wakeup_source_unregister.part.0+0x64/0x1b4 drivers/base/power/wakeup.c:237)
 r7:00000000 r6:86ddfc40 r5:00000113 r4:87aa3c00
[<80c2779c>] (wakeup_source_unregister.part.0) from [<80c27968>] (wakeup_source_unregister+0x18/0x1c drivers/base/power/wakeup.c:236)
 r7:00000000 r6:86ddfc40 r5:868dd000 r4:868dd008
[<80c27950>] (wakeup_source_unregister) from [<81331ba0>] (mmc_host_classdev_release+0x1c/0x58 drivers/mmc/core/host.c:69)
[<81331b84>] (mmc_host_classdev_release) from [<80c03f40>] (device_release+0x40/0xb0 drivers/base/core.c:2640)
 r5:87abc000 r4:868dd008
[<80c03f00>] (device_release) from [<81b8b3b0>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80c03f00>] (device_release) from [<81b8b3b0>] (kobject_release lib/kobject.c:720 [inline])
[<80c03f00>] (device_release) from [<81b8b3b0>] (kref_put include/linux/kref.h:65 [inline])
[<80c03f00>] (device_release) from [<81b8b3b0>] (kobject_put+0xa0/0x258 lib/kobject.c:737)
 r5:81d5e268 r4:868dd008
[<81b8b310>] (kobject_put) from [<80c040b4>] (put_device+0x18/0x1c drivers/base/core.c:3884)
 r8:00000101 r7:8135038c r6:868dd000 r5:00000000 r4:868dd000
[<80c0409c>] (put_device) from [<81332304>] (mmc_free_host+0x30/0x34 drivers/mmc/core/host.c:703)
[<813322d4>] (mmc_free_host) from [<813504ec>] (vub300_delete drivers/mmc/host/vub300.c:379 [inline])
[<813322d4>] (mmc_free_host) from [<813504ec>] (kref_put include/linux/kref.h:65 [inline])
[<813322d4>] (mmc_free_host) from [<813504ec>] (vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline])
[<813322d4>] (mmc_free_host) from [<813504ec>] (vub300_inactivity_timer_expired+0x160/0x1b8 drivers/mmc/host/vub300.c:742)
 r5:00000000 r4:868ddaec
[<8135038c>] (vub300_inactivity_timer_expired) from [<80331320>] (call_timer_fn+0x30/0x268 kernel/time/timer.c:1748)
 r7:8135038c r6:83218380 r5:868ddaec r4:868ddaec
[<803312f0>] (call_timer_fn) from [<803317f4>] (expire_timers kernel/time/timer.c:1799 [inline])
[<803312f0>] (call_timer_fn) from [<803317f4>] (__run_timers+0x29c/0x420 kernel/time/timer.c:2374)
 r10:83201d34 r9:00002e00 r8:00000000 r7:8135038c r6:8320b194 r5:868ddaec
 r4:dddc7000
[<80331558>] (__run_timers) from [<803319e0>] (__run_timer_base kernel/time/timer.c:2386 [inline])
[<80331558>] (__run_timers) from [<803319e0>] (__run_timer_base kernel/time/timer.c:2378 [inline])
[<80331558>] (__run_timers) from [<803319e0>] (run_timer_base+0x68/0x78 kernel/time/timer.c:2395)
 r10:83218380 r9:00000082 r8:00000101 r7:00000004 r6:00000002 r5:00000001
 r4:dddc7000
[<80331978>] (run_timer_base) from [<80331a0c>] (run_timer_softirq+0x1c/0x34 kernel/time/timer.c:2405)
 r4:83203084
[<803319f0>] (run_timer_softirq) from [<8025b2b4>] (handle_softirqs+0x160/0x4e8 kernel/softirq.c:645)
[<8025b154>] (handle_softirqs) from [<8025b7d8>] (__do_softirq kernel/softirq.c:679 [inline])
[<8025b154>] (handle_softirqs) from [<8025b7d8>] (invoke_softirq kernel/softirq.c:519 [inline])
[<8025b154>] (handle_softirqs) from [<8025b7d8>] (__irq_exit_rcu+0x150/0x1d4 kernel/softirq.c:758)
 r10:824e697c r9:83218380 r8:00000000 r7:83201e88 r6:824e697c r5:82521180
 r4:83218380
[<8025b688>] (__irq_exit_rcu) from [<8025bb20>] (irq_exit+0x10/0x18 kernel/softirq.c:787)
 r5:82521180 r4:830d70ec
[<8025bb10>] (irq_exit) from [<81bb36bc>] (generic_handle_arch_irq+0x7c/0x80 kernel/irq/handle.c:293)
[<81bb3640>] (generic_handle_arch_irq) from [<80200bdc>] (__irq_svc+0x7c/0xbc arch/arm/kernel/entry-armv.S:228)
Exception stack(0x83201e88 to 0x83201ed0)
1e80:                   00000000 82328c7c 0005eee4 00000001 83218380 00000000
1ea0: 00000000 830d62f0 00000000 8320b20c 824e697c 83201ef4 83201ec8 83201ed8
1ec0: 81bb4360 81bb4f30 20000013 ffffffff
 r9:83218380 r8:00000000 r7:83201ebc r6:ffffffff r5:20000013 r4:81bb4f30
[<81bb4ee4>] (default_idle_call) from [<802b8ae0>] (cpuidle_idle_call kernel/sched/idle.c:199 [inline])
[<81bb4ee4>] (default_idle_call) from [<802b8ae0>] (do_idle+0x240/0x3c0 kernel/sched/idle.c:355)
 r7:830d62f0 r6:00000000 r5:8320b1e8 r4:83218380
[<802b88a0>] (do_idle) from [<802b8f70>] (cpu_startup_entry+0x30/0x34 kernel/sched/idle.c:454)
 r10:83217db4 r9:8245fad4 r8:00000000 r7:dddf03ec r6:8320b140 r5:8321eec0
 r4:000000e5
[<802b8f40>] (cpu_startup_entry) from [<81bb52bc>] (rest_init+0x110/0x114 init/main.c:732)
[<81bb51ac>] (rest_init) from [<8300148c>] (start_kernel+0x864/0x880 init/main.c:1190)
[<83000c28>] (start_kernel) from [<00000000>] (0x0)
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
