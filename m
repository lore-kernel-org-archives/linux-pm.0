From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/9] i2c: designware: Fix system suspend
Date: Mon, 26 Jun 2017 23:11:34 +0200
Message-ID: <CAJZ5v0i-AgTDTOX+O41abVsnahU9V=NV+HEW0vajhBqGfJuUEg@mail.gmail.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
 <20170622104933.GY629@lahna.fi.intel.com> <2842386.AFZiXzV2Sq@aspire.rjw.lan>
 <CAPDyKFo80QWYhU_SFexr_riPSZS3QEXDyBcywa5qBYa3sJXcjw@mail.gmail.com>
 <CAJZ5v0irHvYXHv1GykatTH+XROZyL0nR0c=KfdSrpH395s6V8g@mail.gmail.com>
 <CAPDyKFov=08AQw0PPPgcFbrerTskoPGfLZcJL9gjikfQfZUJpw@mail.gmail.com> <4324e2c8-ab79-5a21-a8ab-c660920cba59@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4324e2c8-ab79-5a21-a8ab-c660920cba59@ti.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 26, 2017 at 9:39 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 06/26/2017 11:49 AM, Ulf Hansson wrote:

[cut]

>>>> This makes it worse in that sense, that then you don't even need an
>>>> i2c slave to trigger the problem.
>>>
>>> In that case your changelog is a bit misleading.
>>
>> Yeah, it is! I didn't realize that until I fully investigated the revert option.
>>
>>>
>>> It looks like the commit in question attempted to fix exactly this
>>> issue, but it failed, so it should be replaced with something else
>>> which is what your patch is effectively doing.
>>>
>>> IMO you should describe the original problem, explain why that commit
>>> is not sufficient to fix it and then describe the final fix.
>>>
>>> Anyway, after reading the changelog it should be clear that things
>>> were broken before the commit in question.
>>>
>>> And BTW I'm not really sure how the rest of the series is related to this?
>>
>> Going back in history, I realize the system sleep support in this
>> driver has been broken even before the commit $subject patch intends
>> to fix.
>> However it has been working fine for the ACPI case, because of how the
>> ACPI PM domain manages its devices during system sleep.
>>
>> The commit in question, adds an improvement to the driver, because it
>> enables the direct_complete path. For ACPI, that was already working,
>> but not for the other cases. So to be able to support the similar
>> improvement as the direct_complete path offers, as that isn't working
>> for this driver, I tried out using the runtime PM centric path
>> instead. That is what the rest of the changes in this series takes
>> care of.
>>
>> Now, as the system sleep support is broken I wanted to make a simple
>> fix for that first, via $subject patch. I guess what makes this a bit
>> confusing is that I shouldn't point to a certain commit, but rather
>> just add a stable tag and update the changelog accordingly.

I agree, modulo the below.

>
> Wouldn't it fix suspend for this driver if you will just replace
> dw_i2c_plat_suspend() with pm_runtime_force_suspend() in SET_SYSTEM_SLEEP_PM_OPS() as
> you've done in patch 9?
>
> And, I think, direct_complete path should still work after this also.

That's a good point and I was about to mention that.

In any case, even if the pm_runtime_resume() added by the $subject
patch is necessary to start with, it could be added to the ->suspend
callback of the driver instead of the ->complete one, in which case
the ACPI path would not be affected by this change.

Thanks,
Rafael
