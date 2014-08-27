From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
Date: Wed, 27 Aug 2014 09:25:21 +0200
Message-ID: <CAPDyKFpgf+Qn5xa7FLFvk3KGNW_6k8XPVECHb2+6aZbiQccwgg@mail.gmail.com>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
	<1409054837-5667-2-git-send-email-ulf.hansson@linaro.org>
	<1959719.tXfePhObS9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:54745 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbaH0HZX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 03:25:23 -0400
Received: by mail-la0-f44.google.com with SMTP id el20so16325790lab.31
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 00:25:21 -0700 (PDT)
In-Reply-To: <1959719.tXfePhObS9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the->

On 27 August 2014 02:16, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 26, 2014 02:07:09 PM Ulf Hansson wrote:
>> To give callers the option of acting on a errors while removing the
>> pm_domain ops for the device in the ACPI power domain, let
>> acpi_dev_pm_detach() return an int to provide the error code.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/acpi/device_pm.c | 4 ++++
>>  include/linux/acpi.h     | 7 +++++--
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index 67075f8..fa78abb 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -1087,6 +1087,8 @@ EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>>   *
>>   * Callers must ensure proper synchronization of this function with power
>>   * management callbacks.
>> + *
>> + * Returns 0 on successfully detached power domain or negative error code.
>
> "PM domain" here, please, not "power domain".
>

Sure.

If you prefer that term, I can also change on the other patches in
this patchset. There are commit-msg etc , where I think I have used
"power domain".

>>   */
>>  void acpi_dev_pm_detach(struct device *dev, bool power_off)
>
> It looks like you've never compiled this, have you?

You are absolutely right. There were quite some combinations of
CONFIG_PM_* that I tried out, but I totally forgot ACPI, sorry! I will
make sure to do it in v2.

>
>>  {
>> @@ -1107,7 +1109,9 @@ void acpi_dev_pm_detach(struct device *dev, bool power_off)
>>                       acpi_device_wakeup(adev, ACPI_STATE_S0, false);
>>                       acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
>>               }
>> +             return 0;
>>       }
>> +     return -ENODEV;
>
> -EINVAL perhaps?

Sure!

>
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_dev_pm_detach);
>>  #endif /* CONFIG_PM */
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 5320153..a7bfdf6 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -576,7 +576,7 @@ static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
>>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
>>  struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
>>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
>> -void acpi_dev_pm_detach(struct device *dev, bool power_off);
>> +int acpi_dev_pm_detach(struct device *dev, bool power_off);
>>  #else
>>  static inline struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
>>  {
>> @@ -586,7 +586,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>>  {
>>       return -ENODEV;
>>  }
>> -static inline void acpi_dev_pm_detach(struct device *dev, bool power_off) {}
>> +static inline int acpi_dev_pm_detach(struct device *dev, bool power_off)
>> +{
>> +     return -ENODEV;
>> +}
>>  #endif
>>
>>  #ifdef CONFIG_ACPI
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

Thanks for reviewing!

Kind regards
Uffe
