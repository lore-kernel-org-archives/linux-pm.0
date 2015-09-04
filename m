From: Xunlei Pang <pang.xunlei@linaro.org>
Subject: Re: [PATCH v3] cpuidle/coupled: Add sanity check for safe_state_index
Date: Fri, 4 Sep 2015 10:15:41 +0800
Message-ID: <CADcy93VYaL9VxkLj8P7ScgJqrPNf+bq7WTaH1qWS7pLXr=z7JQ@mail.gmail.com>
References: <1440992045-17464-1-git-send-email-xlpang@126.com>
	<2730874.lxGIcz4Q5K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2730874.lxGIcz4Q5K@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 3 September 2015 at 09:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, August 31, 2015 11:34:05 AM Xunlei Pang wrote:
>> From: Xunlei Pang <pang.xunlei@linaro.org>
>>
>> Since we are using cpuidle_driver::safe_state_index directly as the
>> target state index, it is better to add the sanity check at the point
>> of registering the driver.
>>
>> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
>
> I'm queuing this one up for the next PM pull request, thanks!

Thanks!

Regards,
Xunlei

>
>
>> ---
>> v2->v3:
>> Move the code to a new cpuidle_coupled_state_verify() depending on
>> CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED, to avoid using #ifdef in function
>> bodies. Thanks Rafael's comments on this.
>>
>>  drivers/cpuidle/coupled.c | 22 ++++++++++++++++++++++
>>  drivers/cpuidle/cpuidle.h |  6 ++++++
>>  drivers/cpuidle/driver.c  |  4 ++++
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
>> index 1523e2d..344058f 100644
>> --- a/drivers/cpuidle/coupled.c
>> +++ b/drivers/cpuidle/coupled.c
>> @@ -187,6 +187,28 @@ bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state)
>>  }
>>
>>  /**
>> + * cpuidle_coupled_state_verify - check if the coupled states are correctly set.
>> + * @drv: struct cpuidle_driver for the platform
>> + *
>> + * Returns 0 for valid state values, a negative error code otherwise:
>> + *  * -EINVAL if any coupled state(safe_state_index) is wrongly set.
>> + */
>> +int cpuidle_coupled_state_verify(struct cpuidle_driver *drv)
>> +{
>> +     int i;
>> +
>> +     for (i = drv->state_count - 1; i >= 0; i--) {
>> +             if (cpuidle_state_is_coupled(drv, i) &&
>> +                 (drv->safe_state_index == i ||
>> +                  drv->safe_state_index < 0 ||
>> +                  drv->safe_state_index >= drv->state_count))
>> +                     return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>>   * cpuidle_coupled_set_ready - mark a cpu as ready
>>   * @coupled: the struct coupled that contains the current cpu
>>   */
>> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
>> index 178c5ad..f87f399 100644
>> --- a/drivers/cpuidle/cpuidle.h
>> +++ b/drivers/cpuidle/cpuidle.h
>> @@ -35,6 +35,7 @@ extern void cpuidle_remove_sysfs(struct cpuidle_device *dev);
>>
>>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>  bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state);
>> +int cpuidle_coupled_state_verify(struct cpuidle_driver *drv);
>>  int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>>               struct cpuidle_driver *drv, int next_state);
>>  int cpuidle_coupled_register_device(struct cpuidle_device *dev);
>> @@ -46,6 +47,11 @@ bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state)
>>       return false;
>>  }
>>
>> +static inline int cpuidle_coupled_state_verify(struct cpuidle_driver *drv)
>> +{
>> +     return 0;
>> +}
>> +
>>  static inline int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>>               struct cpuidle_driver *drv, int next_state)
>>  {
>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>> index 5db1478..389ade4 100644
>> --- a/drivers/cpuidle/driver.c
>> +++ b/drivers/cpuidle/driver.c
>> @@ -227,6 +227,10 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>>       if (!drv || !drv->state_count)
>>               return -EINVAL;
>>
>> +     ret = cpuidle_coupled_state_verify(drv);
>> +     if (ret)
>> +             return ret;
>> +
>>       if (cpuidle_disabled())
>>               return -ENODEV;
>>
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
