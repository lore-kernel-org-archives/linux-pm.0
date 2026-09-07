Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE741D4C1
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791561; cv=none; b=o7VV4LajniY7RWtOtZd+pbyRbMzythINTSIL8NdHC1bsuSie5k3YJMmCjeUw0UIYc5m+5rP4cLcoTbw/8lCJ0icybJgDU29Llzn+rzBj7i0hOcYWl33dfO1djUZF5Zac1Z7TGKpM2DSRKedPKyCXhRJLRSCiQMUkjnJwzb4E/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791561; c=relaxed/simple;
	bh=fBmJkFrjdbqQa9wtHbLrYELqEWWCgzQze+ARyBh4rsk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K9bGffgYHO7bETTmvyfar542SODioefV9b/+/q3Q21a8G4DuWeLFx64ZbsFY7j2Bqp1B28rRYUuq8BuDpMjvh8l65XbY3dnl7o92nyNk9kAxkWAYgTnAw7CImsTmDa4PFz7JzzsUAJ45pR+dHECW365cznLizGHe1YsV3kS8LWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-7f4ddb9adf4so1290799a34.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 07:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791555; x=1789396355;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8kkssp/3l33VQHdWcbtgleD7SI3txr/4Uxqa9iwhW4=;
        b=s0UUEx5aQfAFDywe4oCW9HN7tR7+mmjxt4U1qcA+1dp6w0f2WXD2ziISma0gGAUmY7
         gEfHaP+uXrIoxEulwd8ZCISV9ZC+PdVp46AbKuJkZpBcC16yyJzZDVvjVALBsbMxnoUr
         7zZ1ghk7/VMJnbTWLfMS3+Ans2NctiCjmdS2A3F+JZo5lVxlwKnKjLKs4ksdL/nwoq4r
         FNps9lDPbWU5MIBZYr4DjJO2cpzf+xb6YvzHJwyQ+2qCp7AWPridC2y3tB8EQc7vCegt
         yf9DQg3uBFhbldyHewkXPB9oayJ3h9gjX1+dZ2flcAapTSbCTm0qrHVBa3C2xba7YVIg
         IrhQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4He23igscIy9Q9G4ggzNGYPc4tsjBcW9eLyRWAlg0Ro29iDzoCXLfXUmnFREtLq+LDi/t6wajeQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kohwN4CocFAqlb/wF0qQl5eCc9cOJL0hL0bGqtkzqO+SgRB1/J
	jONFJWf9/pZmTwqZK+D3BVjCxPJIZsWHOBtsS6HIIGxB61of/Poq9GE8H/z1SYCqMNQry3SicJl
	AILIeXP31vyxWJPr5cD0gKkpBFv6woQZGvi2r8ydEu90d5t4iXU5tzflpLqI=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e904:0:b0:6b7:83c5:fdf0 with SMTP id
 006d021491bc7-6b783c603b3mr12556035eaf.49.1788791555747; Mon, 07 Sep 2026
 07:32:35 -0700 (PDT)
Date: Mon, 07 Sep 2026 07:32:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9ecb03.2bb5a69c.24b23c.0003.GAE@google.com>
Subject: [syzbot] [pm?] WARNING: suspicious RCU usage in wakeup_source_unregister
From: syzbot <syzbot+2d935ddaec3db1ab6f26@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    841e384b841a Merge tag 's390-7.3-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d94b9e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=2d935ddaec3db1ab6f26
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c871e5c1ff29/disk-841e384b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/056a12208699/vmlinux-841e384b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09b9c08fc219/bzImage-841e384b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d935ddaec3db1ab6f26@syzkaller.appspotmail.com

RBP: 00007fdafa94fdec R08: 0000000000000000 R09: 0000000000000001
R10: 000055558fe747d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000076876 R15: 00007fdafa94fe40
 </TASK>
=============================
WARNING: suspicious RCU usage
syzkaller #0 Tainted: G        W    L     
-----------------------------
kernel/rcu/srcutree.c:1468 Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz-executor/5675: 5, last CPU#0:
 #0: ffffffff8ee35c10 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ee35c10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1595
 #1: ffff88807ed2c378 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff88807ed2c378 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888025d09078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888025d09078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #4: ffffc90000007cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745

stack backtrace:
CPU: 0 UID: 0 PID: 5675 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 __synchronize_srcu+0x157/0x2f0 kernel/rcu/srcutree.c:1464
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
 mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x413/0xc60 kernel/sched/core.c:5371
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 f7 ed 50 0a e8 d2 00 3a 00 fb 4c 8b 65 c8 <49> 8d bc 24 10 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc90004327020 EFLAGS: 00000206
RAX: 00000000000f564d RBX: ffff8880b863c8e0 RCX: 8000000000000001
RDX: 0000000000000006 RSI: ffffffff8e4744cc RDI: ffffffff8c6d9480
RBP: ffffc90004327070 R08: ffffffff907a167f R09: 1ffffffff20f42cf
R10: dffffc0000000000 R11: fffffbfff20f42d0 R12: ffff88803588ddc0
R13: ffff8880b863c8b8 R14: dffffc0000000000 R15: 1ffff110170c791c
 context_switch kernel/sched/core.c:5523 [inline]
 __schedule+0x17e3/0x58f0 kernel/sched/core.c:7270
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7449
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:201 [inline]
 _raw_spin_unlock+0x41/0x50 kernel/locking/spinlock.c:213
 spin_unlock include/linux/spinlock.h:401 [inline]
 copy_pte_range mm/memory.c:1429 [inline]
 copy_pmd_range+0x5176/0x5c10 mm/memory.c:1490
 copy_pud_range mm/memory.c:1527 [inline]
 copy_p4d_range mm/memory.c:1551 [inline]
 copy_page_range+0xc82/0x1290 mm/memory.c:1637
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1595
 copy_process+0x1e75/0x43e0 kernel/fork.c:2307
 kernel_clone+0x2d7/0x940 kernel/fork.c:2766
 __do_sys_clone kernel/fork.c:2908 [inline]
 __se_sys_clone kernel/fork.c:2892 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2892
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdafa5c6bd2
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007fdafa94fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fdafa94fc60 RCX: 00007fdafa5c6bd2
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fdafa94fdec R08: 0000000000000000 R09: 0000000000000001
R10: 000055558fe747d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000076876 R15: 00007fdafa94fe40
 </TASK>
BUG: sleeping function called from invalid context at kernel/rcu/srcutree.c:1472
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5675, name: syz-executor
preempt_count: 101, expected: 0
RCU nest depth: 1, expected: 0
locks held by syz-executor/5675: 5, last CPU#0:
 #0: ffffffff8ee35c10 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ee35c10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1595
 #1: ffff88807ed2c378 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff88807ed2c378 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888025d09078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888025d09078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #4: ffffc90000007cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
Preemption disabled at:
[<ffffffff81336576>] preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
CPU: 0 UID: 0 PID: 5675 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x36a/0x4c0 kernel/sched/core.c:9234
 __synchronize_srcu+0x1a1/0x2f0 kernel/rcu/srcutree.c:1472
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
 mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x413/0xc60 kernel/sched/core.c:5371
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 f7 ed 50 0a e8 d2 00 3a 00 fb 4c 8b 65 c8 <49> 8d bc 24 10 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc90004327020 EFLAGS: 00000206
RAX: 00000000000f564d RBX: ffff8880b863c8e0 RCX: 8000000000000001
RDX: 0000000000000006 RSI: ffffffff8e4744cc RDI: ffffffff8c6d9480
RBP: ffffc90004327070 R08: ffffffff907a167f R09: 1ffffffff20f42cf
R10: dffffc0000000000 R11: fffffbfff20f42d0 R12: ffff88803588ddc0
R13: ffff8880b863c8b8 R14: dffffc0000000000 R15: 1ffff110170c791c
 context_switch kernel/sched/core.c:5523 [inline]
 __schedule+0x17e3/0x58f0 kernel/sched/core.c:7270
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7449
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:201 [inline]
 _raw_spin_unlock+0x41/0x50 kernel/locking/spinlock.c:213
 spin_unlock include/linux/spinlock.h:401 [inline]
 copy_pte_range mm/memory.c:1429 [inline]
 copy_pmd_range+0x5176/0x5c10 mm/memory.c:1490
 copy_pud_range mm/memory.c:1527 [inline]
 copy_p4d_range mm/memory.c:1551 [inline]
 copy_page_range+0xc82/0x1290 mm/memory.c:1637
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1595
 copy_process+0x1e75/0x43e0 kernel/fork.c:2307
 kernel_clone+0x2d7/0x940 kernel/fork.c:2766
 __do_sys_clone kernel/fork.c:2908 [inline]
 __se_sys_clone kernel/fork.c:2892 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2892
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdafa5c6bd2
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007fdafa94fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fdafa94fc60 RCX: 00007fdafa5c6bd2
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fdafa94fdec R08: 0000000000000000 R09: 0000000000000001
R10: 000055558fe747d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000076876 R15: 00007fdafa94fe40
 </TASK>
ODEBUG: object ffffc90000007a80 is NOT on stack ffffc90004320000, but annotated.
------------[ cut here ]------------
1
WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#0: syz-executor/5675
WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc lib/debugobjects.c:705 [inline], CPU#0: syz-executor/5675
WARNING: lib/debugobjects.c:672 at __debug_object_init+0x2c4/0x3c0 lib/debugobjects.c:798, CPU#0: syz-executor/5675
Modules linked in:
CPU: 0 UID: 0 PID: 5675 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:672 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:705 [inline]
RIP: 0010:__debug_object_init+0x2c4/0x3c0 lib/debugobjects.c:798
Code: cc cc cc 41 ff c7 44 89 3d c9 75 e8 15 48 c7 c1 80 9d 6d 8c 48 c7 c7 e0 9d 6d 8c 84 c0 48 0f 45 f9 48 89 de e8 4d fa 3d fc 90 <0f> 0b 90 e9 c0 fe ff ff e8 4f 1c 00 00 8b 05 a1 cd 6e 0a 3b 05 9f
RSP: 0018:ffffc900000079b8 EFLAGS: 00010046
RAX: 0000000000000050 RBX: ffffc90000007a80 RCX: 0978036a12caea00
RDX: 0000000000000100 RSI: 0000000000000100 RDI: 0000000000000000
RBP: ffff88803588dde0 R08: 0000000000000100 R09: 0000000000080000
R10: 0000000000008000 R11: ffffffff8ec362b8 R12: 1ffff92000000f4c
R13: ffff888021b995e8 R14: dffffc0000000000 R15: 0000000000000001
FS:  000055558fe74500(0000) GS:ffff888124cd9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdafb3556c8 CR3: 00000000640ca000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __synchronize_srcu+0x1d5/0x2f0 kernel/rcu/srcutree.c:1475
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
 mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x413/0xc60 kernel/sched/core.c:5371
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 f7 ed 50 0a e8 d2 00 3a 00 fb 4c 8b 65 c8 <49> 8d bc 24 10 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc90004327020 EFLAGS: 00000206
RAX: 00000000000f564d RBX: ffff8880b863c8e0 RCX: 8000000000000001
RDX: 0000000000000006 RSI: ffffffff8e4744cc RDI: ffffffff8c6d9480
RBP: ffffc90004327070 R08: ffffffff907a167f R09: 1ffffffff20f42cf
R10: dffffc0000000000 R11: fffffbfff20f42d0 R12: ffff88803588ddc0
R13: ffff8880b863c8b8 R14: dffffc0000000000 R15: 1ffff110170c791c
 context_switch kernel/sched/core.c:5523 [inline]
 __schedule+0x17e3/0x58f0 kernel/sched/core.c:7270
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7449
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:201 [inline]
 _raw_spin_unlock+0x41/0x50 kernel/locking/spinlock.c:213
 spin_unlock include/linux/spinlock.h:401 [inline]
 copy_pte_range mm/memory.c:1429 [inline]
 copy_pmd_range+0x5176/0x5c10 mm/memory.c:1490
 copy_pud_range mm/memory.c:1527 [inline]
 copy_p4d_range mm/memory.c:1551 [inline]
 copy_page_range+0xc82/0x1290 mm/memory.c:1637
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1595
 copy_process+0x1e75/0x43e0 kernel/fork.c:2307
 kernel_clone+0x2d7/0x940 kernel/fork.c:2766
 __do_sys_clone kernel/fork.c:2908 [inline]
 __se_sys_clone kernel/fork.c:2892 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2892
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdafa5c6bd2
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007fdafa94fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fdafa94fc60 RCX: 00007fdafa5c6bd2
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fdafa94fdec R08: 0000000000000000 R09: 0000000000000001
R10: 000055558fe747d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000076876 R15: 00007fdafa94fe40
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	41 c7 84 24 20 0e 00 	movl   $0x0,0xe20(%r12)
   9:	00 00 00 00 00
   e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  13:	49 83 c4 48          	add    $0x48,%r12
  17:	4c 89 e7             	mov    %r12,%rdi
  1a:	e8 f7 ed 50 0a       	call   0xa50ee16
  1f:	e8 d2 00 3a 00       	call   0x3a00f6
  24:	fb                   	sti
  25:	4c 8b 65 c8          	mov    -0x38(%rbp),%r12
* 29:	49 8d bc 24 10 17 00 	lea    0x1710(%r12),%rdi <-- trapping instruction
  30:	00
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  3d:	84 c0                	test   %al,%al


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
