From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 01:08:51 +0200
Message-ID: <CAJZ5v0ifOMb=wCvCRoGb2AHTfGLc0z10_fPUYVMP3pH_kWtr4A@mail.gmail.com>
References: <20160701165959.GR12473@ubuntu> <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu> <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish> <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu> <20160713054507.GA563@swordfish> <20160713153910.GY4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33074 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcGMXIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 19:08:55 -0400
In-Reply-To: <20160713153910.GY4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Alex Elder <alex.elder@linaro.org>, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>, Petr Mladek <pmladek@suse.com>

On Wed, Jul 13, 2016 at 5:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 13-07-16, 14:45, Sergey Senozhatsky wrote:
>> On (07/12/16 16:19), Viresh Kumar wrote:

[cut]

>>
>> something like below, perhaps. will this work for you?
>
> Maybe not, as this can still lead to the original bug we were all
> chasing. This may hog some other CPU if we are doing excessive
> printing in suspend :(

How can it hog that CPU, exactly?

> suspend_console() is called quite early, so for example in my case we
> do lots of printing during suspend (not from the suspend thread, but
> an IRQ handled by the USB subsystem, which removes a bus with help of
> some other thread probably).

Why doing a lot of printing from an IRQ is not regarded as a bug?

Are all of those messages printed actually useful?

> That is why my Hacky patch tried to do it after devices are removed
> and irqs are disabled, but before syscore users are suspended (and
> timekeeping is one of them). And so it fixes it for me completely.
>
> IOW, we should switch back to synchronous printing after disabling
> interrupts on the last running CPU.
>
> And I of course agree with Rafael that we would need something similar
> in Hibernation code path as well, if we choose to fix it my way.

Well, the patch proposed by Sergey is sufficient to fix the deadlock
issue and it is not clear that anything more needs to be done.

My suggestion, then, would be to use this patch to start with and see
if things really go worse then.

Thanks,
Rafael
