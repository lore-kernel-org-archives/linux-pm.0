From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Mon, 6 Jun 2016 14:05:06 -0700
Message-ID: <743a8e5b-abe2-3bc1-bc03-71157b42c9ca@zytor.com>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
 <20160606142506.GE30909@twins.programming.kicks-ass.net>
 <36DF59CE26D8EE47B0655C516E9CE6402876CB97@shsmsx102.ccr.corp.intel.com>
 <20160606164033.GD30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:46452 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbcFFVHG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Jun 2016 17:07:06 -0400
In-Reply-To: <20160606164033.GD30154@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>

On 06/06/16 09:40, Peter Zijlstra wrote:
> On Mon, Jun 06, 2016 at 03:59:06PM +0000, Chen, Yu C wrote:
> 
>>>> +	if (hibernation_in_resume())
>>>> +		mwait_ptr = empty_zero_page;
>>>> +	else
>>>> +		mwait_ptr = &current_thread_info()->flags;
>>>
>>> Why is this conditional? Is there any case in which the zero page is not also
>>> correct?
>> I'm thinking of avoid unnecessary wakeup for normal CPU offline,  for example, 
>> if one  driver uses  the zero page and access it.
> 
> Writing to the zero page would be a major fail.
> 

One implementation of MWAIT is for the waiting processor to claim the
line in an exclusive state, which would be highly undesirable for the
zero page.  I don't actually know if this is done by any real
implementation, however.

Either way, the problem at hand seems limited to post-hibernation, as
for regular CPU offline the page tables will be fully populated, so it
seems like it should not be an issue.

	-hpa

