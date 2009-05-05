From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Mon, 4 May 2009 17:37:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905041735590.24101__45592.0456712649$1241484068$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905042151.07953.rjw@sisk.pl>
	<alpine.DEB.2.00.0905041253380.23036@chino.kir.corp.google.com>
	<200905050023.38064.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905050023.38064.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 5 May 2009, Rafael J. Wysocki wrote:

> Index: linux-2.6/kernel/power/process.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/process.c
> +++ linux-2.6/kernel/power/process.c
> @@ -19,6 +19,8 @@
>   */
>  #define TIMEOUT	(20 * HZ)
>  
> +static bool tasks_frozen;
> +
>  static inline int freezeable(struct task_struct * p)
>  {
>  	if ((p == current) ||
> @@ -120,6 +122,10 @@ int freeze_processes(void)
>   Exit:
>  	BUG_ON(in_atomic());
>  	printk("\n");
> +
> +	if (!error)
> +		tasks_frozen = true;
> +
>  	return error;
>  }
>  
> @@ -145,6 +151,8 @@ static void thaw_tasks(bool nosig_only)
>  
>  void thaw_processes(void)
>  {
> +	tasks_frozen = false;
> +
>  	printk("Restarting tasks ... ");
>  	thaw_tasks(true);
>  	thaw_tasks(false);
> @@ -152,3 +160,7 @@ void thaw_processes(void)
>  	printk("done.\n");
>  }
>  
> +bool processes_are_frozen(void)
> +{
> +	return tasks_frozen;
> +}
> Index: linux-2.6/include/linux/freezer.h
> ===================================================================
> --- linux-2.6.orig/include/linux/freezer.h
> +++ linux-2.6/include/linux/freezer.h
> @@ -50,6 +50,7 @@ extern int thaw_process(struct task_stru
>  extern void refrigerator(void);
>  extern int freeze_processes(void);
>  extern void thaw_processes(void);
> +extern bool processes_are_frozen(void);
>  
>  static inline int try_to_freeze(void)
>  {
> @@ -170,6 +171,7 @@ static inline int thaw_process(struct ta
>  static inline void refrigerator(void) {}
>  static inline int freeze_processes(void) { BUG(); return 0; }
>  static inline void thaw_processes(void) {}
> +static inline bool processes_are_frozen(void) { return false; }
>  
>  static inline int try_to_freeze(void) { return 0; }
>  
> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -46,6 +46,7 @@
>  #include <linux/page-isolation.h>
>  #include <linux/page_cgroup.h>
>  #include <linux/debugobjects.h>
> +#include <linux/freezer.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -1599,7 +1600,8 @@ nofail_alloc:
>  					zonelist, high_zoneidx, alloc_flags);
>  		if (page)
>  			goto got_pg;
> -	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
> +	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)
> +			&& !processes_are_frozen()) {
>  		if (!try_set_zone_oom(zonelist, gfp_mask)) {
>  			schedule_timeout_uninterruptible(1);
>  			goto restart;

Cool, that looks like the semantics of __GFP_NO_OOM_KILL without requiring 
a new gfp flag.  Thanks.
