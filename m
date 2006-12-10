From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Sun, 10 Dec 2006 11:45:36 +0100
Message-ID: <200612101145.37342.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612091635.33455.rjw@sisk.pl>
	<200612100127.37288.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612100127.37288.rjw@sisk.pl>
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
To: suspend-devel@lists.sourceforge.net
Cc: Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 10 December 2006 01:27, Rafael J. Wysocki wrote:
> On Saturday, 9 December 2006 16:35, Rafael J. Wysocki wrote:
> > On Saturday, 9 December 2006 00:36, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > I wonder if we should start a test suite ;-).
> > > > > > 
> > > > > > > This means, however, that with this patch the behavior of a process (gdb)
> > > > > > > after the resume may be different to its normal behavior, which is wrong.
> > > > > > 
> > > > > > Yep.
> > > > 
> > > > Okay, I think I know what to do so that it works.  The above symptoms are not
> > > > present with the appended patch.
> > > 
> > > Looks good to me. Thanks for you work!
> > 
> > Well, there's still a race possible in there, if SIGCONT comes after we have
> > forced the SIGSTOP and before we call signal_wake_up().
> > 
> > I think we should force the SIGSTOP and call signal_wake_up() without
> > releasing the lock.  I'll try to do something along these lines later today.
> 
> I think something like the appended patch will do.
> 
> Greetings,
> Rafael
> 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/sched.h  |    1 +
>  kernel/power/process.c |   15 ++++++++-------
>  kernel/signal.c        |   16 +++++++++++++++-
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
> ===================================================================
> --- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-08 23:20:35.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-10 00:37:24.000000000 +0100
> @@ -28,8 +28,7 @@ static inline int freezeable(struct task
>  	if ((p == current) || 
>  	    (p->flags & PF_NOFREEZE) ||
>  	    (p->exit_state == EXIT_ZOMBIE) ||
> -	    (p->exit_state == EXIT_DEAD) ||
> -	    (p->state == TASK_STOPPED))
> +	    (p->exit_state == EXIT_DEAD))
>  		return 0;
>  	return 1;
>  }
> @@ -61,9 +60,13 @@ static inline void freeze_process(struct
>  	unsigned long flags;
>  
>  	if (!freezing(p)) {
> -		freeze(p);
>  		spin_lock_irqsave(&p->sighand->siglock, flags);
> -		signal_wake_up(p, 0);
> +		freeze(p);
> +		if (p->state == TASK_STOPPED) {
> +			force_sigstop_and_wake_up(p);
> +		} else {
> +			signal_wake_up(p, 0);
> +		}
>  		spin_unlock_irqrestore(&p->sighand->siglock, flags);
>  	}
>  }

Ah, freeze(p) need not be under the lock.

Besides, I'm now thinking the previous version is also correct, because even
if SIGCONT comes after we have forced SIGSTOP, it will remove the SIGSTOP
from the queue and the task's state will change to TASK_RUNNING, so the
next signal_wake_up() will do what it should.

I prefer that one, because it's shorter and doesn't affect sched.h. ;-)

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
