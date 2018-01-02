From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/3] gpio: rcar: Use WAKEUP_PATH driver PM flag
Date: Tue, 2 Jan 2018 16:41:30 +0100
Message-ID: <CAPDyKFrFe_V0SVH_yCzfLAJ2mObvGGPELFUb8WOAFKGjqohN5w@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
 <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0gWtr1bwi7WVeEbTJPu3KC8YfPvfUh5XDmomiK8TFmfyg@mail.gmail.com>
 <CAMuHMdVmqM+WA_EaCRHNojpV6NYmS0-V18MoixyV5UdC3cq+2g@mail.gmail.com>
 <CAJZ5v0j7r_-TJA=n6ohC_iFc_0Tei9nfVZUN5rjB0n0CxYkMgQ@mail.gmail.com>
 <CAPDyKFqcv8+B=xL_NSzydNYOH_ZzdJuqmrX72jsy=-FNnEf=tw@mail.gmail.com> <CAMuHMdUuQP4_Zw+PfSwtdnwsbSeGGAh7fEf2bveAFNe1tRuLFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:41357 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeABPlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 10:41:31 -0500
Received: by mail-it0-f68.google.com with SMTP id x28so39124264ita.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 07:41:31 -0800 (PST)
In-Reply-To: <CAMuHMdUuQP4_Zw+PfSwtdnwsbSeGGAh7fEf2bveAFNe1tRuLFw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2 January 2018 at 14:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Jan 2, 2018 at 1:53 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 2 January 2018 at 11:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Tue, Jan 2, 2018 at 11:44 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Tue, Jan 2, 2018 at 11:32 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>> On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>> --- a/drivers/gpio/gpio-rcar.c
>>>>>> +++ b/drivers/gpio/gpio-rcar.c
>>>>
>>>>>> @@ -415,6 +402,18 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
>>>>>>         return 0;
>>>>>>  }
>>>>>>
>>>>>> +#ifdef CONFIG_PM_SLEEP
>>>>>> +static int gpio_rcar_suspend(struct device *dev)
>>>>>> +{
>>>>>> +       struct gpio_rcar_priv *p = dev_get_drvdata(dev);
>>>>>> +
>>>>>> +       dev_pm_set_driver_flags(dev, p->wakeup_path ? DPM_FLAG_WAKEUP_PATH : 0);
>>>>>
>>>>> Why don't you simply set dev->power.wakeup_path here?
>>>>
>>>> That's what my v1 did (https://patchwork.kernel.org/patch/10050995/).
>>>
>>> I very much prefer this one. :-)
>>
>> Okay!
>
>>> What's wrong with it?
>>
>> It works, although I would rather change the assignment of the flag to
>> respect if the current value is true, something like this:
>>
>> dev->power.wakeup_path = dev->power.wakeup_path || p->wakeup_path;
>
> dev->power.wakeup_path |= p->wakeup_path?

Yeah, correct.

Br
Uffe
