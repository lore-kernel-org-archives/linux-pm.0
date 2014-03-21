From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 1/3] cpufreq: Make sure frequency transitions are serialized
Date: Fri, 21 Mar 2014 16:54:16 +0530
Message-ID: <532C2160.4030909@linux.vnet.ibm.com>
References: <cover.1395379422.git.viresh.kumar@linaro.org> <f6116069b730c0c3a74ff627fa818b98dc4f1491.1395379422.git.viresh.kumar@linaro.org> <532BEE64.3090501@linux.vnet.ibm.com> <CAKohpom8ZHXxVmuSHYL5nyZzNrK8EFNVdx5XJdJxiHWPb13aeg@mail.gmail.com> <532BFB77.5060107@linux.vnet.ibm.com> <CAKohpomY4xf4tOFTGt-ykE7sUi4ks7vW5qp8ytgopm6CiY9QRg@mail.gmail.com> <20140321110559.GB13596@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:34766 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbaCULYj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 07:24:39 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 21:24:37 +1000
In-Reply-To: <20140321110559.GB13596@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>

On 03/21/2014 04:35 PM, Catalin Marinas wrote:
> On Fri, Mar 21, 2014 at 09:21:02AM +0000, Viresh Kumar wrote:
>> @Catalin: We have a problem here and need your expert advice. After changing
>> CPU frequency we need to call this code:
>>
>> cpufreq_notify_post_transition();
>> policy->transition_ongoing = false;
>>
>> And the sequence must be like this only. Is this guaranteed without any
>> memory barriers? cpufreq_notify_post_transition() isn't touching
>> transition_ongoing at all..
> 
> The above sequence doesn't say much. As rmk said, the compiler wouldn't
> reorder the transition_ongoing write before the function call. I think
> most architectures (not sure about Alpha) don't do speculative stores,
> so hardware wouldn't reorder them either. However, other stores inside
> the cpufreq_notify_post_transition() could be reordered after
> transition_ongoing store. The same for memory accesses after the
> transition_ongoing update, they could be reordered before.
> 
> So what we actually need to know is what are the other relevant memory
> accesses that require strict ordering with transition_ongoing.
>

Hmm.. The thing is, _everything_ inside the post_transition() function
should complete before writing to transition_ongoing. Because, setting the
flag to 'false' indicates the end of the critical section, and the next
contending task can enter the critical section.

So, I think we should use smp_mb() before setting transition_ongoing = false.
That way we'll be safe.

> What I find strange in your patch is that
> cpufreq_freq_transition_begin() uses spinlocks around transition_ongoing
> update but cpufreq_freq_transition_end() doesn't.
> 

The reason is that, by the time we drop the spinlock, we would have set
the transition_ongoing flag to true, which prevents any other task from
entering the critical section. Hence, when we call the _end() function,
we are 100% sure that only one task is executing it. Hence locks are not
necessary around that second update. In fact, that very update marks the
end of the critical section (which acts much like a spin_unlock(&lock)
in a "regular" critical section).

I know the "critical section" and the synchronization used in this patch
is a bit unconventional, but that's because the scenario itself is
unconventional : we need to able to start the critical section in one
task, and end it in another task! That's where all the complication
arises :-)  It sounds weird, but in this cpufreq case, its actually valid
and surprisingly, makes sense too! :-)

Regards,
Srivatsa S. Bhat

