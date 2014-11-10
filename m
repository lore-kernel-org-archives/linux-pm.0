From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 3/6] sched: idle: Get the next timer event and pass
 it the cpuidle framework
Date: Mon, 10 Nov 2014 16:15:50 +0100
Message-ID: <5460D6A6.9070501@linaro.org>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org> <1415370687-18688-4-git-send-email-daniel.lezcano@linaro.org> <20141110124353.GO3337@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:60234 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaKJPP4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 10:15:56 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so9070977wgh.40
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 07:15:54 -0800 (PST)
In-Reply-To: <20141110124353.GO3337@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 11/10/2014 01:43 PM, Peter Zijlstra wrote:
> On Fri, Nov 07, 2014 at 03:31:24PM +0100, Daniel Lezcano wrote:
>>   static void cpu_idle_loop(void)
>>   {
>> -	unsigned int latency_req;
>> +	unsigned int latency_req, next_timer_event;
>>
>>   	while (1) {
>>   		/*
>> @@ -221,6 +222,9 @@ static void cpu_idle_loop(void)
>>
>>   			latency_req =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>>
>> +			next_timer_event =3D
>> +				ktime_to_us(tick_nohz_get_sleep_length());
>> +
>>   			/*
>>   			 * In poll mode we reenable interrupts and spin.
>>   			 *
>> @@ -238,7 +242,8 @@ static void cpu_idle_loop(void)
>>   			    tick_check_broadcast_expired())
>>   				cpu_idle_poll();
>>   			else
>> -				cpuidle_idle_call(latency_req);
>> +				cpuidle_idle_call(latency_req,
>> +						  next_timer_event);
>>
>>   			arch_cpu_idle_exit();
>>   		}
>
> Why do we want to query the next timer in the poll case? Afaict the
> other patches don't make use of this either.

Well, the direction I am taking when writing those cleanups is to have=20
something like:

"I will sleep X usec, I have Y usec latency constraints". Grouping the=20
latency req and the next timer allows to stick to the next changes.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

