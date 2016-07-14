From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 14:55:49 -0700
Message-ID: <20160714215549.GC3057@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160713153910.GY4695@ubuntu>
 <20160714005524.GA517@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160714005524.GA517@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>
List-Id: linux-pm@vger.kernel.org

On 14-07-16, 09:55, Sergey Senozhatsky wrote:
> excessive printing is just part of the problem here. if we cab cond_resched()
> part of suspend/hibernation is cpu_down(), which lands in console_cpu_notify(),
> that does synchronous printing for every CPU taken down:
> 
> static int console_cpu_notify(struct notifier_block *self,
> 	unsigned long action, void *hcpu)
> {
> 	switch (action) {
> 	case CPU_ONLINE:
> 	case CPU_DEAD:
> 	case CPU_DOWN_FAILED:
> 	case CPU_UP_CANCELED:
> 		console_lock();
> 		console_unlock();
> 		^^^^^^^^^^^^^^
> 	}
> 	return NOTIFY_OK;
> }
> 
> console_unlock() is synchronous (I posted a very early draft patch that makes
> it asynchronous, but that's a future work). so if there is a ton of printk()-s,
> then console_unlock() will print it, 100% guaranteed. even if printk_kthread
> is doing the printing job at the moment, cpu down path will wait for it to
> stop, lock the console semaphore, and got to console_unlock() printing loop.

Hmm...

> in printk that you have posted, that will happen not only for CPU_DEAD,

It doesn't happen for CPU_DEAD right now as CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
isn't enabled in my setup.

> but for CPU_DYING as well (possibly, there is a /* invoked with preemption
> disabled, so defer */ comment, so may be you never endup doing direct
> printk there, but then you schedule a console_unlock() work).

-- 
viresh
