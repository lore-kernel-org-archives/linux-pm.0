From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Fri, 2 Dec 2016 11:42:21 -0600
Message-ID: <20161202174221.sfcvvddbvl5uz4f4@treble>
References: <CACT4Y+anS0XniR7ZxoEQ1nnAKPsGNvgc5L72uiSThOi3F742gA@mail.gmail.com>
 <20161201173438.bfe5eq23i6ezfxsq@treble>
 <CACT4Y+Z62RBTkiAjTG_ZF1zCZKA=S92fobENzRcq001XOTj36A@mail.gmail.com>
 <20161201175611.gf63mwzomt4wrlxy@treble>
 <20161201203154.mwt5x736g7z6jh3o@treble>
 <5144d695-7ac4-f992-5239-91c772b0c121@virtuozzo.com>
 <20161202140147.gvj452hmlbxnstrg@treble>
 <20161202144240.3tect4hx4cks44iu@treble>
 <d632571d-43cb-9dec-a51f-7cf8a6f91c0b@virtuozzo.com>
 <20161202150819.2h25oyoj7qsvrw77@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbcLBRmY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Dec 2016 12:42:24 -0500
Content-Disposition: inline
In-Reply-To: <20161202150819.2h25oyoj7qsvrw77@treble>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, "x86@kernel.org" <x86@kernel.org>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>

Resuming from a suspend operation is showing a KASAN false positive
warning:

  BUG: KASAN: stack-out-of-bounds in unwind_get_return_address+0x11d/0x130 at addr ffff8803867d7878
  Read of size 8 by task pm-suspend/7774
  page:ffffea000e19f5c0 count:0 mapcount:0 mapping:          (null) index:0x0
  flags: 0x2ffff0000000000()
  page dumped because: kasan: bad access detected
  CPU: 0 PID: 7774 Comm: pm-suspend Tainted: G    B           4.9.0-rc7+ #8
  Hardware name: Gigabyte Technology Co., Ltd. Z170X-UD5/Z170X-UD5-CF, BIOS F5 03/07/2016
  Call Trace:
    dump_stack+0x63/0x82
    kasan_report_error+0x4b4/0x4e0
    ? acpi_hw_read_port+0xd0/0x1ea
    ? kfree_const+0x22/0x30
    ? acpi_hw_validate_io_request+0x1a6/0x1a6
    __asan_report_load8_noabort+0x61/0x70
    ? unwind_get_return_address+0x11d/0x130
    unwind_get_return_address+0x11d/0x130
    ? unwind_next_frame+0x97/0xf0
    __save_stack_trace+0x92/0x100
    save_stack_trace+0x1b/0x20
    save_stack+0x46/0xd0
    ? save_stack_trace+0x1b/0x20
    ? save_stack+0x46/0xd0
    ? kasan_kmalloc+0xad/0xe0
    ? kasan_slab_alloc+0x12/0x20
    ? acpi_hw_read+0x2b6/0x3aa
    ? acpi_hw_validate_register+0x20b/0x20b
    ? acpi_hw_write_port+0x72/0xc7
    ? acpi_hw_write+0x11f/0x15f
    ? acpi_hw_read_multiple+0x19f/0x19f
    ? memcpy+0x45/0x50
    ? acpi_hw_write_port+0x72/0xc7
    ? acpi_hw_write+0x11f/0x15f
    ? acpi_hw_read_multiple+0x19f/0x19f
    ? kasan_unpoison_shadow+0x36/0x50
    kasan_kmalloc+0xad/0xe0
    kasan_slab_alloc+0x12/0x20
    kmem_cache_alloc_trace+0xbc/0x1e0
    ? acpi_get_sleep_type_data+0x9a/0x578
    acpi_get_sleep_type_data+0x9a/0x578
    acpi_hw_legacy_wake_prep+0x88/0x22c
    ? acpi_hw_legacy_sleep+0x3c7/0x3c7
    ? acpi_write_bit_register+0x28d/0x2d3
    ? acpi_read_bit_register+0x19b/0x19b
    acpi_hw_sleep_dispatch+0xb5/0xba
    acpi_leave_sleep_state_prep+0x17/0x19
    acpi_suspend_enter+0x154/0x1e0
    ? trace_suspend_resume+0xe8/0xe8
    suspend_devices_and_enter+0xb09/0xdb0
    ? printk+0xa8/0xd8
    ? arch_suspend_enable_irqs+0x20/0x20
    ? try_to_freeze_tasks+0x295/0x600
    pm_suspend+0x6c9/0x780
    ? finish_wait+0x1f0/0x1f0
    ? suspend_devices_and_enter+0xdb0/0xdb0
    state_store+0xa2/0x120
    ? kobj_attr_show+0x60/0x60
    kobj_attr_store+0x36/0x70
    sysfs_kf_write+0x131/0x200
    kernfs_fop_write+0x295/0x3f0
    __vfs_write+0xef/0x760
    ? handle_mm_fault+0x1346/0x35e0
    ? do_iter_readv_writev+0x660/0x660
    ? __pmd_alloc+0x310/0x310
    ? do_lock_file_wait+0x1e0/0x1e0
    ? apparmor_file_permission+0x18/0x20
    ? security_file_permission+0x73/0x1c0
    ? rw_verify_area+0xbd/0x2b0
    vfs_write+0x149/0x4a0
    SyS_write+0xd9/0x1c0
    ? SyS_read+0x1c0/0x1c0
    entry_SYSCALL_64_fastpath+0x1e/0xad
  Memory state around the buggy address:
   ffff8803867d7700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff8803867d7780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff8803867d7800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f4
                                                                  ^
   ffff8803867d7880: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
   ffff8803867d7900: 00 00 00 f1 f1 f1 f1 04 f4 f4 f4 f3 f3 f3 f3 00

KASAN instrumentation poisons the stack when entering a function and
unpoisons it when exiting the function.  However, in the suspend path,
some functions never return, so their stack never gets unpoisoned,
resulting in stale KASAN shadow data which can cause later false
positive warnings like the one above.

Reported-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/acpi/wakeup_64.S | 9 +++++++++
 mm/kasan/kasan.c                 | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 169963f..50b8ed0 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -109,6 +109,15 @@ ENTRY(do_suspend_lowlevel)
 	movq	pt_regs_r14(%rax), %r14
 	movq	pt_regs_r15(%rax), %r15
 
+#ifdef CONFIG_KASAN
+	/*
+	 * The suspend path may have poisoned some areas deeper in the stack,
+	 * which we now need to unpoison.
+	 */
+	movq	%rsp, %rdi
+	call	kasan_unpoison_task_stack_below
+#endif
+
 	xorl	%eax, %eax
 	addq	$8, %rsp
 	FRAME_END
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 0e9505f..b2a0cff 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -80,7 +80,14 @@ void kasan_unpoison_task_stack(struct task_struct *task)
 /* Unpoison the stack for the current task beyond a watermark sp value. */
 asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 {
-	__kasan_unpoison_stack(current, watermark);
+	/*
+	 * Calculate the task stack base address.  Avoid using 'current'
+	 * because this function is called by early resume code which hasn't
+	 * yet set up the percpu register (%gs).
+	 */
+	void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));
+
+	kasan_unpoison_shadow(base, watermark - base);
 }
 
 /*
-- 
2.7.4

