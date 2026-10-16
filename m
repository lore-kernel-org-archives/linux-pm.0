Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20022F6188
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118740; cv=none; b=jaTNmUe1WIzyS9EDDtwHuAiK8HUs08Kd8VM61629r63tDem4kOtJQTYbil24eNcTdGUFmQQcYT1qWrqrCHj0gFZp+CZFZC6yEJ1+ddEBOb//2LhL3Q5TuAeEGRebw2Q4B97GGIPqoNvJWDpiiUpJH/k+FDVLCorI7s5Idz/XOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118740; c=relaxed/simple;
	bh=IE3vhzJCpcsuRVqgAbpm2icf0SaJyRmEDDrxW0o0f8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bmNbkJdpu1k1ia6c1MnjaWYVfoPmi65V2tGcuvPfLM5t3CbauhYvgSr3QujeJI14/9AChrTp5Y3/Fu9geVPmUxrKqXu0H3reMt8d/rb2wOvYlKkcKKjpcJAJba1vfjdUT0nM20OwmR+hMSdlzP9EKvhFdMTEajS2UfzO8bk7Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4eb0b989f0eso1059744b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 19:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118737; x=1792723537;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XX3/oYkLjmdjSqbDcP/sp/YOpYFp+mZ+ZxYseY0tPWg=;
        b=nHuq7CbEGKoTj59Z2ZDn5mrBYDmTiMyXAyzxe9ZqzlbE++7LbKlLStstnFYDMA/BWs
         rGOhh3E78Fy79SUJFhQs5lHMpdgSJO32rretdtdEuMQpsltWQKE4Hw2hJsxiS+7dFNbM
         YJg5ObxvMBwbO2hpWoHuT0JuGc2lj2FHI08sZzEuUTZWeSflEIL3gMPk6Rf0paV19nPI
         P7ZIPFs/6qM9629Edz6xe3SmpqF7q0mYHtLeSd6Zm9P094nLiR9mu09lpjx6lwjSu2lA
         GudMT97bK+a5EVxwT3PT4ejEwVx4pmANzo7239/PZUO7B4SY1q26R8Oq3xTcerMY2T+O
         Qsng==
X-Forwarded-Encrypted: i=1; AKwUvBxFiGd0SCwBjMPQZcbW0UuCvd+Oed49Gokv0xW3aiH4stOftECPwuGV0eUIfhAdeEZlYrJqo3IT2A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLOHSlaKmPID9KOwBMDNy9Vj1Dt0J2UYl6z2ZCmktAU48DL0XN
	CTwJbO5ktcwUtcNFQxDr9Ehptp1b422zcUWjgoipG3fGSMuZVU+J9SPHrOFL3jmQe9I1ra/U5XV
	fgPKZDTZNFAEbyJugz2HVlojQ+d4GiFWXHSI1okqN6auRLCYMPAGVAbKvQXU=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e85:b0:4ea:935e:43d6 with SMTP id
 5614622812f47-5370270df29mr1157162b6e.45.1792118737052; Thu, 15 Oct 2026
 19:45:37 -0700 (PDT)
Date: Thu, 15 Oct 2026 19:45:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad18fd1.7514cce4.1ece07.0120.GAE@google.com>
Subject: [syzbot] [pm?] BUG: sleeping function called from invalid context in __synchronize_srcu
From: syzbot <syzbot+136ee4ebfb4a81dab91b@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fcb05b72344 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f2ce8e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44ac479246d4559b
dashboard link: https://syzkaller.appspot.com/bug?extid=136ee4ebfb4a81dab91b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0fcb05b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7de97b060425/vmlinux-0fcb05b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe04791ba0c2/bzImage-0fcb05b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+136ee4ebfb4a81dab91b@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/workqueue.c:4561
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 13343, name: syz-executor
preempt_count: 100, expected: 0
RCU nest depth: 1, expected: 0
locks held by syz-executor/13343: 3, last CPU#0:
 #0: ffff888026340460 (sb_writers#5){.+.+}-{0:0}, at: filename_unlinkat+0x1ad/0x730 fs/namei.c:5725
 #1: ffffffff8fdec3e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8fdec3e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8fdec3e0 (rcu_read_lock){....}-{1:3}, at: find_lock_entries+0x10f/0x1190 mm/filemap.c:2188
 #2: ffffc90000007c98 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11d/0x5f0 kernel/time/timer.c:1745
Preemption disabled at:
[<ffffffff81c9ef13>] softirq_handle_begin kernel/softirq.c:486 [inline]
[<ffffffff81c9ef13>] handle_softirqs+0xf3/0x9d0 kernel/softirq.c:621
CPU: 0 UID: 0 PID: 13343 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
=============================
WARNING: suspicious RCU usage
syzkaller #0 Tainted: G        W    L     
-----------------------------
kernel/rcu/srcutree.c:1464 Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz-executor/13343: 3, last CPU#0:
 #0: 
ffff888026340460
 (
sb_writers
#5
){.+.+}-{0:0}
, at: filename_unlinkat+0x1ad/0x730 fs/namei.c:5725
 #1: 
ffffffff8fdec3e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
ffffffff8fdec3e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
ffffffff8fdec3e0 (rcu_read_lock){....}-{1:3}, at: find_lock_entries+0x10f/0x1190 mm/filemap.c:2188
 #2: ffffc90000007c98 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11d/0x5f0 kernel/time/timer.c:1745

stack backtrace:
CPU: 0 UID: 0 PID: 13343 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb2 kernel/locking/lockdep.c:6972
 __synchronize_srcu+0x29d/0x300 kernel/rcu/srcutree.c:1464
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister.part.0+0x12c/0x540 drivers/base/power/wakeup.c:237
 wakeup_source_unregister+0x1f/0x30 drivers/base/power/wakeup.c:236
 mmc_host_classdev_release+0x42/0x120 drivers/mmc/core/host.c:69
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline]
 vub300_inactivity_timer_expired+0x42f/0x550 drivers/mmc/host/vub300.c:742
 call_timer_fn+0x198/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb00 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__sanitizer_cov_trace_pc+0x46/0x70 kernel/kcov.c:213
Code: 00 01 00 ff 74 1e f6 c4 01 74 44 a9 00 00 00 0f 75 3d f7 c1 00 00 00 f0 75 35 8b 82 44 17 00 00 85 c0 74 2b 8b 82 18 17 00 00 <83> f8 02 75 20 48 8b 8a 20 17 00 00 8b 92 1c 17 00 00 48 8b 01 48
RSP: 0000:ffffc9002334f5d8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc9002334f6c0 RCX: 0000000000000000
RDX: ffff888073702580 RSI: ffffffff8bd06124 RDI: ffff888073702580
RBP: 0000000000002a3b R08: 0000000000000006 R09: 0000000000002a3b
R10: fffffffffffffffe R11: 0000000000000001 R12: fffffffffffffffe
R13: ffff888050b7a680 R14: 0000000000000000 R15: dffffc0000000000
 xas_find+0xc4/0x8e0 lib/xarray.c:1408
 find_get_entry mm/filemap.c:2085 [inline]
 find_lock_entries+0x176/0x1190 mm/filemap.c:2189
 shmem_undo_range+0x212/0x1570 mm/shmem.c:1143
 shmem_truncate_range mm/shmem.c:1289 [inline]
 shmem_evict_inode+0x3b1/0xca0 mm/shmem.c:1420
 evict+0x3c2/0xad0 fs/inode.c:822
 iput_final fs/inode.c:2014 [inline]
 iput.part.0+0x989/0x1050 fs/inode.c:2063
 iput+0x35/0x40 fs/inode.c:2029
 filename_unlinkat+0x466/0x730 fs/namei.c:5752
 __do_sys_unlink fs/namei.c:5783 [inline]
 __se_sys_unlink fs/namei.c:5780 [inline]
 __ia32_sys_unlink+0x45/0x60 fs/namei.c:5780
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f95fec
Code: d2 74 05 c1 e8 0c 89 02 8b 5d fc 31 c0 c9 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 58 b8
RSP: 002b:00000000ffb7b7c8 EFLAGS: 00000292
 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00000000ffb7b870 RCX: 0000000000008000
RDX: 00000000f741aff4 RSI: 0000000000000000 RDI: 00000000ffb7c904
RBP: 00000000ffb7b870 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
ODEBUG: object ffffc90000007a60 is NOT on stack ffffc90023348000, but annotated.
------------[ cut here ]------------
1
WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#0: syz-executor/13343
WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705, CPU#0: syz-executor/13343
Modules linked in:

CPU: 0 UID: 0 PID: 13343 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:672 [inline]
RIP: 0010:lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705
Code: c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 c5 01 89 2d 20 28 7d 1b 4c 89 e6 48 c7 c7 c0 65 62 8c e8 e1 c7 eb ff 90 <0f> 0b 90 e9 62 70 fe 03 83 c5 01 89 2d ff 27 7d 1b 49 39 c4 73 da
RSP: 0000:ffffc900000078f0 EFLAGS: 00010082

RAX: 0000000000000050 RBX: ffff8880150a88f8 RCX: 0000000000000000
RDX: 0000000000000050 RSI: ffffffff81e9ad09 RDI: fffff52000000f0f
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000101 R11: 0000000000000001 R12: ffffc90000007a60
R13: ffff888073702580 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88809574a000(0063) knlGS:0000000056b1e480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f737dffc CR3: 000000004e89d000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lookup_object_or_alloc lib/debugobjects.c:682 [inline]
 __debug_object_init+0x2a9/0x3d0 lib/debugobjects.c:798
 __synchronize_srcu+0x1c3/0x300 kernel/rcu/srcutree.c:1475
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister.part.0+0x12c/0x540 drivers/base/power/wakeup.c:237
 wakeup_source_unregister+0x1f/0x30 drivers/base/power/wakeup.c:236
 mmc_host_classdev_release+0x42/0x120 drivers/mmc/core/host.c:69
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline]
 vub300_inactivity_timer_expired+0x42f/0x550 drivers/mmc/host/vub300.c:742
 call_timer_fn+0x198/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb00 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__sanitizer_cov_trace_pc+0x46/0x70 kernel/kcov.c:213
Code: 00 01 00 ff 74 1e f6 c4 01 74 44 a9 00 00 00 0f 75 3d f7 c1 00 00 00 f0 75 35 8b 82 44 17 00 00 85 c0 74 2b 8b 82 18 17 00 00 <83> f8 02 75 20 48 8b 8a 20 17 00 00 8b 92 1c 17 00 00 48 8b 01 48
RSP: 0000:ffffc9002334f5d8 EFLAGS: 00000246

RAX: 0000000000000000 RBX: ffffc9002334f6c0 RCX: 0000000000000000
RDX: ffff888073702580 RSI: ffffffff8bd06124 RDI: ffff888073702580
RBP: 0000000000002a3b R08: 0000000000000006 R09: 0000000000002a3b
R10: fffffffffffffffe R11: 0000000000000001 R12: fffffffffffffffe
R13: ffff888050b7a680 R14: 0000000000000000 R15: dffffc0000000000
 xas_find+0xc4/0x8e0 lib/xarray.c:1408
 find_get_entry mm/filemap.c:2085 [inline]
 find_lock_entries+0x176/0x1190 mm/filemap.c:2189
 shmem_undo_range+0x212/0x1570 mm/shmem.c:1143
 shmem_truncate_range mm/shmem.c:1289 [inline]
 shmem_evict_inode+0x3b1/0xca0 mm/shmem.c:1420
 evict+0x3c2/0xad0 fs/inode.c:822
 iput_final fs/inode.c:2014 [inline]
 iput.part.0+0x989/0x1050 fs/inode.c:2063
 iput+0x35/0x40 fs/inode.c:2029
 filename_unlinkat+0x466/0x730 fs/namei.c:5752
 __do_sys_unlink fs/namei.c:5783 [inline]
 __se_sys_unlink fs/namei.c:5780 [inline]
 __ia32_sys_unlink+0x45/0x60 fs/namei.c:5780
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f95fec
Code: d2 74 05 c1 e8 0c 89 02 8b 5d fc 31 c0 c9 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 58 b8
RSP: 002b:00000000ffb7b7c8 EFLAGS: 00000292
 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00000000ffb7b870 RCX: 0000000000008000
RDX: 00000000f741aff4 RSI: 0000000000000000 RDI: 00000000ffb7c904
RBP: 00000000ffb7b870 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 01                	add    %al,(%rcx)
   2:	00 ff                	add    %bh,%bh
   4:	74 1e                	je     0x24
   6:	f6 c4 01             	test   $0x1,%ah
   9:	74 44                	je     0x4f
   b:	a9 00 00 00 0f       	test   $0xf000000,%eax
  10:	75 3d                	jne    0x4f
  12:	f7 c1 00 00 00 f0    	test   $0xf0000000,%ecx
  18:	75 35                	jne    0x4f
  1a:	8b 82 44 17 00 00    	mov    0x1744(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 2b                	je     0x4f
  24:	8b 82 18 17 00 00    	mov    0x1718(%rdx),%eax
* 2a:	83 f8 02             	cmp    $0x2,%eax <-- trapping instruction
  2d:	75 20                	jne    0x4f
  2f:	48 8b 8a 20 17 00 00 	mov    0x1720(%rdx),%rcx
  36:	8b 92 1c 17 00 00    	mov    0x171c(%rdx),%edx
  3c:	48 8b 01             	mov    (%rcx),%rax
  3f:	48                   	rex.W


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
