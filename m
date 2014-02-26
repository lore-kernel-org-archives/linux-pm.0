From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Thu, 27 Feb 2014 00:13:54 +0100
Message-ID: <CAPDyKFqCHXj-O5EwYLQXpfs5oko=Yfi_ZLmQwKVVW8AjUSUZfQ@mail.gmail.com>
References: <1393237368-15500-1-git-send-email-ulf.hansson@linaro.org>
	<7hk3chwkbp.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:45236 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaBZXNz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 18:13:55 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so3159270qab.23
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2014 15:13:54 -0800 (PST)
In-Reply-To: <7hk3chwkbp.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

On 27 February 2014 00:00, Kevin Hilman <khilman@linaro.org> wrote:
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
>>
>> Changes in v2:
>>       Updated the macro to return a callback instead.
>>       Suggested by Josh Cartwright.
>>
>> ---
>>  drivers/base/power/runtime.c |   63 ++++++++++++++++--------------------------
>>  1 file changed, 24 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 72e00e6..cc7d1ed 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -13,6 +13,27 @@
>>  #include <trace/events/rpm.h>
>>  #include "power.h"
>>
>> +#define RPM_GET_CALLBACK(dev, cb)                            \
>> +({                                                           \
>> +     int (*__rpm_cb)(struct device *__d);                    \
>> +                                                             \
>> +     if (dev->pm_domain)                                     \
>> +             __rpm_cb = dev->pm_domain->ops.cb;              \
>> +     else if (dev->type && dev->type->pm)                    \
>> +             __rpm_cb = dev->type->pm->cb;                   \
>> +     else if (dev->class && dev->class->pm)                  \
>> +             __rpm_cb = dev->class->pm->cb;                  \
>> +     else if (dev->bus && dev->bus->pm)                      \
>> +             __rpm_cb = dev->bus->pm->cb;                    \
>> +     else                                                    \
>> +             __rpm_cb = NULL;                                \
>> +                                                             \
>> +     if (!__rpm_cb && dev->driver && dev->driver->pm)        \
>> +             __rpm_cb = dev->driver->pm->cb;                 \
>> +                                                             \
>> +     __rpm_cb;                                               \
>> +})
>
> So the main question from v1 remains: why use a macro, and not a function?
>

I am no big fan of macros, but in this case I thought it make sense.
Using _a_ function would not be enough, since we would need three, one
for each runtime PM callback (suspend, idle, resume), right?

I am happy to change to whatever you guys thinks best, I have no strong opinion.

Kind regards
Uffe

> Kevin
