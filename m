From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 18:22:50 +0100
Message-ID: <200612051822.50999.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612051526.56899.rjw@sisk.pl>
	<20061205152736.GA5029@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061205152736.GA5029@ucw.cz>
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

On Tuesday, 5 December 2006 16:27, Pavel Machek wrote:
> Hi!
> 
> > > >(2) the race between the delivery of
> > > > the continuation signal and the freezer is damn hard to trigger (still I think
> > > > I can wirte some artificial code that would trigger this, although it would
> > > > involve a kernel thread sending SIGCONT to a user space process - provided
> > > > it's permissible ;-)).
> > > 
> > > It is not really permissible, but I do not see how it would hurt...
> > > 
> > > With that patch, we put TASK_STOPPED tasks into refrigerator, along
> > > with everyone else. SIGCONT is *not* going to help them out of
> > > refrigerator.
> > > 
> > > We also ignore TASK_STOPPED now, so we'll not proceed until all
> > > stopped tasks are in refrigerator.
> > > 
> > > Now... I'm not 100% sure I got the ptrace() cases right (and did not
> > > test that)... but TASK_STOPPED cases look pretty trivial to me now.
> > 
> > Please note that currently (and with your patch) freezeable() returns 0 for
> 
> I cerainly wanted freezable to return 1 for TASK_STOPPED... and I
> think this part of my patch should be doing it...?
> 
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 7bcc976..d56e494 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c                                 
> @@ -26,8 +26,7 @@ static inline int freezeable(struct task
>             (p->flags & PF_NOFREEZE) ||
>             (p->exit_state == EXIT_ZOMBIE) ||
>             (p->exit_state == EXIT_DEAD) ||
> -           ((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||
> -           (p->state == TASK_STOPPED))
> +           ((p->exit_state == TASK_TRACED) && frozen(p->parent)))
>                 return 0;
>         return 1;
>  }

Ah, I didn't notice, sorry.

You should add
(p->exit_state == TASK_TRACED && p->parent->state == TASK_STOPPED) here
too, I think.

Also, have you verified that stopped tasks don't go to the refrigerator after
thaw_processes() is called?

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
