From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [Linux v4.10.0-rc1+] Still call-traces after suspend-resume (pm?
 i915? cpu/hotplug?)
Date: Fri, 30 Dec 2016 19:01:34 +0100
Message-ID: <CA+icZUVPxC4M_GGqRrYnUJMKAVVU_ovYBW787JjELSPT6LUTDA@mail.gmail.com>
References: <CA+icZUVydvidHHeWn7=ni1Kxr0y1kaRLKMWCPQi2YY5c_xNL_Q@mail.gmail.com>
 <CAJZ5v0gp_BwxR+B3wtoLRh2B_ojY7cd9E5shJ8zsBeGL_LtnGg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35379 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbcL3SBg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 13:01:36 -0500
In-Reply-To: <CAJZ5v0gp_BwxR+B3wtoLRh2B_ojY7cd9E5shJ8zsBeGL_LtnGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mika Kuoppala <mika.kuoppala@linux.intel.com>

On Fri, Dec 30, 2016 at 3:02 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 30, 2016 at 12:40 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> Hi,
>>
>> I have already reported this issue in [1].
>> One of the issue was solved.
>> Unfortunately, it looks like there is still a different problem here
>> (Ubuntu/precise AMD64).
>>
>> I tried v4.10-rc1 and latest Linus tree up to...
>>
>> commit 98473f9f3f9bd404873cd1178c8be7d6d619f0d1
>> "mm/filemap: fix parameters to test_bit()"
>>
>> Here we go...
>>
>> [   29.636047] BUG: sleeping function called from invalid context at
>> drivers/base/power/runtime.c:1032
>> [   29.636055] in_atomic(): 1, irqs_disabled(): 0, pid: 1500, name: Xorg
>> [   29.636058] 1 lock held by Xorg/1500:
>> [   29.636060]  #0:  (&dev->struct_mutex){+.+.+.}, at:
>> [<ffffffffa0680c13>] i915_mutex_lock_interruptible+0x43/0x140 [i915]
>> [   29.636107] CPU: 0 PID: 1500 Comm: Xorg Not tainted
>> 4.10.0-rc1-6-iniza-amd64 #1
>> [   29.636109] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
>> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>> [   29.636111] Call Trace:
>> [   29.636120]  dump_stack+0x85/0xc2
>> [   29.636124]  ___might_sleep+0x196/0x260
>> [   29.636127]  __might_sleep+0x53/0xb0
>> [   29.636131]  __pm_runtime_resume+0x7a/0x90
>> [   29.636159]  intel_runtime_pm_get+0x25/0x90 [i915]
>> [   29.636189]  aliasing_gtt_bind_vma+0xaa/0xf0 [i915]
>> [   29.636220]  i915_vma_bind+0xaf/0x1e0 [i915]
>> [   29.636248]  i915_gem_execbuffer_relocate_entry+0x513/0x6f0 [i915]
>> [   29.636272]  i915_gem_execbuffer_relocate_vma.isra.34+0x188/0x250 [i915]
>> [   29.636275]  ? trace_hardirqs_on+0xd/0x10
>> [   29.636294]  ? i915_gem_execbuffer_reserve_vma.isra.31+0x152/0x1f0 [i915]
>> [   29.636316]  ? i915_gem_execbuffer_reserve.isra.32+0x372/0x3a0 [i915]
>> [   29.636342]  i915_gem_do_execbuffer.isra.38+0xa70/0x1a40 [i915]
>> [   29.636347]  ? __might_fault+0x4e/0xb0
>> [   29.636373]  i915_gem_execbuffer2+0xc5/0x260 [i915]
>> [   29.636376]  ? __might_fault+0x4e/0xb0
>> [   29.636395]  drm_ioctl+0x206/0x450 [drm]
>> [   29.636420]  ? i915_gem_execbuffer+0x340/0x340 [i915]
>> [   29.636425]  ? __fget+0x5/0x200
>> [   29.636429]  do_vfs_ioctl+0x91/0x6f0
>> [   29.636431]  ? __fget+0x111/0x200
>> [   29.636433]  ? __fget+0x5/0x200
>> [   29.636436]  SyS_ioctl+0x79/0x90
>> [   29.636441]  entry_SYSCALL_64_fastpath+0x23/0xc6
>>
>> On suspend/resume I see the same call trace.
>> [2] points to the "BUG" line.
>
> Well, this appears to be an i915 issue, but not a serious one.
>
> Clearly, a function that may sleep (pm_runtime_get_sync() in
> intel_runtime_pm_get()) is called with disabled interrupts.  If I
> understand the code correctly, though, it actually is not going to
> sleep in this particular case, because pm_runtime_get_sync() has
> already been called once for this device in the same code path which
> means that this particular instance will return immediately, so this
> is a false-positive (most likely).
>
> Let me see if I the might_sleep_if() assertion in
> __pm_runtime_resume(() can be moved to a better place.
>

OK.
Please CC me if you have something to test for.
Thanks, Rafael.

- Sedat -
