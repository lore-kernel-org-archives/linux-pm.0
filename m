From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] cpuidle: acpi: Remove TIME_INVALID flag from acpi
Date: Thu, 04 Dec 2014 09:53:53 +0100
Message-ID: <54802121.2030407@linaro.org>
References: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org> <2283319.n13QkHWkNs@vostro.rjw.lan> <546F53CF.8070004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:60571 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbaLDIx4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 03:53:56 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so22276823wgh.18
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 00:53:55 -0800 (PST)
In-Reply-To: <546F53CF.8070004@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On 11/21/2014 04:01 PM, Daniel Lezcano wrote:
> On 11/21/2014 04:05 PM, Rafael J. Wysocki wrote:
>> On Friday, November 21, 2014 10:29:51 AM Daniel Lezcano wrote:
>>> The commit 8e92b6605d introduced the TIME_VALID flag for the C1 sta=
te
>>> if this one is a mwait state assuming the interrupt will be enabled
>>> before reading the end time of the idle state.
>>>
>>> The changelog of this commit mention a potential problem with the m=
enu
>>> governor but not a real observation and I assume it described an ol=
d
>>> code as the commit is from 2008.
>>>
>>> I have been digging through the code and I didn't find any place
>>> where the
>>> interrupts are enabled before reading the time. Moreover with the
>>> changes
>>> in the meantime, we moved the time measurements in the cpuidle core
>>> as well
>>> as the interrupts enabling making sure the time is measured before =
the
>>> interrupt are enabled again in a single place.
>>>
>>> Remove this test as the time measurement is always valid for this
>>> state.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Well, I need Len to have a look at this.

Hi,

any news on that ?

Thanks

   -- Daniel

> Ok thanks.
>
> If you have time, is it possible also you have a look at the patchset=
 I
> sent :
>
> [PATCH V3 0/6] sched: idle: cpuidle: cleanups and fixes
>
> and give your opinion about the poll state Peter and I we were discus=
sing ?
>
> Regards
>
>    -- Daniel
>
>>> ---
>>>   drivers/acpi/processor_idle.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/processor_idle.c
>>> b/drivers/acpi/processor_idle.c
>>> index 380b4b4..7afba40 100644
>>> --- a/drivers/acpi/processor_idle.c
>>> +++ b/drivers/acpi/processor_idle.c
>>> @@ -985,8 +985,6 @@ static int
>>> acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>>>           state->flags =3D 0;
>>>           switch (cx->type) {
>>>               case ACPI_STATE_C1:
>>> -            if (cx->entry_method !=3D ACPI_CSTATE_FFH)
>>> -                state->flags |=3D CPUIDLE_FLAG_TIME_INVALID;
>>>
>>>               state->enter =3D acpi_idle_enter_c1;
>>>               state->enter_dead =3D acpi_idle_play_dead;
>>>
>>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

