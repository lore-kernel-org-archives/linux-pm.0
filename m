From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
Date: Wed, 27 Aug 2014 09:26:21 +0200
Message-ID: <CAPDyKFruPum0Xb_pF1x8GW=SC4Q5Eexa96WBAU-q7iTKFfNrUA@mail.gmail.com>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
	<1409054837-5667-2-git-send-email-ulf.hansson@linaro.org>
	<1AE640813FDE7649BE1B193DEA596E880265FDCA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:49635 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbaH0H0X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 03:26:23 -0400
Received: by mail-la0-f43.google.com with SMTP id gi9so13829648lab.30
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 00:26:21 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880265FDCA@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark

On 27 August 2014 07:43, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Ulf Hansson
>> Sent: Tuesday, August 26, 2014 8:07 PM
>> To: Rafael J. Wysocki; Brown, Len; Pavel Machek; Greg Kroah-Hartman; linux-pm@vger.kernel.org
>>
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
>>   */
>>  void acpi_dev_pm_detach(struct device *dev, bool power_off)
>
> Should the return type be "int" here?

You are right, thanks!

Kind regards
Uffe

>
> Thanks and best regards
> -Lv
>
>>  {
>> @@ -1107,7 +1109,9 @@ void acpi_dev_pm_detach(struct device *dev, bool power_off)
>>                       acpi_device_wakeup(adev, ACPI_STATE_S0, false);
>>                       acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
>>               }
>> +             return 0;
>>       }
>> +     return -ENODEV;
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
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
