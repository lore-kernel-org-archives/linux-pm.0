From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Thu, 11 Jul 2013 20:08:54 +0530
Message-ID: <51DEC37E.2070500@linux.vnet.ibm.com>
References: <Pine.LNX.4.44L0.1307111010180.1276-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:37531 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932889Ab3GKOm0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2013 10:42:26 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 11 Jul 2013 20:04:20 +0530
In-Reply-To: <Pine.LNX.4.44L0.1307111010180.1276-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, =?ISO-8859-1?Q?Toralf_F=F6rst?= =?ISO-8859-1?Q?er?= <toralf.foerster@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, tianyu.lan@intel.com

On 07/11/2013 07:53 PM, Alan Stern wrote:
> On Thu, 11 Jul 2013, Srivatsa S. Bhat wrote:
> 
>> Oops! You are right. Hmm, this looks quite difficult to get right :(
>> There are multiple challenges here:
>>
>> 1. The sysfs files must not be removed during cpu_down, and not initialized
>>
>>    during cpu_up. That would help us preserve the file permissions.
>> 2. But we should ensure that we really do the cpufreq-core parts of the cpu
>>    initialization during cpu_up. If we fail to free some of the data-structures
>>    during cpu_down, the cpu_up callback will think that a full-init is not
>>    required and not do its job. That will make cpufreq behave erratically after
>>    suspend/resume and take us back to square one.
>>
>> 3. A full re-init in the cpu_up callback also involves memory allocations.
>>    So if we don't release the memory in the cpu_down callback, we'll end up
>>    in a memory leak.
>>
>> I tried to address all these in this patch, but you found yet another serious
>> loop-hole. I guess I'm out of ideas now... if anybody has any thoughts on how
>> to get this right, then I'm all ears. Else, we'll just revert the original
>> commit like Rafael suggested and leave it upto userspace to save and restore
>> the permissions across suspend/resume if it wants ;-(
> 
> Asking as a naive outsider who is completely unfamiliar with the code,
> why are any of these things at all troublesome?
> 
> 	Can't cpu_up tell the difference between activating a brand-new
> 	CPU and reactivating one that was present before but was
> 	temporarily disabled?
> 
> 	Doesn't cpu_up know which data structures get freed when an
> 	active CPU is temporarily deactivated?
> 
> 	Doesn't cpu_down know what memory gets allocated in cpu_up?
> 	Can't it deallocate just the right parts for the type of
> 	transition it is doing?
> 
> It sounds like you're really asking how to make sure that cpu_up and 
> cpu_down both know what the other is doing, so that each can do the 
> opposite of the other.  That doesn't sound hard.
>

It would not have been hard if the code had been already structured that
way. Currently, the code is quite a bit entangled, and it doesn't distinguish
the "temporarily deactivated" and the "fully torn-down" cases. To add to the
mess, the code is generously sprinkled with notifiers that are invoked every
now and then (which depend on previous init steps etc).

But the bottomline is that this is purely a code-reorganization issue,
nothing more than that. And hopefully we'll be able to separate out the
"temporarily deactivated" and the "fully down" cases reasonably well, such
that we can preserve the sysfs file permissions easily across suspend/resume.
That's the code reorganization I'm working on at the moment; I'll post it
out as soon as I'm done.

Regards,
Srivatsa S. Bhat

