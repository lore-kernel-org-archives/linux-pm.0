From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 7/9] cpuidle/powernv: Add "Fast-Sleep" CPU idle state
Date: Mon, 02 Dec 2013 20:37:05 +0530
Message-ID: <529CA219.20109@linux.vnet.ibm.com>
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com> <20131129104319.651.29563.stgit@preeti.in.ibm.com> <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:53405 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3LBPKd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2013 10:10:33 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 2 Dec 2013 08:10:32 -0700
In-Reply-To: <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com, rjw@sisk.pl, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org

Hi Thomas,

On 11/29/2013 08:09 PM, Thomas Gleixner wrote:
> On Fri, 29 Nov 2013, Preeti U Murthy wrote:
>> +static enum hrtimer_restart handle_broadcast(struct hrtimer *hrtimer)
>> +{
>> +	struct clock_event_device *bc_evt = &bc_timer;
>> +	ktime_t interval, next_bc_tick, now;
>> +
>> +	now = ktime_get();
>> +
>> +	if (!restart_broadcast(bc_evt))
>> +		return HRTIMER_NORESTART;
>> +
>> +	interval = ktime_sub(bc_evt->next_event, now);
>> +	next_bc_tick = get_next_bc_tick();
> 
> So you're seriously using a hrtimer to poll in HZ frequency for
> updates of bc->next_event?
> 
> To be honest, this design sucks.
> 
> First of all, why is this a PPC specific feature? There are probably
> other architectures which could make use of this. So this should be
> implemented in the core code to begin with.
> 
> And a lot of the things you need for this are already available in the
> core in one form or the other.
> 
> For a start you can stick the broadcast hrtimer to the cpu which does
> the timekeeping. The handover in the hotplug case is handled there as
> well as is the handover for the NOHZ case.
> 
> This needs to be extended for this hrtimer broadcast thingy to work,
> but it shouldn't be that hard to do so.
> 
> Now for the polling. That's a complete trainwreck.
> 
> This can be solved via the broadcast IPI as well. When a CPU which
> goes down into deep idle sets the broadcast to expire earlier than the
> active value it can denote that and send the timer broadcast IPI over
> to the CPU which has the honour of dealing with this.
> 
> This supports HIGHRES and NO_HZ if done right, without polling at
> all. So you can even let the last CPU which handles the broadcast
> hrtimer go for a long sleep, just not in the deepest idle state.

Thank you for the review. The above points are all valid. I will rework
the design to:

1. Eliminate the concept of a broadcast CPU and integrate its
functionality in the timekeeping CPU.

2. Avoid polling by using IPIs to communicate the next wakeup of the
CPUs in deep idle state so as to reprogram the broadcast hrtimer.

3. Make this feature generic and not arch-specific.

Regards
Preeti U Murthy
> 
> Thanks,
> 
> 	tglx
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

