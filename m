From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] i2c: designware: Fix system suspend
Date: Mon, 26 Jun 2017 18:49:32 +0200
Message-ID: <CAPDyKFov=08AQw0PPPgcFbrerTskoPGfLZcJL9gjikfQfZUJpw@mail.gmail.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
 <20170622104933.GY629@lahna.fi.intel.com> <2842386.AFZiXzV2Sq@aspire.rjw.lan>
 <CAPDyKFo80QWYhU_SFexr_riPSZS3QEXDyBcywa5qBYa3sJXcjw@mail.gmail.com> <CAJZ5v0irHvYXHv1GykatTH+XROZyL0nR0c=KfdSrpH395s6V8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0irHvYXHv1GykatTH+XROZyL0nR0c=KfdSrpH395s6V8g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, stable@vger.linux.org
List-Id: linux-pm@vger.kernel.org

On 23 June 2017 at 00:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 22, 2017 at 11:37 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 June 2017 at 16:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Thursday, June 22, 2017 01:49:33 PM Mika Westerberg wrote:
>>>> On Thu, Jun 22, 2017 at 01:31:51AM +0200, Rafael J. Wysocki wrote:
>>>> > On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> > > The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
>>>> > > during system suspend"), may suggest to the PM core to try out the so
>>>> > > called direct_complete path for system sleep. In this path, the PM core
>>>> > > treats a runtime suspended device as it's already in a proper low power
>>>> > > state for system sleep, which makes it skip calling the system sleep
>>>> > > callbacks for the device, except for the ->prepare() and the ->complete()
>>>> > > callback.
>>>> > >
>>>> > > Moreover, under certain circumstances the PM core may unset the
>>>> > > direct_complete flag for a parent device, in case its child device are
>>>> > > being system suspended before. In other words, the PM core doesn't skip
>>>> > > calling the system sleep callbacks, no matter if the device is runtime
>>>> > > suspended or not.
>>>> > >
>>>> > > In cases of an i2c slave device, the above situation is triggered.
>>>> > > Unfortunate, this also breaks the assumption that the i2c device is always
>>>> > > runtime resumed, whenever the dw_i2c_plat_suspend() callback is being
>>>> > > invoked, which then leads to a regression.
>>>> > >
>>>> > > More precisely, dw_i2c_plat_suspend() then calls clk_core_disable() and
>>>> > > clk_core_unprepare(), for an already disabled/unprepared clock, leading to
>>>> > > complaints about clocks calls being wrongly balanced.
>>>> > >
>>>> > > In cases when the i2c device is attached to the ACPI PM domain, the problem
>>>> > > doesn't occur. That's because ACPI's ->suspend() callback, assigned to
>>>> > > acpi_subsys_suspend(), calls pm_runtime_resume() for the i2c device.
>>>> >
>>>> > Which really is expected to happen, so direct_complete should only be
>>>> > used along with the ACPI PM domain in this case.
>>>> >
>>>> > Moreover, in the ACPI PM domain case acpi_subsys_prepare() is supposed
>>>> > to do the right thing without dw_i2c_plat_prepare() and the return
>>>> > value of the latter will be ignored anyway, so dw_i2c_plat_prepare()
>>>> > will only have effect without ACPI PM domain AFAICS.
>>>> >
>>>> > It looks like commit 8503ff166504 is entirely misguided.
>>>>
>>>> Indeed it is. At the time I suggested that change I did not really
>>>> understand how the direct complete is supposed to be used :-/
>>>
>>> So can we go for a full revert, please, and then fix up things properly?
>>
>> Unfortunate I think a revert is going to make it worse, for the non ACPI case.
>>
>> Because in that case, unless I am reading the code wrong, I think when
>> the device is runtime suspended during system sleep, then the system
>> suspend callback will also be called (because the direct_complete
>> isn't run), again causing clock unbalance issues.
>>
>> This makes it worse in that sense, that then you don't even need an
>> i2c slave to trigger the problem.
>
> In that case your changelog is a bit misleading.

Yeah, it is! I didn't realize that until I fully investigated the revert option.

>
> It looks like the commit in question attempted to fix exactly this
> issue, but it failed, so it should be replaced with something else
> which is what your patch is effectively doing.
>
> IMO you should describe the original problem, explain why that commit
> is not sufficient to fix it and then describe the final fix.
>
> Anyway, after reading the changelog it should be clear that things
> were broken before the commit in question.
>
> And BTW I'm not really sure how the rest of the series is related to this?

Going back in history, I realize the system sleep support in this
driver has been broken even before the commit $subject patch intends
to fix.
However it has been working fine for the ACPI case, because of how the
ACPI PM domain manages its devices during system sleep.

The commit in question, adds an improvement to the driver, because it
enables the direct_complete path. For ACPI, that was already working,
but not for the other cases. So to be able to support the similar
improvement as the direct_complete path offers, as that isn't working
for this driver, I tried out using the runtime PM centric path
instead. That is what the rest of the changes in this series takes
care of.

Now, as the system sleep support is broken I wanted to make a simple
fix for that first, via $subject patch. I guess what makes this a bit
confusing is that I shouldn't point to a certain commit, but rather
just add a stable tag and update the changelog accordingly.

Kind regards
Uffe
