From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] thermal/intel_powerclamp: convert to smpboot thread
Date: Mon, 11 Apr 2016 18:04:37 +0200
Message-ID: <570BCB15.1010702@linutronix.de>
References: <1457710701-3014-1-git-send-email-bigeasy@linutronix.de>
 <20160406094735.1bbb3c0c@icelake> <570B9CD0.5060904@linutronix.de>
 <20160411081915.585de6c2@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:32867 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbcDKQEt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 12:04:49 -0400
In-Reply-To: <20160411081915.585de6c2@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Petr Mladek <pmladek@suse.com>

On 04/11/2016 05:19 PM, Jacob Pan wrote:
>> But you disturb RT tasks with prio 1. Also I am not sure if you see
>> the sofirq bits. The softirq runs before any (RT) task so the
>> `pending ' should be 0. Unless the work is delegated to ksoftirqd.
>>
> I agree softirq runs before RT but there could be a gap between
> raise_softirq() (set pending) and run softirq(). So it is possible
> (thus unlikely()) our RT task runs after pending bits set but before
> softirq runs. correct?

If you raise_softirq() then softirqs are run on return from IRQ code.
If raise them while holding a BH lock then then they are run after you
drop the BH lock / enable BH again.
If the softirq processing is deferred to ksoftirqd *then* you see the
pending bits.

>>>> The timer is probably here if mwait would let it sleep too long.
>>>>
>>> not sure i understand. could you explain?
>>
>> The timer invokes noop_timer() which does nothing so the only thing
>> you want is the interrupt. Your mwait_idle_with_hints() could let you
>> sleep say for one second. But the timer ensures that you wake up no
>> later than 100us.
>>
> yeah, that is the idea to make sure we don't oversleep. You mean we can
> optimize this but avoid extra wake ups? e.g. cancel timer if we already
> sleep enough time?

No, just stated / summarized what I *assumed* the timer was doing and
just confirmed it.
I don't see a way how you can cancel the timer. And that is why I
suggest to run as an idle handler because those can sleep endless :)
But since you have RT priority you need to make sure that a process
with lower priority manages to get on the CPU at some point.

>>>> I tried to convert it over to smpboot thread so we don't have that
>>>> CPU notifier stuff to fire the cpu threads during hotplug events.
>>>>
>>> there is another patchset to convert it to kthread worker. any
>>> advantage of smpboot thread?
>>> http://comments.gmane.org/gmane.linux.kernel.mm/144964
>>
>> It partly does the same thing except you still have your hotplug
>> notifier which I wanted to get rid off. However it looks better than
>> before.
>> If you do prefer the kworker thingy then please switch from CPU_DEAD
>> to CPU_DOWN_PREPARE (and add CPU_DOWN_FAILED to CPU_ONLINE).
>> With those changes I should have no further problem with it :)
>> Any ETA for (either of those patches) upstream?
>>
> +Petr
> I do prefer not to keep track of CPU hotplug events. Let me do some
> testing.
Okay. Please keep me posted where you stand on this. If you go for the
kwork series then I will try to make a patch which replaces CPU_DEAD to
CPU_DOWN_PREPARE in order to make it symmetrical (and from what it
looks, there is no need to run at CPU_DEAD time).

>> Implement it as an idle driver. So it would be invoked once the system
>> goes idle as an alternative to (the default) mwait. However the fact
>> that you (seem to) go idle even if there is work to do seems that you
>> aim a different goal than idle if there is nothing left.
>>
> Right, we use the same idle inner loop as the idle task but powerclamp
> driver aims at aligned, forced, and controlled idle time to manage
> power/thermal envelop.
> I also had an attempt to do this in CFS sched class.
> https://lkml.org/lkml/2015/11/2/756
> As it was suggested to be able to stop scheduler tick during force idle
> time (which cannot do in  the current powerclamp code).

Right. So if you have FULL_NO_HZ and an idle opportunity then you won't
be able to sleep for very long. I think you will basically interrupt the
idle loop with your idle loop and then *your* timer / noop_timer wakes
the system to switch over to the idle loop.

> Jacob

Sebastian
