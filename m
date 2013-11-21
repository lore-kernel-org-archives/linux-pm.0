From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend] cpuidle: free all state kobjects from cpuidle_free_state_kobj()
Date: Thu, 21 Nov 2013 21:18:34 +0530
Message-ID: <CAKohpon_-QSPOMi4L6WJZL0akXymhRqhkEWpmzuczE6F-=VUBw@mail.gmail.com>
References: <8094ec60e0ad37d24ffbf146bc61515bd805c4fe.1385004181.git.viresh.kumar@linaro.org>
	<1500472.jI9SKO09jR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500472.jI9SKO09jR@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21 November 2013 18:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 21, 2013 08:54:12 AM Viresh Kumar wrote:
>> Loop for states is currently present on callers side and so is replicated at
>> several places. It would be better to move that inside cpuidle_free_state_kobj()
>> instead.
>>
>> This patch does it.
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpuidle/sysfs.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>> index e918b6d..ade31a9 100644
>> --- a/drivers/cpuidle/sysfs.c
>> +++ b/drivers/cpuidle/sysfs.c
>> @@ -378,12 +378,17 @@ static struct kobj_type ktype_state_cpuidle = {
>>       .release = cpuidle_state_sysfs_release,
>>  };
>>
>> -static inline void cpuidle_free_state_kobj(struct cpuidle_device *device, int i)
>> +static inline void cpuidle_free_state_kobj(struct cpuidle_device *device,
>> +             int count)
>>  {
>> -     kobject_put(&device->kobjs[i]->kobj);
>> -     wait_for_completion(&device->kobjs[i]->kobj_unregister);
>> -     kfree(device->kobjs[i]);
>> -     device->kobjs[i] = NULL;
>> +     int i;
>> +
>> +     for (i = 0; i < count; i++) {
>> +             kobject_put(&device->kobjs[i]->kobj);
>> +             wait_for_completion(&device->kobjs[i]->kobj_unregister);
>> +             kfree(device->kobjs[i]);
>> +             device->kobjs[i] = NULL;
>> +     }
>>  }
>>
>>  /**
>> @@ -419,8 +424,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
>>       return 0;
>>
>>  error_state:
>> -     for (i = i - 1; i >= 0; i--)
>> -             cpuidle_free_state_kobj(device, i);
>> +     cpuidle_free_state_kobj(device, i);
>
> Well, doesn't the ordering actually matter?  Your patch changes the ordering
> here.

I don't think it matters. And it was done in reverse order earlier to
save an extra
variable..

Daniel??
