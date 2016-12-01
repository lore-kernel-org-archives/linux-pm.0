From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Thu, 1 Dec 2016 10:53:03 -0600
Message-ID: <20161201165303.rysogoj2uvepw6oe@treble>
References: <20161129181300.GA29095@sbauer-Z170X-UD5>
 <20161130183507.syv3cdpp3hzxi77k@treble>
 <20161130190217.GA2756@sbauer-Z170X-UD5>
 <20161130231011.ofmbmevn3hqasetz@treble>
 <CAJZ5v0iW8kNbU6pP96WTc8uLB_0V05vrEyum0d1Q-XKvX0-O-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iW8kNbU6pP96WTc8uLB_0V05vrEyum0d1Q-XKvX0-O-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 01, 2016 at 03:04:22PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 1, 2016 at 12:10 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > Resuming from a suspend operation is showing a KASAN false positive
> > warning:
> >
> >   BUG: KASAN: stack-out-of-bounds in unwind_get_return_address+0x11d/0x130 at addr ffff8803867d7878
> >   Read of size 8 by task pm-suspend/7774
> >   page:ffffea000e19f5c0 count:0 mapcount:0 mapping:          (null) index:0x0
> >   flags: 0x2ffff0000000000()
> >   page dumped because: kasan: bad access detected
> >   CPU: 0 PID: 7774 Comm: pm-suspend Tainted: G    B           4.9.0-rc7+ #8
> >   Hardware name: Gigabyte Technology Co., Ltd. Z170X-UD5/Z170X-UD5-CF, BIOS F5 03/07/2016
> >    ffff8803867d7468 ffffffffb4c0d051 ffff8803867d7500 ffff8803867d7878
> >    ffff8803867d74f0 ffffffffb45cbe34 ffffffffb4e64136 ffffffffb4510d42
> >    ffff8803828c3f4c 0000000000000097 0000000041b58ab3 ffffffffb6192731
> >   Call Trace:
> >     dump_stack+0x63/0x82
> >     kasan_report_error+0x4b4/0x4e0
> >     ? acpi_hw_read_port+0xd0/0x1ea
> >     ? kfree_const+0x22/0x30
> >     ? acpi_hw_validate_io_request+0x1a6/0x1a6
> >     __asan_report_load8_noabort+0x61/0x70
> >     ? unwind_get_return_address+0x11d/0x130
> >     unwind_get_return_address+0x11d/0x130
> >     ? unwind_next_frame+0x97/0xf0
> >     __save_stack_trace+0x92/0x100
> >     save_stack_trace+0x1b/0x20
> >     save_stack+0x46/0xd0
> >     ? save_stack_trace+0x1b/0x20
> >     ? save_stack+0x46/0xd0
> >     ? kasan_kmalloc+0xad/0xe0
> >     ? kasan_slab_alloc+0x12/0x20
> >     ? acpi_hw_read+0x2b6/0x3aa
> >     ? acpi_hw_validate_register+0x20b/0x20b
> >     ? acpi_hw_write_port+0x72/0xc7
> >     ? acpi_hw_write+0x11f/0x15f
> >     ? acpi_hw_read_multiple+0x19f/0x19f
> >     ? memcpy+0x45/0x50
> >     ? acpi_hw_write_port+0x72/0xc7
> >     ? acpi_hw_write+0x11f/0x15f
> >     ? acpi_hw_read_multiple+0x19f/0x19f
> >     ? kasan_unpoison_shadow+0x36/0x50
> >     kasan_kmalloc+0xad/0xe0
> >     kasan_slab_alloc+0x12/0x20
> >     kmem_cache_alloc_trace+0xbc/0x1e0
> >     ? acpi_get_sleep_type_data+0x9a/0x578
> >     acpi_get_sleep_type_data+0x9a/0x578
> >     acpi_hw_legacy_wake_prep+0x88/0x22c
> >     ? acpi_hw_legacy_sleep+0x3c7/0x3c7
> >     ? acpi_write_bit_register+0x28d/0x2d3
> >     ? acpi_read_bit_register+0x19b/0x19b
> >     acpi_hw_sleep_dispatch+0xb5/0xba
> >     acpi_leave_sleep_state_prep+0x17/0x19
> >     acpi_suspend_enter+0x154/0x1e0
> >     ? trace_suspend_resume+0xe8/0xe8
> >     suspend_devices_and_enter+0xb09/0xdb0
> >     ? printk+0xa8/0xd8
> >     ? arch_suspend_enable_irqs+0x20/0x20
> >     ? try_to_freeze_tasks+0x295/0x600
> >     pm_suspend+0x6c9/0x780
> >     ? finish_wait+0x1f0/0x1f0
> >     ? suspend_devices_and_enter+0xdb0/0xdb0
> >     state_store+0xa2/0x120
> >     ? kobj_attr_show+0x60/0x60
> >     kobj_attr_store+0x36/0x70
> >     sysfs_kf_write+0x131/0x200
> >     kernfs_fop_write+0x295/0x3f0
> >     __vfs_write+0xef/0x760
> >     ? handle_mm_fault+0x1346/0x35e0
> >     ? do_iter_readv_writev+0x660/0x660
> >     ? __pmd_alloc+0x310/0x310
> >     ? do_lock_file_wait+0x1e0/0x1e0
> >     ? apparmor_file_permission+0x18/0x20
> >     ? security_file_permission+0x73/0x1c0
> >     ? rw_verify_area+0xbd/0x2b0
> >     vfs_write+0x149/0x4a0
> >     SyS_write+0xd9/0x1c0
> >     ? SyS_read+0x1c0/0x1c0
> >     entry_SYSCALL_64_fastpath+0x1e/0xad
> >   Memory state around the buggy address:
> >    ffff8803867d7700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >    ffff8803867d7780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >   >ffff8803867d7800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f4
> >                                                                   ^
> >    ffff8803867d7880: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
> >    ffff8803867d7900: 00 00 00 f1 f1 f1 f1 04 f4 f4 f4 f3 f3 f3 f3 00
> >
> > KASAN instrumentation poisons the stack when entering a function and
> > unpoisons it when exiting the function.  However, in the suspend path,
> > some functions never return, so their stack never gets unpoisoned,
> > resulting in stale KASAN shadow data which can cause false positive
> > warnings like the one above.
> >
> > Reported-by: Scott Bauer <scott.bauer@intel.com>
> > Tested-by: Scott Bauer <scott.bauer@intel.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/kernel/acpi/sleep.c | 3 +++
> >  include/linux/kasan.h        | 7 +++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> > index 4858733..62bd046 100644
> > --- a/arch/x86/kernel/acpi/sleep.c
> > +++ b/arch/x86/kernel/acpi/sleep.c
> > @@ -115,6 +115,9 @@ int x86_acpi_suspend_lowlevel(void)
> >         pause_graph_tracing();
> >         do_suspend_lowlevel();
> >         unpause_graph_tracing();
> > +
> > +       kasan_unpoison_stack_below_sp();
> > +
> >         return 0;
> >  }
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 820c0ad..e0945d5 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -45,6 +45,12 @@ void kasan_unpoison_shadow(const void *address, size_t size);
> >
> >  void kasan_unpoison_task_stack(struct task_struct *task);
> >  void kasan_unpoison_stack_above_sp_to(const void *watermark);
> > +asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
> > +
> > +static inline void kasan_unpoison_stack_below_sp(void)
> > +{
> > +       kasan_unpoison_task_stack_below(__builtin_frame_address(0));
> > +}
> >
> >  void kasan_alloc_pages(struct page *page, unsigned int order);
> >  void kasan_free_pages(struct page *page, unsigned int order);
> > @@ -87,6 +93,7 @@ static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
> >
> >  static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> >  static inline void kasan_unpoison_stack_above_sp_to(const void *watermark) {}
> > +static inline void kasan_unpoison_stack_below_sp(void) {}
> >
> >  static inline void kasan_enable_current(void) {}
> >  static inline void kasan_disable_current(void) {}
> > --
> 
> Looks OK to me.
> 
> Whom do you expect to apply this?

Assuming it gets an ack from Andrey, can you take it?  Or would the tip
tree be better?

-- 
Josh
