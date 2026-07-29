Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FD2E6116
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296201; cv=none; b=kr9/Q0sA3/qCFMRsFB4O8Q8w6lXf2Sf4dqFqt34ODlxj8wf3eiFYkXWRpjBZdspsylkmTcqV+w3VgTdPza/697ieWeH5md5oaDIUKVnr9RhMngFoK8QMr57uGj9+n76NMN67MPcPbOF0vhKMjciG5pwVt457SeOCfiglBTWsACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296201; c=relaxed/simple;
	bh=YCE9uOU4OrvFd2DKmVaTJGBlmH6Wlb5KZdSUax6l9bE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Erbp1DTkKEfAW3tEGjgNIJ9JPy8SPI1FWwSvTiyzSojX34/IeDYVglPDmWx74tioWnm3jmeFIeesdVgWypDtmt3bgXoJdi8iz16YPqviyRPZuNTCo2R5mvn7Anxsh1bh6pSorY1f9tUxBZWQA9Nv3VuFkH7oegdUKa3htPgeOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a45b3f0bdfso524019b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 20:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296198; x=1785900998;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0v5mRGbS2rTiMEzXjZ+tJA0JsHiN1tvBaFh4oEVAsI=;
        b=hr5b4NKghOTV6bqUT4Im4zSEcuWa1xribw+uJpZmfROcqUTlSKeCudRXpyVkb/ZY9W
         G07VPTlU45s/mNjD33LaUR7vAa+UAPM8q+OE6rE/ewfRZJqNwyUarMu+Hqiyd2g+9GaK
         rKrMiKO8dER6pA8AnfaEWBpd8/feGiK58kJd9CddGpPH3BqjRmSJnZ45twzhbAU431ei
         eZPFaSZg6HVnLBs6gCWy8OdKQ92X/Qt69+240lX2UcID+sUFnaskxTy0DgNDQ7faInd2
         OxWTky8DfxfJQRStZZz2Wwz0cRjaaWPnv/6+wHTrtf8+6llsevQAJTltU6ahQN2r7Qjj
         qKQw==
X-Forwarded-Encrypted: i=1; AHgh+RpbFCCCvzxwdWhddvzPkg4Mq6C4pUuAD/0APLGT4AE+1/xWFj9f4cIpiZhMWcl7ni13sTK3C7seBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtDDrzPctsPVjIOxi+3pkxMOvvr4ASkilgxOe0zSCwWktWCff
	l7Qf1Be8Z5o+fRtTyTw8wVcjYCZhRyVGokOkvKnKr1q6AQxntFtiFpglrxf0uc7aRcCSJvB09g0
	RYT1VN0BVQhfTGpTV+JrdvXsbNVpmltDHv4QxYjgdtKi4Pq2J9LSzZtgYTeU=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3010:b0:4a4:c09:6a4 with SMTP id
 5614622812f47-4ad5b992f68mr2747511b6e.10.1785296198301; Tue, 28 Jul 2026
 20:36:38 -0700 (PDT)
Date: Tue, 28 Jul 2026 20:36:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a697546.6bd615f2.c0aa.0009.GAE@google.com>
Subject: [syzbot] [pm?] possible deadlock in device_link_add
From: syzbot <syzbot+a335e4c21d52fb8d9e95@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48a5a7ab8d6a Merge tag 'v7.2-rc4-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101332ea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=a335e4c21d52fb8d9e95
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-48a5a7ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ed725bee82f/vmlinux-48a5a7ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/110c09c210d5/bzImage-48a5a7ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a335e4c21d52fb8d9e95@syzkaller.appspotmail.com

i2c i2c-0: new_device: Instantiated device rt1719 at 0x49
wusb3801 0-004a: supply vbus not found, using dummy regulator
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.6.979/9504 is trying to acquire lock:
ffffffff8edba220 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8edba220 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4565 [inline]
ffffffff8edba220 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4925 [inline]
ffffffff8edba220 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x63/0x6c0 mm/slub.c:5511

but task is already holding lock:
ffffffff8fc0bc60 (dpm_list_mtx){+.+.}-{4:4}, at: device_link_add+0x2e5/0x19e0 drivers/base/core.c:828

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (dpm_list_mtx){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       device_pm_add+0x87/0x370 drivers/base/power/main.c:153
       device_add+0xa1b/0x1970 drivers/base/core.c:3720
       device_create_groups_vargs+0x1f8/0x270 drivers/base/core.c:4454
       device_create+0xed/0x130 drivers/base/core.c:4493
       msr_device_create+0x31/0x70 arch/x86/kernel/msr.c:251
       cpuhp_invoke_callback+0x3b4/0x9a0 kernel/cpu.c:194
       cpuhp_thread_fun+0x3e9/0x7c0 kernel/cpu.c:1109
       smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #7 (cpuhp_state-up){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       cpuhp_lock_acquire kernel/cpu.c:103 [inline]
       cpuhp_thread_fun+0x146/0x7c0 kernel/cpu.c:1086
       smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (cpu_hotplug_lock){++++}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x170 kernel/cpu.c:490
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       nbd_reconnect_socket drivers/block/nbd.c:1379 [inline]
       nbd_genl_reconfigure+0xd82/0x1a00 drivers/block/nbd.c:2468
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
       __sys_sendmsg+0x160/0x210 net/socket.c:2770
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x135/0x380 block/blk-mq.c:2531
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x135/0x380 block/blk-mq.c:2531
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (set->srcu){.+.+}-{0:0}:
       lock_sync kernel/locking/lockdep.c:5916 [inline]
       lock_sync+0x9d/0x110 kernel/locking/lockdep.c:5904
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xa2/0x300 kernel/rcu/srcutree.c:1481
       blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
       blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
       elevator_switch+0x17b/0x7e0 block/elevator.c:576
       elevator_change+0x352/0x530 block/elevator.c:681
       elevator_set_default+0x29e/0x360 block/elevator.c:754
       blk_register_queue+0x48e/0x630 block/blk-sysfs.c:992
       __add_disk+0x73f/0xe40 block/genhd.c:524
       add_disk_fwnode+0x118/0x480 block/genhd.c:593
       add_disk include/linux/blkdev.h:800 [inline]
       nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:2021
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2729
       do_one_initcall+0x11d/0x700 init/main.c:1347
       do_initcall_level init/main.c:1409 [inline]
       do_initcalls init/main.c:1425 [inline]
       do_basic_setup init/main.c:1445 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
       kernel_init+0x1f/0x1e0 init/main.c:1548
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       elevator_change+0x1bc/0x530 block/elevator.c:679
       elevator_set_none+0x92/0xf0 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5101 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5146 [inline]
       blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5211
       nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1526
       nbd_genl_connect+0xff2/0x1a40 drivers/block/nbd.c:2276
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
       __sys_sendmsg+0x160/0x210 net/socket.c:2770
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       blk_alloc_queue+0x610/0x790 block/blk-core.c:504
       blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4420
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4467
       nbd_dev_add+0x492/0xb10 drivers/block/nbd.c:1991
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2729
       do_one_initcall+0x11d/0x700 init/main.c:1347
       do_initcall_level init/main.c:1409 [inline]
       do_initcalls init/main.c:1425 [inline]
       do_basic_setup init/main.c:1445 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
       kernel_init+0x1f/0x1e0 init/main.c:1548
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4329 [inline]
       fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4343
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4565 [inline]
       slab_alloc_node mm/slub.c:4925 [inline]
       __kmalloc_cache_noprof+0x63/0x6c0 mm/slub.c:5511
       _kmalloc_noprof include/linux/slab.h:969 [inline]
       _kzalloc_noprof include/linux/slab.h:1290 [inline]
       device_link_add+0x45d/0x19e0 drivers/base/core.c:920
       _regulator_get_common+0x594/0x9a0 drivers/regulator/core.c:2526
       _regulator_get drivers/regulator/core.c:2545 [inline]
       _regulator_get+0x58/0x70 drivers/regulator/core.c:2534
       _devm_regulator_get+0x55/0xd0 drivers/regulator/devres.c:31
       wusb3801_probe+0x151/0x8e0 drivers/usb/typec/wusb3801.c:342
       i2c_device_probe+0x658/0xd10 drivers/i2c/i2c-core-base.c:592
       call_driver_probe drivers/base/dd.c:628 [inline]
       really_probe+0x241/0xa60 drivers/base/dd.c:706
       __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
       driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
       __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
       bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
       __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
       device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
       bus_probe_device+0x64/0x160 drivers/base/bus.c:620
       device_add+0x121d/0x1970 drivers/base/core.c:3772
       i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
       new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
       dev_attr_store+0x58/0x80 drivers/base/core.c:2505
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpuhp_state-up --> dpm_list_mtx

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(dpm_list_mtx);
                               lock(cpuhp_state-up);
                               lock(dpm_list_mtx);
  lock(fs_reclaim);

 *** DEADLOCK ***

7 locks held by syz.6.979/9504:
 #0: ffff88802cc54b70 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff88802667a450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff8880370f8080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff88802e23db48 (kn->active#72){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff88802e23db48 (kn->active#72){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #4: ffff8880371f7148 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #4: ffff8880371f7148 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #5: ffffffff8fbf4080 (device_links_lock){+.+.}-{4:4}, at: device_links_write_lock drivers/base/core.c:316 [inline]
 #5: ffffffff8fbf4080 (device_links_lock){+.+.}-{4:4}, at: device_link_add+0x2e0/0x19e0 drivers/base/core.c:827
 #6: ffffffff8fc0bc60 (dpm_list_mtx){+.+.}-{4:4}, at: device_link_add+0x2e5/0x19e0 drivers/base/core.c:828

stack backtrace:
CPU: 1 UID: 0 PID: 9504 Comm: syz.6.979 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4329 [inline]
 fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4343
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4565 [inline]
 slab_alloc_node mm/slub.c:4925 [inline]
 __kmalloc_cache_noprof+0x63/0x6c0 mm/slub.c:5511
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 device_link_add+0x45d/0x19e0 drivers/base/core.c:920
 _regulator_get_common+0x594/0x9a0 drivers/regulator/core.c:2526
 _regulator_get drivers/regulator/core.c:2545 [inline]
 _regulator_get+0x58/0x70 drivers/regulator/core.c:2534
 _devm_regulator_get+0x55/0xd0 drivers/regulator/devres.c:31
 wusb3801_probe+0x151/0x8e0 drivers/usb/typec/wusb3801.c:342
 i2c_device_probe+0x658/0xd10 drivers/i2c/i2c-core-base.c:592
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17c619de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f17c70ca028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f17c6425fa0 RCX: 00007f17c619de99
RDX: 000000000000000e RSI: 0000200000000400 RDI: 0000000000000004
RBP: 00007f17c6233eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f17c6426038 R14: 00007f17c6425fa0 R15: 00007ffc87927898
 </TASK>
i2c i2c-0: new_device: Instantiated device wusb3801 at 0x4a


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
