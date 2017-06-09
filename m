From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] thermal: int340x: check for sensor when PTYP is missing
Date: Sat, 10 Jun 2017 01:36:34 +0300
Message-ID: <CAHp75VfV+Cx7fKnCQyHs8WzrYTuz-Uvii99jy7dToBCv-wHRQg@mail.gmail.com>
References: <1496790041-104500-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAHp75VfvVNFRiVMnGEe96C84AkxKs=hR29q8dp701Q4OyNO47g@mail.gmail.com> <1497046994.26258.9.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36671 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdFIWgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 18:36:49 -0400
In-Reply-To: <1497046994.26258.9.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jun 10, 2017 at 1:23 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Wed, 2017-06-07 at 13:55 +0300, Andy Shevchenko wrote:
>> On Wed, Jun 7, 2017 at 2:00 AM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:

>> > This change checks for the presence of _TMP method and if present,
>> > then
>> > treats this device as a sensor.
>> >
>> >         status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
>> >                                        NULL, &priv->type);
>> >         if (ACPI_FAILURE(status)) {
>> > -               result = -EINVAL;
>> > -               goto err;
>> >
>> > +               unsigned long long tmp;
>> You may use &priv->type as temporary variable, though I would go
>> other
>> way around:
>> declare tmp for function, then
>>
>>     unsigned long long tmp;
>> ...
>>     status = acpi_evaluate_integer(priv->adev->handle, "PTYP",  NULL,
>> &tmp);
>>     if (ACPI_FAILURE(status)) {
>>         status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
>> NULL, &tmp);
>>         if (ACPI_FAILURE(status)) {
>>             result = -EINVAL;
>>             goto err;
>>         }
>>         tmp = INT3403_TYPE_SENSOR;
>>     }
>>     priv->type = tmp;
>>
> So what are we saving by doing this way?

We make priv->type assignment in one place.

That's the difference.

So, you may choose your way of course. It's not a big deal.

-- 
With Best Regards,
Andy Shevchenko
