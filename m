From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Quieten freezer if !CONFIG_PM_DEBUG.
Date: Sat, 21 Oct 2006 16:01:34 +0200
Message-ID: <200610211601.35277.rjw@sisk.pl>
References: <1161433364.7644.9.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <1161433364.7644.9.camel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, suspend2-devel <suspend2-devel@lists.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, 21 October 2006 14:22, Nigel Cunningham wrote:
> The freezing of processes is currently very noisy. This patch makes the
> noise dependant upon CONFIG_PM_DEBUG.

Well, I don't think it's _that_ noisy.  It only printks one character per
frozen task.

In fact I think it at least should print "Freezing processes" and "done"
messages.
 
> Prepared against current git.
>     
> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 29be608..6829612 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -15,6 +15,12 @@ #include <linux/module.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
>  
> +#ifdef CONFIG_PM_DEBUG
> +#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
> +#else
> +#define freezer_message(msg, a...) do { } while(0)
> +#endif
> +
>  /* 
>   * Timeout for stopping processes
>   */
> @@ -40,7 +46,7 @@ void refrigerator(void)
>  	long save;
>  	save = current->state;
>  	pr_debug("%s entered refrigerator\n", current->comm);
> -	printk("=");
> +	freezer_message("=");

I'd prefer to treat the pr_debug thing in a similar way, like
freezer_debug_message("%s entered refrigerator\n" ...).

Or better yet, I'd leave just one message like

freezer_print_task(current->comm);

instead of the two that will be defined to either printk the entire
"%s entered refrigerator\n", ... message or printk the "=" character or do
nothing, depending on a predefined verbosity level.

>  
>  	frozen_process(current);
>  	spin_lock_irq(&current->sighand->siglock);
> @@ -87,7 +93,7 @@ int freeze_processes(void)
>  	unsigned long start_time;
>  	struct task_struct *g, *p;
>  
> -	printk( "Stopping tasks: " );
> +	freezer_message( "Stopping tasks: " );

I wouldn't change this.

>  	start_time = jiffies;
>  	user_frozen = 0;
>  	do {
> @@ -135,7 +141,7 @@ int freeze_processes(void)
>  	 * but it cleans up leftover PF_FREEZE requests.
>  	 */
>  	if (todo) {
> -		printk( "\n" );
> +		freezer_message( "\n" );

Ditto.

>  		printk(KERN_ERR " stopping tasks timed out "
>  			"after %d seconds (%d tasks remaining):\n",
>  			TIMEOUT / HZ, todo);
> @@ -149,7 +155,7 @@ int freeze_processes(void)
>  		return todo;
>  	}
>  
> -	printk( "|\n" );
> +	freezer_message( "|\n" );

I'd call it freezer_print_finish(); and define to printk the "|\n" or do
nothing like for freezer_print_task().

>  	BUG_ON(in_atomic());
>  	return 0;
>  }
> @@ -158,18 +164,18 @@ void thaw_processes(void)
>  {
>  	struct task_struct *g, *p;
>  
> -	printk( "Restarting tasks..." );

I wouldn't change this.

> +	freezer_message( "Restarting tasks..." );
>  	read_lock(&tasklist_lock);
>  	do_each_thread(g, p) {
>  		if (!freezeable(p))
>  			continue;
>  		if (!thaw_process(p))
> -			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> +			freezer_message(KERN_INFO " Strange, %s not stopped\n", p->comm );
>  	} while_each_thread(g, p);
>  
>  	read_unlock(&tasklist_lock);
>  	schedule();
> -	printk( " done\n" );
> +	freezer_message( " done\n" );

Ditto.

>  }
>  
>  EXPORT_SYMBOL(refrigerator);
> 
> 
> -

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
