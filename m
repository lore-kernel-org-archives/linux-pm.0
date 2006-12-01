From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] ACPI vs device ordering on resume
Date: Fri, 1 Dec 2006 12:31:55 +0100
Message-ID: <200612011231.56703.rjw@sisk.pl>
References: <20061114153026.730deb94@freekitty> <200612011133.12332.rjw@sisk.pl> <20061201105740.GC1968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061201105740.GC1968@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 1 December 2006 11:57, Pavel Machek wrote:
> Hi!
> 
> > > > > So it looks like we need this sequence:
> > > > > 
> > > > > enable_nonboot_cpus() /* INIT */
> > > > > finish()	/* _WAK */
> > > > > device_resume()
> > > > 
> > > > Can somebody remind me about this immediately after 2.6.19?
> > > 
> > > Remind. But note that freezer is not yet SMP safe... Rafael is working
> > > on that.
> > 
> > Yup.
> > 
> > BTW, have you looked at the last version of the patch for the handling of
> > stopped tasks (appended just in case, full discussion at:
> > http://lists.osdl.org/pipermail/linux-pm/2006-November/004214.html)?
> 
> Well, I took a look.. and decided I'd like to find the place in kernel
> where I can add try_to_freeze() and fix the TASK_STOPPED processes. I
> hope such place exists.

Well, try_to_freeze() will only work for a process that has PF_FREEZE set, no?

So, if you want try_to_freeze() to work for a stopped process, you have to set
PF_FREEZE for this process, but this means that stopped processes cannot
be treated as unfreezeable ...

> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/process.c |   36 ++++++++++++++++++++++++++++++------
> >  kernel/signal.c        |    2 +-
> >  2 files changed, 31 insertions(+), 7 deletions(-)
> > 
> > Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
> > ===================================================================
> > --- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c
> > +++ linux-2.6.19-rc6-mm2/kernel/power/process.c
> > @@ -28,8 +28,7 @@ static inline int freezeable(struct task
> >  	if ((p == current) || 
> >  	    (p->flags & PF_NOFREEZE) ||
> >  	    (p->exit_state == EXIT_ZOMBIE) ||
> > -	    (p->exit_state == EXIT_DEAD) ||
> > -	    (p->state == TASK_STOPPED))
> > +	    (p->exit_state == EXIT_DEAD))

... so this change is _necessary_ anyway.

Now if we don't treat stopped processes as unfreezeable, it doesn't make
sense to set PF_FREEZE for them more than once.  This it's reasonable to
check if we have already set PF_FREEZE for given stopped task and skip it
if so ...

> >  		return 0;
> >  	return 1;
> >  }
> > @@ -81,6 +80,11 @@ static void cancel_freezing(struct task_
> >  	}
> >  }
> >  
> > +static inline int stopped_and_freezing(struct task_struct *p)
> > +{
> > +	return p->state == TASK_STOPPED && freezing(p);
> > +}
> > +
> >  static inline int is_user_space(struct task_struct *p)
> >  {
> >  	return p->mm && !(p->flags & PF_BORROWED_MM);
> > @@ -103,9 +107,11 @@ static unsigned int try_to_freeze_tasks(
> >  			if (frozen(p))
> >  				continue;
> >  
> > -			if (p->state == TASK_TRACED &&
> > -			    (frozen(p->parent) ||
> > -			     p->parent->state == TASK_STOPPED)) {
> > +			if (stopped_and_freezing(p))
> > +				continue;

... which is done here.

Now the condition for the freezing of traced tasks should be modified to
account for the fact that we no longer regard stopped tasks as unfreezeable ...

> > +
> > +			if (p->state == TASK_TRACED && (frozen(p->parent) ||
> > +			    stopped_and_freezing(p->parent))) {

... so we need this change too.

> >  				cancel_freezing(p);
> >  				continue;
> >  			}
> > @@ -149,7 +155,8 @@ static unsigned int try_to_freeze_tasks(
> >  			if (is_user_space(p) == !freeze_user_space)
> >  				continue;
> >  
> > -			if (freezeable(p) && !frozen(p))
> > +			if (freezeable(p) && !frozen(p) &&
> > +			    p->state != TASK_STOPPED && p->state != TASK_TRACED)
> >  				printk(KERN_ERR " %s\n", p->comm);

Now if the freezing of tasks fails, we don't want to confuse the user by
reporting that some stopped or traced tasks weren't frozen, so it's reasonable
to do the above, but it's really optional.

> >  
> >  			cancel_freezing(p);
> > @@ -185,6 +192,18 @@ int freeze_processes(void)
> >  	return 0;
> >  }
> >  
> > +static void release_stopped_tasks(void)
> > +{
> > +	struct task_struct *g, *p;
> > +
> > +	read_lock(&tasklist_lock);
> > +	do_each_thread(g, p) {
> > +		if (stopped_and_freezing(p))
> > +			cancel_freezing(p);
> > +	} while_each_thread(g, p);
> > +	read_unlock(&tasklist_lock);
> > +}
> > +
> >  static void thaw_tasks(int thaw_user_space)
> >  {
> >  	struct task_struct *g, *p;
> > @@ -197,6 +216,10 @@ static void thaw_tasks(int thaw_user_spa
> >  		if (is_user_space(p) == !thaw_user_space)
> >  			continue;
> >  
> > +		if (!frozen(p) &&
> > +		    (p->state == TASK_STOPPED || p->state == TASK_TRACED))
> > +			continue;
> > +

Again, we shouldn't be confusing the user by reporting that some stopped
or traced tasks didn't stop, because that's likely a normal thing ... 

> >  		if (!thaw_process(p))
> >  			printk(KERN_WARNING " Strange, %s not stopped\n",
> >  				p->comm );
> > @@ -207,6 +230,7 @@ static void thaw_tasks(int thaw_user_spa
> >  void thaw_processes(void)
> >  {
> >  	printk("Restarting tasks ... ");
> > +	release_stopped_tasks();

... but we need this in case there are some stopped tasks for which we set
PF_FREEZE during the suspend and they haven't entered the refrigerator
(eg. because they haven't received the continuation signal in the meantime).

This also is a consequence of the fact that we don't regard the stopped tasks
as unfreezeable.

> >  	thaw_tasks(FREEZER_KERNEL_THREADS);
> >  	thaw_tasks(FREEZER_USER_SPACE);
> >  	schedule();
> > Index: linux-2.6.19-rc6-mm2/kernel/signal.c
> > ===================================================================
> > --- linux-2.6.19-rc6-mm2.orig/kernel/signal.c
> > +++ linux-2.6.19-rc6-mm2/kernel/signal.c
> > @@ -1937,9 +1937,9 @@ int get_signal_to_deliver(siginfo_t *inf
> >  	sigset_t *mask = &current->blocked;
> >  	int signr = 0;
> >  
> > +relock:
> >  	try_to_freeze();
> >  
> > -relock:
> >  	spin_lock_irq(&current->sighand->siglock);
> >  	for (;;) {
> >  		struct k_sigaction *ka;

And this makes stopped tasks that have just received the continuation signal
to immediately check if they should go to the refrigerator.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
