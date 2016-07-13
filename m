From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Wed, 13 Jul 2016 15:22:58 +0200
Message-ID: <CAJZ5v0gu7pfjNhzdO1x5D3coHzvZKepLBS=X4G0wjKVkhBxSGQ@mail.gmail.com>
References: <20160706182842.GS2671@ubuntu> <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish> <20160711223501.GI4695@ubuntu>
 <20160712093805.GA498@swordfish> <20160712125243.GA8597@pathway.suse.cz>
 <20160712131203.GN4695@ubuntu> <20160712171113.GD4695@ubuntu>
 <20160713070004.GB563@swordfish> <CAJZ5v0gPJ9XOHO3xbbt+irPfh_V72-jeV8L_OTmA=8xnFbVmbQ@mail.gmail.com>
 <20160713125704.GA458@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33375 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcGMNX1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 09:23:27 -0400
In-Reply-To: <20160713125704.GA458@swordfish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Alex Elder <alex.elder@linaro.org>, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Jul 13, 2016 at 2:57 PM, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
> Hello Rafael,
>
> On (07/13/16 14:05), Rafael J. Wysocki wrote:
> [..]
>> > ah, just saw this. OK, very close to what I sent in another thread, so I
>> > guess it will work on your side.
>> > let me know if it doesn't, I'll fold it into 0001 and re-spin the series.
>> > thanks for your help!
>>
>> But you need to do an analogous thing for hibernation.  Essentially,
>> wherever disable_nonboot_cpus() is called.
>
> hibernation() suspends console, and suspend_console() forces printk to
> switch to sync mode. resume_console() lets printk to operate in async
> mode (if printk was configured to operate in async mode at all).
>
> the patch I'm talking about is:
>  http://marc.info/?l=linux-kernel&m=146838876027364&w=2

Ah OK.  That should work for hibernation too.

> am I missing something?

No, I got confused for some reason.

Thanks,
Rafael
