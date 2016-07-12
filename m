From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 06:12:04 -0700
Message-ID: <20160712131203.GN4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712093805.GA498@swordfish>
 <20160712125243.GA8597@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160712125243.GA8597@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, rjw@rjwysocki.net
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

+Rafael and linux-pm to this thread :)

On 12-07-16, 14:52, Petr Mladek wrote:
> On Tue 2016-07-12 18:38:05, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > On (07/11/16 15:35), Viresh Kumar wrote:
> > [..]
> > > Sometimes, the platform doesn't come back after suspend. I have tried
> > > enabling no-console-suspend and the last line it prints is:
> > > 
> > >         Disabling non-boot CPUs
> 
> I guess that the printk() kthread is not longer scheduled when there
> is only one CPU left.

Yeah, so I tried debugging this more and I am able to get printing
done to just before arch_suspend_disable_irqs() in suspend.c and then
it stops because of the async nature.

I get to this point for both successful suspend/resume (where system
resumes back successfully) and in the bad case (where the system just
hangs/crashes).

FWIW, I also tried commenting out following in suspend_enter():

        error = suspend_ops->enter(state);

so that the system doesn't go into suspend at all, and just resume
back immediately (similar to TEST_CORE) and I saw the hang/crash then
as well one of the times.

> We might try to explicitly flush the consoles in suspend_console().

That wouldn't happen as I have disabled console-suspend.

> But I am not sure if we always want to do so because it might take
> a while. Also it need not help if someone already owns the
> console_sem. Note the console_unlock() calls the cond_resched()
> when in safe context.
> 
> Well, we might do the best effort when no_console_suspend is enabled.

Hmm.. I have no reasoning yet on why the system comes to a complete
stop and a forceful reboot only makes it work :(

-- 
viresh
