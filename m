From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Tue, 12 May 2009 18:52:36 +0200
Message-ID: <200905121852.37224.rjw__16224.0281737924$1242147324$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905120128.16780.rjw@sisk.pl>
	<20090511171111.9d74e4c0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090511171111.9d74e4c0.akpm@linux-foundation.org>
Content-Disposition: inline
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
Cc: kernel-testers@vger.kernel.org, mel@csn.ul.ie, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 May 2009, Andrew Morton wrote:
> On Tue, 12 May 2009 01:28:15 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Tuesday 12 May 2009, Andrew Morton wrote:
> > > On Tue, 12 May 2009 00:44:36 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > Which means this patch:
> > > > http://marc.info/?l=linux-kernel&m=124165031723627 (it also is my favourite
> > > > one).
> > > 
> > > ho hum, I could live with that ;)
> > > 
> > > Would it make sense to turn it into something more general?  Instead of
> > > "tasks_frozen/processes_are_frozen()", present it as
> > > "oom_killer_disabled/oom_killer_is_disabled()"?
> > > 
> > > That would invite other subsystems to use it, if they want to.  Which
> > > might well be a bad thing on their behalf, hard to say..
> > 
> > I chose the names this way because the variable is defined in the freezer code.
> > 
> > Alternatively, I can define one in page_alloc.c, add [disable|enable]_oom_killer()
> > for manipulating it and call them from the freezer code.  Do you think that
> > would be better?
> 
> The choice is:
> 
> a) put a general oom-killer interface function into the oom-killer
>    code, call that from swsusp.
> 
> b) put a swsusp-specific change into the oom-killer, call that from swsusp.
> 
> 
> From a cleanliess POV, a) is way better.  But it does need to be a
> general function!  If there's some hidden requirement which only makes
> the function applicable to swsusp, such as "all tasks must be frozen" then
> we'd be kidding ourselves by making it general-looking.

Hmm.  I guess there may be other situations in which it's better to fail
memory allocations than to kill tasks.

> I have a bad feeling that after one week and 12^17 emails, we're back
> to your original patch :)

Well, what about the following?

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: mm, PM/Freezer: Disable OOM killer when tasks are frozen

Currently, the following scenario appears to be possible in theory:
* Tasks are frozen for hibernation or suspend.
* Free pages are almost exhausted.
* Certain piece of code in the suspend code path attempts to allocate
  some memory using GFP_KERNEL and allocation order less than or
  equal to PAGE_ALLOC_COSTLY_ORDER.
* __alloc_pages_internal() cannot find a free page so it invokes the
  OOM killer.
* The OOM killer attempts to kill a task, but the task is frozen, so
  it doesn't die immediately.
* __alloc_pages_internal() jumps to 'restart', unsuccessfully tries
  to find a free page and invokes the OOM killer.
* No progress can be made.
Although it is now hard to trigger during hibernation due to the
memory shrinking carried out by the hibernation code, it is
theoretically possible to trigger during suspend after the memory
shrinking has been removed from that code path.  Moreover, since
memory allocations are going to be used for the hibernation memory
shrinking, it will be even more likely to happen during hibernation.

To prevent it from happening, introduce the oom_killer_disabled
switch that will cause __alloc_pages_internal() to fail in the
situations in which the OOM killer would have been called and make
the freezer set this switch after tasks have been successfully
frozen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/gfp.h    |   12 ++++++++++++
 kernel/power/process.c |    5 +++++
 mm/page_alloc.c        |    5 +++++
 3 files changed, 22 insertions(+)

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -175,6 +175,8 @@ static void set_pageblock_migratetype(st
 					PB_migrate, PB_migrate_end);
 }
 
+bool oom_killer_disabled __read_mostly;
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -1600,6 +1602,9 @@ nofail_alloc:
 		if (page)
 			goto got_pg;
 	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+		if (oom_killer_disabled)
+			goto nopage;
+
 		if (!try_set_zone_oom(zonelist, gfp_mask)) {
 			schedule_timeout_uninterruptible(1);
 			goto restart;
Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
@@ -245,4 +245,16 @@ void drain_zone_pages(struct zone *zone,
 void drain_all_pages(void);
 void drain_local_pages(void *dummy);
 
+extern bool oom_killer_disabled;
+
+static inline void disable_oom_killer(void)
+{
+	oom_killer_disabled = true;
+}
+
+static inline void enable_oom_killer(void)
+{
+	oom_killer_disabled = false;
+}
+
 #endif /* __LINUX_GFP_H */
Index: linux-2.6/kernel/power/process.c
===================================================================
--- linux-2.6.orig/kernel/power/process.c
+++ linux-2.6/kernel/power/process.c
@@ -117,9 +117,12 @@ int freeze_processes(void)
 	if (error)
 		goto Exit;
 	printk("done.");
+
+	disable_oom_killer();
  Exit:
 	BUG_ON(in_atomic());
 	printk("\n");
+
 	return error;
 }
 
@@ -145,6 +148,8 @@ static void thaw_tasks(bool nosig_only)
 
 void thaw_processes(void)
 {
+	enable_oom_killer();
+
 	printk("Restarting tasks ... ");
 	thaw_tasks(true);
 	thaw_tasks(false);
