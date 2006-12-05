From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 23:18:17 +0100
Message-ID: <200612052318.18192.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612052203.43977.rjw@sisk.pl>
	<20061205221948.GA1723@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061205221948.GA1723@elf.ucw.cz>
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

On Tuesday, 5 December 2006 23:19, Pavel Machek wrote:
> Hi!
> 
> > > Actually, what do you think about this patch? It removes special
> > > handling of TASK_TRACED, and should do the trick, too...
> > > 
> > > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > > index 7bcc976..d56e494 100644
> > > --- a/kernel/power/process.c
> > > +++ b/kernel/power/process.c
> > > @@ -26,8 +26,7 @@ static inline int freezeable(struct task
> > >  	    (p->flags & PF_NOFREEZE) ||
> > >  	    (p->exit_state == EXIT_ZOMBIE) ||
> > >  	    (p->exit_state == EXIT_DEAD) ||
> > > -	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||
> > > -	    (p->state == TASK_STOPPED))
> > > +	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)))
> > 
> > ... with the exception that I haven't added the last line, since there's some
> > code in try_to_freeze_tasks() that does the same and better ...
> 
> > >  		return 0;
> > >  	return 1;
> > >  }
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > index 9a61944..e305ad1 100644
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -1702,7 +1702,9 @@ finish_stop(int stop_count)
> > >  		read_unlock(&tasklist_lock);
> > >  	}
> > >  
> > > -	schedule();
> > > +	do {
> > > +		schedule();
> > > +	} while (try_to_freeze());
> > >  	/*
> > >  	 * Now we don't run again until continued.
> > >  	 */
> > > 
> > > 
> > 
> > ... and it fails to freeze processes if there's a stopped task (to verify,
> > run vi, press ^Z, and try to suspend).
> 
> Huh, I thought I've tested that. Too bad, you are right.
> 
> > It happens because we shouldn't count the stopped task as freezeable any
> > more after we've set PF_FREEZE for it and we can fix that by adding
> > 
> > 	if (p->state == TASK_STOPPED && freezing(p))
> > 		continue;
> 
> No, I'd actually like to force stopped task into refrigerator.

Well, we'd have to send SIGCONT to them for this purpose and then stop them
back again during the resume.  Doesn't sound nice ...

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
