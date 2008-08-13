From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/5] Container Freezer: Implement freezer
	cgroup subsystem
Date: Wed, 13 Aug 2008 16:51:07 +0200
Message-ID: <200808131651.08681.rjw__35656.4774913297$1218651518$gmane$org@sisk.pl>
References: <20080811235323.872291138@us.ibm.com>
	<20080812155610.f4d40bb1.akpm@linux-foundation.org>
	<1218595088.19008.176.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1218595088.19008.176.camel@localhost.localdomain>
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, clg@fr.ibm.com, linux-pm@lists.linux-foundation.org, serue@us.ibm.com, Andrew Morton <akpm@linux-foundation.org>, menage@google.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, 13 of August 2008, Matt Helsley wrote:
> 
> On Tue, 2008-08-12 at 15:56 -0700, Andrew Morton wrote:
> > On Mon, 11 Aug 2008 16:53:26 -0700
> > Matt Helsley <matthltc@us.ibm.com> wrote:
> > 
> > > This patch implements a new freezer subsystem in the control groups framework.
> > > It provides a way to stop and resume execution of all tasks in a cgroup by
> > > writing in the cgroup filesystem.
> > > 
> > > The freezer subsystem in the container filesystem defines a file named
> > > freezer.state. Writing "FROZEN" to the state file will freeze all tasks in the
> > > cgroup. Subsequently writing "RUNNING" will unfreeze the tasks in the cgroup.
> > > Reading will return the current state.
> > > 
> > > * Examples of usage :
> > > 
> > >    # mkdir /containers/freezer
> > >    # mount -t cgroup -ofreezer freezer  /containers
> > >    # mkdir /containers/0
> > >    # echo $some_pid > /containers/0/tasks
> > > 
> > > to get status of the freezer subsystem :
> > > 
> > >    # cat /containers/0/freezer.state
> > >    RUNNING
> > > 
> > > to freeze all tasks in the container :
> > > 
> > >    # echo FROZEN > /containers/0/freezer.state
> > >    # cat /containers/0/freezer.state
> > >    FREEZING
> > >    # cat /containers/0/freezer.state
> > >    FROZEN
> > > 
> > > to unfreeze all tasks in the container :
> > > 
> > >    # echo RUNNING > /containers/0/freezer.state
> > >    # cat /containers/0/freezer.state
> > >    RUNNING
> > > 
> > > This is the basic mechanism which should do the right thing for user space task
> > > in a simple scenario.
> > > 
> > > It's important to note that freezing can be incomplete. In that case we return
> > > EBUSY. This means that some tasks in the cgroup are busy doing something that
> > > prevents us from completely freezing the cgroup at this time. After EBUSY,
> > > the cgroup will remain partially frozen -- reflected by freezer.state reporting
> > > "FREEZING" when read. The state will remain "FREEZING" until one of these
> > > things happens:
> > > 
> > > 	1) Userspace cancels the freezing operation by writing "RUNNING" to
> > > 		the freezer.state file
> > > 	2) Userspace retries the freezing operation by writing "FROZEN" to
> > > 		the freezer.state file (writing "FREEZING" is not legal
> > > 		and returns EIO)
> > > 	3) The tasks that blocked the cgroup from entering the "FROZEN"
> > > 		state disappear from the cgroup's set of tasks.
> > > 
> > > ...
> > 
> > Is a Documentation/ update planned?  Documentation/cgroups.txt might be
> > the place, or not.
> 
> I'll post a patch for that.
> 
> > > +
> > > +#ifdef CONFIG_CGROUP_FREEZER
> > > +SUBSYS(freezer)
> > > +#endif
> > > +
> > > +/* */
> > > Index: linux-2.6.27-rc1-mm1/include/linux/freezer.h
> > > ===================================================================
> > > --- linux-2.6.27-rc1-mm1.orig/include/linux/freezer.h
> > > +++ linux-2.6.27-rc1-mm1/include/linux/freezer.h
> > > @@ -47,22 +47,30 @@ static inline bool should_send_signal(st
> > >  /*
> > >   * Wake up a frozen process
> > >   *
> > > - * task_lock() is taken to prevent the race with refrigerator() which may
> > > + * task_lock() is needed to prevent the race with refrigerator() which may
> > >   * occur if the freezing of tasks fails.  Namely, without the lock, if the
> > >   * freezing of tasks failed, thaw_tasks() might have run before a task in
> > >   * refrigerator() could call frozen_process(), in which case the task would be
> > >   * frozen and no one would thaw it.
> > >   */
> > > -static inline int thaw_process(struct task_struct *p)
> > > +static inline int __thaw_process(struct task_struct *p)
> > >  {
> > > -	task_lock(p);
> > >  	if (frozen(p)) {
> > >  		p->flags &= ~PF_FROZEN;
> > > +		return 1;
> > > +	}
> > > +	clear_freeze_flag(p);
> > > +	return 0;
> > > +}
> > > +
> > > +static inline int thaw_process(struct task_struct *p)
> > > +{
> > > +	task_lock(p);
> > > +	if (__thaw_process(p) == 1) {
> > >  		task_unlock(p);
> > >  		wake_up_process(p);
> > >  		return 1;
> > >  	}
> > > -	clear_freeze_flag(p);
> > >  	task_unlock(p);
> > >  	return 0;
> > >  }
> > 
> > I wonder why these are inlined.
> 
> I wanted the changes to be obvious. I think uninlining this would be a
> separate improvement. I'll post a patch uninlining these.
> 
> > > @@ -83,6 +91,12 @@ static inline int try_to_freeze(void)
> > >  extern bool freeze_task(struct task_struct *p, bool sig_only);
> > >  extern void cancel_freezing(struct task_struct *p);
> > >  
> > > +#ifdef CONFIG_CGROUP_FREEZER
> > > +extern int cgroup_frozen(struct task_struct *task);
> > > +#else /* !CONFIG_CGROUP_FREEZER */
> > > +static inline int cgroup_frozen(struct task_struct *task) { return 0; }
> > > +#endif /* !CONFIG_CGROUP_FREEZER */
> > > +
> > >  /*
> > >   * The PF_FREEZER_SKIP flag should be set by a vfork parent right before it
> > >   * calls wait_for_completion(&vfork) and reset right after it returns from this
> > > Index: linux-2.6.27-rc1-mm1/init/Kconfig
> > > ===================================================================
> > > --- linux-2.6.27-rc1-mm1.orig/init/Kconfig
> > > +++ linux-2.6.27-rc1-mm1/init/Kconfig
> > > @@ -299,6 +299,13 @@ config CGROUP_NS
> > >            for instance virtual servers and checkpoint/restart
> > >            jobs.
> > >  
> > > +config CGROUP_FREEZER
> > > +        bool "control group freezer subsystem"
> > > +        depends on CGROUPS
> > 
> > Should it depend on FREEZER also?
> >
> > oh,
> > 
> > > --- linux-2.6.27-rc1-mm1.orig/kernel/power/Kconfig
> > > +++ linux-2.6.27-rc1-mm1/kernel/power/Kconfig
> > > @@ -86,7 +86,7 @@ config PM_SLEEP
> > >  	default y
> > >  
> > >  config FREEZER
> > > -	def_bool PM_SLEEP
> > > +	def_bool PM_SLEEP || CGROUP_FREEZER
> > >  
> > 
> > we did it that way.  Spose that makes sense.
> 
> 	I did consider a few alternatives for this. Makefile and cpp didn't
> seem as nice as this. "select" didn't fit. Using "depends on" does
> directly translate the build dependency. However I didn't think it would
> be clear to everyone configuring a kernel that they had to enable
> "FREEZER" before they could get PM_SLEEP or CGROUP_FREEZER.
> 
> 	Also, Rafael has asked to see this in a kernel/Kconfig file instead
> (see his reply to patch 2).

Yes, I have and there's a good reason for that IMO - you want FREEZER to be
used by architectures that don't include 'kernel/power/Kconfig', apparently.

Thanks,
Rafael
