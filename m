From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Fri, 31 Jan 2014 15:04:32 +0100
Message-ID: <52EBAD70.6040303@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net> <52EA7D8A.6080604@linaro.org> <20140130163501.GG5002@laptop.programming.kicks-ass.net> <52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com> <20140131090230.GM5002@laptop.programming.kicks-ass.net> <52EB6F65.8050008@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52EB6F65.8050008@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Len Brown <len.brown@intel.com>
Cc: Preeti Murthy <preeti.lkml@gmail.com>, nicolas.pitre@linaro.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 01/31/2014 10:39 AM, Preeti U Murthy wrote:
> Hi Peter,
>
> On 01/31/2014 02:32 PM, Peter Zijlstra wrote:
>> On Fri, Jan 31, 2014 at 02:15:47PM +0530, Preeti Murthy wrote:
>>>>
>>>> If the driver does its own random mapping that will break the gove=
rnor
>>>> logic. So yes, the states are ordered, the higher the index is, th=
e more you
>>>> save power and the higher the exit latency is.
>>>
>>> The above point holds true for only the ladder governor which sees =
the idle
>>> states indexed in the increasing order of target_residency/exit_lat=
ency.
>>>
>>> However this is not true as far as I can see in the menu governor. =
It
>>> acknowledges the dynamic ordering of idle states as can be seen in =
the
>>> menu_select() function in the menu governor, where the idle state f=
or the
>>> CPU gets chosen.  You will notice that, even if it is found that th=
e predicted
>>> idle time of the CPU is smaller than the target residency of an idl=
e state,
>>> the governor continues to search for suitable idle states in the hi=
gher indexed
>>> states although it should have halted if the idle states' were orde=
red according
>>> to their target residency.. The same holds for exit_latency.
>>>
>>> Hence I think this patch would make sense only with additional info=
rmation
>>> like exit_latency or target_residency is present for the scheduler.=
 The idle
>>> state index alone will not be sufficient.
>>
>> Alternatively, can we enforce sanity on the cpuidle infrastructure t=
o
>> make the index naturally ordered? If not, please explain why :-)
>
> The commit id 71abbbf856a0e70 says that there are SOCs which could ha=
ve
> their target_residency and exit_latency values change at runtime. Thi=
s
> commit thus removed the ordering of the idle states according to thei=
r
> target_residency/exit_latency. Adding Len and Arjan to the CC.

This commit is outdated, AFAICT.

Indeed, there are dynamic idle states. Some idle states are added or=20
removed when a laptop is going to battery or plugged in.

In ACPI, the power event leads the acpi cpuidle driver to disable the=20
cpuidle framework, get the idle states which are ordered, and re-enable=
=20
the cpuidle framework which in turn kicks all the cpus. So the index in=
=20
the struct rq should be always ok.




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
