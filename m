From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
	suspending devices
Date: Wed, 3 Feb 2010 02:44:23 +0100
Message-ID: <201002030244.23989.rjw__35204.2435472415$1265161590$gmane$org@sisk.pl>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201002011630.04281.rjw@sisk.pl>
	<20100201075706.69b1d2c0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100201075706.69b1d2c0.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Monday 01 February 2010, Andrew Morton wrote:
> On Mon, 1 Feb 2010 16:30:04 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Monday 01 February 2010, Sebastian Ott wrote:
> > > Hi Rafael,
> > > 
> > > since you didn't like the idea of calling the driver callbacks with just
> > > one cpu enabled, we gave your patch: "MM / PM: Force GFP_NOIO during
> > > suspend/hibernation and resume" a try and i can confirm that this
> > > fixes the issue on s390.
> > 
> > Great, thanks for testing!
> > 
> > > Will this go in 2.6.33/stable?
> > 
> > That depends on Andrew, actually.
> > 
> > Andrew, what do you think of the patch at:
> > http://patchwork.kernel.org/patch/74740/mbox/ ?
> > 
> > It helps people and I don't see any major drawbacks of it.
> > 
> 
> Seems sane.  A couple of minor things:
> 
> - the names mm_force_noio_allocations() and mm_allow_io_allocations()
>   are a bit sucky.  Asymmetrical.

Yeah.  The lack of imagination.  Sigh.

> - the functions don't nest: if someone calls
>   mm_force_noio_allocations() twice in succession then the kernel is
>   all mucked up.  Why not:
> 
> gfp_t mm_set_gfp_mask(gfp_t mask)
> {
> 	gfp_t ret = gfp_allowed_mask;
> 
> 	gfp_allowed_mask = mask;
> 	return ret;
> }
> 
> which is of course racy :)  Could add a local spinlock if really worried.

I'm not sure how that helps.  I'd need to read gfp_allowed_mask to obtain the
new value anyway.

> All your current callers can easily save the old value in a local.

Indeed.

Well, does the appended one look better?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: MM / PM: Force GFP_NOIO during suspend/hibernation and resume (rev. 2)

There are quite a few GFP_KERNEL memory allocations made during
suspend/hibernation and resume that may cause the system to hang,
because the I/O operations they depend on cannot be completed due to
the underlying devices being suspended.

Avoid this problem by clearing the __GFP_IO and __GFP_FS bits in
gfp_allowed_mask before suspend/hibernation and restoring the
original values of these bits in gfp_allowed_mask durig the
subsequent resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 include/linux/gfp.h      |    8 ++++++++
 kernel/power/hibernate.c |    9 +++++++++
 kernel/power/suspend.c   |    3 +++
 3 files changed, 20 insertions(+)

Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -323,6 +323,7 @@ static int create_image(int platform_mod
 int hibernation_snapshot(int platform_mode)
 {
 	int error;
+	gfp_t saved_mask;
 
 	error = platform_begin(platform_mode);
 	if (error)
@@ -334,6 +335,7 @@ int hibernation_snapshot(int platform_mo
 		goto Close;
 
 	suspend_console();
+	saved_mask = clear_gfp_allowed_mask(GFP_IOFS);
 	error = dpm_suspend_start(PMSG_FREEZE);
 	if (error)
 		goto Recover_platform;
@@ -351,6 +353,7 @@ int hibernation_snapshot(int platform_mo
 
 	dpm_resume_end(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
+	set_gfp_allowed_mask(saved_mask);
 	resume_console();
  Close:
 	platform_end(platform_mode);
@@ -445,14 +448,17 @@ static int resume_target_kernel(bool pla
 int hibernation_restore(int platform_mode)
 {
 	int error;
+	gfp_t saved_mask;
 
 	pm_prepare_console();
 	suspend_console();
+	saved_mask = clear_gfp_allowed_mask(GFP_IOFS);
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
 		dpm_resume_end(PMSG_RECOVER);
 	}
+	set_gfp_allowed_mask(saved_mask);
 	resume_console();
 	pm_restore_console();
 	return error;
@@ -466,6 +472,7 @@ int hibernation_restore(int platform_mod
 int hibernation_platform_enter(void)
 {
 	int error;
+	gfp_t saved_mask;
 
 	if (!hibernation_ops)
 		return -ENOSYS;
@@ -481,6 +488,7 @@ int hibernation_platform_enter(void)
 
 	entering_platform_hibernation = true;
 	suspend_console();
+	saved_mask = clear_gfp_allowed_mask(GFP_IOFS);
 	error = dpm_suspend_start(PMSG_HIBERNATE);
 	if (error) {
 		if (hibernation_ops->recover)
@@ -518,6 +526,7 @@ int hibernation_platform_enter(void)
  Resume_devices:
 	entering_platform_hibernation = false;
 	dpm_resume_end(PMSG_RESTORE);
+	set_gfp_allowed_mask(saved_mask);
 	resume_console();
 
  Close:
Index: linux-2.6/kernel/power/suspend.c
===================================================================
--- linux-2.6.orig/kernel/power/suspend.c
+++ linux-2.6/kernel/power/suspend.c
@@ -198,6 +198,7 @@ static int suspend_enter(suspend_state_t
 int suspend_devices_and_enter(suspend_state_t state)
 {
 	int error;
+	gfp_t saved_mask;
 
 	if (!suspend_ops)
 		return -ENOSYS;
@@ -208,6 +209,7 @@ int suspend_devices_and_enter(suspend_st
 			goto Close;
 	}
 	suspend_console();
+	saved_mask = clear_gfp_allowed_mask(GFP_IOFS);
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
@@ -224,6 +226,7 @@ int suspend_devices_and_enter(suspend_st
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
+	set_gfp_allowed_mask(saved_mask);
 	resume_console();
  Close:
 	if (suspend_ops->end)
Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
@@ -83,6 +83,7 @@ struct vm_area_struct;
 #define GFP_HIGHUSER_MOVABLE	(__GFP_WAIT | __GFP_IO | __GFP_FS | \
 				 __GFP_HARDWALL | __GFP_HIGHMEM | \
 				 __GFP_MOVABLE)
+#define GFP_IOFS	(__GFP_IO | __GFP_FS)
 
 #ifdef CONFIG_NUMA
 #define GFP_THISNODE	(__GFP_THISNODE | __GFP_NOWARN | __GFP_NORETRY)
@@ -342,4 +343,11 @@ static inline void set_gfp_allowed_mask(
 	gfp_allowed_mask = mask;
 }
 
+static inline gfp_t clear_gfp_allowed_mask(gfp_t mask)
+{
+	gfp_t ret = gfp_allowed_mask;
+	gfp_allowed_mask &= ~mask;
+	return ret;
+}
+
 #endif /* __LINUX_GFP_H */
