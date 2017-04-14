From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 2/3] power: supply: bq24190_charger: Do not reset the
 charger on probe by default
Date: Fri, 14 Apr 2017 06:25:28 -0700
Message-ID: <CAKvHMgR_y9djwVKZzF-0L3VD4iRUExL0zaaAGXFDyu_cnpTkXQ@mail.gmail.com>
References: <20170412181808.31768-1-hdegoede@redhat.com> <20170412181808.31768-3-hdegoede@redhat.com>
 <CAKvHMgTxYa7U+u0W5On9+xgViWuGX5PFMi865f_2HojrnLM-aQ@mail.gmail.com>
 <72abeafe-1378-50a3-69a5-28f9ab837dcc@redhat.com> <CAKvHMgT-uX4oAhtieYQ+XVNLVWVnhy3-NE5FUuq7RaNSbZDURA@mail.gmail.com>
 <0b4d4397-50e1-7dfa-6a00-82a2b3323e12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34701 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdDNNZa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 09:25:30 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so18597816ioi.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 06:25:29 -0700 (PDT)
In-Reply-To: <0b4d4397-50e1-7dfa-6a00-82a2b3323e12@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Fri, Apr 14, 2017 at 5:44 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 14-04-17 12:34, Liam Breck wrote:
>>
>> G'day Hans,
>>
>> On Thu, Apr 13, 2017 at 4:54 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 13-04-17 01:06, Liam Breck wrote:
>
>
> <snip>
>
>
>>>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>>>> b/drivers/power/supply/bq24190_charger.c
>>>>> index bd9e5c3..ad429b7 100644
>>>>> --- a/drivers/power/supply/bq24190_charger.c
>>>>> +++ b/drivers/power/supply/bq24190_charger.c
>>>>> @@ -1382,9 +1382,11 @@ static int bq24190_hw_init(struct
>>>>> bq24190_dev_info
>>>>> *bdi)
>>>>>                 return -ENODEV;
>>>>>         }
>>>>>
>>>>> -       ret = bq24190_register_reset(bdi);
>>>>> -       if (ret < 0)
>>>>> -               return ret;
>>>>> +       if (device_property_read_bool(bdi->dev, "reset-on-probe")) {
>>>>> +               ret = bq24190_register_reset(bdi);
>>>>> +               if (ret < 0)
>>>>> +                       return ret;
>>>>> +       }
>>>>
>>>>
>>>>
>>>> Maybe check property and return if true in register_reset(), instead
>>>> of adjusting all the calls. There would be a set_mode_host() in
>>>> resume() which is unnecessary, but it's a no-op to set host mode when
>>>> we're already in it.
>>
>>
>> Please check the property in register_reset() instead of at the
>> callers. It's much cleaner.
>>
>>> i2c transfers are quite slow, so it is better to avoid doing unnecessary
>>> i2c transfers.
>>
>>
>> It's only a few bytes, and only on resume,
>
>
> Ok, I can send a v5 with the condition moved to bq24190_register_reset()
>
>> but an extra condition
>> there would be OK.
>>
>>>> Perhaps device_property_present() since _read_bool() implies we expect
>>>> it to be set T or F?
>>>
>>>
>>>
>>> From include/linux/property.h:
>>>
>>> static inline bool device_property_read_bool(struct device *dev,
>>>                                              const char *propname)
>>> {
>>>         return device_property_present(dev, propname);
>>> }
>>>
>>> So nope _read_bool() does not expect true or false, it works
>>> just like devicetree properties
>>
>>
>> I did examine the source before suggesting _present(). It's a
>> semantics question: _read_bool() suggests that a property is expected,
>> whereas _present() doesn't.
>
>
> _read_bool suggests that we are checking a boolean value, which
> is exactly what we're doing, _present() could be used to see
> if any value integer / string / whatever is present which is
> not what we want. That under the hood bool's are implement
> by being present == true and not present == false is an
> implementation detail which the _read_bool is abstracting
> away.
>
>
>>
>>>> Let's keep the original reset behavior as the default,
>>>
>>>
>>>
>>> Tony Lindgren suggested to do disable reset by default:
>>>
>>> On 04-04-17 02:56, Tony Lindgren wrote:
>>>
>>>> My guess is that the reset is left over from missing handling of
>>>> clearing of the EN_HIZ on errors. I recall that EN_HIZ error can
>>>> happen when plugging the cable a little bit sideways to a USB hub
>>>> with loose tolerance USB connectors.
>>>>
>>>> So it should be safe to limit the reset to only happen if something
>>>> like "reset-on-probe" is specified. Not sure we want to remove it
>>>> completely, maybe just add notes that reset may misbehave in
>>>> some conditions.
>>>
>>>
>>> And I agree that that is the best way, as it simply does not seem
>>> necessary to reset the charger.
>>
>>
>> However, I don't think it's kosher to change a default behavior that's
>> four years old without a deprecation warning which persists for
>> several kernel releases, including at least one LTS.
>
>
> That is a fair argument.
>
>> The absence of evidence for other users of this driver is not evidence
>> of their absence.
>>
>> And we have yet to confirm that the confused-charger issue you see is
>> a flaw in the charger, vs that board. If it's not a charger bug, I
>> suspect that reset may be a valid default for probe/remove(), tho
>> perhaps not suspend/resume(). But that is a debate for another day.
>>
>> So how about a property preset-registers = <reg id list>; which would
>> enable us to save/restore them if nec later. For the purpose of
>> skipping reset, just use _present(). A different term than "preset"
>> could work, e.g. programmed, configured...
>
>
> That sounds like something for a different patch. You've convinced
> me that keeping the default behavior the same is the best, so I will
> submit a v6 which adds a "disable-reset" property.

But "preset-registers" is the actual circumstance here, and more
information/context, even if we don't use it all in this patch, is
preferable.
