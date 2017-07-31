From: Jiri Kosina <jikos@kernel.org>
Subject: x86/thermal: AB-BA dependency between mvm->mutex and tz->lock
Date: Mon, 31 Jul 2017 13:18:20 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707311300440.4705@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbdGaLSX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Jul 2017 07:18:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

booting current Linus' tree, I'm seeing lockdep splat (see the end of this 
mail).

Apparently, there is AB-BA between tz->lock and mvm->mutex through the CPU 
hotplug lock.

The obivous depency is: thermal_zone_get_temp() acquires tz->lock, and 
then calls iwl_mvm_tzone_get_temp() (through tz->ops->get_temp() 
callback), which acquires mvm->mutex

The less obvious dependency is primarily caused by iwl_op_mode_mvm_start() 
allocating workqueue (#2 stacktrace) while holding mvm->mutex (which is 
broken, because that mutex is being taken also from CPU hotplug callback 
path, hence the AB-BA).

 ======================================================
 WARNING: possible circular locking dependency detected
 4.13.0-rc2-00110-g0b5477d #347 Not tainted
 ------------------------------------------------------
 modprobe/881 is trying to acquire lock:
  (&mvm->mutex){+.+.+.}, at: [<ffffffffc0c504d2>] iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
 
 but task is already holding lock:
  (&tz->lock){+.+.+.}, at: [<ffffffff926a9351>] thermal_zone_get_temp+0x41/0x70
 
 which lock already depends on the new lock.

 
 the existing dependency chain (in reverse order) is:
 
 -> #5 (&tz->lock){+.+.+.}:
        lock_acquire+0xbd/0x220
        __mutex_lock+0x6e/0x900
        mutex_lock_nested+0x1b/0x20
        thermal_zone_get_temp+0x41/0x70
        thermal_zone_device_update+0x3c/0x280
        thermal_zone_device_register+0x3b8/0x610
        pkg_thermal_cpu_online+0x20b/0x284 [x86_pkg_temp_thermal]
        cpuhp_invoke_callback+0xac/0x900
        cpuhp_thread_fun+0x79/0x160
        smpboot_thread_fn+0x156/0x220
        kthread+0x114/0x150
        ret_from_fork+0x2a/0x40
 
 -> #4 (cpuhp_state){+.+.+.}:
        lock_acquire+0xbd/0x220
        cpuhp_issue_call+0xea/0x170
        __cpuhp_setup_state_cpuslocked+0x12a/0x190
        __cpuhp_setup_state+0x46/0xc0
        page_writeback_init+0x43/0x67
        pagecache_init+0x39/0x3c
        start_kernel+0x45a/0x4ae
        x86_64_start_reservations+0x24/0x26
        x86_64_start_kernel+0x13d/0x14c
        verify_cpu+0x0/0xf1
 
 -> #3 (cpuhp_state_mutex){+.+.+.}:
        lock_acquire+0xbd/0x220
        __mutex_lock+0x6e/0x900
        mutex_lock_nested+0x1b/0x20
        __cpuhp_setup_state_cpuslocked+0x4f/0x190
        __cpuhp_setup_state+0x46/0xc0
        page_alloc_init+0x28/0x30
        start_kernel+0x186/0x4ae
        x86_64_start_reservations+0x24/0x26
        x86_64_start_kernel+0x13d/0x14c
        verify_cpu+0x0/0xf1
 
 -> #2 (cpu_hotplug_lock.rw_sem){++++++}:
        lock_acquire+0xbd/0x220
        cpus_read_lock+0x46/0x90
        apply_workqueue_attrs+0x17/0x50
        __alloc_workqueue_key+0x195/0x4d0
        _iwl_pcie_rx_init+0x384/0x390 [iwlwifi]
        iwl_pcie_rx_init+0x1e/0x380 [iwlwifi]
        iwl_trans_pcie_start_fw+0x295/0x6f0 [iwlwifi]
        iwl_mvm_load_ucode_wait_alive+0xe7/0x390 [iwlmvm]
        iwl_run_init_mvm_ucode+0x84/0x320 [iwlmvm]
        iwl_op_mode_mvm_start+0x964/0xd30 [iwlmvm]
        _iwl_op_mode_start.isra.9+0x47/0xa0 [iwlwifi]
        iwl_opmode_register+0xaa/0xd0 [iwlwifi]
        iwl_mvm_init+0x37/0x1000 [iwlmvm]
        do_one_initcall+0x51/0x1a9
        do_init_module+0x60/0x20e
        load_module+0x203f/0x2b50
        SYSC_finit_module+0x96/0xd0
        SyS_finit_module+0xe/0x10
        entry_SYSCALL_64_fastpath+0x23/0xc2
 
 -> #1 (&trans_pcie->mutex){+.+.+.}:
        lock_acquire+0xbd/0x220
        __mutex_lock+0x6e/0x900
        mutex_lock_nested+0x1b/0x20
        iwl_trans_pcie_start_fw+0x130/0x6f0 [iwlwifi]
        iwl_mvm_load_ucode_wait_alive+0xe7/0x390 [iwlmvm]
        iwl_run_init_mvm_ucode+0x84/0x320 [iwlmvm]
        iwl_op_mode_mvm_start+0x964/0xd30 [iwlmvm]
        _iwl_op_mode_start.isra.9+0x47/0xa0 [iwlwifi]
        iwl_opmode_register+0xaa/0xd0 [iwlwifi]
        iwl_mvm_init+0x37/0x1000 [iwlmvm]
        do_one_initcall+0x51/0x1a9
        do_init_module+0x60/0x20e
        load_module+0x203f/0x2b50
        SYSC_finit_module+0x96/0xd0
        SyS_finit_module+0xe/0x10
        entry_SYSCALL_64_fastpath+0x23/0xc2
 
 -> #0 (&mvm->mutex){+.+.+.}:
        __lock_acquire+0x13e1/0x1400
        lock_acquire+0xbd/0x220
        __mutex_lock+0x6e/0x900
        mutex_lock_nested+0x1b/0x20
        iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
        thermal_zone_get_temp+0x51/0x70
        thermal_zone_device_update+0x3c/0x280
        thermal_zone_device_register+0x3b8/0x610
        iwl_mvm_thermal_initialize+0x1d1/0x3a0 [iwlmvm]
        iwl_op_mode_mvm_start+0xa1d/0xd30 [iwlmvm]
        _iwl_op_mode_start.isra.9+0x47/0xa0 [iwlwifi]
        iwl_opmode_register+0xaa/0xd0 [iwlwifi]
        iwl_mvm_init+0x37/0x1000 [iwlmvm]
        do_one_initcall+0x51/0x1a9
        do_init_module+0x60/0x20e
        load_module+0x203f/0x2b50
        SYSC_finit_module+0x96/0xd0
        SyS_finit_module+0xe/0x10
        entry_SYSCALL_64_fastpath+0x23/0xc2
 
 other info that might help us debug this:

 Chain exists of:
   &mvm->mutex --> cpuhp_state --> &tz->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&tz->lock);
                                lock(cpuhp_state);
                                lock(&tz->lock);
   lock(&mvm->mutex);
 
  *** DEADLOCK ***

 2 locks held by modprobe/881:
  #0:  (&iwlwifi_opmode_table_mtx){+.+.+.}, at: [<ffffffffc0aa2df4>] iwl_opmode_register+0x24/0xd0 [iwlwifi]
  #1:  (&tz->lock){+.+.+.}, at: [<ffffffff926a9351>] thermal_zone_get_temp+0x41/0x70
 
 stack backtrace:
 CPU: 3 PID: 881 Comm: modprobe Not tainted 4.13.0-rc2-00110-g0b5477d #347
 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
 Call Trace:
  dump_stack+0x85/0xc9
  print_circular_bug+0x1f9/0x207
  __lock_acquire+0x13e1/0x1400
  lock_acquire+0xbd/0x220
  ? iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
  ? iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
  __mutex_lock+0x6e/0x900
  ? iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
  ? thermal_zone_get_temp+0x41/0x70
  ? iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
  ? thermal_zone_get_temp+0x41/0x70
  ? find_held_lock+0x39/0xb0
  mutex_lock_nested+0x1b/0x20
  iwl_mvm_tzone_get_temp+0x32/0x80 [iwlmvm]
  thermal_zone_get_temp+0x51/0x70
  thermal_zone_device_update+0x3c/0x280
  thermal_zone_device_register+0x3b8/0x610
  iwl_mvm_thermal_initialize+0x1d1/0x3a0 [iwlmvm]
  iwl_op_mode_mvm_start+0xa1d/0xd30 [iwlmvm]
  _iwl_op_mode_start.isra.9+0x47/0xa0 [iwlwifi]
  iwl_opmode_register+0xaa/0xd0 [iwlwifi]
  iwl_mvm_init+0x37/0x1000 [iwlmvm]
  ? 0xffffffffc0c87000
  do_one_initcall+0x51/0x1a9
  ? rcu_read_lock_sched_held+0x98/0xa0
  ? kmem_cache_alloc_trace+0x2a5/0x340
  do_init_module+0x60/0x20e
  load_module+0x203f/0x2b50
  ? __symbol_put+0x50/0x50
  SYSC_finit_module+0x96/0xd0
  SyS_finit_module+0xe/0x10
  entry_SYSCALL_64_fastpath+0x23/0xc2
 RIP: 0033:0x7f2ef067cc89
 RSP: 002b:00007ffea2ea3d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f2ef067cc89
 RDX: 0000000000000000 RSI: 000000000041af06 RDI: 0000000000000001
 RBP: 0000000000000005 R08: 0000000000000000 R09: 000000000096b230
 R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffea2ea2d80
 R13: 00007ffea2ea2d60 R14: 0000000000000005 R15: 000000000096f3c0
 thermal thermal_zone3: failed to read out thermal zone (-5)


-- 
Jiri Kosina
SUSE Labs
