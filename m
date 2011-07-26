From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: better oopsing when frozen
Date: Wed, 27 Jul 2011 00:24:11 +0200
Message-ID: <201107270024.11194.rjw__5315.04946197874$1311719142$gmane$org@sisk.pl>
References: <201107251043.19932.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107251043.19932.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, July 25, 2011, Oliver Neukum wrote:
> Hi Rafael,
> 
> I had a problem with the kernel stopping the machine forever because I got an
> oops while tasks were frozen. It seems to me that we should thaw when this
> happens. How about this approach?

Well, we do something like this already for the OOM killer (see
oom_killer_disable() and friends), so I think it would be better to
simply extend/modify that mechanism instead of adding a new one
doing almost exactly the same thing.

I have no complaints about adding thaw_in_oops(), though, so long as
Andrew thinks it makes sense.

Thanks,
Rafael 


> From 6f3b5e7a5c7ccf3564bdd2e703eba7eee753ecdc Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Fri, 22 Jul 2011 11:20:19 +0200
> Subject: [PATCH] unfreeze tasks if an oops happens while tasks are frozen
> 
> If an oops kills the task suspending or snapshotting
> is system, the system is dead because the action is
> never completed and the tasks never thawed.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  include/linux/freezer.h |    1 +
>  kernel/panic.c          |    2 ++
>  kernel/power/process.c  |   11 +++++++++++
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 1effc8b..9907cf6 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -50,6 +50,7 @@ extern int thaw_process(struct task_struct *p);
>  extern void refrigerator(void);
>  extern int freeze_processes(void);
>  extern void thaw_processes(void);
> +extern void thaw_in_oops(void);
>  
>  static inline int try_to_freeze(void)
>  {
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 6923167..255e662 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -23,6 +23,7 @@
>  #include <linux/init.h>
>  #include <linux/nmi.h>
>  #include <linux/dmi.h>
> +#include <linux/freezer.h>
>  
>  #define PANIC_TIMER_STEP 100
>  #define PANIC_BLINK_SPD 18
> @@ -355,6 +356,7 @@ void oops_exit(void)
>  	do_oops_enter_exit();
>  	print_oops_end_marker();
>  	kmsg_dump(KMSG_DUMP_OOPS);
> +	thaw_in_oops();
>  }
>  
>  #ifdef WANT_WARN_ON_SLOWPATH
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 0cf3a27..20994cd 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -22,6 +22,9 @@
>   */
>  #define TIMEOUT	(20 * HZ)
>  
> +/* in case we oops while processes are frozen */
> +static bool tasks_fozen = false;
> +
>  static inline int freezable(struct task_struct * p)
>  {
>  	if ((p == current) ||
> @@ -131,6 +134,7 @@ static int try_to_freeze_tasks(bool sig_only)
>  			elapsed_csecs % 100);
>  	}
>  
> +	tasks_fozen = (todo == 0);
>  	return todo ? -EBUSY : 0;
>  }
>  
> @@ -189,7 +193,14 @@ void thaw_processes(void)
>  	thaw_workqueues();
>  	thaw_tasks(true);
>  	thaw_tasks(false);
> +	tasks_fozen = false;
>  	schedule();
>  	printk("done.\n");
>  }
>  
> +void thaw_in_oops(void)
> +{
> +	if (tasks_fozen)
> +		thaw_processes();
> +}
> +
> 
