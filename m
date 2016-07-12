From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 07:04:28 -0700
Message-ID: <20160712140428.GS4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <2231804.EWgFb9e2VG@vostro.rjw.lan>
 <20160711224601.GJ4695@ubuntu>
 <2571775.VuqrgkDp1o@vostro.rjw.lan>
 <20160712130231.GM4695@ubuntu>
 <20160712135640.GB8597@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34008 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbcGLOEb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 10:04:31 -0400
Received: by mail-pf0-f177.google.com with SMTP id h14so7330255pfe.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2016 07:04:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160712135640.GB8597@pathway.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>

On 12-07-16, 15:56, Petr Mladek wrote:
> Ah, I have missed that the hang happens only when you use the async
> printk patchset.

And that also doesn't happen always, but only sometimes. So there is a
race somewhere I feel :)

> I wonder if it is somehow related to the commit 8d91f8b15361dfb438ab
> ("printk: do cond_resched() between lines while outputting to
> consoles"). A process (printk thread) might sleep with taken
> console_sem. Then suspend_console() might be unable to
> get the semaphore in console_lock() and might deadlock.

I am not sure at this point really, and I don't have indepth knowledge
of printk core as well (I should accept that here :).

> Does it help to enable "no_console_suspend" please?

No. With no_console_suspend, we just print one more line (Disabling
non-boot CPUs) and once the interrupt on the local CPU are disabled,
we don't get any more prints until a resume happens.

-- 
viresh
