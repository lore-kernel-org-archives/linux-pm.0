From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Mon, 03 Feb 2014 08:17:47 -0800
Message-ID: <52EFC12B.50704@linux.intel.com>
References: <52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com> <20140131090230.GM5002@laptop.programming.kicks-ass.net> <52EB6F65.8050008@linux.vnet.ibm.com> <52EBBC23.8020603@linux.intel.com> <52EBC33A.6080101@linaro.org> <52EBC645.2040607@linux.intel.com> <alpine.LFD.2.11.1401311236470.2312@knanqh.ubzr> <20140203125441.GD19029@e103034-lin> <52EFA9D3.1030601@linux.intel.com> <20140203145605.GL8874@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9533 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbaBCQSC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Feb 2014 11:18:02 -0500
In-Reply-To: <20140203145605.GL8874@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Preeti Murthy <preeti.lkml@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 2/3/2014 6:56 AM, Peter Zijlstra wrote:
>
> Arjan, could you have a look at teaching your Thunderpants to wrap lines
> at ~80 chars please?

I'll try but it suffers from Apple-disease


>> 1) A latency driven one
>> 2) A performance impact on
>>
>> first one is pretty much the exit latency related time, sort of a
>> "expected time to first instruction" (currently menuidle has the
>> 99.999% worst case number, which is not useful for this, but is a
>> first approximation). This is obviously the dominating number for
>> expected-short running tasks
>>
>> second on is more of a "is there any cache/TLB left or is it flushed"
>> kind of metric. It's more tricky to compute, since what is the cost of
>> an empty cache (or even a cache migration) after all....  .... but I
>> suspect it's in part what the scheduler will care about more for
>> expected-long  running tasks.
>
> Yeah, so currently we 'assume' cache hotness based on runtime; see
> task_hot(). A hint that the CPU wiped its caches might help there.

if there's a simple api like

sched_cpu_cache_wiped(int llc)

that would be very nice for this; the menuidle side knows this
for some cases and thus can just call it. This would be a very
small and minimal change

* if you don't care about llc vs core local caches then that
   parameter can go away

* I assume this is also called for the local cpu... if not then we
   need to add a cpu number argument

* we can also call this from architecture code when wbinvd or the
   arm equivalent is called etc



