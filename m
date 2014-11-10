From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/6] sched: idle: cpuidle: Check the latency req before
 idle
Date: Mon, 10 Nov 2014 23:21:19 +0100
Message-ID: <54613A5F.7060107@linaro.org>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org> <1415370687-18688-3-git-send-email-daniel.lezcano@linaro.org> <20141110124111.GN3337@twins.programming.kicks-ass.net> <5460D5EF.2000805@linaro.org> <20141110152803.GX10501@worktop.programming.kicks-ass.net> <5460E0A5.9040508@linaro.org> <20141110161530.GB10501@worktop.programming.kicks-ass.net> <5460F386.1050109@linaro.org> <20141110194820.GD10501@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141110194820.GD10501@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/10/2014 08:48 PM, Peter Zijlstra wrote:
> On Mon, Nov 10, 2014 at 06:19:02PM +0100, Daniel Lezcano wrote:
>>> I really don't get why the governors should know about this though,=
 its
>>> just another state, they should iterate all states and pick the bes=
t,
>>> given the power usage this state should really never be eligible un=
less
>>> we're QoS forced or whatnot.
>>
>> The governors just don't use the poll state at all, except for a cou=
ple of
>> cases in menu.c defined above in the previous email. What is the rat=
ional of
>> adding a state in the cpuidle driver and do everything we can to avo=
id using
>> it ? From my POV, the poll state is a special state, we should remov=
e from
>> the driver's idle states like the arch_cpu_idle() is a specific idle=
 state
>> only used in idle.c (but which may overlap with an idle state in dif=
ferent
>> archs eg. cpu_do_idle() and the 0th idle state).
>
> So I disagree, I think poll-idle is an idle mode just like all the
> others. It should be an available state to the governor and it should
> treat it like any other.

The governors are just ignoring it, except for a small timer=20
optimization in menu.c (and I am still not convinced it is worth to hav=
e=20
it). I don't see the point to add a state we don't want to use.

Eg. on my server it was called 2 times over 1313856 times.

> I don't tihnk the whole ARCH_HAS_CPU_RELAX thing makes any kind of
> sense, _every_ arch has some definition of it, the generic polling lo=
op
> is always a valid idle implementation.
>
> What we can do is always populate the idle state table with it before
> calling the regular drivers.

I am not sure to understand. You want to add the poll idle loop in all=20
the drivers ?

What about "safe_halt()" ? (arch_cpu_idle() for x86). It is also an idl=
e=20
state. Why not add it in the idle state table also ?

> If the arch drivers have a 'better' latency_req=3D=3D0 idle routine -=
- note
> my argument on the ppc issue, I think its wrong -- it can replace the
> existing one.
>
> We should further remove all the special casing in the governors, its
> always a valid state, but it should hardly ever be the most desirable
> state.
>
> I think the whole arch specific idle loop is a mistake, we already ha=
ve
> an (arch) interface into the idle routines, we don't need yet another=
=2E



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
