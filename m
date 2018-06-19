From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
Date: Tue, 19 Jun 2018 10:22:52 +0200
Message-ID: <7eff02c1-3d78-de08-19ab-a4a45c491a86@collabora.com>
References: <20180615100452.17466-1-enric.balletbo@collabora.com>
 <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
 <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, cwchoi00@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 18/06/18 11:02, Enric Balletbo Serra wrote:
> Hi Chanwoo,
> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
> 2018 a les 5:50:
>>
>> Hi Enric,
>>
>> This issue will happen on the position to use find_devfreq_governor()
>> as following:
>> - devfreq_add_governora() and governor_store()
>>
>> If device driver with module type after loaded want to change the
>> scaling governor,
>> new governor might be not yet loaded. So, devfreq bettero to consider this case
>> in the find_devfreq_governor().
>>
> Ok, I'll move there and send a v2.
> 

I tried your suggestion but I found one problem, if I move the code in
find_devfreq_governor it end up with a deadlock. The reason is the following calls.

devfreq_add_device
  find_devfreq_governor (!!!)
    request_module
       devfreq_simple_ondemand_init
          devfreq_add_governor
             find_devfreq_governor (DEADLOCK)

So I am wondering if shouldn't be more easy fix the issue in both places,
devfreq_add_device and governor_store.

To devfreq_add_device

devfreq_add_device
  governor = find_devfreq_governor
  if (IS_ERR(governor) {
     request_module
     governor = find_devfreq_governor
     if (IS_ERR(governor)
       return ERR_PTR(governor)
  }

And the same for governor_store

governor_store
  governor = find_devfreq_governor
  if (IS_ERR(governor) {
     request_module
     governor = find_devfreq_governor
     if (IS_ERR(governor)
       return ERR_PTR(governor)
  }

Maybe all  can go in a new function try_find_devfreq_governor_then_request

Other suggestions?

- Enric

> Thanks
>  Enric.
> 
> 
>> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
>> <enric.balletbo@collabora.com>:
>>> When the devfreq driver and the governor driver are built as modules,
>>> the call to devfreq_add_device() fails because the governor driver is
>>> not loaded at the time the devfreq driver loads. The devfreq driver has
>>> a build dependency on the governor but also should have a runtime
>>> dependency. We need to make sure that the governor driver is loaded
>>> before the devfreq driver.
>>>
>>> This patch fixes this bug in devfreq_add_device(). First tries to find
>>> the governor, and then, if was not found, it requests the module and
>>> tries again.
>>>
>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
>>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index fe2af6aa88fc..1d917f043e30 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -11,6 +11,7 @@
>>>   */
>>>
>>>  #include <linux/kernel.h>
>>> +#include <linux/kmod.h>
>>>  #include <linux/sched.h>
>>>  #include <linux/errno.h>
>>>  #include <linux/err.h>
>>> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>
>>>         governor = find_devfreq_governor(devfreq->governor_name);
>>>         if (IS_ERR(governor)) {
>>> -               dev_err(dev, "%s: Unable to find governor for the device\n",
>>> -                       __func__);
>>> -               err = PTR_ERR(governor);
>>> -               goto err_init;
>>> +               list_del(&devfreq->node);
>>> +               mutex_unlock(&devfreq_list_lock);
>>> +
>>> +               /*
>>> +                * If the governor is not found, then request the module and
>>> +                * try again. This can happen when both drivers (the governor
>>> +                * driver and the driver that calls devfreq_add_device) are
>>> +                * built as modules.
>>> +                */
>>> +               if (!strncmp(devfreq->governor_name,
>>> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
>>> +                       err = request_module("governor_%s", "simpleondemand");
>>> +               else
>>> +                       err = request_module("governor_%s",
>>> +                                            devfreq->governor_name);
>>> +               if (err)
>>> +                       goto err_unregister;
>>> +
>>> +               mutex_lock(&devfreq_list_lock);
>>> +               list_add(&devfreq->node, &devfreq_list);
>>> +
>>> +               governor = find_devfreq_governor(devfreq->governor_name);
>>> +               if (IS_ERR(governor)) {
>>> +                       dev_err(dev,
>>> +                               "%s: Unable to find governor for the device\n",
>>> +                               __func__);
>>> +                       err = PTR_ERR(governor);
>>> +                       goto err_init;
>>> +               }
>>>         }
>>>
>>>         devfreq->governor = governor;
>>> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  err_init:
>>>         list_del(&devfreq->node);
>>>         mutex_unlock(&devfreq_list_lock);
>>> -
>>> +err_unregister:
>>>         device_unregister(&devfreq->dev);
>>>  err_dev:
>>>         if (devfreq)
>>> --
>>> 2.17.1
>>>
>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
