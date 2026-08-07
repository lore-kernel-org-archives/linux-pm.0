Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFB4B04BB
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060953; cv=none; b=q/CKYZ5EY7aGKbeZ1kqdBthnn9XDb4EXTzd7nM8fkwn2ndsbYsv37OTvE5NfG5gY6pgvg8lt60n+kj7DhkcuS1uTQBok9fkuBxDiO5TVJ8sQuVfbZ5pjj1Gqm0VtZanS1nk5wmAIPE6/77pHOLiU8P+qeyd/1miVUcy0z2yC2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060953; c=relaxed/simple;
	bh=z2tXnhjE9e1sQO8jaEH+JYwBo2RPBDcsQUQ2mgfd6Ig=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hadZ+21SJw4avk9ITFgA1jhfmW7EWFmB2toX31REdY00RWHzTstMueNcjEOzxHonHhECc+aIg0jwFg3CH3Y9hyhuAghbee7+CzzpHuNQzhuZy5NGNCjRaQ+J4BJ4/9gY1zEBFP+zD8h9tPRiQggqlY3Qu36GZRC9qyvmMI0aQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6a313ec13ceso1155641eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 17:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060946; x=1786665746;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XZ/crxJoplbs1rqNkidwJyW5ffroSRO0+0Frz8Wl6M=;
        b=B0hWJXvDfZ7dHo3+sPVWCmwrE/jkXqr7WjE1pJskornlpyHqalwZgpSvVbdUvbqZS3
         0j4a7G7a3k/gn2UTKK1EyrYhTCeeuK2PwS+tP5cK1jGXdgE8nx+gGQvDheFGsZcSxau9
         cihMB3vpKA/vw8HAg8FnrJ6wPKjM3OOUx7S+84XeBlUyG6eRhqkMQalnxMF8YTHKXT4g
         VHYpZiRvjDX7ZU+aRoQja6+gprxTBfwb7GNt2xxVrt/V4liPSChse6raFG7/HbGiCtS1
         NYkxLhfdyyI6NDAJQKc4TM3X7QY4nMZqxNnL/1c8vReBpLFy8kuVriFtrkb36oD0W65f
         DpWg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Kb5ef8JmFiru2MN4tWAvlIMWi1xEzjPK7oO+Q7W5N10fKYlGz3D0kOIBw6PixGY71Nr3PTU8Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc8nReSiPgUb6vZ5Rvc2D/PNkhJLlQxTus4iMDJcDBPrW9gXT
	uoKhxpZ52WsUpZ69BwNAnWlLBBRuV7GjzZgbLvJ9XdYWbr12JlmOasWQWL5a/h4ZD6aDI+aYRmV
	EjoN3Jw4mfN6jvM/ovzP6pU2x6VuDKGunb6+ArkdHIkxzagvuTEdhz/b/CtQ=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a09:b0:6ae:8a52:ffa9 with SMTP id
 006d021491bc7-6ae96c17679mr9341349eaf.3.1786060946165; Thu, 06 Aug 2026
 17:02:26 -0700 (PDT)
Date: Thu, 06 Aug 2026 17:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a752092.9c11d2ce.289b96.009f.GAE@google.com>
Subject: [syzbot] [pm?] inconsistent lock state in lock_sync
From: syzbot <syzbot+7b4431d5335ca2d9f771@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1479be32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=7b4431d5335ca2d9f771
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32c9dc084aaa/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7604244b0a9/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4cd321f6fe47/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b4431d5335ca2d9f771@syzkaller.appspotmail.com

RBP: 00007faa6b63500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faa6b826038 R14: 00007faa6b825fa0 R15: 00007ffe29482fa8
 </TASK>
================================
WARNING: inconsistent lock state
syzkaller #0 Tainted: G        W          
--------------------------------
inconsistent {SOFTIRQ-ON-R} -> {IN-SOFTIRQ-W} usage.
syz.4.93/7194 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffff8fc0ed18 (wakeup_srcu){.+-+}-{0:0}, at: srcu_lock_sync include/linux/srcu.h:199 [inline]
ffffffff8fc0ed18 (wakeup_srcu){.+-+}-{0:0}, at: __synchronize_srcu+0x1c/0x300 kernel/rcu/srcutree.c:1481
{SOFTIRQ-ON-R} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
  srcu_lock_acquire include/linux/srcu.h:187 [inline]
  srcu_read_lock include/linux/srcu.h:294 [inline]
  device_wakeup_arm_wake_irqs+0x53/0x130 drivers/base/power/wakeup.c:401
  dpm_suspend_noirq drivers/base/power/main.c:1652 [inline]
  dpm_suspend_end+0xe5/0x210 drivers/base/power/main.c:1860
  create_image kernel/power/hibernate.c:328 [inline]
  hibernation_snapshot+0x28b/0x9c0 kernel/power/hibernate.c:442
  hibernate.cold+0x17c/0x6a2 kernel/power/hibernate.c:811
  state_store+0x1ff/0x240 kernel/power/main.c:821
  kobj_attr_store+0x58/0x80 lib/kobject.c:840
  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
  kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
  new_sync_write fs/read_write.c:595 [inline]
  vfs_write+0x6ac/0x1050 fs/read_write.c:687
  ksys_write+0x12a/0x250 fs/read_write.c:739
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 90148
hardirqs last  enabled at (90148): [<ffffffff8bbe28f2>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
hardirqs last  enabled at (90148): [<ffffffff8bbe28f2>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:198
hardirqs last disabled at (90147): [<ffffffff8bbe2602>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:130 [inline]
hardirqs last disabled at (90147): [<ffffffff8bbe2602>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:166
softirqs last  enabled at (89630): [<ffffffff81c8f222>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (89630): [<ffffffff81c8f222>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (89630): [<ffffffff81c8f222>] __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
softirqs last disabled at (89637): [<ffffffff81c8f222>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (89637): [<ffffffff81c8f222>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (89637): [<ffffffff81c8f222>] __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(wakeup_srcu);
  <Interrupt>
    lock(wakeup_srcu);

 *** DEADLOCK ***

8 locks held by syz.4.93/7194:
 #0: ffff88807ade1430 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff888069482450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888055791080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff88801f2c81e8 (kn->active#61){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff88801f2c81e8 (kn->active#61){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #4: ffffffff8ea9fc80 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x56/0x70 kernel/power/main.c:71
 #5: ffffffff8fbf46e0 (device_hotplug_lock){+.+.}-{4:4}, at: hibernate.cold+0x126/0x6a2 kernel/power/hibernate.c:805
 #6: ffffffff8f8c6bc0 (acpi_scan_lock){+.+.}-{4:4}, at: acpi_pm_start drivers/acpi/sleep.c:533 [inline]
 #6: ffffffff8f8c6bc0 (acpi_scan_lock){+.+.}-{4:4}, at: acpi_hibernation_begin+0xf6/0x1c0 drivers/acpi/sleep.c:945
 #7: ffffc90000a08ca0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745

stack backtrace:
CPU: 1 UID: 0 PID: 7194 Comm: syz.4.93 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_usage_bug.part.0+0x257/0x340 kernel/locking/lockdep.c:4042
 print_usage_bug kernel/locking/lockdep.c:4010 [inline]
 valid_state kernel/locking/lockdep.c:4056 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4273 [inline]
 mark_lock+0x6b5/0xa20 kernel/locking/lockdep.c:4753
 mark_usage kernel/locking/lockdep.c:4642 [inline]
 __lock_acquire+0xff3/0x1a40 kernel/locking/lockdep.c:5191
 lock_sync kernel/locking/lockdep.c:5916 [inline]
 lock_sync+0x9d/0x110 kernel/locking/lockdep.c:5904
 srcu_lock_sync include/linux/srcu.h:199 [inline]
 __synchronize_srcu+0xa2/0x300 kernel/rcu/srcutree.c:1481
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister.part.0+0x12c/0x540 drivers/base/power/wakeup.c:237
 wakeup_source_unregister+0x1f/0x30 drivers/base/power/wakeup.c:236
 mmc_host_classdev_release+0x42/0x120 drivers/mmc/core/host.c:69
 device_release+0xd2/0x270 drivers/base/core.c:2636
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3880
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline]
 vub300_inactivity_timer_expired+0x42f/0x550 drivers/mmc/host/vub300.c:742
 call_timer_fn+0x19a/0x610 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb00 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:198
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 f6 d0 27 f6 48 89 df e8 7e 20 28 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 05 2e 17 f6 65 8b 05 4e 57 a6 08 85 c0 74 16 5b
RSP: 0018:ffffc9000500fb10 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff88823fff8740 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffffffff8e1a8186 RDI: ffffffff8c402680
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000140001
R13: 00000000000a8d20 R14: ffffffff81e6a290 R15: 0000000000000005
 mark_free_pages kernel/power/snapshot.c:1252 [inline]
 count_data_pages+0x7d/0xf0 kernel/power/snapshot.c:1417
 hibernate_preallocate_memory+0x104/0x507 kernel/power/snapshot.c:1859
 hibernation_snapshot+0x1e6/0x9c0 kernel/power/hibernate.c:430
 hibernate.cold+0x17c/0x6a2 kernel/power/hibernate.c:811
 state_store+0x1ff/0x240 kernel/power/main.c:821
 kobj_attr_store+0x58/0x80 lib/kobject.c:840
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa6b59e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa6c4cf028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faa6b825fa0 RCX: 00007faa6b59e019
RDX: 0000000000000005 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007faa6b63500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faa6b826038 R14: 00007faa6b825fa0 R15: 00007ffe29482fa8
 </TASK>
ODEBUG: object ffffc90000a08a70 is NOT on stack ffffc90005008000, but annotated.
------------[ cut here ]------------
1
WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#1: syz.4.93/7194
WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705, CPU#1: syz.4.93/7194
Modules linked in:
CPU: 1 UID: 0 PID: 7194 Comm: syz.4.93 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:672 [inline]
RIP: 0010:lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705
Code: c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f e9 49 18 88 0a 83 c5 01 89 2d 20 43 57 1a 4c 89 e6 48 c7 c7 c0 31 40 8c e8 f1 ef eb ff 90 <0f> 0b 90 e9 d2 03 f1 03 83 c5 01 89 2d ff 42 57 1a 49 39 c4 73 da
RSP: 0018:ffffc90000a08900 EFLAGS: 00010086
RAX: 0000000000000050 RBX: ffff888076281508 RCX: 0000000000000000
RDX: 0000000000000050 RSI: ffffffff81e8afd9 RDI: fffff52000141111
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000102 R11: 205d314320202020 R12: ffffc90000a08a70
R13: ffff888033bc0000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007faa6c4cf6c0(0000) GS:ffff888123ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 00000000618ef000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lookup_object_or_alloc lib/debugobjects.c:682 [inline]
 __debug_object_init+0x2a9/0x3d0 lib/debugobjects.c:798
 __synchronize_srcu+0x1c3/0x300 kernel/rcu/srcutree.c:1494
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister.part.0+0x12c/0x540 drivers/base/power/wakeup.c:237
 wakeup_source_unregister+0x1f/0x30 drivers/base/power/wakeup.c:236
 mmc_host_classdev_release+0x42/0x120 drivers/mmc/core/host.c:69
 device_release+0xd2/0x270 drivers/base/core.c:2636
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3880
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline]
 vub300_inactivity_timer_expired+0x42f/0x550 drivers/mmc/host/vub300.c:742
 call_timer_fn+0x19a/0x610 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb00 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:198
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 f6 d0 27 f6 48 89 df e8 7e 20 28 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 05 2e 17 f6 65 8b 05 4e 57 a6 08 85 c0 74 16 5b
RSP: 0018:ffffc9000500fb10 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff88823fff8740 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffffffff8e1a8186 RDI: ffffffff8c402680
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000140001
R13: 00000000000a8d20 R14: ffffffff81e6a290 R15: 0000000000000005
 mark_free_pages kernel/power/snapshot.c:1252 [inline]
 count_data_pages+0x7d/0xf0 kernel/power/snapshot.c:1417
 hibernate_preallocate_memory+0x104/0x507 kernel/power/snapshot.c:1859
 hibernation_snapshot+0x1e6/0x9c0 kernel/power/hibernate.c:430
 hibernate.cold+0x17c/0x6a2 kernel/power/hibernate.c:811
 state_store+0x1ff/0x240 kernel/power/main.c:821
 kobj_attr_store+0x58/0x80 lib/kobject.c:840
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa6b59e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa6c4cf028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faa6b825fa0 RCX: 00007faa6b59e019
RDX: 0000000000000005 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007faa6b63500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faa6b826038 R14: 00007faa6b825fa0 R15: 00007ffe29482fa8
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 f6 d0 27 f6       	call   0xf627d109
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 7e 20 28 f6       	call   0xf6282099
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 23                	jne    0x46
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 37                	jne    0x61
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 05 2e 17 f6       	call   0xf6172e39
  34:	65 8b 05 4e 57 a6 08 	mov    %gs:0x8a6574e(%rip),%eax        # 0x8a65789
  3b:	85 c0                	test   %eax,%eax
  3d:	74 16                	je     0x55
  3f:	5b                   	pop    %rbx


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
