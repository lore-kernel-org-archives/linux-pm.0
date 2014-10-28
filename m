From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 3/5] cpuidle: idle: menu: Don't reflect when a state
 selection failed
Date: Tue, 28 Oct 2014 20:15:52 +0100
Message-ID: <544FEB68.50701@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>	<1414054881-17713-3-git-send-email-daniel.lezcano@linaro.org> <CAJvTdKm+jwv=2nbi8OZKHHbsieuggp53go=C-ztCr1w4SNpfpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKm+jwv=2nbi8OZKHHbsieuggp53go=C-ztCr1w4SNpfpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, Patch Tracking <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 10/28/2014 03:01 AM, Len Brown wrote:
> On Thu, Oct 23, 2014 at 5:01 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> In the current code, the check to reflect or not the outcoming state=
 is done
>> against the idle state which has been chosen and its value.
>>
>> Instead of doing a check in each of the reflect functions, just don'=
t call reflect
>> if something went wrong in the idle path.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Nicolas Pitre <nico@linaro.org>
>> ---
>>   drivers/cpuidle/governors/ladder.c | 3 +--
>>   drivers/cpuidle/governors/menu.c   | 4 +---
>>   kernel/sched/idle.c                | 3 ++-
>>   3 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/go=
vernors/ladder.c
>> index fb396d6..c0b36a8 100644
>> --- a/drivers/cpuidle/governors/ladder.c
>> +++ b/drivers/cpuidle/governors/ladder.c
>> @@ -165,8 +165,7 @@ static int ladder_enable_device(struct cpuidle_d=
river *drv,
>>   static void ladder_reflect(struct cpuidle_device *dev, int index)
>>   {
>>          struct ladder_device *ldev =3D &__get_cpu_var(ladder_device=
s);
>> -       if (index > 0)
>> -               ldev->last_state_idx =3D index;
>
> Before this patch, last_state_idx was never set to 0 here.
> After this patch, last_state_idx will be set to 0 when entered_state =
is 0.
> Is that okay?

Yes, I think so because the state zero won't be never selected on x86=20
but on the other arch it will. So before this patch, on the other archs=
,=20
the state 0 was never reflected as it should do.

This is resulting from the CPUIDLE_DRIVER_STATE_START macro (I hope I=20
can kill this macro in a couple of patchset after this one).

>> +       ldev->last_state_idx =3D index;
>>   }
>>
>>   static struct cpuidle_governor ladder_governor =3D {
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gove=
rnors/menu.c
>> index a17515f..3907301 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -365,9 +365,7 @@ static int menu_select(struct cpuidle_driver *dr=
v, struct cpuidle_device *dev,
>>   static void menu_reflect(struct cpuidle_device *dev, int index)
>>   {
>>          struct menu_device *data =3D &__get_cpu_var(menu_devices);
>> -       data->last_state_idx =3D index;
>> -       if (index >=3D 0)
>> -               data->needs_update =3D 1;
>> +       data->needs_update =3D 1;
>>   }
>>
>>   /**
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index 58c7522..49dcc7d 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -162,7 +162,8 @@ use_default:
>>          /*
>>           * Give the governor an opportunity to reflect on the outco=
me
>>           */
>> -       cpuidle_reflect(dev, entered_state);
>> +       if (entered_state >=3D 0)
>> +               cpuidle_reflect(dev, entered_state);
>>
>>   exit_idle:
>>          __current_set_polling();
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
