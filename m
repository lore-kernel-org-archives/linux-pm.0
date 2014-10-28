From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 3/5] cpuidle: idle: menu: Don't reflect when a state
 selection failed
Date: Tue, 28 Oct 2014 19:28:02 +0100
Message-ID: <544FE032.5050900@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>	<1414054881-17713-3-git-send-email-daniel.lezcano@linaro.org> <CAM4v1pO9e7r10KX=D=9aVTV_ecvPa-aJOoB6PAwR5jxMS3eg4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46693 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaJ1S2I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 14:28:08 -0400
Received: by mail-wi0-f170.google.com with SMTP id n3so9652486wiv.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2014 11:28:06 -0700 (PDT)
In-Reply-To: <CAM4v1pO9e7r10KX=D=9aVTV_ecvPa-aJOoB6PAwR5jxMS3eg4w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti Murthy <preeti.lkml@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, patches@linaro.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On 10/28/2014 08:01 AM, Preeti Murthy wrote:
> On Thu, Oct 23, 2014 at 2:31 PM, Daniel Lezcano
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
>
> Why is the last_state_idx not getting updated ?

Oups, right. This is missing.

Thanks for pointing this out.

By the way, I don't think a back end driver is changing the selected=20
state currently and I am not sure this is desirable since we want to=20
trust the state we are going (as a best effort). So if the 'enter'=20
function does not change the index, that means the last_state_idx has=20
not to be changed since it has been assigned in the 'select' function.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

