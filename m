From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/5] sched: idle: cpuidle: Check the latency req before
 idle
Date: Wed, 05 Nov 2014 15:28:36 +0100
Message-ID: <545A3414.7030500@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org> <CAM4v1pOg1GFW82WD8b6Vas5xhYQrQtdP1STGxyzYtrBNSa+-Pw@mail.gmail.com> <544FE787.8090108@linaro.org> <54504A60.2090908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54504A60.2090908@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, Preeti Murthy <preeti.lkml@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On 10/29/2014 03:01 AM, Preeti U Murthy wrote:
> On 10/29/2014 12:29 AM, Daniel Lezcano wrote:
>> On 10/28/2014 04:51 AM, Preeti Murthy wrote:
>>> Hi Daniel,
>>>
>>> On Thu, Oct 23, 2014 at 2:31 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>> When the pmqos latency requirement is set to zero that means "poll=
 in
>>>> all the
>>>> cases".
>>>>
>>>> That is correctly implemented on x86 but not on the other archs.
>>>>
>>>> As how is written the code, if the latency request is zero, the
>>>> governor will
>>>> return zero, so corresponding, for x86, to the poll function, but =
for
>>>> the
>>>> others arch the default idle function. For example, on ARM this is
>>>> wait-for-
>>>> interrupt with a latency of '1', so violating the constraint.
>>>
>>> This is not true actually. On PowerPC the idle state 0 has an
>>> exit_latency of 0.
>>>
>>>>
>>>> In order to fix that, do the latency requirement check *before*
>>>> calling the
>>>> cpuidle framework in order to jump to the poll function without en=
tering
>>>> cpuidle. That has several benefits:
>>>
>>> Doing so actually hurts on PowerPC. Because the idle loop defined f=
or
>>> idle state 0 is different from what cpu_relax() does in cpu_idle_lo=
op().
>>> The spinning is more power efficient in the former case. Moreover w=
e
>>> also set
>>> certain register values which indicate an idle cpu. The ppc_runlatc=
h bits
>>> do precisely this. These register values are being read by some use=
r
>>> space
>>> tools.  So we will end up breaking them with this patch
>>>
>>> My suggestion is very well keep the latency requirement check in
>>> kernel/sched/idle.c
>>> like your doing in this patch. But before jumping to cpu_idle_loop
>>> verify if the
>>> idle state 0 has an exit_latency > 0 in addition to your check on t=
he
>>> latency_req =3D=3D 0.
>>> If not, you can fall through to the regular path of calling into th=
e
>>> cpuidle driver.
>>> The scheduler can query the cpuidle_driver structure anyway.
>>>
>>> What do you think?
>>
>> Thanks for reviewing the patch and spotting this.
>>
>> Wouldn't make sense to create:
>>
>> void __weak_cpu_idle_poll(void) ?
>>
>> and override it with your specific poll function ?
>>
>
> No this would become ugly as far as I can see. A weak function has to=
 be
> defined under arch/* code. We will either need to duplicate the idle
> loop that we already have in the drivers or point the weak function t=
o
> the first idle state defined by our driver. Both of which is not
> desirable (calling into the driver from arch code is ugly). Another
> reason why I don't like the idea of a weak function is that if you ha=
ve
> missed looking at a specific driver and they have an idle loop with
> features similar to on powerpc, you will have to spot it yourself and
> include the arch specific cpu_idle_poll() for them.

Yes, I agree this is a fair point. But actually I don't see the interes=
t=20
of having the poll loop in the cpuidle driver. These cleanups are=20
preparing the removal of the CPUIDLE_DRIVER_STATE_START macro which=20
leads to a lot of mess in the cpuidle code.

With the removal of this macro, we should be able to move the select=20
loop from the menu governor and use it everywhere else. Furthermore,=20
this state which is flagged with TIME_VALID, isn't because the local=20
interrupt are enabled so we are measuring the interrupt time processing=
=2E
Beside that the idle loop for x86 is mostly not used.

So the idea would be to extract those idle loop from the drivers and us=
e=20
them directly when:
  1. the idle selection fails (use the poll loop under certain=20
circumstances we have to redefine)
  2. when the latency req is zero

That will result in a cleaner code in cpuidle and in the governor.

Do you agree with that ?

> But by having a check on the exit_latency, you are claiming that sinc=
e
> the driver's 0th idle state is no better than the generic idle loop i=
n
> cases of 0 latency req, we are better off calling the latter, which
> looks reasonable. That way you don't have to bother about worsening t=
he
> idle loop behavior on any other driver.





--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
