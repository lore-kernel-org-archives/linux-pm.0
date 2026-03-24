Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF443147;
	Tue, 24 Mar 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396262; cv=none; b=DgTBRqBcvZPXldlDy4F4NdLIPcv8QLvEqQHvicaUYl2cxwD9YTHQcHfbUTjU4cZxIaTOPJOWHDNX2YVd739stMtngKIbBV4qar3NvbYd2mCs1jt2dwEkFSVwTRIGDvPHFLrTsCtU+k0z60oFzUZM1XKiZQuhJgr7eF5RguJx8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396262; c=relaxed/simple;
	bh=lguQ6EdEv6rrxDiKOXAu5h9P71MXj8S7ivISXWRjKSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=njMNYsikEAa8Ldrwf2qjzXOkEeRhG9P6dfe1w4WxGN0L5Weh7Pc6YZ9GVX2xYcag9KJJ2Q0mU1P1HzJ+JhkXCqMjuGwGx1jK3Bm4OALL7LA+1SFEKvtjkttkmOjGwct0sHhfF3IuMhkh64hih7bFLA6/5PvaE65ewEiPIgyZ5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iaFOkBIP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iaFOkBIP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YHl8moKZWvgqJthfZ7oM1xKjJW4qahLmXGO7nzBssnU=; b=iaFOkBIP2bbaAokVeHEiWIG2Lt
	FZxEpLMgWSgxOGQYAxfFC3ZC+yRybwXx+2/uNOfCH9dfHdzq0SF0lfEKhJRtz5Nk/2ttl6LqfUPS2
	bKuMEQpVs24ZdhpZHKuj1usng+xp9OfqgJc29ECnYgQcvH1dvwDcCKRh6mqDzYewVUGYpyXQxF6aE
	s+2wVmxUy1xNqjUPbHQ6Rc+hpHoBGQrpaD6u0vJbLP2fOJQTlPj0cHtFRLSr9KU4pNZpYLeyyVpTl
	OFFoMJ7ovYr79p0+axvysBe+ZfT+3IJOEp1Qik/wxwOJj+9I62kLWhCInFZwNMCLuS+0VpiJ3GgF0
	gNfW8m0g==;
Received: from 186-249-144-69.shared.desktop.com.br ([186.249.144.69] helo=[192.168.1.66])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5BWJ-005ZeZ-Hq; Wed, 25 Mar 2026 00:50:48 +0100
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 24 Mar 2026 20:50:32 -0300
Subject: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
X-B4-Tracking: v=1; b=H4sIAEcjw2kC/x3NWwrCMBBG4a2UeXYgFyvqVqSU0Pyxg7WRSb1Ru
 neDj9/LOSsVqKDQuVlJ8ZIiea6wu4aGMcxXsMRqcsYdjHd7XkboPUw8ZAU/Q2KZZekjpvBF7N9
 Zb9zaU4tkvLf2SDX0UCT5/CeXbtt+kr1JE3QAAAA=
X-Change-ID: 20260324-thermal-core-uaf-init_delayed_work-5195ef033118
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2

If INIT_DELAYED_WORK() is called for a currently running work item,
cancel_delayed_work_sync() is unable to cancel/wait for it anymore,
as the work item's data bits required for that are cleared.

In the resume path, INIT_DELAYED_WORK() is called twice:
1) to replace the work function: thermal_zone_device_check/resume()
2) to restore it.

Both cases might race with the unregister path and bypass the call to
cancel_delayed_work_sync(), after which struct thermal_zone_device *tz
is freed, and the non-canceled/non-waited for work hits use-after-free.

Fix the first case with a dedicated work item for the resume function,
and the second case by initializing the work item(s) only during init.

Case 1 (reported by syzbot):

  Thread A:
    WORK: tz->poll_queue
      thermal_zone_device_check()
        ...

  Thread B:
    thermal_pm_notify() // syzbot reaches this with snapshot_release()
      thermal_pm_notify_complete()
        thermal_zone_pm_complete()
          INIT_DELAYED_WORK(&tz->poll_queue, ...)

  Thread C:
    thermal_zone_device_unregister()
      cancel_delayed_work_sync(&tz->poll_queue) // does not cancel/wait
      kfree(tz)

  Thread A:
        ...
        thermal_zone_device_update()
          guard(thermal_zone)(tz) // use-after-free!

Case 2:

  Thread A:
    WORK: tz_poll_queue
      thermal_zone_device_resume()
        thermal_zone_device_init()
          INIT_DELAYED_WORK(&tz->poll_queue, ...)
          ...

  Thread B:
    thermal_zone_device_unregister()
      cancel_delayed_work_sync(&tz->poll_queue) // does not cancel/wait
      kfree(tz)

  Thread A:
          ...
          tz->temperature = ... // use-after-free!

Note: in Case 1, thermal_zone_pm_complete() calls cancel_delayed_work()
before INIT_DELAYED_WORK(), but that does not wait for the work item to
finish (which could avoid the issue in that case), as it is not _sync().
Indeed, it should _not_ be _sync(), as it could block for a significant
time in __thermal_zone_device_update(); the reason of the Fixes: commit.

Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
Reported-by: syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=3b3852c6031d0f30dfaf
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
These are the KASAN reports observed with synthetic reproducers.
(If you're interested, I can send them as well.)

This patch has been tested on v7.0-rc5 with the synthethic reproducers
and with these steps:
- Set polling_delay to 1000 ms to periodically start tz->poll_queue;
- Access /dev/snapshot in loop to periodically start tz->resume_queue;
- Manually unload test_power.ko to unregister and free memory
  while both work items were periodically started.
- Each test ran for ~1 minute until unregistering. Repeated 3 times.

Case 1:

This matches the syzbot report, except for the driver (unrelated).
- use-after-free in thermal_zone_device_check() callee
- allocated by thermal_zone_device_register_with_trips()
- freed by thermal_zone_device_unregister()
- last potentially related work creation: thermal_pm_notify()
- driver:
  - original: hid-nvidia-shield.ko
  - reproducer: test_power.ko
  - common: power_supply_register()

[   30.611925] ==================================================================
[   30.616232] BUG: KASAN: slab-use-after-free in mutex_lock+0x76/0xe0
[   30.618698] Write of size 8 at addr ffff888006f8b460 by task kworker/0:1/11
[   30.622799]
[   30.624803] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.0.0-rc5+ #12 PREEMPT(lazy)
[   30.624835] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   30.624875] Workqueue: events_freezable_pwr_efficient thermal_zone_device_check
[   30.624914] Call Trace:
[   30.624929]  <TASK>
[   30.624941]  dump_stack_lvl+0x4d/0x70
[   30.624970]  print_report+0x170/0x4f3
[   30.625027]  kasan_report+0xda/0x110
[   30.625094]  kasan_check_range+0x125/0x200
[   30.625119]  mutex_lock+0x76/0xe0
[   30.625180]  thermal_zone_device_check+0x40/0xb0
[   30.625203]  process_one_work+0x617/0xf00
[   30.625251]  worker_thread+0x422/0xbb0
[   30.625345]  kthread+0x2cb/0x3a0
[   30.625405]  ret_from_fork+0x357/0x540
[   30.625485]  ret_from_fork_asm+0x1a/0x30
[   30.625516]  </TASK>
[   30.625525]
[   30.661253] Allocated by task 248:
[   30.661484]  kasan_save_stack+0x30/0x50
[   30.661770]  kasan_save_track+0x14/0x30
[   30.662260]  __kasan_kmalloc+0x7f/0x90
[   30.662716]  __kmalloc_noprof+0x180/0x4b0
[   30.663211]  thermal_zone_device_register_with_trips+0xf4/0x11d0
[   30.663674]  thermal_tripless_zone_device_register+0x1f/0x30
[   30.664238]  __power_supply_register.part.0+0x887/0xcf0
[   30.664618]  0xffffffffc040204f
[   30.664952]  do_one_initcall+0x9f/0x3b0
[   30.665253]  do_init_module+0x281/0x820
[   30.665509]  load_module+0x4a5c/0x6300
[   30.665975]  init_module_from_file+0x161/0x180
[   30.666480]  idempotent_init_module+0x224/0x750
[   30.667180]  __x64_sys_finit_module+0xbf/0x130
[   30.667700]  do_syscall_64+0x101/0x4c0
[   30.668217]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.668621]
[   30.668713] Freed by task 261:
[   30.669036]  kasan_save_stack+0x30/0x50
[   30.669608]  kasan_save_track+0x14/0x30
[   30.670757]  kasan_save_free_info+0x3b/0x70
[   30.671293]  __kasan_slab_free+0x47/0x70
[   30.671591]  kfree+0x147/0x3b0
[   30.671901]  thermal_zone_device_unregister+0x305/0x3f0
[   30.672287]  power_supply_unregister+0xdd/0x120
[   30.672628]  0xffffffffc0401ac7
[   30.672924]  __do_sys_delete_module+0x2d3/0x480
[   30.673366]  do_syscall_64+0x101/0x4c0
[   30.673583]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.673926]
[   30.674079] Last potentially related work creation:
[   30.674531]  kasan_save_stack+0x30/0x50
[   30.674947]  kasan_record_aux_stack+0x8c/0xa0
[   30.675341]  __queue_work+0x69b/0x1010
[   30.675750]  mod_delayed_work_on+0xf3/0x100
[   30.676057]  thermal_pm_notify+0x2d1/0x420
[   30.676274]  notifier_call_chain+0xc1/0x2b0
[   30.676509]  blocking_notifier_call_chain+0x69/0xb0
[   30.676762]  snapshot_release+0x13b/0x1b0
[   30.677102]  __fput+0x35f/0xac0
[   30.677291]  task_work_run+0x116/0x1f0
[   30.677490]  exit_to_user_mode_loop+0xad/0x420
[   30.677724]  do_syscall_64+0x385/0x4c0
[   30.678062]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.678478]
[   30.678626] Second to last potentially related work creation:
[   30.680309]  kasan_save_stack+0x30/0x50
[   30.680657]  kasan_record_aux_stack+0x8c/0xa0
[   30.681084]  __queue_work+0x69b/0x1010
[   30.681427]  call_timer_fn+0x2c/0x270
[   30.681767]  __run_timers+0x437/0x880
[   30.682205]  run_timer_softirq+0x14b/0x280
[   30.682622]  handle_softirqs+0x18e/0x520
[   30.684318]  irq_exit_rcu+0xa5/0xe0
[   30.684660]  sysvec_apic_timer_interrupt+0x6b/0x80
[   30.685784]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   30.686516]
[   30.686619] The buggy address belongs to the object at ffff888006f8b000
[   30.686619]  which belongs to the cache kmalloc-2k of size 2048
[   30.688109] The buggy address is located 1120 bytes inside of
[   30.688109]  freed 2048-byte region [ffff888006f8b000, ffff888006f8b800)
[   30.689309]
[   30.689446] The buggy address belongs to the physical page:
[   30.690192] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6f88
[   30.690715] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   30.692023] flags: 0x100000000000040(head|node=0|zone=1)
[   30.692604] page_type: f5(slab)
[   30.693162] raw: 0100000000000040 ffff888001042000 dead000000000100 dead000000000122
[   30.693747] raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
[   30.694407] head: 0100000000000040 ffff888001042000 dead000000000100 dead000000000122
[   30.695338] head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
[   30.696115] head: 0100000000000003 ffffea00001be201 00000000ffffffff 00000000ffffffff
[   30.696779] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   30.697418] page dumped because: kasan: bad access detected
[   30.697794]
[   30.697983] Memory state around the buggy address:
[   30.698390]  ffff888006f8b300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.699047]  ffff888006f8b380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.699696] >ffff888006f8b400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.700237]                                                        ^
[   30.700727]  ffff888006f8b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.702005]  ffff888006f8b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.702739] ==================================================================
[   30.703531] Disabling lock debugging due to kernel taint

Case 2:

This was found during the analysis of Case 1.

[   28.879799] ==================================================================
[   28.880509] BUG: KASAN: slab-use-after-free in thermal_zone_device_init+0x6ae/0x760
[   28.881456] Write of size 4 at addr ffff8880020503d0 by task kworker/1:1/37
[   28.882215]
[   28.882339] CPU: 1 UID: 0 PID: 37 Comm: kworker/1:1 Not tainted 7.0.0-rc5+ #17 PREEMPT(lazy)
[   28.882345] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   28.882348] Workqueue: events_freezable_pwr_efficient thermal_zone_device_resume
[   28.882356] Call Trace:
[   28.882360]  <TASK>
[   28.882363]  dump_stack_lvl+0x4d/0x70
[   28.882372]  print_report+0x170/0x4f3
[   28.882392]  kasan_report+0xda/0x110
[   28.882415]  thermal_zone_device_init+0x6ae/0x760
[   28.882423]  thermal_zone_device_resume+0x83/0xcb
[   28.882429]  process_one_work+0x617/0xf00
[   28.882444]  worker_thread+0x422/0xbb0
[   28.882471]  kthread+0x2cb/0x3a0
[   28.882489]  ret_from_fork+0x357/0x540
[   28.882513]  ret_from_fork_asm+0x1a/0x30
[   28.882522]  </TASK>
[   28.882525]
[   28.895017] Allocated by task 229:
[   28.895213]  kasan_save_stack+0x30/0x50
[   28.895431]  kasan_save_track+0x14/0x30
[   28.895757]  __kasan_kmalloc+0x7f/0x90
[   28.896109]  __kmalloc_noprof+0x180/0x4b0
[   28.896409]  thermal_zone_device_register_with_trips+0xf4/0x11d0
[   28.897214]  thermal_tripless_zone_device_register+0x1f/0x30
[   28.897583]  __power_supply_register.part.0+0x887/0xcf0
[   28.898127]  0xffffffffc040204f
[   28.898445]  do_one_initcall+0x9f/0x3b0
[   28.898874]  do_init_module+0x281/0x820
[   28.899260]  load_module+0x4a5c/0x6300
[   28.899609]  init_module_from_file+0x161/0x180
[   28.900058]  idempotent_init_module+0x224/0x750
[   28.900504]  __x64_sys_finit_module+0xbf/0x130
[   28.900973]  do_syscall_64+0x101/0x4c0
[   28.901287]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   28.901772]
[   28.901904] Freed by task 235:
[   28.902157]  kasan_save_stack+0x30/0x50
[   28.902451]  kasan_save_track+0x14/0x30
[   28.902828]  kasan_save_free_info+0x3b/0x70
[   28.903218]  __kasan_slab_free+0x47/0x70
[   28.903533]  kfree+0x147/0x3b0
[   28.903889]  thermal_zone_device_unregister+0x436/0x464
[   28.904440]  power_supply_unregister+0xdd/0x120
[   28.904939]  0xffffffffc0401ac7
[   28.905245]  __do_sys_delete_module+0x2d3/0x480
[   28.905681]  do_syscall_64+0x101/0x4c0
[   28.906082]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   28.906434]
[   28.906527] Last potentially related work creation:
[   28.907126]  kasan_save_stack+0x30/0x50
[   28.907507]  kasan_record_aux_stack+0x8c/0xa0
[   28.908025]  __queue_work+0x69b/0x1010
[   28.908439]  mod_delayed_work_on+0xf3/0x100
[   28.908989]  thermal_pm_notify+0x2d1/0x420
[   28.909463]  notifier_call_chain+0xc1/0x2b0
[   28.909981]  blocking_notifier_call_chain+0x69/0xb0
[   28.910472]  snapshot_release+0x13b/0x1b0
[   28.910868]  __fput+0x35f/0xac0
[   28.911239]  task_work_run+0x116/0x1f0
[   28.911704]  exit_to_user_mode_loop+0xad/0x420
[   28.912187]  do_syscall_64+0x385/0x4c0
[   28.912455]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   28.912951]
[   28.913132] Second to last potentially related work creation:
[   28.913663]  kasan_save_stack+0x30/0x50
[   28.913864]  kasan_record_aux_stack+0x8c/0xa0
[   28.914150]  __queue_work+0x69b/0x1010
[   28.914481]  call_timer_fn+0x2c/0x270
[   28.914847]  __run_timers+0x437/0x880
[   28.915163]  run_timer_softirq+0x14b/0x280
[   28.915507]  handle_softirqs+0x18e/0x520
[   28.915884]  irq_exit_rcu+0xa5/0xe0
[   28.916163]  sysvec_apic_timer_interrupt+0x6b/0x80
[   28.916641]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   28.917206]
[   28.917371] The buggy address belongs to the object at ffff888002050000
[   28.917371]  which belongs to the cache kmalloc-2k of size 2048
[   28.918672] The buggy address is located 976 bytes inside of
[   28.918672]  freed 2048-byte region [ffff888002050000, ffff888002050800)
[   28.919703]
[   28.919804] The buggy address belongs to the physical page:
[   28.920235] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2050
[   28.920950] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   28.921553] flags: 0x100000000000040(head|node=0|zone=1)
[   28.922004] page_type: f5(slab)
[   28.922276] raw: 0100000000000040 ffff888001042000 dead000000000100 dead000000000122
[   28.922983] raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
[   28.923673] head: 0100000000000040 ffff888001042000 dead000000000100 dead000000000122
[   28.924444] head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
[   28.925140] head: 0100000000000003 ffffea0000081401 00000000ffffffff 00000000ffffffff
[   28.925882] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   28.926576] page dumped because: kasan: bad access detected
[   28.927039]
[   28.927172] Memory state around the buggy address:
[   28.927739]  ffff888002050280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   28.928393]  ffff888002050300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   28.929087] >ffff888002050380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   28.929450]                                                  ^
[   28.929878]  ffff888002050400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   28.930472]  ffff888002050480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   28.931067] ==================================================================
[   28.931803] Disabling lock debugging due to kernel taint
---
 drivers/thermal/thermal_core.c | 17 +++++++++--------
 drivers/thermal/thermal_core.h |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b7d706ed7ed96a4be3a2e2abe9d87d1b72b03651..236192b45e3f0ede54abbf96d517352322fbe023 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1396,11 +1396,16 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
+static void thermal_zone_device_resume(struct work_struct *work);
+
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_trip_desc *td, *next;
 
-	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
+	if (tz->state & TZ_STATE_FLAG_INIT) {
+		INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
+		INIT_DELAYED_WORK(&tz->resume_queue, thermal_zone_device_resume);
+	}
 
 	tz->temperature = THERMAL_TEMP_INIT;
 	tz->passive = 0;
@@ -1721,6 +1726,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		return;
 
 	cancel_delayed_work_sync(&tz->poll_queue);
+	cancel_delayed_work_sync(&tz->resume_queue);
 
 	thermal_set_governor(tz, NULL);
 
@@ -1781,7 +1787,7 @@ static void thermal_zone_device_resume(struct work_struct *work)
 {
 	struct thermal_zone_device *tz;
 
-	tz = container_of(work, struct thermal_zone_device, poll_queue.work);
+	tz = container_of(work, struct thermal_zone_device, resume_queue.work);
 
 	guard(thermal_zone)(tz);
 
@@ -1834,13 +1840,8 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 	reinit_completion(&tz->resume);
 	tz->state |= TZ_STATE_FLAG_RESUMING;
 
-	/*
-	 * Replace the work function with the resume one, which will restore the
-	 * original work function and schedule the polling work if needed.
-	 */
-	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
 	/* Queue up the work without a delay. */
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
+	mod_delayed_work(system_freezable_power_efficient_wq, &tz->resume_queue, 0);
 }
 
 static void thermal_pm_notify_complete(void)
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index d3acff602f9ce1703172540a906c59089c98505d..9e757aa3cbcd1aeaf1537e9bf924b2b67a2a1a66 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -110,6 +110,7 @@ struct thermal_governor {
  * @lock:	lock to protect thermal_instances list
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
+ * @resume_queue:	delayed work for resuming
  * @notify_event: Last notification event
  * @state: 	current state of the thermal zone
  * @debugfs:	this thermal zone device's thermal zone debug info
@@ -146,6 +147,7 @@ struct thermal_zone_device {
 	struct mutex lock;
 	struct list_head node;
 	struct delayed_work poll_queue;
+	struct delayed_work resume_queue;
 	enum thermal_notify_event notify_event;
 	u8 state;
 #ifdef CONFIG_THERMAL_DEBUGFS

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-thermal-core-uaf-init_delayed_work-5195ef033118

Best regards,
-- 
Mauricio Faria de Oliveira <mfo@igalia.com>

