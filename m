From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 23:45:28 +0100
Message-ID: <200612052345.28882.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612052203.43977.rjw@sisk.pl>
	<20061205223634.GA2642@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061205223634.GA2642@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 5 December 2006 23:36, Pavel Machek wrote:
> Hi!
> 
> > ... and it fails to freeze processes if there's a stopped task (to verify,
> > run vi, press ^Z, and try to suspend).
> 
> Ok, here's better version. (Notice it only differs by one bit ;-).
> 
> Ok, something is still weird. Bash reports spurious...
> 
> [2]+  Stopped                 vi
> 
> ...after resume.

This is because of how signal_wake_up() works, I think..

> But I think it is right approach.

Fine by me with a couple of remarks below.

> We want to store all the tasks in refrigerator.
> 								Pavel
> 
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 7bcc976..9849d88 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -26,8 +26,7 @@ static inline int freezeable(struct task
>  	    (p->flags & PF_NOFREEZE) ||
>  	    (p->exit_state == EXIT_ZOMBIE) ||
>  	    (p->exit_state == EXIT_DEAD) ||
> -	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||
> -	    (p->state == TASK_STOPPED))
> +	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)))

This doesn't apply to -mm as well as to -stable, -git, whatever.  There's no

((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||

line here in any of these kernels.  Instead, there is a check in
try_to_freeze_tasks() that does this.

>  		return 0;
>  	return 1;
>  }
> @@ -62,7 +61,7 @@ static inline void freeze_process(struct
>  	if (!freezing(p)) {
>  		freeze(p);
>  		spin_lock_irqsave(&p->sighand->siglock, flags);
> -		signal_wake_up(p, 0);
> +		signal_wake_up(p, 1);

Do we want traced tasks to get kicked here?  If not, we'd have to write our
own signal_wake_up() (no big deal, I think) or modify the existing one to be
able to kick TASK_STOPPED without kicking TASK_TRACED.

>  		spin_unlock_irqrestore(&p->sighand->siglock, flags);
>  	}
>  }
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9a61944..e305ad1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1702,7 +1702,9 @@ finish_stop(int stop_count)
>  		read_unlock(&tasklist_lock);
>  	}
>  
> -	schedule();
> +	do {
> +		schedule();
> +	} while (try_to_freeze());
>  	/*
>  	 * Now we don't run again until continued.
>  	 */

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
