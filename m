Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BC302753
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255386; cv=none; b=qWAI6YLMPG+7GVgOworI7nDiU5VDz4iZL433LjdB7JXORXxjG+ichtbfL+kyEpRINPd3UyUY3a6I1QwelZUVssMSYANxaxb46jT4kVTP89xe+SBbBJNJNp8HW164m2IHrJeIPSAXWfR+z4qDfGnYlqtwbzva7SEHkM8wsQ6i61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255386; c=relaxed/simple;
	bh=gaRoBgwDc/kkTrxL4nw0uRSO/KlEff7Dffn6SUs3lns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PUDumbxOm+xIpPVEH6+AbcVHrdwHdatlh4eH7fA5/DJiy9o1epbzGIgAoUKH58xuH+4pxnsnbq2Tg8YE3TZgYqIdGMc8M7wnM3XE6XA1gitmEjtKCiNqmAVOsbFo0SoCxziaYMQIe0w6BLvKYwExeZCtUK7yd0tVxBgGDQScHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-455e3cdda0dso3668648fac.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 09:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255383; x=1785860183;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+UhyG89aGvSsBpGu5Z8//1dPaBhmB5er2b4nPXWQ/g=;
        b=hjdTK13/wIU5EE2objuq2D5sN6mLZS9LS0rzsYp7cv027Tq6TpP3A5wqZRlNiCjUAP
         MKFMhXplprjs4aKMZrZgyxssIZpYMcgs3sPfI+FrflK7IyjyX92PTJ9uQTC62Sr8J3bS
         njNZn4j3CrEk2EFHqIlQ6QqxETptb1nz02h3EGYduSO/sWTyYGUL5PGyM+zykx4EFoxE
         vMt0jA7R5C32CEo93ZxG3qhcrCsmNI7ChnbY/WaKQkOdXyGp7uaJai8VRrkPAPDvHLw4
         lyIoFeFkZ6WL28qwbr8iv1zVgVpNO0YcWrX+GXupNYAnwHEaRPedBrKPVULhguf8Y4DC
         dpCA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0a0MjgUKTae9/XDQSjx0qQiDzOdgcX0fNJ9C+/I3vxGDsPrvLuecyH5oMLtmzvWfmi+veIr0WOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEiubaTouQ0h1DV+EA2dP2Tr22f6Lg+TPGLKpxITPTbwnqPTe
	GImGRSRnfW68JwLGaFK/nDKi5c//h+VOnKb3o24/7o6JQ+YctR5YbHI4FNjtu6xL2S7pzSTkjpI
	lP9hHZhniS0qWvpaDDGQ6BtoLBHQDQH4BHY32HaBFn/tqP30b4u/f7Ks+pB0=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1905:b0:495:fecb:bf9c with SMTP id
 5614622812f47-4ad5b965d74mr1857004b6e.6.1785255383287; Tue, 28 Jul 2026
 09:16:23 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:16:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a68d5d7.e3659fcc.2a40b8.0016.GAE@google.com>
Subject: [syzbot] [pm?] WARNING in ct_kernel_exit
From: syzbot <syzbot+79883955da3a62652a80@syzkaller.appspotmail.com>
To: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    365f9c7a6b81 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=127b16b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72c97575381cec47
dashboard link: https://syzkaller.appspot.com/bug?extid=79883955da3a62652a80
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124451b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122f9632580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eafe0adb7386/disk-365f9c7a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29422d607579/vmlinux-365f9c7a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98ca955a8b54/Image-365f9c7a.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79883955da3a62652a80@syzkaller.appspotmail.com

vhci_hcd vhci_hcd.1: suspend vhci_hcd
vhci_hcd vhci_hcd.0: suspend vhci_hcd
Disabling non-boot CPUs ...
psci: CPU1 killed (polled 0 ms)
------------[ cut here ]------------
WARNING: kernel/context_tracking.c:120 at ct_kernel_exit+0x1b4/0x1f4 kernel/context_tracking.c:118, CPU#0: syz.1.501/5462
Modules linked in:
CPU: 0 UID: 0 PID: 5462 Comm: syz.1.501 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 634003c5 (nZCv DAIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ct_kernel_exit+0x1b4/0x1f4 kernel/context_tracking.c:118
lr : instrument_atomic_read include/linux/instrumented.h:82 [inline]
lr : atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
lr : ct_rcu_watching include/linux/context_tracking_state.h:91 [inline]
lr : ct_kernel_exit+0x13c/0x1f4 kernel/context_tracking.c:119
sp : ffff800095f775f0
x29: ffff800095f775f0 x28: dfff800000000000 x27: ffff800095f77660
x26: 00000000000000c0 x25: ffff700012beeecc x24: ffff800088abf998
x23: ffff800088b0b6a0 x22: ffff0001ade38998 x21: ffff0001ade38998
x20: 0000000000000000 x19: 0000000000000005 x18: 00000000ffffffff
x17: ffff80008a791000 x16: 0000000000000005 x15: ffff80008a31ada0
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff600035bc7135 x9 : dfff800000000000
x8 : 0000000000000040 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000008 x3 : ffff8000868e6858
x2 : 0000000000000000 x1 : 0000000000000004 x0 : 0000000000000001
Call trace:
 ct_kernel_exit+0x1b4/0x1f4 kernel/context_tracking.c:118 (P)
 ct_idle_enter+0x24/0x38 kernel/context_tracking.c:299
 ct_cpuidle_enter include/linux/cpuidle.h:134 [inline]
 cpu_suspend+0x264/0x474 arch/arm64/kernel/suspend.c:140
 psci_system_suspend_enter+0x4c/0x80 drivers/firmware/psci/psci.c:544
 suspend_enter kernel/power/suspend.c:468 [inline]
 suspend_devices_and_enter+0x88c/0xd0c kernel/power/suspend.c:533
 enter_state kernel/power/suspend.c:618 [inline]
 pm_suspend+0x498/0x698 kernel/power/suspend.c:644
 state_store+0x14c/0x1fc kernel/power/main.c:819
 kobj_attr_store+0x6c/0x90 lib/kobject.c:840
 sysfs_kf_write+0xe0/0x108 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
irq event stamp: 69726
hardirqs last  enabled at (69725): [<ffff80008690522c>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:187 [inline]
hardirqs last  enabled at (69725): [<ffff80008690522c>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:206
hardirqs last disabled at (69726): [<ffff800080473cc0>] arch_suspend_disable_irqs+0x34/0x4c kernel/power/suspend.c:403
softirqs last  enabled at (68262): [<ffff80008030ff18>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (68262): [<ffff80008030ff18>] handle_softirqs+0xc28/0xd98 kernel/softirq.c:650
softirqs last disabled at (68257): [<ffff8000800204c0>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: kernel/context_tracking.c:165 at ct_kernel_enter+0x138/0x170 kernel/context_tracking.c:150, CPU#0: syz.1.501/5462
Modules linked in:
CPU: 0 UID: 0 PID: 5462 Comm: syz.1.501 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ct_kernel_enter+0x138/0x170 kernel/context_tracking.c:150
lr : instrument_atomic_read include/linux/instrumented.h:82 [inline]
lr : atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
lr : ct_rcu_watching include/linux/context_tracking_state.h:91 [inline]
lr : ct_kernel_enter+0xc8/0x170 kernel/context_tracking.c:164
sp : ffff800095f775e0
x29: ffff800095f775e0 x28: dfff800000000000 x27: ffff800095f77660
x26: 00000000000000c0 x25: ffff700012beeecc x24: 0000000100000000
x23: ffff800088b0b6a0 x22: ffff800088abf998 x21: ffff0001ade38998
x20: ffff0001ade38998 x19: 0000000000000000 x18: 00000000ffffffff
x17: 000000040044ffff x16: 041000f5b5503510 x15: 0000000000000000
x14: ffff0000db381d40 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff600035bc7135 x9 : dfff800000000000
x8 : 0000000000000040 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff8000868e6a20
x2 : 0000000000000000 x1 : 0000000000000004 x0 : 0000000000000001
Call trace:
 ct_kernel_enter+0x138/0x170 kernel/context_tracking.c:150 (P)
 ct_idle_exit+0x24/0x48 kernel/context_tracking.c:317
 ct_cpuidle_exit include/linux/cpuidle.h:144 [inline]
 cpu_suspend+0x2dc/0x474 arch/arm64/kernel/suspend.c:158
 psci_system_suspend_enter+0x4c/0x80 drivers/firmware/psci/psci.c:544
 suspend_enter kernel/power/suspend.c:468 [inline]
 suspend_devices_and_enter+0x88c/0xd0c kernel/power/suspend.c:533
 enter_state kernel/power/suspend.c:618 [inline]
 pm_suspend+0x498/0x698 kernel/power/suspend.c:644
 state_store+0x14c/0x1fc kernel/power/main.c:819
 kobj_attr_store+0x6c/0x90 lib/kobject.c:840
 sysfs_kf_write+0xe0/0x108 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
irq event stamp: 69728
hardirqs last  enabled at (69727): [<ffff800084649440>] psci_system_suspend_enter+0x4c/0x80 drivers/firmware/psci/psci.c:544
hardirqs last disabled at (69728): [<ffff800084649440>] psci_system_suspend_enter+0x4c/0x80 drivers/firmware/psci/psci.c:544
softirqs last  enabled at (68262): [<ffff80008030ff18>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (68262): [<ffff80008030ff18>] handle_softirqs+0xc28/0xd98 kernel/softirq.c:650
softirqs last disabled at (68257): [<ffff8000800204c0>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
Enabling non-boot CPUs ...
CPU1 is up
OOM killer enabled.
Restarting tasks: Starting
Restarting tasks: Done
random: crng reseeded on system resumption
PM: suspend exit


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
