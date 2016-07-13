From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Wed, 13 Jul 2016 21:57:04 +0900
Message-ID: <20160713125704.GA458@swordfish>
References: <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712093805.GA498@swordfish>
 <20160712125243.GA8597@pathway.suse.cz>
 <20160712131203.GN4695@ubuntu>
 <20160712171113.GD4695@ubuntu>
 <20160713070004.GB563@swordfish>
 <CAJZ5v0gPJ9XOHO3xbbt+irPfh_V72-jeV8L_OTmA=8xnFbVmbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35164 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcGMM5h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 08:57:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gPJ9XOHO3xbbt+irPfh_V72-jeV8L_OTmA=8xnFbVmbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>

Hello Rafael,

On (07/13/16 14:05), Rafael J. Wysocki wrote:
[..]
> > ah, just saw this. OK, very close to what I sent in another thread, so I
> > guess it will work on your side.
> > let me know if it doesn't, I'll fold it into 0001 and re-spin the series.
> > thanks for your help!
> 
> But you need to do an analogous thing for hibernation.  Essentially,
> wherever disable_nonboot_cpus() is called.

hibernation() suspends console, and suspend_console() forces printk to
switch to sync mode. resume_console() lets printk to operate in async
mode (if printk was configured to operate in async mode at all).

the patch I'm talking about is:
 http://marc.info/?l=linux-kernel&m=146838876027364&w=2

am I missing something?

	-ss
