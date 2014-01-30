From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Thu, 30 Jan 2014 18:25:27 +0100
Message-ID: <52EA8B07.6020206@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net> <52EA7D8A.6080604@linaro.org> <20140130163501.GG5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140130163501.GG5002@laptop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: nicolas.pitre@linaro.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/30/2014 05:35 PM, Peter Zijlstra wrote:
> On Thu, Jan 30, 2014 at 05:27:54PM +0100, Daniel Lezcano wrote:
>> struct cpuidle_state *state =3D &drv->states[rq->index];
>>
>> And from the state, we have the following informations:
>>
>> struct cpuidle_state {
>>
>> 	[ ... ]
>>
>>          unsigned int    exit_latency; /* in US */
>>          int             power_usage; /* in mW */
>>          unsigned int    target_residency; /* in US */
>>          bool            disabled; /* disabled on all CPUs */
>>
>> 	[ ... ]
>> };
>
> Right, but can we say that a higher index will save more power and ha=
ve
> a higher exit latency? Or is a driver free to have a random mapping f=
rom
> idle_index to state?

If the driver does its own random mapping that will break the governor=20
logic. So yes, the states are ordered, the higher the index is, the mor=
e=20
you save power and the higher the exit latency is.

> Also, we should probably create a pretty function to get that state,
> just like you did in patch 1.

Yes, right.

>> IIRC, Alex Shi sent a patchset to improve the choosing of the idlest=
 cpu and
>> the exit_latency was needed.
>
> Right. However if we have a 'natural' order in the state array the in=
dex
> itself might often be sufficient to find the least idle state, in thi=
s
> specific case the absolute exit latency doesn't matter, all we want i=
s
> the lowest one.

Indeed. It could be simple as that. I feel we may need more information=
s=20
in the future but comparing the indexes could be a nice simple and=20
efficient solution.

> Not dereferencing the state array saves hitting cold cachelines.

Yeah, always good to remind that. Should keep in mind for later.

Thanks for your comments.

   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
