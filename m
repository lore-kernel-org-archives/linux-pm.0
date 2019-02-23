From: Randy Dunlap <rdunlap@infradead.org>
Subject: UBSAN: Undefined behaviour in
 ../drivers/cpuidle/governors/menu.c:229:21
Date: Fri, 22 Feb 2019 17:07:13 -0800
Message-ID: <01740a74-f663-9287-50c8-57d6e8f2bbba@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This is 5.0-rc7 on an old Toshiba Portege laptop.


================================================================================
[   51.898454] UBSAN: Undefined behaviour in ../drivers/cpuidle/governors/menu.c:229:21
[   51.898467] signed integer overflow:
[   51.898478] 3758096350 * 3758096350 cannot be represented in type 'long long int'
[   51.898496] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.0.0-rc7mod #3
[   51.898507] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   51.898519] Call Trace:
[   51.898533]  dump_stack+0x7b/0xb5
[   51.898544]  ubsan_epilogue+0xd/0x81
[   51.898553]  handle_overflow+0x198/0x1d7
[   51.898564]  ? __ubsan_handle_negate_overflow+0x195/0x195
[   51.898575]  ? tick_nohz_get_sleep_length+0x121/0x1d0
[   51.898588]  ? ipv6_icmp_error+0x755/0x7f0
[   51.898597]  ? tick_nohz_next_event+0x1b3/0x4a0
[   51.898607]  ? can_stop_idle_tick+0x260/0x260
[   51.898617]  ? __switch_to_asm+0x40/0x70
[   51.898628]  ? calibrate_delay+0x25/0x2341
[   51.898637]  ? __switch_to_asm+0x34/0x70
[   51.898646]  ? common_interrupt+0xa/0xf
[   51.898658]  __ubsan_handle_mul_overflow+0xe/0x1c
[   51.898669]  menu_select+0x13d0/0x1df0
[   51.898682]  ? menu_enable_device+0x170/0x170
[   51.898691]  ? sched_clock+0x9/0x10
[   51.898701]  ? kasan_check_write+0x14/0x20
[   51.898711]  ? rcu_dynticks_eqs_exit+0x2c/0x80
[   51.898722]  cpuidle_select+0x5a/0xa0
[   51.898732]  do_idle+0x2aa/0x3c0
[   51.898742]  ? arch_cpu_idle_exit+0x40/0x40
[   51.898751]  ? kasan_check_read+0x11/0x20
[   51.898761]  ? do_raw_spin_unlock+0x54/0x220
[   51.898773]  cpu_startup_entry+0x18/0x20
[   51.898782]  rest_init+0x165/0x1a0
[   51.898793]  arch_call_rest_init+0x9/0x11
[   51.898803]  start_kernel+0x697/0x6bd
[   51.898813]  ? mem_encrypt_init+0x6/0x6
[   51.898822]  ? load_ucode_intel_bsp+0x53/0x8a
[   51.898832]  ? init_intel_microcode+0x1a4/0x1a4
[   51.898844]  ? load_ucode_bsp+0x1e8/0x21c
[   51.898854]  x86_64_start_reservations+0x24/0x26
[   51.898865]  x86_64_start_kernel+0x74/0x77
[   51.898874]  secondary_startup_64+0xa4/0xb0
[   51.898887] ================================================================================


-- 
~Randy
