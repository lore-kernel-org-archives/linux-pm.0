From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Wed, 26 Feb 2014 23:02:49 +0100
Message-ID: <CAPDyKFrYUz1D9UQ8KPE47fvNsR4svvtrKSyp1QcgNbmZZCosKw@mail.gmail.com>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
	<1392910280-12891-2-git-send-email-ulf.hansson@linaro.org>
	<7htxblyitw.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50131 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbaBZWCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 17:02:50 -0500
Received: by mail-qa0-f46.google.com with SMTP id i13so1074398qae.33
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2014 14:02:49 -0800 (PST)
In-Reply-To: <7htxblyitw.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 26 February 2014 16:50, Kevin Hilman <khilman@linaro.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> While fetching the proper runtime PM callback, we walk the hierarchy of
>> device's power domains, subsystems and drivers.
>>
>> This is common for rpm_suspend(), rpm_idle() and rpm_resume(). Let's
>> clean up the code by using a macro that handles this.
>>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Alessandro Rubini <rubini@unipv.it>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/runtime.c |   59 ++++++++++++++----------------------------
>>  1 file changed, 20 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 72e00e6..dedbd64 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -13,6 +13,23 @@
>>  #include <trace/events/rpm.h>
>>  #include "power.h"
>>
>> +#define RPM_GET_CALLBACK(dev, cb)                            \
>> +({                                                           \
>> +     if (dev->pm_domain)                                     \
>> +             callback = dev->pm_domain->ops.cb;              \
>> +     else if (dev->type && dev->type->pm)                    \
>> +             callback = dev->type->pm->cb;                   \
>> +     else if (dev->class && dev->class->pm)                  \
>> +             callback = dev->class->pm->cb;                  \
>> +     else if (dev->bus && dev->bus->pm)                      \
>> +             callback = dev->bus->pm->cb;                    \
>> +     else                                                    \
>> +             callback = NULL;                                \
>> +                                                             \
>> +     if (!callback && dev->driver && dev->driver->pm)        \
>> +             callback = dev->driver->pm->cb;                 \
>> +})
>> +
>>  static int rpm_resume(struct device *dev, int rpmflags);
>>  static int rpm_suspend(struct device *dev, int rpmflags);
>>
>> @@ -310,19 +327,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
>>
>>       dev->power.idle_notification = true;
>>
>> -     if (dev->pm_domain)
>> -             callback = dev->pm_domain->ops.runtime_idle;
>> -     else if (dev->type && dev->type->pm)
>> -             callback = dev->type->pm->runtime_idle;
>> -     else if (dev->class && dev->class->pm)
>> -             callback = dev->class->pm->runtime_idle;
>> -     else if (dev->bus && dev->bus->pm)
>> -             callback = dev->bus->pm->runtime_idle;
>> -     else
>> -             callback = NULL;
>> -
>> -     if (!callback && dev->driver && dev->driver->pm)
>> -             callback = dev->driver->pm->runtime_idle;
>> +     RPM_GET_CALLBACK(dev, runtime_idle);
>
> This macro sets the local 'callback' variable, but it's not at all
> obvious when reading the code.  macros with side-effects like this are a
> major readability problem.  Just use a function.
>
> Kevin

Thanks for reviewing Kevin. I got the same comment from Josh - I
totally agree with you guys.

There are a v2 submitted of this patch, please have look.

Kind regards
Uffe
