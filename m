From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 2/3] idle: store the idle state the cpu is
Date: Tue, 15 Apr 2014 16:17:36 +0200
Message-ID: <534D3F80.9010902@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-3-git-send-email-daniel.lezcano@linaro.org> <20140415124330.GK11182@twins.programming.kicks-ass.net> <20140415124437.GO13658@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140415124437.GO13658@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On 04/15/2014 02:44 PM, Peter Zijlstra wrote:
> On Tue, Apr 15, 2014 at 02:43:30PM +0200, Peter Zijlstra wrote:
>> On Fri, Mar 28, 2014 at 01:29:55PM +0100, Daniel Lezcano wrote:
>>> @@ -143,6 +145,10 @@ static int cpuidle_idle_call(void)
>>>   			if (!ret) {
>>>   				trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>>
>>> +				*power =3D &drv->states[next_state].power;
>>> +
>>> +				wmb();
>>> +
>>
>> I very much suspect you meant: smp_wmb(), as I don't see the hardwar=
e
>> reading that pointer, therefore UP wouldn't care. Also, any and all
>> barriers should come with a comment that describes the data ordering=
 and
>> points to the matchin barriers.
>
> Furthermore, this patch fails to describe the life-time rules of the
> object placed there. Can the objected pointed to ever disappear?

Hi Peter,

thanks for reviewing the patches.

There are a couple of situations where a cpuidle state can disappear:

1. For x86/acpi with dynamic c-states, when a laptop switches from=20
battery to AC that could result on removing the deeper idle state. The=20
acpi driver triggers:

'acpi_processor_cst_has_changed' which will call=20
'cpuidle_pause_and_lock'. This one will call=20
'cpuidle_uninstall_idle_handler' which in turn calls 'kick_all_cpus_syn=
c'.

All cpus will exit their idle state and the pointed object will be set=20
to NULL again.

2. The cpuidle driver is unloaded. Logically that could happen but not=20
in practice because the drivers are always compiled in and 95% of the=20
drivers are not coded to unregister the driver. Anyway ...

The unloading code must call 'cpuidle_unregister_device', that calls=20
'cpuidle_pause_and_lock' leading to 'kick_all_cpus_sync'.

IIUC, the race can happen if we take the pointer and then one of these=20
two situation occurs at the same moment.

As the function 'find_idlest_cpu' is inside a rcu_read_lock may be a=20
rcu_barrier in 'cpuidle_pause_and_lock' or=20
'cpuidle_uninstall_idle_handler' should suffice, no ?

Thanks

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
