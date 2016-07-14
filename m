From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 09:55:24 +0900
Message-ID: <20160714005524.GA517@swordfish>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160713153910.GY4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32792 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbcGNAz0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 20:55:26 -0400
Content-Disposition: inline
In-Reply-To: <20160713153910.GY4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>

Hello,

On (07/13/16 08:39), Viresh Kumar wrote:
[..]
> Maybe not, as this can still lead to the original bug we were all
> chasing. This may hog some other CPU if we are doing excessive
> printing in suspend :(

excessive printing is just part of the problem here. if we cab cond_resched()
in console_unlock() (IOW, we execute console_unlock() with preemption and
interrupts enabled) then everything must be ok, and *from printing POV* there
is no difference whether it's printk_kthread or anything else in this case.
the difference jumps in when original console_unlock() is executed with
preemption/irq disabled, then offloading it to schedulable printk_kthread is
the right thing.

> suspend_console() is called quite early, so for example in my case we
> do lots of printing during suspend (not from the suspend thread, but
> an IRQ handled by the USB subsystem, which removes a bus with help of
> some other thread probably).

a silly question -- can we suspend consoles later?

part of suspend/hibernation is cpu_down(), which lands in console_cpu_notify(),
that does synchronous printing for every CPU taken down:

static int console_cpu_notify(struct notifier_block *self,
	unsigned long action, void *hcpu)
{
	switch (action) {
	case CPU_ONLINE:
	case CPU_DEAD:
	case CPU_DOWN_FAILED:
	case CPU_UP_CANCELED:
		console_lock();
		console_unlock();
		^^^^^^^^^^^^^^
	}
	return NOTIFY_OK;
}

console_unlock() is synchronous (I posted a very early draft patch that makes
it asynchronous, but that's a future work). so if there is a ton of printk()-s,
then console_unlock() will print it, 100% guaranteed. even if printk_kthread
is doing the printing job at the moment, cpu down path will wait for it to
stop, lock the console semaphore, and got to console_unlock() printing loop.

in printk that you have posted, that will happen not only for CPU_DEAD,
but for CPU_DYING as well (possibly, there is a /* invoked with preemption
disabled, so defer */ comment, so may be you never endup doing direct
printk there, but then you schedule a console_unlock() work).

> That is why my Hacky patch tried to do it after devices are removed
> and irqs are disabled, but before syscore users are suspended (and
> timekeeping is one of them). And so it fixes it for me completely.
> 
> IOW, we should switch back to synchronous printing after disabling
> interrupts on the last running CPU.
> 
> And I of course agree with Rafael that we would need something similar
> in Hibernation code path as well, if we choose to fix it my way.

suspend/hibernation/kexec - all covered by this patch.

	-ss
