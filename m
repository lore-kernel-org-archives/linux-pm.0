From: yalin wang <yalin.wang2010@gmail.com>
Subject: Re: [PATCH 1/3] power, vfs: move away from PF_KTHREAD freezing in favor of fs freezing
Date: Mon, 2 Nov 2015 15:54:47 +0800
Message-ID: <F50CC49E-C818-4631-AFB1-25A6EDC09BB0@gmail.com>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz> <alpine.LNX.2.00.1510301439080.17538@pobox.suse.cz>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1510301439080.17538@pobox.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> On Oct 30, 2015, at 21:47, Jiri Kosina <jikos@kernel.org> wrote:
> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Freeze all filesystems during hibernation in favor of dropping kthread
> freezing completely.
> 
> Kthread freezing has a history of not very well defined semantics.
> Historically, it has been established to make sure that kthreads which are
> helpers to writing out data to disk are frozen during hibernation at
> well-defined state, so that it's guaranteed that they freeze only after all the
> outstanding I/O made it to disk (userspace has already been frozen by that
> time, so there is no new I/O being issued).
> 
> One of the issues with kthread freezer is that the places where try_to_freeze()
> is called in kthreads is rather random / arbitrary. This stems mostly from
> the fact that there is actually no good definition / list of requirements
> that should be enforced on a frozen kthread (it's important to mention that
> frozen kthread for example doesn't automatically imply that everything that
> has been spawned asynchronously from it (such as timers) is stopped as well).
> 
> Basically the main argument why kthread freezer is not needed boils down to
> this: the only facility that is needed during suspend: "no persistent fs
> changes are allowed from now on".
> 
> 	- this is something we get from fs freezing for free
> 	- Why do we issue all those try_to_freeze() calls in kthreads that
> 	  don't generate any I/O themselves at all?
> 	- Why do we issue all those try_to_freeze() calls in kthreads that
> 	  are actual I/O helpers? (if there is outstanding I/O, we *want*
> 	  it to happen before hibernating).
> 
> This patch removes freezing of kthreads during suspend, and issues a global
> filesystem freeze instead.
> 
> We awoid freezing in-memory filesystems, because (a) they end up in the
> image in a consistent state anyway (b) we will deadlock, as write to
> /sys/power/state would never succeed.
> 
> The patch could have been made a bit nicer if generic iterate_supers()
> could be used, but the locking (especially s_umount semantics) would have to
> be redone, so that'd be something to postpone for later.
> Also, the 'skip_virtual' flag is superfluous for now (as hibernation is the
> only user of this facility for the time being), but I'd like to keep it
> there to avoid further confusion regarding the fact that freeze_all_supers()
> actually skips in-memory filesystems.
> 
> Based on prior work done by Rafael Wysocki.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> drivers/xen/manage.c     |  6 ----
> fs/super.c               | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
> include/linux/freezer.h  |  2 --
> include/linux/fs.h       |  2 ++
> kernel/power/hibernate.c |  5 ---
> kernel/power/power.h     | 20 +-----------
> kernel/power/process.c   | 63 +++++++++---------------------------
> kernel/power/user.c      |  9 ------
> 8 files changed, 103 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index e12bd36..d47716a 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -109,12 +109,6 @@ static void do_suspend(void)
> 		goto out;
> 	}
> 
> -	err = freeze_kernel_threads();
> -	if (err) {
> -		pr_err("%s: freeze kernel threads failed %d\n", __func__, err);
> -		goto out_thaw;
> -	}
> -
> 	err = dpm_suspend_start(PMSG_FREEZE);
> 	if (err) {
> 		pr_err("%s: dpm_suspend_start %d\n", __func__, err);
> diff --git a/fs/super.c b/fs/super.c
> index 954aeb8..b7cb50f 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1373,3 +1373,87 @@ out:
> 	return 0;
> }
> EXPORT_SYMBOL(thaw_super);
> +
> +static bool super_should_freeze(struct super_block *sb, bool skip_virtual)
> +{
> +	if (!sb->s_root)
> +		return false;
> +	if (!(sb->s_flags & MS_BORN))
> +		return false;
> +	/* Should we freeze virtual filesystems? */
> +	if (sb->s_bdi == &noop_backing_dev_info && skip_virtual)
> +		return false;
> +	/* No need to freeze read-only filesystems */
> +	if (sb->s_flags & MS_RDONLY)
> +		return false;
> +	return true;
> +}
> +
> +/**
> + * freeze_all_supers -- iterate through all filesystems and freeze them
> + * @skip_virtual: should those with no backing device be skipped?
> + *
> + * Iterate over all superblocks and call freeze_super() for them. Some
> + * use-cases (such as freezer) might want to have to skip those which
> + * don't have any backing bdev.
> + *
> + */
> +int freeze_all_supers(bool skip_virtual)
> +{
> +	struct super_block *sb, *p = NULL;
> +	int error = 0;
> +
> +	spin_lock(&sb_lock);
> +	/*
> +	 * The list of super-blocks is iterated in a reverse order so that
> +	 * inter-dependencies (such as loopback devices) are handled in
> +	 * a non-deadlocking order
> +	 */
> +	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
> +		if (hlist_unhashed(&sb->s_instances))
> +			continue;
> +		sb->s_count++;
> +
> +		spin_unlock(&sb_lock);
> +		if (super_should_freeze(sb, skip_virtual)) {
> +			error = freeze_super(sb);
> +			if (error) {
> +				spin_lock(&sb_lock);
> +				break;
> +			}
> +		}
> +		spin_lock(&sb_lock);
> +
> +		if (p)
> +			__put_super(p);
> +		p = sb;
> +	}
> +	if (p)
> +		__put_super(p);
> +	spin_unlock(&sb_lock);
> +
> +	return error;
> +}
> +
> +void thaw_all_supers(void)
> +{
> +	struct super_block *sb, *p = NULL;
> +
> +	spin_lock(&sb_lock);
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		if (hlist_unhashed(&sb->s_instances))
> +			continue;
> +		sb->s_count++;
> +
> +		spin_unlock(&sb_lock);
> +		thaw_super(sb);
> +		spin_lock(&sb_lock);
> +
> +		if (p)
> +			__put_super(p);
> +		p = sb;
> +	}
> +	if (p)
> +		__put_super(p);
> +	spin_unlock(&sb_lock);
> +}
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 6b7fd9c..81335f6 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -43,9 +43,7 @@ extern void __thaw_task(struct task_struct *t);
> 
> extern bool __refrigerator(bool check_kthr_stop);
> extern int freeze_processes(void);
> -extern int freeze_kernel_threads(void);
> extern void thaw_processes(void);
> -extern void thaw_kernel_threads(void);
> 
> /*
>  * DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 72d8a84..8ef2605 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2029,6 +2029,8 @@ extern int fd_statfs(int, struct kstatfs *);
> extern int vfs_ustat(dev_t, struct kstatfs *);
> extern int freeze_super(struct super_block *super);
> extern int thaw_super(struct super_block *super);
> +extern int freeze_all_supers(bool);
> +extern void thaw_all_supers(void);
> extern bool our_mnt(struct vfsmount *mnt);
> 
> extern int current_umask(void);
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 690f78f..d5c36bb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -348,10 +348,6 @@ int hibernation_snapshot(int platform_mode)
> 	if (error)
> 		goto Close;
> 
> -	error = freeze_kernel_threads();
> -	if (error)
> -		goto Cleanup;
> -
> 	if (hibernation_test(TEST_FREEZER)) {
> 
> 		/*
> @@ -402,7 +398,6 @@ int hibernation_snapshot(int platform_mode)
> 	return error;
> 
>  Thaw:
> -	thaw_kernel_threads();
>  Cleanup:
> 	swsusp_free();
> 	goto Close;
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index caadb56..4c3267f 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -224,25 +224,7 @@ extern int pm_test_level;
> #ifdef CONFIG_SUSPEND_FREEZER
> static inline int suspend_freeze_processes(void)
> {
> -	int error;
> -
> -	error = freeze_processes();
> -	/*
> -	 * freeze_processes() automatically thaws every task if freezing
> -	 * fails. So we need not do anything extra upon error.
> -	 */
> -	if (error)
> -		return error;
> -
> -	error = freeze_kernel_threads();
> -	/*
> -	 * freeze_kernel_threads() thaws only kernel threads upon freezing
> -	 * failure. So we have to thaw the userspace tasks ourselves.
> -	 */
> -	if (error)
> -		thaw_processes();
> -
> -	return error;
> +	return freeze_processes();
> }
> 
> static inline void suspend_thaw_processes(void)
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 564f786..b1ad215 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -17,6 +17,7 @@
> #include <linux/delay.h>
> #include <linux/workqueue.h>
> #include <linux/kmod.h>
> +#include <linux/fs.h>
> #include <trace/events/power.h>
> 
> /* 
> @@ -140,6 +141,17 @@ int freeze_processes(void)
> 	pr_cont("\n");
> 	BUG_ON(in_atomic());
> 
> +	pr_info("Freezing filesystems ... ");
> +
> +	error = freeze_all_supers(true);
> +	if (error) {
> +		pr_cont("failed.\n");
> +		thaw_processes();
> +		return error;
> +	}
> +
> +	pr_cont("done.\n");
> +
> 	/*
> 	 * Now that the whole userspace is frozen we need to disbale
> 	 * the OOM killer to disallow any further interference with
> @@ -148,35 +160,10 @@ int freeze_processes(void)
> 	if (!error && !oom_killer_disable())
> 		error = -EBUSY;
> 
> -	if (error)
> +	if (error) {
> 		thaw_processes();
> -	return error;
> -}
> -
> -/**
> - * freeze_kernel_threads - Make freezable kernel threads go to the refrigerator.
> - *
> - * On success, returns 0.  On failure, -errno and only the kernel threads are
> - * thawed, so as to give a chance to the caller to do additional cleanups
> - * (if any) before thawing the userspace tasks. So, it is the responsibility
> - * of the caller to thaw the userspace tasks, when the time is right.
> - */
> -int freeze_kernel_threads(void)
> -{
> -	int error;
> -
> -	pr_info("Freezing remaining freezable tasks ... ");
> -
> -	pm_nosig_freezing = true;
> -	error = try_to_freeze_tasks(false);
> -	if (!error)
> -		pr_cont("done.");
> -
> -	pr_cont("\n");
> -	BUG_ON(in_atomic());
> -
> -	if (error)
> -		thaw_kernel_threads();
> +		thaw_all_supers();
> +	}
> 	return error;
> }
> 
> @@ -197,6 +184,7 @@ void thaw_processes(void)
> 
> 	__usermodehelper_set_disable_depth(UMH_FREEZING);
> 	thaw_workqueues();
> +	thaw_all_supers();
> 
> 	read_lock(&tasklist_lock);
> 	for_each_process_thread(g, p) {
> @@ -216,22 +204,3 @@ void thaw_processes(void)
> 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
> }
> 
> -void thaw_kernel_threads(void)
> -{
> -	struct task_struct *g, *p;
> -
> -	pm_nosig_freezing = false;
> -	pr_info("Restarting kernel threads ... ");
> -
> -	thaw_workqueues();
> -
> -	read_lock(&tasklist_lock);
> -	for_each_process_thread(g, p) {
> -		if (p->flags & (PF_KTHREAD | PF_WQ_WORKER))
> -			__thaw_task(p);
> -	}
> -	read_unlock(&tasklist_lock);
> -
> -	schedule();
> -	pr_cont("done.\n");
> -}
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 526e891..75771c0 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -275,15 +275,6 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
> 		swsusp_free();
> 		memset(&data->handle, 0, sizeof(struct snapshot_handle));
> 		data->ready = false;
> -		/*
> -		 * It is necessary to thaw kernel threads here, because
> -		 * SNAPSHOT_CREATE_IMAGE may be invoked directly after
> -		 * SNAPSHOT_FREE.  In that case, if kernel threads were not
> -		 * thawed, the preallocation of memory carried out by
> -		 * hibernation_snapshot() might run into problems (i.e. it
> -		 * might fail or even deadlock).
> -		 */
> -		thaw_kernel_threads();
> 		break;
> 
> 	case SNAPSHOT_PREF_IMAGE_SIZE:
> -- 
> 1.9.2
do you test your patch on kthread_bind()  kernel thread ?
if you remove freeze_kernel_threads() function,
this means lots of pthread will be running status during suspend .
will have problem for bind thread , these thread will be migrate to other 
CPU , will have problem running code on other CPU, another problems is 
that the cpu_allowed_ptr is changed and will never be restore to original CPU mask .
this is not unsafe .
for example, if there is a thread like this :

kthread_bind()
while (!pthread_should_stop())
{
	do_something();

	try_to_freeze();
}

if remove try_to_freeze() , this thread maybe migrate to other CPU if the thread is running .
freeze kernel thread can make sure lots of kernel thread are not in runq during suspend ,
then we can avoid task migration.

Thanks
















