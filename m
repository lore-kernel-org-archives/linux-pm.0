From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume when
 RT suspended
Date: Fri, 16 Jun 2017 15:49:59 +0200
Message-ID: <CAPDyKFrJGFHvvM=-xYLcSTtv0FVvo=CNjnA9RAdm=pUrg552GQ@mail.gmail.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
 <CAPDyKFqfDYg1ZzcJ2Z7md5CD6tYWRMwi4N8M82DesG_ybVKHMw@mail.gmail.com>
 <da36d4c0-7bcb-be18-6c8c-9fd714e2f1e0@linux.intel.com> <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

[...]

>>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> index a597ba32de7e..42a9cd09aa64 100644
>>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> @@ -377,6 +377,9 @@ static int dw_i2c_plat_suspend(struct device *dev)
>>>>         struct platform_device *pdev = to_platform_device(dev);
>>>>         struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>>>>
>>>> +       if (pm_runtime_suspended(dev))
>>>> +               return 0;
>>>
>>>
>>> This looks weird. I don't find any other drivers that needs this, what
>>> is so different with this one?
>>>
>> There are some drivers that are checking pm_runtime_suspended() or
>> pm_runtime_status_suspended() in their suspend/resume callbacks and doing
>> things only when they return false so the problem is not so unique here.
>>
>> I didn't try to find are there drivers that are using some own state
>> variable for the same purpose but I wouldn't surprise if there are.
>>
>>> I have been following the development for the i2c-designware driver
>>> for a while. Some time back I also tried to fix the similar problems
>>> as you are currently [1] are. Back then, I picked the same approach as
>>> John Stultz did recently [2].
>>>
>>> To summarize my view, I don't understand the justification of using
>>> the direct_complete feature for i2c-designware. To me, it just add
>>> complexity to the driver that we really should try to avoid. I think
>>> we need something else here.
>>>
>> Dates back to commit 8503ff166504 ("i2c: designware: Avoid unnecessary
>> resuming during system suspend") but I agree it's worth to consider.
>>
>>> To me, the proper solution is to use the
>>> pm_runtime_force_suspend|resume() helpers to deal with system
>>> suspend/resume. However I understand that the behavior of the ACPI PM
>>> domain currently prevents us from doing this. That said, perhaps we
>>> should instead try to make the ACPI PM domain to better collaborate
>>> with drivers using pm_runtime_force_suspend|resume()? I have been
>>> investigating that and started to cook some patches, although I have
>>> not yet been able to post something. If you think it could make sense,
>>> I can pick it up.
>>>
>> That's a good idea. I didn't think about it at all.
>
> Okay, thanks! I will continue to look into this and try to submit
> something within a reasonable time frame, keep you posted.
>
> Kind regards
> Uffe

Jarkko, Andy,

I just wanted to mention that I haven't forgot about this, I am doing
the final changes for the ACPI PM domain at this very moment, however
I need a couple of more days more before I can post something.

Kind regards
Uffe
