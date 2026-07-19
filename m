Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5A16A956
	for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784492310; cv=none; b=QZjt33FqhjXoU4Fy4BL0TmkzDrHV3+y4krEV+6XWFft2PXSKPSPFkmiQvjWwowPfI7tXiIXWW1JNCYnATjZEanTnloGVCdDL1vmJmGpQdf1WZw00BosKjcxiC+pc9W1CuLqcS6krLYErdwa6x4bxFAWDDoyzcCkSD6VJ23L/kJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784492310; c=relaxed/simple;
	bh=6t7vWTVRCqJZgpzyZLm0OZQ+0CsBlfh9aDGfDxDNAF0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tQODZa4Rd1X5x8JlezldcfzJVa5NuVTxPGF0hOz4n6QusHTwLHcX2h3bg6k4eZ9WhdKgYwAuJ7nP3OtDC6oHxq7GH2J0dk+ZMVdf5OWM8PcJuSdBclAdZrDoaT0xl++GFrVPdXBkaIl3mJONev3R0f/DPjtFI496wkB4wzdq094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49f3a97f1caso9321243b6e.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2026 13:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784492308; x=1785097108;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7T1XGPTxjyOXm2x1yxEIZsJaIZKP9ZUCrWvngzfM/mo=;
        b=V5y9jhn6YjPYRWvboeJ+RQCwbSzzO6mfG1C/Srchrki62VoUNnEfQPvhn5Zn4RsIMN
         f96rptpm4twk4y2fDIFbBgtMOEPHbwLF57Sj24StKMcgoAD9sVgXQP9TjiCUZ/qXVtkS
         xvojDI6X2qQNWK3E872k9jO3IWFKZu69AcnUpjTVCq7Qh4k0lw3bswZmfyaaD2WrnSle
         fx1Qwacl8m86+rl0sAimzgAGjpq53KiNT0oPDCnuGUvPKUF158fSkYBbMAAAEKkRvMBa
         qSUtlorg5K1QMy/ZllaltdO2zFurNGj5nOr2Adcuggc7uoMlKT9tMHDB0891g+86ZEs+
         cfaQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+V4sCNYnW4FbJQl7+yNPeVoyscWJgq93kuIalqef0PLNYwXmZHis3OLGZ4aCwRaNU8S/W80OPvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRn+1SyE+fVkWZkqzzdjEzHEiljrVVuNuQEg+NNYPAnaEMsOo
	bnsl/yIM2XzjrzWnf4r9abXuwL+Gif4KckOMe/A8jeViKJXneEMXxW/pxeHnGvbyiRN1WxJK/ro
	NBH2bhu1hVoaHkaZvUFs+dNm3jzP/h6S8DEDzYoQBX4p8lXuc/Yzv61Ap8hU=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1910:b0:479:f7e7:4a81 with SMTP id
 5614622812f47-4a4d00499edmr7991367b6e.0.1784492308033; Sun, 19 Jul 2026
 13:18:28 -0700 (PDT)
Date: Sun, 19 Jul 2026 13:18:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5d3114.42649fcc.6186.007b.GAE@google.com>
Subject: [syzbot] [pm?] possible deadlock in device_move (2)
From: syzbot <syzbot+fe46941938f79773c2f2@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, pavel@kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f1f75536668 net: openvswitch: reject oversized nested act..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11f98789580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=fe46941938f79773c2f2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38c0534858bd/disk-3f1f7553.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3140a6e2252d/vmlinux-3f1f7553.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8a7156a6da0/bzImage-3f1f7553.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe46941938f79773c2f2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u9:1/4940 is trying to acquire lock:
ffffffff8ec848a0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8ec848a0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4565 [inline]
ffffffff8ec848a0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4925 [inline]
ffffffff8ec848a0 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:5361 [inline]
ffffffff8ec848a0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof+0xbc/0x720 mm/slub.c:5387

but task is already holding lock:
ffffffff8f5f5880 (dpm_list_mtx){+.+.}-{4:4}, at: device_move+0x3c/0x720 drivers/base/core.c:4678

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (dpm_list_mtx){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       device_pm_add+0x7d/0x350 drivers/base/power/main.c:153
       device_add+0x4eb/0xb80 drivers/base/core.c:3720
       device_create_groups_vargs drivers/base/core.c:4454 [inline]
       device_create+0x269/0x300 drivers/base/core.c:4493
       msr_device_create+0x33/0x50 arch/x86/kernel/msr.c:251
       cpuhp_invoke_callback+0x434/0x810 kernel/cpu.c:194
       cpuhp_thread_fun+0x362/0x780 kernel/cpu.c:1109
       smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #7 (cpuhp_state-up){+.+.}-{0:0}:
       cpuhp_lock_acquire kernel/cpu.c:103 [inline]
       cpuhp_thread_fun+0x127/0x780 kernel/cpu.c:1086
       smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       nbd_reconnect_socket drivers/block/nbd.c:1379 [inline]
       nbd_genl_reconfigure+0x1301/0x1e80 drivers/block/nbd.c:2468
       genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
       __sys_sendmsg net/socket.c:2770 [inline]
       __do_sys_sendmsg net/socket.c:2775 [inline]
       __se_sys_sendmsg net/socket.c:2773 [inline]
       __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x373/0x1150 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x16c/0x300 block/blk-mq.c:2532
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       nbd_queue_rq+0xc1/0x1150 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x16c/0x300 block/blk-mq.c:2532
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xc9/0x2f0 kernel/rcu/srcutree.c:1481
       elevator_switch+0x1e8/0x7b0 block/elevator.c:576
       elevator_change+0x2fa/0x480 block/elevator.c:681
       elevator_set_default+0x375/0x440 block/elevator.c:754
       blk_register_queue+0x3f3/0x4e0 block/blk-sysfs.c:992
       __add_disk+0x6cb/0xe30 block/genhd.c:528
       add_disk_fwnode+0xfb/0x4b0 block/genhd.c:597
       add_disk include/linux/blkdev.h:800 [inline]
       nbd_dev_add+0x733/0xb60 drivers/block/nbd.c:2021
       nbd_init+0x15f/0x1e0 drivers/block/nbd.c:2729
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x10a/0x1a0 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       elevator_change+0x1af/0x480 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5101 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5146 [inline]
       blk_mq_update_nr_hw_queues+0x5ef/0x19f0 block/blk-mq.c:5211
       nbd_start_device+0x189/0xb30 drivers/block/nbd.c:1526
       nbd_genl_connect+0x1597/0x1c10 drivers/block/nbd.c:2276
       genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
       __sys_sendmsg net/socket.c:2770 [inline]
       __do_sys_sendmsg net/socket.c:2775 [inline]
       __se_sys_sendmsg net/socket.c:2773 [inline]
       __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#50){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:504
       blk_mq_alloc_queue block/blk-mq.c:4420 [inline]
       __blk_mq_alloc_disk+0x194/0x390 block/blk-mq.c:4467
       nbd_dev_add+0x494/0xb60 drivers/block/nbd.c:1991
       nbd_init+0x15f/0x1e0 drivers/block/nbd.c:2729
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x10a/0x1a0 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4329 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4343
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4565 [inline]
       slab_alloc_node mm/slub.c:4925 [inline]
       __do_kmalloc_node mm/slub.c:5361 [inline]
       __kmalloc_noprof+0xbc/0x720 mm/slub.c:5387
       _kmalloc_noprof include/linux/slab.h:973 [inline]
       _kzalloc_noprof include/linux/slab.h:1290 [inline]
       kobject_get_path+0xc5/0x2f0 lib/kobject.c:161
       kobject_move+0x2fa/0x720 lib/kobject.c:556
       device_move+0xe0/0x720 drivers/base/core.c:4689
       hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
       hci_conn_cleanup net/bluetooth/hci_conn.c:170 [inline]
       hci_conn_del+0xc3d/0x1200 net/bluetooth/hci_conn.c:1306
       hci_abort_conn_sync+0xdd0/0x1190 net/bluetooth/hci_sync.c:5805
       hci_cmd_sync_work+0x20b/0x3f0 net/bluetooth/hci_sync.c:332
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

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

5 locks held by kworker/u9:1/4940:
 #0: ffff8880507ad140 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff8880507ad140 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000fe5fc40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000fe5fc40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffff888064c14ea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1cb/0x3f0 net/bluetooth/hci_sync.c:331
 #3: ffff888064c140b8 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0xa6f/0x1190 net/bluetooth/hci_sync.c:5786
 #4: ffffffff8f5f5880 (dpm_list_mtx){+.+.}-{4:4}, at: device_move+0x3c/0x720 drivers/base/core.c:4678

stack backtrace:
CPU: 0 UID: 0 PID: 4940 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/25/2026
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4329 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4343
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4565 [inline]
 slab_alloc_node mm/slub.c:4925 [inline]
 __do_kmalloc_node mm/slub.c:5361 [inline]
 __kmalloc_noprof+0xbc/0x720 mm/slub.c:5387
 _kmalloc_noprof include/linux/slab.h:973 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 kobject_get_path+0xc5/0x2f0 lib/kobject.c:161
 kobject_move+0x2fa/0x720 lib/kobject.c:556
 device_move+0xe0/0x720 drivers/base/core.c:4689
 hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:170 [inline]
 hci_conn_del+0xc3d/0x1200 net/bluetooth/hci_conn.c:1306
 hci_abort_conn_sync+0xdd0/0x1190 net/bluetooth/hci_sync.c:5805
 hci_cmd_sync_work+0x20b/0x3f0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Bluetooth: hci4: command 0x0405 tx timeout


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
