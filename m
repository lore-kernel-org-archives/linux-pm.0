Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC141A791
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160471; cv=none; b=RjRfF4TVz78Q9CWxaNVZWwkWiJVO7393xs/hv7WLuvVgohSbD4/5GXABou4QaPBtpWqhggxBLb+H3ujyCwAf1MAdvaqb9+dZJQJvkX75vgcD7zzS8c3zbCQFlitWv/FLofmcVWMvwDVYfE7N53AFYO7Mr9GxO93XGi1gOYp5QV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160471; c=relaxed/simple;
	bh=Ammk2rqj3PoYcxhsCNXkVWqIhOs4SLsr/Q33U/MhMpA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=flfAIlEB0AdtwEeOLjbT+eicfhZvUli8RA4KnoQy9xiVAmshbodxYdsLk/etsNdEYTD4jFL8rBXVWcK/YioY9utEKI2DeadSZJt/K4p67BhKvv8wevM3vwSvu7bo2fvYFPtSswwJisXRx1Y0wQcJVMNkCwxNCZUs7s/S14vuk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-455ad408573so1934722fac.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 06:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160467; x=1785765267;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnzEC0VoFdLfs8njaors4vEeH2LH6UQZpM6UIN3guNY=;
        b=pRJWEB7hSuoBA7qKSElq4YGQ04BGBd3WJ9kXE4oN9Ciokn0xkpvZRZD+lEfqFeelH4
         7tCozSgtiJ9jGFViKrHDa05YqsyFMSJpQbjd9BUozCvCzQc8/4EiCnNxMs8S1s87D41t
         fz+j+DOxM9jQoI03laTeEg4BVnCoOvHvkRPtOBtqAd3td8cVL/84MhF5rBFxoesvj9mg
         I/4via+wkhOOWLEm3gcGSzX72Ahy8vWIleAAigIuoO0Gmj3/L9SdwOMS2X3GGZcJbu2a
         Nw5FLjAuVmEMtyI5guKbts0dGllukfuaq0zNBm/95aoERDwX7RQAD6VZQMv3FOVXtNNJ
         7+3A==
X-Forwarded-Encrypted: i=1; AHgh+RqfJJTh73saw0ZogLzU2+Df2phRvwmTFbvcteD9jB6pb4pDFZjMcvloQZcX1OinJ4Y+2+FmQ78aUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytPrZP/X6qE9/A9OFFiEWAFouKRxUlmNLdS8GoIj//Y0Y9Nr0t
	oi4TkRaIj9jGfMRW/1BS2nN/QPhVOx5hGil+hZZKEQme8icS4t9TeuPcH3t3a2zadCMP85ndZlC
	9tlJ2mwTZT3O8B9sV3BjvRPxoo+lJeCpa2x1+vN6X7P0NWFsjM7bVRyWdfes=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:220a:b0:49b:c387:36c5 with SMTP id
 5614622812f47-4ab6a10d714mr9408653b6e.17.1785160467201; Mon, 27 Jul 2026
 06:54:27 -0700 (PDT)
Date: Mon, 27 Jul 2026 06:54:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a676313.073198cf.94f0f.0033.GAE@google.com>
Subject: [syzbot] [pm?] possible deadlock in thermal_zone_device_set_mode
From: syzbot <syzbot+b3969bd2017944d13bae@syzkaller.appspotmail.com>
To: daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4539944e5151 Merge tag 'liveupdate-fixes-2026-07-22' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16acc232580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=b3969bd2017944d13bae
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4539944e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3de652e41d56/vmlinux-4539944e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/490f5e3de405/bzImage-4539944e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3969bd2017944d13bae@syzkaller.appspotmail.com

shield 0003:0955:7214.0038: unknown main item tag 0x0
input: HID 0955:7214 Haptics as /devices/virtual/input/input136
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
kworker/0:5/5892 is trying to acquire lock:
ffffffff8edb8220 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8edb8220 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4565 [inline]
ffffffff8edb8220 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4925 [inline]
ffffffff8edb8220 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x66/0x6b0 mm/slub.c:5017

but task is already holding lock:
ffff888035544750 (&tz->lock){+.+.}-{4:4}, at: class_thermal_zone_constructor drivers/thermal/thermal_core.h:158 [inline]
ffff888035544750 (&tz->lock){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x21/0x130 drivers/thermal/thermal_core.c:606

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (&tz->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       class_thermal_zone_constructor drivers/thermal/thermal_core.h:158 [inline]
       thermal_zone_init_complete drivers/thermal/thermal_core.c:1351 [inline]
       thermal_zone_device_register_with_trips+0xe28/0x13d0 drivers/thermal/thermal_core.c:1540
       thermal_tripless_zone_device_register+0x34/0x50 drivers/thermal/thermal_core.c:1571
       psy_register_thermal drivers/power/supply/power_supply_core.c:1529 [inline]
       __power_supply_register.part.0+0xb85/0x1300 drivers/power/supply/power_supply_core.c:1635
       __power_supply_register drivers/power/supply/power_supply_core.c:1572 [inline]
       power_supply_register+0xce/0x110 drivers/power/supply/power_supply_core.c:1699
       thunderstrike_psy_create drivers/hid/hid-nvidia-shield.c:841 [inline]
       thunderstrike_create drivers/hid/hid-nvidia-shield.c:897 [inline]
       shield_probe+0x9b4/0xf40 drivers/hid/hid-nvidia-shield.c:1058
       __hid_device_probe drivers/hid/hid-core.c:2829 [inline]
       hid_device_probe+0x50e/0x800 drivers/hid/hid-core.c:2866
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
       hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:3010
       usbhid_probe+0xa64/0x10b0 drivers/hid/usbhid/hid-core.c:1452
       usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
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
       usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
       usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
       usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
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
       usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
       hub_port_connect drivers/usb/core/hub.c:5567 [inline]
       hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
       port_event drivers/usb/core/hub.c:5871 [inline]
       hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #8 (thermal_list_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       class_mutex_constructor include/linux/mutex.h:253 [inline]
       thermal_cooling_device_init_complete drivers/thermal/thermal_core.c:948 [inline]
       thermal_cooling_device_add+0x2fa/0x560 drivers/thermal/thermal_core.c:1047
       thermal_cooling_device_register+0x4c/0x80 drivers/thermal/thermal_core.c:1085
       acpi_processor_thermal_init+0x33/0x1f0 drivers/acpi/processor_thermal.c:316
       __acpi_processor_start drivers/acpi/processor_driver.c:167 [inline]
       acpi_soft_cpu_online+0x1ce/0x3a0 drivers/acpi/processor_driver.c:113
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
       kmem_cache_alloc_node_noprof+0x66/0x6b0 mm/slub.c:5017
       __alloc_skb+0x140/0x710 net/core/skbuff.c:704
       alloc_skb include/linux/skbuff.h:1384 [inline]
       nlmsg_new include/net/netlink.h:1055 [inline]
       genlmsg_new include/net/genetlink.h:613 [inline]
       thermal_genl_send_event+0xb5/0x3d0 drivers/thermal/thermal_netlink.c:324
       thermal_notify_tz_enable+0xa7/0x100 drivers/thermal/thermal_netlink.c:369
       thermal_zone_device_set_mode+0x115/0x130 drivers/thermal/thermal_core.c:619
       psy_register_thermal drivers/power/supply/power_supply_core.c:1533 [inline]
       __power_supply_register.part.0+0xbd3/0x1300 drivers/power/supply/power_supply_core.c:1635
       __power_supply_register drivers/power/supply/power_supply_core.c:1572 [inline]
       power_supply_register+0xce/0x110 drivers/power/supply/power_supply_core.c:1699
       thunderstrike_psy_create drivers/hid/hid-nvidia-shield.c:841 [inline]
       thunderstrike_create drivers/hid/hid-nvidia-shield.c:897 [inline]
       shield_probe+0x9b4/0xf40 drivers/hid/hid-nvidia-shield.c:1058
       __hid_device_probe drivers/hid/hid-core.c:2829 [inline]
       hid_device_probe+0x50e/0x800 drivers/hid/hid-core.c:2866
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
       hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:3010
       usbhid_probe+0xa64/0x10b0 drivers/hid/usbhid/hid-core.c:1452
       usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
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
       usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
       usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
       usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
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
       usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
       hub_port_connect drivers/usb/core/hub.c:5567 [inline]
       hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
       port_event drivers/usb/core/hub.c:5871 [inline]
       hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> thermal_list_lock --> &tz->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tz->lock);
                               lock(thermal_list_lock);
                               lock(&tz->lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

7 locks held by kworker/0:5/5892:
 #0: ffff888022ae1d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12b1/0x1940 kernel/workqueue.c:3297
 #1: ffffc90003e07d08 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x988/0x1940 kernel/workqueue.c:3298
 #2: ffff88802ce261d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #2: ffff88802ce261d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1c0/0x4a60 drivers/usb/core/hub.c:5899
 #3: ffff88804252b1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #3: ffff88804252b1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #4: ffff88803d7eb1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #4: ffff88803d7eb1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #5: ffff888066189a58 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #5: ffff888066189a58 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #6: ffff888035544750 (&tz->lock){+.+.}-{4:4}, at: class_thermal_zone_constructor drivers/thermal/thermal_core.h:158 [inline]
 #6: ffff888035544750 (&tz->lock){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x21/0x130 drivers/thermal/thermal_core.c:606

stack backtrace:
CPU: 0 UID: 0 PID: 5892 Comm: kworker/0:5 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
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
 kmem_cache_alloc_node_noprof+0x66/0x6b0 mm/slub.c:5017
 __alloc_skb+0x140/0x710 net/core/skbuff.c:704
 alloc_skb include/linux/skbuff.h:1384 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 genlmsg_new include/net/genetlink.h:613 [inline]
 thermal_genl_send_event+0xb5/0x3d0 drivers/thermal/thermal_netlink.c:324
 thermal_notify_tz_enable+0xa7/0x100 drivers/thermal/thermal_netlink.c:369
 thermal_zone_device_set_mode+0x115/0x130 drivers/thermal/thermal_core.c:619
 psy_register_thermal drivers/power/supply/power_supply_core.c:1533 [inline]
 __power_supply_register.part.0+0xbd3/0x1300 drivers/power/supply/power_supply_core.c:1635
 __power_supply_register drivers/power/supply/power_supply_core.c:1572 [inline]
 power_supply_register+0xce/0x110 drivers/power/supply/power_supply_core.c:1699
 thunderstrike_psy_create drivers/hid/hid-nvidia-shield.c:841 [inline]
 thunderstrike_create drivers/hid/hid-nvidia-shield.c:897 [inline]
 shield_probe+0x9b4/0xf40 drivers/hid/hid-nvidia-shield.c:1058
 __hid_device_probe drivers/hid/hid-core.c:2829 [inline]
 hid_device_probe+0x50e/0x800 drivers/hid/hid-core.c:2866
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
 hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:3010
 usbhid_probe+0xa64/0x10b0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
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
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
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
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
shield 0003:0955:7214.0038: Registered Thunderstrike controller
shield 0003:0955:7214.0038: : USB HID v0.00 Device [HID 0955:7214] on usb-dummy_hcd.9-1/input0


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
