From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Thu, 21 Apr 2016 00:28:35 +0200
Message-ID: <57180293.1040809@intel.com>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
 <6087716.bi8vDPiZNy@vostro.rjw.lan>
 <20160420140117.GZ3448@twins.programming.kicks-ass.net>
 <CANRm+CzGm5axJC_y=rqhmi=DLkfpXfo2NLzFyRyjeZE89Aty4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:5519 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbcDTW2l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Apr 2016 18:28:41 -0400
In-Reply-To: <CANRm+CzGm5axJC_y=rqhmi=DLkfpXfo2NLzFyRyjeZE89Aty4Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On 4/21/2016 12:24 AM, Wanpeng Li wrote:
> 2016-04-20 22:01 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>> On Wed, Apr 20, 2016 at 02:32:35AM +0200, Rafael J. Wysocki wrote:
>>> On Monday, April 18, 2016 01:51:24 PM Wanpeng Li wrote:
>>>> Sometimes update_curr() is called w/o tasks actually running, it is
>>>> captured by:
>>>>      u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>>>> We should not trigger cpufreq update in this case for rt/deadline
>>>> classes, and this patch fix it.
>>>>
>>>> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>>> The signed-off-by tag should agree with the From: header.  One way to achieve
>>> that is to add an extra From: line at the start of the changelog.
>>>
>>> That said, this looks like a good catch that should go into 4.6 to me.
>>>
>>> Peter, what do you think?
>> I'm confused by the Changelog. *what* ?
> Sometimes .update_curr hook is called w/o tasks actually running, it is
> captured by:
>
>          u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>
> We should not trigger cpufreq update in this case for rt/deadline
> classes, and this patch fix it.

That's what you wrote in the changelog, no need to repeat that.

I guess Peter is asking for more details, though.  I actually would like 
to get some more details here too.  Like an example of when the 
situation in question actually happens.

Thanks,
Rafael


