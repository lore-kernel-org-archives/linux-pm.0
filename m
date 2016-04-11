From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] thermal/intel_powerclamp: convert to smpboot thread
Date: Mon, 11 Apr 2016 14:47:12 +0200
Message-ID: <570B9CD0.5060904@linutronix.de>
References: <1457710701-3014-1-git-send-email-bigeasy@linutronix.de>
 <20160406094735.1bbb3c0c@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59857 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbcDKMrS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 08:47:18 -0400
In-Reply-To: <20160406094735.1bbb3c0c@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On 04/06/2016 06:47 PM, Jacob Pan wrote:
> On Fri, 11 Mar 2016 16:38:21 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Apologize for the delay, I missed it until Rui reminded me.
>> Oh boy oh boy. This thing runs at SCHED_FIFO MAX_USER_RT_PRIO/2 and
>> stops at mwait_idle_with_hints(). Why bother with /2?
>> There are a few things I haven't fully decoded. For instance why is it
>> looking at local_softirq_pending()?
> the idea is to instrument some kind of quality of service. Idle
> injection is a best effort based mechanism. So we don't want to affect
> high priority realtime tasks nor softirq.

But you disturb RT tasks with prio 1. Also I am not sure if you see the
sofirq bits. The softirq runs before any (RT) task so the `pending '
should be 0. Unless the work is delegated to ksoftirqd.

>> The timer is probably here if mwait would let it sleep too long.
>>
> not sure i understand. could you explain?

The timer invokes noop_timer() which does nothing so the only thing you
want is the interrupt. Your mwait_idle_with_hints() could let you sleep
say for one second. But the timer ensures that you wake up no later than
100us.

>> I tried to convert it over to smpboot thread so we don't have that CPU
>> notifier stuff to fire the cpu threads during hotplug events.
>>
> there is another patchset to convert it to kthread worker. any
> advantage of smpboot thread?
> http://comments.gmane.org/gmane.linux.kernel.mm/144964

It partly does the same thing except you still have your hotplug
notifier which I wanted to get rid off. However it looks better than
before.
If you do prefer the kworker thingy then please switch from CPU_DEAD to
CPU_DOWN_PREPARE (and add CPU_DOWN_FAILED to CPU_ONLINE).
With those changes I should have no further problem with it :)
Any ETA for (either of those patches) upstream?

>> The code / logic itself could be a little more inteligent and only
>> wake up the threads for the CPUs that are about to idle but it seems
>> it is done on all of the at once unless I missed something.
>>
> you mean only force idle when there is no natural idle? i thought
> about that but hard to coordinate and enforce the duration of each
> idle period. Any specific pointers?

Implement it as an idle driver. So it would be invoked once the system
goes idle as an alternative to (the default) mwait. However the fact
that you (seem to) go idle even if there is work to do seems that you
aim a different goal than idle if there is nothing left.

Sebastian
