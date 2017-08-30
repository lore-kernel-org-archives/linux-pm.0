From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
Date: Wed, 30 Aug 2017 11:57:28 +0200
Message-ID: <CAPDyKFosu8RYUUCiBn7+03b3TNmND-aCTqR=+svcvzCwhxw9+A@mail.gmail.com>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <1957183.ZU1CWrAZoR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1957183.ZU1CWrAZoR@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 August 2017 at 22:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 29, 2017 4:56:42 PM CEST Ulf Hansson wrote:
>> The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
>> isn't well optimized for system sleep.
>>
>> What makes this driver particularly interesting is because it's a cross-SoC
>> driver, which sometimes means there is an ACPI PM domain attached to the i2c
>> device and sometimes not. The driver is being used on both x86 and ARM.
>>
>> In principle, to optimize the system sleep support in i2c driver, this series
>> enables the proven runtime PM centric path for the i2c driver. However, to do
>> that the ACPI PM domain also have to collaborate and understand this behaviour.
>> From earlier versions, Rafael has also pointed out that also the PM core needs
>> to be involved.
>
> Earlier today I realized that drivers pointing their ->suspend_late and
> ->resume_early callbacks, respectively, to pm_runtime_force_suspend() and
> pm_runtime_force_resume(), are fundamentally incompatible with any bus type
> doing nontrivial PM and with almost any nontrivial PM domains, for two reasons.
>
> First, it basically requires the bus type or PM domain to expect that its
> ->runtime_suspend callback may or may not be indirectly invoked from its
> own ->suspend_late callback, depending on the driver (and analogously
> for ->runtime_resume and ->resume early), which is insane.
>
> Second, it is a layering violation, because it makes the driver effectively
> override the upper layer's decisions about what code to run.

You are right that for more complex bus types and PM domains, those
needs to play along. So that is what I am trying to implement for the
ACPI PM domain in this series.

The generic PM domain, is simple in this regards. There is only a
minor adaptation for the ->runtime_suspend|resume() callbacks, which
avoids validating dev_pm_qos constraints during system sleep. Nothing
special is needed in ->suspend_late|noirq callbacks, etc.

For most other simple bus types, like the platform bus, spi, i2c,
amba, no particular adoptions is needed at all. Instead those just
trust the drivers to do the right thing.

Before we had the direct_complete path, using the
pm_runtime_force_suspend|resume() helpers, was the only good way for
these kind of drivers, to in an optimized manner, deal with system
sleep when runtime PM also was enabled for their devices. Now this
method has become widely deployed, unfortunate whether you like it or
not.

Besides the slightly better optimizations you get when using
pm_runtime_force_suspend|resume(), comparing to the direct_complete
path - I think it's also worth to consider, how easy it becomes for
drivers to deploy system sleep support. In many cases, only two lines
of code is needed to add system sleep support in a driver.

Now, some complex code always needs to be implemented somewhere. When
using the runtime PM centric path, that code consist of the
pm_runtime_force_suspend|resume() helpers itself - and some
adaptations in buses/PM domains in cases when those needs special
care.

My point is, the runtime PM centric path, allows us to keep the
complex part of the code at a few centralized places, instead of
having it spread/duplicated into drivers.

So yes, you could consider it insane, but to me and many others, it
seems to work out quite well.

Yeah, and the laying violation is undoubtedly the most controversial
part of the runtime PM centric path - I agree to that! The
direct_complete path don't have this, as you implemented it. :-)

On the other hand, one could consider that these upper layers, in many
cases anyway needs to play along with the behavior of the driver. So,
I guess it depends on how one see it.

>
> That's why I'm afraid that we've reached a dead end here. :-(

That's said news. Is was really hoping I could find a way to move this
forward. You don't have any other ideas on how I can adjust the series
to make you happy?

>
> Thanks,
> Rafael
>

Kind regards
Uffe
