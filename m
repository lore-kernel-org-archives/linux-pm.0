From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] cpuidle: acpi: Remove TIME_INVALID flag from acpi
Date: Fri, 21 Nov 2014 16:01:35 +0100
Message-ID: <546F53CF.8070004@linaro.org>
References: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org> <2283319.n13QkHWkNs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2283319.n13QkHWkNs@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 11/21/2014 04:05 PM, Rafael J. Wysocki wrote:
> On Friday, November 21, 2014 10:29:51 AM Daniel Lezcano wrote:
>> The commit 8e92b6605d introduced the TIME_VALID flag for the C1 stat=
e
>> if this one is a mwait state assuming the interrupt will be enabled
>> before reading the end time of the idle state.
>>
>> The changelog of this commit mention a potential problem with the me=
nu
>> governor but not a real observation and I assume it described an old
>> code as the commit is from 2008.
>>
>> I have been digging through the code and I didn't find any place whe=
re the
>> interrupts are enabled before reading the time. Moreover with the ch=
anges
>> in the meantime, we moved the time measurements in the cpuidle core =
as well
>> as the interrupts enabling making sure the time is measured before t=
he
>> interrupt are enabled again in a single place.
>>
>> Remove this test as the time measurement is always valid for this
>> state.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Well, I need Len to have a look at this.

Ok thanks.

If you have time, is it possible also you have a look at the patchset I=
=20
sent :

[PATCH V3 0/6] sched: idle: cpuidle: cleanups and fixes

and give your opinion about the poll state Peter and I we were discussi=
ng ?

Regards

   -- Daniel

>> ---
>>   drivers/acpi/processor_idle.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index 380b4b4..7afba40 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -985,8 +985,6 @@ static int acpi_processor_setup_cpuidle_states(s=
truct acpi_processor *pr)
>>   		state->flags =3D 0;
>>   		switch (cx->type) {
>>   			case ACPI_STATE_C1:
>> -			if (cx->entry_method !=3D ACPI_CSTATE_FFH)
>> -				state->flags |=3D CPUIDLE_FLAG_TIME_INVALID;
>>
>>   			state->enter =3D acpi_idle_enter_c1;
>>   			state->enter_dead =3D acpi_idle_play_dead;
>>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
