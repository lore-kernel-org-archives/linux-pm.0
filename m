From: Petr Mladek <pmladek@suse.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 15:56:40 +0200
Message-ID: <20160712135640.GB8597@pathway.suse.cz>
References: <20160701165959.GR12473@ubuntu>
 <2231804.EWgFb9e2VG@vostro.rjw.lan>
 <20160711224601.GJ4695@ubuntu>
 <2571775.VuqrgkDp1o@vostro.rjw.lan>
 <20160712130231.GM4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160712130231.GM4695@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2016-07-12 06:02:31, Viresh Kumar wrote:
> On 12-07-16, 14:24, Rafael J. Wysocki wrote:
> > On Monday, July 11, 2016 03:46:01 PM Viresh Kumar wrote:
> > > Yeah and I am not sure how should I go ahead about this issue now :)
> > 
> > FWIW, I think the reason why the "synchronous printk" works is because after
> > disabling the non-boot CPU, the only remaining one disables local interrupts
> > and won't do any async work any more until resume.
> 
> Right. After disabling interrupts, the other printk messages gets
> printed only after the system resumes. I am not that worried about
> printk not working after that point, but on how does asynchronous
> printing affect the system to crash or come to a complete hang?

Ah, I have missed that the hang happens only when you use the async
printk patchset.

I wonder if it is somehow related to the commit 8d91f8b15361dfb438ab
("printk: do cond_resched() between lines while outputting to
consoles"). A process (printk thread) might sleep with taken
console_sem. Then suspend_console() might be unable to
get the semaphore in console_lock() and might deadlock.

Does it help to enable "no_console_suspend" please?


Best Regards,
Petr
