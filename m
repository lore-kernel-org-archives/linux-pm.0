From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] cpuidle: Add some comments in the cpuidle_enter function
Date: Wed, 15 Apr 2015 18:07:07 +0200
Message-ID: <552E8CAB.5060401@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>	<1429092024-20498-2-git-send-email-daniel.lezcano@linaro.org> <CAJZ5v0jazzbqqVSXUyWsGs_eJK1Di6btPP4HN=348VGAn_f-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jazzbqqVSXUyWsGs_eJK1Di6btPP4HN=348VGAn_f-rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, nicolas.pitre@linaro.org
List-Id: linux-pm@vger.kernel.org

On 04/15/2015 03:46 PM, Rafael J. Wysocki wrote:
> On Wed, Apr 15, 2015 at 12:00 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> The code is a bit poor in comments. Fix that by adding some comments=
 in the
>> cpuidle enter function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 1220dac..5e6c6be 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -162,19 +162,50 @@ int cpuidle_enter_state(struct cpuidle_device =
*dev, struct cpuidle_driver *drv,
>>
>>          trace_cpu_idle_rcuidle(index, dev->cpu);
>>
>> +       /*
>> +        * Store the idle start time for this cpu, this information
>> +        * will be used by cpuidle to measure how long the cpu has
>> +        * been idle and by the scheduler to prevent to wake it up t=
oo
>> +        * early
>> +        */
>>          target_state->idle_stamp =3D ktime_to_us(ktime_get());
>>
>> +       /*
>> +        * The enter to the low level idle routine. This call will b=
lock
>> +        * until an interrupt occurs meaning it is the end of the id=
le
>> +        * period
>> +        */
>>          entered_state =3D target_state->enter(dev, drv, index);
>>
>> +       /*
>> +        * Measure as soon as possible the duration of the idle
>> +        * period. It MUST be done before re-enabling the interrupt =
in
>> +        * order to prevent to add in the idle time measurement the
>> +        * interrupt handling duration
>
> That's unless ->enter() itself re-enables interrupts which it may do,=
 right?

Except I missed a change somewhere, I believe I removed all the=20
interrupts re-enablement in all the driver with latest commit 554c06ba3=
=2E

This is why we were able to move the local_irq_enable in this code path=
=20
and finally remove the CPUIDLE_FLAG_TIME_VALID.

> Which is why we made governors use next_timer_us as the "measured"
> value if the measured value itself is greater.
>
> I'd just say "Compute the idle duration here to avoid adding interrup=
t
> handling time to the idle time in case an interrupt occurs as soon as
> re-enabled".

Ok, sounds good.

>> +        */
>>          diff =3D ktime_to_us(ktime_sub_us(ktime_get(), target_state=
->idle_stamp));
>>
>> +       /*
>> +        * Reset the idle time stamp as the scheduler may think the =
cpu is idle
>> +        * while it is in the process of waking up
>> +        */
>>          target_state->idle_stamp =3D 0;
>>
>>          trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>
>> +       /*
>> +        * The cpuidle_enter_coupled uses the cpuidle_enter function=
=2E
>> +        * Don't re-enable the interrupts and let the enter_coupled
>
> "let the enter_coupled function wait" (without the "to").

Ok, thanks.

>> +        * function to wait for all cpus to sync and to enable the
>> +        * interrupts again from there
>> +        */
>
> And I would just say "In the coupled case interrupts will be enabled
> by cpuidle_enter_coupled()".

Ok.

>>          if (!cpuidle_state_is_coupled(dev, drv, entered_state))
>>                  local_irq_enable();
>>
>> +       /*
>> +        * The idle duration will be casted to an integer, prevent t=
o
>
> "will be cast" (like "Cast Away").

Yep.

>> +        * overflow by setting a boundary to INT_MAX
>> +        */
>>          if (diff > INT_MAX)
>>                  diff =3D INT_MAX;
>
> But anyway, instead of adding that comment, why not to change the cod=
e
> like this:
>
> dev->last_residency =3D diff < INT_MAX ? diff : INT_MAX;
>
> and it now should be clear what happens without the comment.

Ok.

Thanks for the review.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
