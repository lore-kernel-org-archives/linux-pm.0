From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/9] PM / Domains: Add APIs to attach/detach a power
 domain for a device
Date: Wed, 27 Aug 2014 09:38:41 +0200
Message-ID: <CAPDyKFpfQApUFtgjJ9mLGzSJbRiYzCVR-yYZcheWKWBc9x+Zag@mail.gmail.com>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
	<1409054837-5667-4-git-send-email-ulf.hansson@linaro.org>
	<4718058.Ou8igBffVK@vostro.rjw.lan>
	<CAPDyKFoMjYaTzD1+Z9dxByMYZv3Qo4xKyMFT7XKRyq7oijr9ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:52957 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932712AbaH0Him (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 03:38:42 -0400
Received: by mail-la0-f50.google.com with SMTP id pi18so16429707lab.9
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 00:38:41 -0700 (PDT)
In-Reply-To: <CAPDyKFoMjYaTzD1+Z9dxByMYZv3Qo4xKyMFT7XKRyq7oijr9ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the->

On 27 August 2014 09:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 27 August 2014 02:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, August 26, 2014 02:07:11 PM Ulf Hansson wrote:
>>> To maintain scalability let's add common methods to attach and detach
>>> a power domain for a device, dev_pm_domain_attach|detach().
>>>
>>> Typically dev_pm_domain_attach() shall be invoked from subsystem level
>>> code at the probe phase to try to attach a device to it's power domain.
>>> The reversed actions may be done a the remove phase and then by invoking
>>> dev_pm_domain_detach().
>>>
>>> The supported power domains at this point are the ACPI and the generic
>>> power domains.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/common.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pm.h          | 14 +++++++++++
>>>  2 files changed, 72 insertions(+)
>>>
>>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>>> index df2e5ee..f544128 100644
>>> --- a/drivers/base/power/common.c
>>> +++ b/drivers/base/power/common.c
>>> @@ -11,6 +11,8 @@
>>>  #include <linux/export.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/pm_clock.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/pm_domain.h>
>>>
>>>  /**
>>>   * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
>>> @@ -82,3 +84,59 @@ int dev_pm_put_subsys_data(struct device *dev)
>>>       return ret;
>>>  }
>>>  EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
>>> +
>>> +/**
>>> + * dev_pm_domain_attach - Attach a device to it's power domain.
>>> + * @dev: Device to attach.
>>> + * @power_on: Used to indicate whether we should power on the device.
>>> + *
>>> + * The @dev may only be attached to a single power domain. By iterating through
>>> + * the available alternatives we try to find a valid domain for the device.
>>> + *
>>> + * This function should typically be invoked from subsystem level code during
>>> + * the probe phase. Especially for those that's hold devices which requires
>>> + * power management through power domains.
>>> + *
>>> + * Callers must ensure proper synchronization of this function with power
>>> + * management callbacks.
>>> + *
>>> + * Returns 0 on successfully attached power domain or negative error code.
>>> + */
>>> +int dev_pm_domain_attach(struct device *dev, bool power_on)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = acpi_dev_pm_attach(dev, power_on);
>>> +     if (ret == -EPROBE_DEFER)
>>
>> This doesn't seem to be possible today.  At least I'm not sure how it can
>> happen.
>
> You are right, but I did this intentionally. The reason for having
> this check, was that I didn't want the new API to put the limit on
> handling deferred probe.
>
> I happy the above check, if you think it's better!?

s/happy/happy to change

>
> Kind regards
> Uffe
>
>>
>>> +             return ret;
>>> +     else
>>> +             ret = genpd_dev_pm_attach(dev);
>>> +
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>>
>> On a more general note, are you sure that the place where we call
>> acpi_dev_pm_attach() will always be suitable for calling genpd_dev_pm_attach()?
>>
>
> Currently, I haven't seen any place where it doesn't make sense.
>
> Additionally if such place is found, we may either just ignore it and
> let the caller of the API worry about the returned error or invoke the
> genpd/acpi API immediately instead.
>
>>> +
>>> +/**
>>> + * dev_pm_domain_detach - Detach a device from it's power domain.
>>> + * @dev: Device to attach.
>>> + * @power_off: Used to indicate whether we should power off the device.
>>> + *
>>> + * The @dev may be attached to a power domain. By iterating through the
>>> + * available alternatives we detach it from it's power domain.
>>> + *
>>> + * This functions will reverse the actions from dev_pm_domain_attach() and
>>> + * thus detach the @dev from it's power domain. Typically it should be invoked
>>> + * from subsystem level code during the remove phase.
>>> + *
>>> + * Callers must ensure proper synchronization of this function with power
>>> + * management callbacks.
>>> + *
>>> + * Returns 0 on successfully detached power domain or negative error code.
>>> + */
>>> +int dev_pm_domain_detach(struct device *dev, bool power_off)
>>> +{
>>> +     if (acpi_dev_pm_detach(dev, power_off))
>>> +             return genpd_dev_pm_detach(dev);
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
>>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>>> index 72c0fe0..8176b07 100644
>>> --- a/include/linux/pm.h
>>> +++ b/include/linux/pm.h
>>> @@ -621,6 +621,20 @@ struct dev_pm_domain {
>>>       struct dev_pm_ops       ops;
>>>  };
>>>
>>> +#ifdef CONFIG_PM
>>> +extern int dev_pm_domain_attach(struct device *dev, bool power_on);
>>> +extern int dev_pm_domain_detach(struct device *dev, bool power_off);
>>> +#else
>>> +static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
>>> +{
>>> +     return -ENODEV;
>>> +}
>>> +static inline int dev_pm_domain_detach(struct device *dev, bool power_off)
>>> +{
>>> +     return -ENODEV;
>>> +}
>>> +#endif
>>> +
>>>  /*
>>>   * The PM_EVENT_ messages are also used by drivers implementing the legacy
>>>   * suspend framework, based on the ->suspend() and ->resume() callbacks common
>>>
>>
>> --
>> I speak only for myself.
>> Rafael J. Wysocki, Intel Open Source Technology Center.
