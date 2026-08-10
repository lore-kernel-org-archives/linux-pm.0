Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDF348C7D
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357480; cv=none; b=NMKZmk1ZcYAQ/yz9Jlp7r1vXj5Hh9uAfMjYECR0+BWhV7Gx2qg66zymDyTgH33G6Ge+90ZoNr9h8hUdwn498S/JNwV3WhyfuUuzHO3aWuqsYs1wuVqfYki2Udsj+HlxSBdGhQcbu6SKdM7aGxwpZMRTAWp4TblH917as6xDkhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357480; c=relaxed/simple;
	bh=yQ1afM2ceyrCs9PVtue+UD7EIdsF3F7rJR66vz9gCho=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jSYfJq54VKUGKNWT9tbCf2nUti5Rt9+jXx06Rw5vemIk8cq0zZ7M9wD3jsZd41f7sAB2Sx5orm0WW5Fez3w2DX17DFEzwHblrEVDxKB+u+QiIGYUp0wr04M/3l8QTOqmuX7iUXqVStT4oCA8di4pNPTNPfKoXphpZfDNLd9W6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-485ebc5706cso5350897b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 03:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357477; x=1786962277;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diOkV4n/K0fzmwoWMYwrzjoYAkxku91O+AW0RHw0zbY=;
        b=X/0vxG3mtC0CA8d92gSlRz8HrnqWklL/DKkNU0E/g1QGMiKkk9CiElHx3xLBD1mebd
         5BO3+Y8yAoHjNPoK/bYZ5bW4Af2wA/pp4OooseR0CyMJyOnmewaT1RXf03/A4ckwYxYx
         SRGuyllL10lW0LgcwovcQTYp9oxrtLTfgbYq7izF4WZQVxjC+XnSPAiRfrfDnszZ7alT
         GCAr3YZ/MLzYfcn8tP8+CHEh1eEdXMOrvLuTaS3VYPDxoB1Nq5fkKXjjjY8iivcHc8zH
         RD1OULtdSP6GApN+z6cpvSTOYPB5hTG4nl0meaDwVPmgC9IuUChZOSeVSoI7k7wHD9V1
         BFUg==
X-Forwarded-Encrypted: i=1; AHgh+RpOx/fOmPquQSQkj01RbSctlDghFIgvrqg2v40RkH62fELPvCvv7+mseiv2JOUTxbvG51LLfKYlzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHe//WTZM9aLyiM/7dvdpubP4L9JHn6bNiaC74FS6ucXpbTgE
	A5qVud+YILHFUTVvwu1qZTSsE4KOV3DXewj9cXkXBxp7bwgtOo1yE1a1sahgwxCrdDi+bRNRvTz
	HbcAa6gwWhOox1EXSaQgyjye8JEy5S7Ub0V9CH5gFLKoJRxhgnuJnoTogiJY=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2381:b0:492:c9a4:2104 with SMTP id
 5614622812f47-4b1af83fae5mr9019870b6e.10.1786357477383; Mon, 10 Aug 2026
 03:24:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 03:24:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a79a6e5.01d0871a.3a0d52.00a7.GAE@google.com>
Subject: [syzbot] [pm?] WARNING: ODEBUG bug in trace_suspend_resume (2)
From: syzbot <syzbot+98850521518b962c5bab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    db2ddb871435 Linux 7.2-rc7
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=11212149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa49d7bda29d9792
dashboard link: https://syzkaller.appspot.com/bug?extid=98850521518b962c5bab
compiler:       arm-linux-gnueabi-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145762c6580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98850521518b962c5bab@syzkaller.appspotmail.com

ODEBUG: object df805d04 is NOT on stack df864000, but annotated.
------------[ cut here ]------------
WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#1: swapper/1/0
WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc.part.0+0x180/0x1ec lib/debugobjects.c:705, CPU#1: swapper/1/0
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Call trace: frame pointer underflow
[<80201998>] (dump_backtrace) from [<80201a8c>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:82a20f78 r6:00000000 r5:82333374 r4:00000001
[<80201a74>] (show_stack) from [<8021ec68>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201a74>] (show_stack) from [<8021ec68>] (dump_stack_lvl+0x5c/0x70 lib/dump_stack.c:120)
[<8021ec0c>] (dump_stack_lvl) from [<8021ec94>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r7:82a20f78 r6:00000000 r5:8317e200 r4:82c83d40
[<8021ec7c>] (dump_stack) from [<80202590>] (vpanic+0x114/0x320 kernel/panic.c:651)
[<8020247c>] (vpanic) from [<802027d0>] (trace_suspend_resume+0x0/0x100 kernel/panic.c:788)
 r7:8095e608
[<8020279c>] (panic) from [<80251a80>] (check_panic_on_warn kernel/panic.c:525 [inline])
[<8020279c>] (panic) from [<80251a80>] (get_taint+0x0/0x1c kernel/panic.c:520)
 r3:82a0b144 r2:00000001 r1:823190d8 r0:82320a34
[<80251a08>] (check_panic_on_warn) from [<80251bfc>] (__warn+0x98/0x1a4 kernel/panic.c:1104)
[<80251b64>] (__warn) from [<80251e80>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:1136)
 r8:00000009 r7:8238dd84 r6:df805c1c r5:8317e200 r4:00000000
[<80251d0c>] (warn_slowpath_fmt) from [<8095e608>] (debug_object_is_on_stack lib/debugobjects.c:672 [inline])
[<80251d0c>] (warn_slowpath_fmt) from [<8095e608>] (lookup_object_or_alloc.part.0+0x180/0x1ec lib/debugobjects.c:705)
 r10:00000001 r9:81c04360 r8:df805d04 r7:00000000 r6:82d1bbf4 r5:82cfc288
 r4:852e1270
[<8095e488>] (lookup_object_or_alloc.part.0) from [<8095ec18>] (lookup_object_or_alloc lib/debugobjects.c:682 [inline])
[<8095e488>] (lookup_object_or_alloc.part.0) from [<8095ec18>] (__debug_object_init+0x140/0x1d8 lib/debugobjects.c:798)
 r10:0001f930 r9:82cfc2c4 r8:00000001 r7:81c04360 r6:20000113 r5:82d1bbf8
 r4:df805d04 r3:00000001
[<8095ead8>] (__debug_object_init) from [<8095ed04>] (debug_object_init_on_stack lib/debugobjects.c:849 [inline])
[<8095ead8>] (__debug_object_init) from [<8095ed04>] (debug_object_init_on_stack+0x28/0x2c lib/debugobjects.c:844)
 r10:df805eac r9:fffff2a8 r8:00000101 r7:00000000 r6:ddde3e00 r5:82b62308
 r4:00000000
[<8095ecdc>] (debug_object_init_on_stack) from [<80300a84>] (init_rcu_head_on_stack+0x18/0x1c kernel/rcu/update.c:487)
[<80300a6c>] (init_rcu_head_on_stack) from [<80304e4c>] (__synchronize_srcu+0x7c/0xcc kernel/rcu/srcutree.c:1494)
[<80304dd0>] (__synchronize_srcu) from [<80304f38>] (synchronize_srcu_expedited kernel/rcu/srcutree.c:1521 [inline])
[<80304dd0>] (__synchronize_srcu) from [<80304f38>] (synchronize_srcu+0x78/0x14c kernel/rcu/srcutree.c:1577)
 r5:60000113 r4:82b62308
[<80304ec0>] (synchronize_srcu) from [<80bf0cd0>] (wakeup_source_remove drivers/base/power/wakeup.c:201 [inline])
[<80304ec0>] (synchronize_srcu) from [<80bf0cd0>] (wakeup_source_unregister.part.0+0x64/0x1b4 drivers/base/power/wakeup.c:237)
 r7:00000000 r6:862c4100 r5:00000113 r4:86469f00
[<80bf0c6c>] (wakeup_source_unregister.part.0) from [<80bf0e38>] (wakeup_source_unregister+0x18/0x1c drivers/base/power/wakeup.c:236)
 r7:00000000 r6:862c4100 r5:866aa000 r4:866aa008
[<80bf0e20>] (wakeup_source_unregister) from [<812f2368>] (mmc_host_classdev_release+0x1c/0x58 drivers/mmc/core/host.c:69)
[<812f234c>] (mmc_host_classdev_release) from [<80bcd9cc>] (device_release+0x40/0xb0 drivers/base/core.c:2636)
 r5:851bc500 r4:866aa008
[<80bcd98c>] (device_release) from [<81b351d0>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80bcd98c>] (device_release) from [<81b351d0>] (kobject_release lib/kobject.c:720 [inline])
[<80bcd98c>] (device_release) from [<81b351d0>] (kref_put include/linux/kref.h:65 [inline])
[<80bcd98c>] (device_release) from [<81b351d0>] (kobject_put+0xa0/0x258 lib/kobject.c:737)
 r5:81d5ae9c r4:866aa008
[<81b35130>] (kobject_put) from [<80bcdb40>] (put_device+0x18/0x1c drivers/base/core.c:3880)
 r8:00000101 r7:81310b3c r6:866aa000 r5:00000000 r4:866aa000
[<80bcdb28>] (put_device) from [<812f2ac4>] (mmc_free_host+0x28/0x2c drivers/mmc/core/host.c:702)
[<812f2a9c>] (mmc_free_host) from [<81310c9c>] (vub300_delete drivers/mmc/host/vub300.c:379 [inline])
[<812f2a9c>] (mmc_free_host) from [<81310c9c>] (kref_put include/linux/kref.h:65 [inline])
[<812f2a9c>] (mmc_free_host) from [<81310c9c>] (vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline])
[<812f2a9c>] (mmc_free_host) from [<81310c9c>] (vub300_inactivity_timer_expired+0x160/0x1b8 drivers/mmc/host/vub300.c:742)
 r5:00000000 r4:866aaaec
[<81310b3c>] (vub300_inactivity_timer_expired) from [<8032ef48>] (call_timer_fn+0x30/0x268 kernel/time/timer.c:1748)
 r7:81310b3c r6:8317e200 r5:866aaaec r4:866aaaec
[<8032ef18>] (call_timer_fn) from [<8032f41c>] (expire_timers kernel/time/timer.c:1799 [inline])
[<8032ef18>] (call_timer_fn) from [<8032f41c>] (__run_timers+0x29c/0x420 kernel/time/timer.c:2374)
 r10:df805eac r9:fffff2a8 r8:00000000 r7:81310b3c r6:82a0b150 r5:866aaaec
 r4:ddddafc0
[<8032f180>] (__run_timers) from [<8032f608>] (__run_timer_base kernel/time/timer.c:2386 [inline])
[<8032f180>] (__run_timers) from [<8032f608>] (__run_timer_base kernel/time/timer.c:2378 [inline])
[<8032f180>] (__run_timers) from [<8032f608>] (run_timer_base+0x68/0x78 kernel/time/timer.c:2395)
 r10:8317e200 r9:00000082 r8:00000101 r7:00000004 r6:00000002 r5:00000001
 r4:ddddafc0
[<8032f5a0>] (run_timer_base) from [<8032f634>] (run_timer_softirq+0x1c/0x34 kernel/time/timer.c:2405)
 r4:82a03084
[<8032f618>] (run_timer_softirq) from [<8025b0dc>] (handle_softirqs+0x160/0x4e4 kernel/softirq.c:622)
[<8025af7c>] (handle_softirqs) from [<8025b5fc>] (__do_softirq kernel/softirq.c:656 [inline])
[<8025af7c>] (handle_softirqs) from [<8025b5fc>] (invoke_softirq kernel/softirq.c:496 [inline])
[<8025af7c>] (handle_softirqs) from [<8025b5fc>] (__irq_exit_rcu+0x150/0x1d0 kernel/softirq.c:735)
 r10:824e709c r9:8317e200 r8:00000000 r7:df865f18 r6:824e709c r5:82522544
 r4:8317e200
[<8025b4ac>] (__irq_exit_rcu) from [<8025b934>] (irq_exit+0x10/0x18 kernel/softirq.c:764)
 r5:82522544 r4:828d3e6c
[<8025b924>] (irq_exit) from [<81b5d85c>] (generic_handle_arch_irq+0x7c/0x80 kernel/irq/handle.c:293)
[<81b5d7e0>] (generic_handle_arch_irq) from [<81b2a4e0>] (call_with_stack+0x1c/0x20 arch/arm/lib/call_with_stack.S:40)
 r9:8317e200 r8:00000000 r7:df865f4c r6:ffffffff r5:20000013 r4:81b5f0d0
[<81b2a4c4>] (call_with_stack) from [<80200bec>] (__irq_svc+0x8c/0xbc arch/arm/kernel/entry-armv.S:228)
Exception stack(0xdf865f18 to 0xdf865f60)
5f00:                                                       00000001 82333374
5f20: 000780b4 00000001 8317e200 00000001 00000000 828d3170 00000000 82a0b1c4
5f40: 824e709c df865f84 df865f58 df865f68 81b5e500 81b5f0d0 20000013 ffffffff
[<81b5f084>] (default_idle_call) from [<802b80fc>] (cpuidle_idle_call kernel/sched/idle.c:199 [inline])
[<81b5f084>] (default_idle_call) from [<802b80fc>] (do_idle+0x240/0x3c0 kernel/sched/idle.c:355)
 r7:828d3170 r6:00000000 r5:82a0b1a4 r4:8317e200
[<802b7ebc>] (do_idle) from [<802b858c>] (cpu_startup_entry+0x30/0x34 kernel/sched/idle.c:454)
 r10:00000000 r9:414fc0f0 r8:80003000 r7:82c834a4 r6:30c0387d r5:00000001
 r4:00000090
[<802b855c>] (cpu_startup_entry) from [<8022fc54>] (secondary_start_kernel+0x12c/0x198 arch/arm/kernel/smp.c:478)
[<8022fb28>] (secondary_start_kernel) from [<80220094>] (__enable_mmu+0x0/0xc arch/arm/kernel/head.S:446)
 r5:00000000 r4:830b70c0
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
