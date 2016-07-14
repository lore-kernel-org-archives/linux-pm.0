From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 10:32:15 +0900
Message-ID: <20160714013215.GB517@swordfish>
References: <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160713153910.GY4695@ubuntu>
 <20160714005524.GA517@swordfish>
 <CAJZ5v0ggjER5soi35bvNHTxGLYK7pie_DxtZKQHSvdH6wFf9AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34441 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbcGNBcR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 21:32:17 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ggjER5soi35bvNHTxGLYK7pie_DxtZKQHSvdH6wFf9AA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Alex Elder <alex.elder@linaro.org>, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>, Petr Mladek <pmladek@suse.com>

On (07/14/16 03:09), Rafael J. Wysocki wrote:
> On Thu, Jul 14, 2016 at 2:55 AM, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> > Hello,
> >
> > On (07/13/16 08:39), Viresh Kumar wrote:
> > [..]
> >> Maybe not, as this can still lead to the original bug we were all
> >> chasing. This may hog some other CPU if we are doing excessive
> >> printing in suspend :(
> >
> > excessive printing is just part of the problem here. if we cab cond_resched()
> > in console_unlock() (IOW, we execute console_unlock() with preemption and
> > interrupts enabled) then everything must be ok, and *from printing POV* there
> > is no difference whether it's printk_kthread or anything else in this case.
> > the difference jumps in when original console_unlock() is executed with
> > preemption/irq disabled, then offloading it to schedulable printk_kthread is
> > the right thing.
> >
> >> suspend_console() is called quite early, so for example in my case we
> >> do lots of printing during suspend (not from the suspend thread, but
> >> an IRQ handled by the USB subsystem, which removes a bus with help of
> >> some other thread probably).
> >
> > a silly question -- can we suspend consoles later?
> 
> Not really and I'm not sure how that would help?

it wouldn't really, this silly question was not directly related to the
deadlock we are discussing here but to Viresh's argument that later stages
of suspending/hibernation seem to printk many messages in sync mode. so I
thought that there might be a small benefit in suspending consoles later,
as far as I understand, Viresh has `no_console_suspend' anyway. other
than that, I tend to stick to the approach of switching to sync mode from
suspend_console().

thanks for your late night reply!

	-ss
