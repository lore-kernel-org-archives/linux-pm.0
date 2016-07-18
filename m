From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Mon, 18 Jul 2016 13:49:38 +0200
Message-ID: <3133978.fMIgBtHcyP@vostro.rjw.lan>
References: <20160701165959.GR12473@ubuntu> <20160714221251.GE3057@ubuntu> <20160718110134.GB6782@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57421 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751013AbcGRLoq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 07:44:46 -0400
In-Reply-To: <20160718110134.GB6782@quack2.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>

On Monday, July 18, 2016 01:01:34 PM Jan Kara wrote:
> On Thu 14-07-16 15:12:51, Viresh Kumar wrote:
> > On 14-07-16, 16:12, Jan Kara wrote:
> > > Exactly. Calling printk() from certain parts of the kernel (like scheduler
> > > code or timer code) has been always unsafe because printk itself uses these
> > > parts and so it can lead to deadlocks. That's why printk_deffered() has
> > > been introduced as you mention below.
> > > 
> > > And with sync printk the above deadlock doesn't trigger only by chance - if
> > > there happened to be a waiter on console_sem while we suspend, the same
> > > deadlock would trigger because up(&console_sem) will try to wake him up and
> > > the warning in timekeeping code will cause recursive printk.
> > > 
> > > So I think your patch doesn't really address the real issue - it only
> > > works around the particular WARN_ON(timekeeping_enabled) warning but if
> > > there was a different warning in timekeeping code which would trigger, it
> > > has a potential for causing recursive printk deadlock (and indeed we had
> > > such issues previously - see e.g. 504d58745c9c "timer: Fix lock inversion
> > > between hrtimer_bases.lock and scheduler locks").
> > > 
> > > So there are IMHO two issues here worth looking at:
> > > 
> > > 1) I didn't find how a wakeup would would lead to calling to ktime_get() in
> > > the current upstream kernel or even current RT kernel. Maybe this is a
> > > problem specific to the 3.10 kernel you are using? If yes, we don't have to
> > > do anything for current upstream AFAIU.
> > 
> > I haven't checked that earlier, but I see the path in both 3.10 and mainline.
> > 
> > vprintk_emit
> >  -> wake_up_process
> >   -> try_to_wake_up
> >    -> ttwu_queue
> >     -> ttwu_do_activate
> >      -> ttwu_activate
> >       -> activate_task
> >        -> enqueue_task (sched/core.c)
> >         -> enqueue_task_rt (rt.c)
> >          -> enqueue_rt_entity
> >           -> __enqueue_rt_entity
> >            -> inc_rt_tasks
> >             -> inc_rt_group
> >              -> start_rt_bandwidth
> >               -> start_bandwidth_timer
> >                -> __hrtimer_start_range_ns
> >                 -> ktime_get()
> 
> Yeah, you are right.
> 
> > > If I just missed how wakeup can call into ktime_get() in current upstream,
> > > there is another question:
> > > 
> > > 2) Is it OK that printk calls wakeup so late during suspend?
> > 
> > To clarify again to everybody, we are talking about the place where all
> > non-boot CPUs are already hot-unplugged and the last running one has
> > disabled interrupts.
> > 
> > I believe that we can't do migration at all now, right? What will we get by
> > calling wake_up_process() now anyway ?
> 
> As I already wrote to Rafael, wake_up_process() will change the process
> state to TASK_RUNNING so that it can run after we resume from suspend.
> 
> But seeing that the same problem is in upstream I guess what Sergey did
> makes more sense if it works for you. If Sergey's fix does not work for you
> due to too many messages being printed during device suspend, then we will
> have to try something else...

Which is exactly my point. :-)

Thanks,
Rafael

