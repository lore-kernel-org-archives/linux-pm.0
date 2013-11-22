From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 Resend] cpuidle: free all state kobjects from cpuidle_free_state_kobj()
Date: Fri, 22 Nov 2013 10:50:29 +0100
Message-ID: <528F28E5.2030900@linaro.org>
References: <8094ec60e0ad37d24ffbf146bc61515bd805c4fe.1385004181.git.viresh.kumar@linaro.org>	<1500472.jI9SKO09jR@vostro.rjw.lan> <CAKohpon_-QSPOMi4L6WJZL0akXymhRqhkEWpmzuczE6F-=VUBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:59971 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab3KVJu0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2013 04:50:26 -0500
Received: by mail-ea0-f170.google.com with SMTP id k10so402335eaj.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2013 01:50:25 -0800 (PST)
In-Reply-To: <CAKohpon_-QSPOMi4L6WJZL0akXymhRqhkEWpmzuczE6F-=VUBw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/21/2013 04:48 PM, Viresh Kumar wrote:
> On 21 November 2013 18:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
>> On Thursday, November 21, 2013 08:54:12 AM Viresh Kumar wrote:
>>> Loop for states is currently present on callers side and so is repl=
icated at
>>> several places. It would be better to move that inside cpuidle_free=
_state_kobj()
>>> instead.
>>>
>>> This patch does it.
>>>
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>   drivers/cpuidle/sysfs.c | 23 ++++++++++++-----------
>>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>>> index e918b6d..ade31a9 100644
>>> --- a/drivers/cpuidle/sysfs.c
>>> +++ b/drivers/cpuidle/sysfs.c
>>> @@ -378,12 +378,17 @@ static struct kobj_type ktype_state_cpuidle =3D=
 {
>>>        .release =3D cpuidle_state_sysfs_release,
>>>   };
>>>
>>> -static inline void cpuidle_free_state_kobj(struct cpuidle_device *=
device, int i)
>>> +static inline void cpuidle_free_state_kobj(struct cpuidle_device *=
device,
>>> +             int count)
>>>   {
>>> -     kobject_put(&device->kobjs[i]->kobj);
>>> -     wait_for_completion(&device->kobjs[i]->kobj_unregister);
>>> -     kfree(device->kobjs[i]);
>>> -     device->kobjs[i] =3D NULL;
>>> +     int i;
>>> +
>>> +     for (i =3D 0; i < count; i++) {
>>> +             kobject_put(&device->kobjs[i]->kobj);
>>> +             wait_for_completion(&device->kobjs[i]->kobj_unregiste=
r);
>>> +             kfree(device->kobjs[i]);
>>> +             device->kobjs[i] =3D NULL;
>>> +     }
>>>   }
>>>
>>>   /**
>>> @@ -419,8 +424,7 @@ static int cpuidle_add_state_sysfs(struct cpuid=
le_device *device)
>>>        return 0;
>>>
>>>   error_state:
>>> -     for (i =3D i - 1; i >=3D 0; i--)
>>> -             cpuidle_free_state_kobj(device, i);
>>> +     cpuidle_free_state_kobj(device, i);
>>
>> Well, doesn't the ordering actually matter?  Your patch changes the =
ordering
>> here.
>
> I don't think it matters. And it was done in reverse order earlier to
> save an extra
> variable..

Yes, that's correct. Without the reverse order we must declare a=20
variable for the error case to do 'for (j =3D 0; j < i; j++)'

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

