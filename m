From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 14:24:47 +0200
Message-ID: <2571775.VuqrgkDp1o@vostro.rjw.lan>
References: <20160701165959.GR12473@ubuntu> <2231804.EWgFb9e2VG@vostro.rjw.lan> <20160711224601.GJ4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49024 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750945AbcGLMUE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 08:20:04 -0400
In-Reply-To: <20160711224601.GJ4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>

On Monday, July 11, 2016 03:46:01 PM Viresh Kumar wrote:
> On 12-07-16, 00:44, Rafael J. Wysocki wrote:
> > On Monday, July 11, 2016 03:35:01 PM Viresh Kumar wrote:
> > > Hi Sergey and Jan,
> > > 
> > > On 12-07-16, 00:44, Sergey Senozhatsky wrote:
> > > > right. apart from cases when the existing console_unlock() behaviour can
> > > > simply "block" a process to flush the log_buf to slow serial consoles
> > > > (regardless the  process execution context) and make the system less
> > > > responsive, I have around ~10 absolutely different scenarios on my list that
> > > > may cause soft/hard lockups, rcu stalls, oom-s, etc. and console_unlock() is
> > > > the root cause there. the simplest ones involve heavy printk() usage, the
> > > > trickier ones do not necessarily have anything that is abusing printk(): a
> > > > moderate printk() pressure coming from other CPUs on the system and more or
> > > > less active tty -> UART can do the trick, because uart interrupt service
> > > > routine and call_console_drivers()->write() have to compete for the same
> > > > uart port spin_lock. soft lockups are probably the most common problems,
> > > > though, it's not all that easy to catch, because watchdog does not ring
> > > > the bell straight after preempt_enable(), but from hrtimer interrupt, that
> > > > happens approx every 4 seconds. by this time CPU can be somewhere far away
> > > > from console_unlock(). I had an idea of doing watchdog soft lockup check
> > > > from preempt_enable(), when it brings preempt_count down to zero, but not
> > > > sure I can recall how well did it go.
> > > 
> > > Thanks for your feedback guys, and I have one more blocking issue
> > > where I need your help/advice.
> > > 
> > > So, the excess printing in our case is done in parallel to system
> > > suspend. And that can very much happen after all the non-boot CPUs are
> > > offlined.
> > > 
> > > Sometimes, the platform doesn't come back after suspend. I have tried
> > > enabling no-console-suspend and the last line it prints is:
> > > 
> > >         Disabling non-boot CPUs
> > > 
> > > And nothing after that at all. We have to forcefully reboot the phone
> > > after that. Moving the prints to they synchronous way (using
> > > echo 1 > /sys/module/printk/parameters/synchronous), fixes that issue.
> > 
> > But no_console_suspend is best-effort by design.
> 
> Yeah and I am not sure how should I go ahead about this issue now :)

FWIW, I think the reason why the "synchronous printk" works is because after
disabling the non-boot CPU, the only remaining one disables local interrupts
and won't do any async work any more until resume.

> > And *please* CC PM-related stuff to linux-pm.
> 
> Sure. I wasn't sure initially when this thread got started, that it is
> a PM related stuff and so didn't do it. As it was all about printk and
> hogging :)

But you started to talk about suspend/resume and such at one point and that
message should have been CCed to linux-pm.

And the reason why is because problems you see during suspend/resume may very
well be suspend-specific and not visible otherwise.  In which case you'll
likely need input from the people on linux-pm.

Thanks,
Rafael

