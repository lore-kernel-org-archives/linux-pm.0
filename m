From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Thu, 30 Jan 2014 17:27:54 +0100
Message-ID: <52EA7D8A.6080604@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:61074 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaA3Q1x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2014 11:27:53 -0500
Received: by mail-wg0-f53.google.com with SMTP id y10so6850274wgg.32
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2014 08:27:52 -0800 (PST)
In-Reply-To: <20140130153150.GD5002@laptop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: nicolas.pitre@linaro.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 01/30/2014 04:31 PM, Peter Zijlstra wrote:
> On Thu, Jan 30, 2014 at 03:09:22PM +0100, Daniel Lezcano wrote:
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 90aef084..130debf 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -654,6 +654,9 @@ struct rq {
>>   #endif
>>
>>   	struct sched_avg avg;
>> +#ifdef CONFIG_CPU_IDLE
>> +	int idle_index;
>> +#endif
>>   };
>
> So my 'problem' with this is that I've no ff'ing clue what the
> idle_index is and what I can do with it.

The cpuidle framework works with index corresponding to the index in th=
e=20
idle states array. This array contains all the idle states the backend=20
driver supports. The cpuidle framework will ask for the governor what=20
idle state it should uses for the cpu, the governor will look at the=20
different characteristics of the idle states + timing information and=20
returns an index corresponding to the idle state the governor thinks=20
suit better. This step is the 'cpuidle_select'.

Then the cpuidle framework calls the idle callback associated with the=20
idle state at the index location. The cpu will stay blocked on this=20
callback until an interrupt occurs. This step is the 'cpuidle_enter'.

Between the 'cpuidle_select' and 'cpuidle_enter', this patch stores the=
=20
current idle state the cpu is about to enter (it stores the index). So=20
from the scheduler and the current cpuidle api it is easy to get=20
information about the idle state a cpu is:

struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);

struct cpuidle_state *state =3D &drv->states[rq->index];

And from the state, we have the following informations:

struct cpuidle_state {

	[ ... ]

         unsigned int    exit_latency; /* in US */
         int             power_usage; /* in mW */
         unsigned int    target_residency; /* in US */
         bool            disabled; /* disabled on all CPUs */

	[ ... ]
};

IIRC, Alex Shi sent a patchset to improve the choosing of the idlest cp=
u=20
and the exit_latency was needed.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

