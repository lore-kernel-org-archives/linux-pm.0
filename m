From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / runtime: Avoid false-positive warnings from might_sleep_if()
Date: Sat, 04 Feb 2017 00:58:53 +0100
Message-ID: <15818372.6qr0ZfnSx1@aspire.rjw.lan>
References: <CA+icZUVydvidHHeWn7=ni1Kxr0y1kaRLKMWCPQi2YY5c_xNL_Q@mail.gmail.com> <CAJZ5v0gaVL1zkVdb3G8p=Lgk5fX8fB2pv-RR54j8_UTd9PYFmA@mail.gmail.com> <CA+icZUWgV-NGyHVWo4yo0c-qOew=W=GKdDEY6L2Le1vSh+SpQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64060 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752872AbdBDADj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2017 19:03:39 -0500
In-Reply-To: <CA+icZUWgV-NGyHVWo4yo0c-qOew=W=GKdDEY6L2Le1vSh+SpQg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, Pavel Machek <pavel@ucw.cz>, Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, Imre Deak <imre.deak@intel.com>

On Thursday, February 02, 2017 02:34:42 PM Sedat Dilek wrote:
> On Wed, Feb 1, 2017 at 1:22 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Jan 30, 2017 at 11:44 PM, Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com> wrote:
> >> On 1/24/2017 2:33 AM, Sedat Dilek wrote:
> >>>
> >>> On Fri, Dec 30, 2016 at 3:02 PM, Rafael J. Wysocki <rafael@kernel.org>
> >>> wrote:
> >>>>
> >>>> On Fri, Dec 30, 2016 at 12:40 PM, Sedat Dilek <sedat.dilek@gmail.com>
> >>>> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> I have already reported this issue in [1].
> >>>>> One of the issue was solved.
> >>>>> Unfortunately, it looks like there is still a different problem here
> >>>>> (Ubuntu/precise AMD64).
> >>>>>
> >>>>> I tried v4.10-rc1 and latest Linus tree up to...
> >>>>>
> >>>>> commit 98473f9f3f9bd404873cd1178c8be7d6d619f0d1
> >>>>> "mm/filemap: fix parameters to test_bit()"
> >>>>>
> >>>>> Here we go...
> >>>>>
> >>>>> [   29.636047] BUG: sleeping function called from invalid context at
> >>>>> drivers/base/power/runtime.c:1032
> >>>>> [   29.636055] in_atomic(): 1, irqs_disabled(): 0, pid: 1500, name: Xorg
> >>>>> [   29.636058] 1 lock held by Xorg/1500:
> >>>>> [   29.636060]  #0:  (&dev->struct_mutex){+.+.+.}, at:
> >>>>> [<ffffffffa0680c13>] i915_mutex_lock_interruptible+0x43/0x140 [i915]
> >>>>> [   29.636107] CPU: 0 PID: 1500 Comm: Xorg Not tainted
> >>>>> 4.10.0-rc1-6-iniza-amd64 #1
> >>>>> [   29.636109] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
> >>>>> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
> >>>>> [   29.636111] Call Trace:
> >>>>> [   29.636120]  dump_stack+0x85/0xc2
> >>>>> [   29.636124]  ___might_sleep+0x196/0x260
> >>>>> [   29.636127]  __might_sleep+0x53/0xb0
> >>>>> [   29.636131]  __pm_runtime_resume+0x7a/0x90
> >>>>> [   29.636159]  intel_runtime_pm_get+0x25/0x90 [i915]
> >>>>> [   29.636189]  aliasing_gtt_bind_vma+0xaa/0xf0 [i915]
> >>>>> [   29.636220]  i915_vma_bind+0xaf/0x1e0 [i915]
> >>>>> [   29.636248]  i915_gem_execbuffer_relocate_entry+0x513/0x6f0 [i915]
> >>>>> [   29.636272]  i915_gem_execbuffer_relocate_vma.isra.34+0x188/0x250
> >>>>> [i915]
> >>>>> [   29.636275]  ? trace_hardirqs_on+0xd/0x10
> >>>>> [   29.636294]  ? i915_gem_execbuffer_reserve_vma.isra.31+0x152/0x1f0
> >>>>> [i915]
> >>>>> [   29.636316]  ? i915_gem_execbuffer_reserve.isra.32+0x372/0x3a0 [i915]
> >>>>> [   29.636342]  i915_gem_do_execbuffer.isra.38+0xa70/0x1a40 [i915]
> >>>>> [   29.636347]  ? __might_fault+0x4e/0xb0
> >>>>> [   29.636373]  i915_gem_execbuffer2+0xc5/0x260 [i915]
> >>>>> [   29.636376]  ? __might_fault+0x4e/0xb0
> >>>>> [   29.636395]  drm_ioctl+0x206/0x450 [drm]
> >>>>> [   29.636420]  ? i915_gem_execbuffer+0x340/0x340 [i915]
> >>>>> [   29.636425]  ? __fget+0x5/0x200
> >>>>> [   29.636429]  do_vfs_ioctl+0x91/0x6f0
> >>>>> [   29.636431]  ? __fget+0x111/0x200
> >>>>> [   29.636433]  ? __fget+0x5/0x200
> >>>>> [   29.636436]  SyS_ioctl+0x79/0x90
> >>>>> [   29.636441]  entry_SYSCALL_64_fastpath+0x23/0xc6
> >>>>>
> >>>>> On suspend/resume I see the same call trace.
> >>>>> [2] points to the "BUG" line.
> >>>>
> >>>> Well, this appears to be an i915 issue, but not a serious one.
> >>>>
> >>>> Clearly, a function that may sleep (pm_runtime_get_sync() in
> >>>> intel_runtime_pm_get()) is called with disabled interrupts.  If I
> >>>> understand the code correctly, though, it actually is not going to
> >>>> sleep in this particular case, because pm_runtime_get_sync() has
> >>>> already been called once for this device in the same code path which
> >>>> means that this particular instance will return immediately, so this
> >>>> is a false-positive (most likely).
> >>>>
> >>>> Let me see if I the might_sleep_if() assertion in
> >>>> __pm_runtime_resume(() can be moved to a better place.
> >>>>
> >>> Hi Rafael,
> >>>
> >>> did you had a chance to look at this?
> >>> The problem still remains in Linux v4.10-rc5.
> >>
> >>
> >> No, I didn't.
> >>
> >> As I said, this is not a serious issue.
> >
> > Something like the attached (untested).
> >
> > Please try it and let me know if it makes the splat go away.
> >
> 
> Your patch fixes the issue here.
> I tested against vanilla Linux v4.10-rc5.
> 
> Feel free to give appropriate credits.

OK, thanks!

Below is a full version with a changelog & tags.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] PM / runtime: Avoid false-positive warnings from might_sleep_if()

The might_sleep_if() assertions in __pm_runtime_idle(),
__pm_runtime_suspend() and __pm_runtime_resume() may generate
false-positive warnings in some situations.  For example, that
happens if a nested pm_runtime_get_sync()/pm_runtime_put() pair
is executed with disabled interrupts within an outer
pm_runtime_get_sync()/pm_runtime_put() section for the same device.
[Generally, pm_runtime_get_sync() may sleep, so it should not be
called with disabled interrupts, but in this particular case the
previous pm_runtime_get_sync() guarantees that the device will not
be suspended, so the inner pm_runtime_get_sync() will return
immediately after incrementing the device's usage counter.]

That started to happen in the i915 driver in 4.10-rc, leading to
the following splat:

 BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1032
 in_atomic(): 1, irqs_disabled(): 0, pid: 1500, name: Xorg
 1 lock held by Xorg/1500:
  #0:  (&dev->struct_mutex){+.+.+.}, at:
  [<ffffffffa0680c13>] i915_mutex_lock_interruptible+0x43/0x140 [i915]
 CPU: 0 PID: 1500 Comm: Xorg Not tainted
 Call Trace:
  dump_stack+0x85/0xc2
  ___might_sleep+0x196/0x260
  __might_sleep+0x53/0xb0
  __pm_runtime_resume+0x7a/0x90
  intel_runtime_pm_get+0x25/0x90 [i915]
  aliasing_gtt_bind_vma+0xaa/0xf0 [i915]
  i915_vma_bind+0xaf/0x1e0 [i915]
  i915_gem_execbuffer_relocate_entry+0x513/0x6f0 [i915]
  i915_gem_execbuffer_relocate_vma.isra.34+0x188/0x250 [i915]
  ? trace_hardirqs_on+0xd/0x10
  ? i915_gem_execbuffer_reserve_vma.isra.31+0x152/0x1f0 [i915]
  ? i915_gem_execbuffer_reserve.isra.32+0x372/0x3a0 [i915]
  i915_gem_do_execbuffer.isra.38+0xa70/0x1a40 [i915]
  ? __might_fault+0x4e/0xb0
  i915_gem_execbuffer2+0xc5/0x260 [i915]
  ? __might_fault+0x4e/0xb0
  drm_ioctl+0x206/0x450 [drm]
  ? i915_gem_execbuffer+0x340/0x340 [i915]
  ? __fget+0x5/0x200
  do_vfs_ioctl+0x91/0x6f0
  ? __fget+0x111/0x200
  ? __fget+0x5/0x200
  SyS_ioctl+0x79/0x90
  entry_SYSCALL_64_fastpath+0x23/0xc6

even though the code triggering it is correct.

Unfortunately, the might_sleep_if() assertions in question are
too coarse-grained to cover such cases correctly, so make them
a bit less sensitive in order to avoid the false-positives.

Reported-and-tested-by: Sedat Dilek <sedat.dilek@gmail.com> 
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -966,13 +966,13 @@ int __pm_runtime_idle(struct device *dev
 	unsigned long flags;
 	int retval;
 
-	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
-
 	if (rpmflags & RPM_GET_PUT) {
 		if (!atomic_dec_and_test(&dev->power.usage_count))
 			return 0;
 	}
 
+	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
+
 	spin_lock_irqsave(&dev->power.lock, flags);
 	retval = rpm_idle(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -998,13 +998,13 @@ int __pm_runtime_suspend(struct device *
 	unsigned long flags;
 	int retval;
 
-	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
-
 	if (rpmflags & RPM_GET_PUT) {
 		if (!atomic_dec_and_test(&dev->power.usage_count))
 			return 0;
 	}
 
+	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
+
 	spin_lock_irqsave(&dev->power.lock, flags);
 	retval = rpm_suspend(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -1029,7 +1029,8 @@ int __pm_runtime_resume(struct device *d
 	unsigned long flags;
 	int retval;
 
-	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
+	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
+			dev->power.runtime_status != RPM_ACTIVE);
 
 	if (rpmflags & RPM_GET_PUT)
 		atomic_inc(&dev->power.usage_count);

