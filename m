From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 2/2] ACPI/thermal: support for thermal zone description
Date: Fri, 18 Aug 2017 16:31:52 -0600
Message-ID: <c572741f-8714-45f8-d389-9e258464e091@codeaurora.org>
References: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
 <1500054535-975-3-git-send-email-pprakash@codeaurora.org>
 <1502180603.4296.15.camel@intel.com>
 <02b23d6b-a923-3790-5fce-222a11eac951@codeaurora.org>
 <1502288876.5343.19.camel@intel.com>
 <CAJZ5v0iR5eJHPOf2ptL9WPO9TFXthER2awVLFSRvSgYqhSj3wA@mail.gmail.com>
 <1503022487.31913.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1503022487.31913.4.camel@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael/Rui,

On 8/17/2017 8:14 PM, Zhang Rui wrote:
> On Fri, 2017-08-18 at 02:09 +0200, Rafael J. Wysocki wrote:
>> On Wed, Aug 9, 2017 at 4:27 PM, Zhang Rui <rui.zhang@intel.com>
>> wrote:
>>> Hi, Prakash,
>>>
>>> On Tue, 2017-08-08 at 10:01 -0600, Prakash, Prashanth wrote:
>>>> Hi Rui,
>>>>
>>>> On 8/8/2017 2:23 AM, Zhang Rui wrote:
>>>>>
>>>>> On Fri, 2017-07-14 at 11:48 -0600, Prashanth Prakash wrote:
>>>>>>
>>>>>> Per ACPI 6.2 spec, platforms can optionally add a
>>>>>> string(_STR)
>>>>>> object within each thermal zone package which provides a user
>>>>>> friendly name/description.
>>>>>>
>>>>>> Add support to parse the string object, which will be exposed
>>>>>> to userspace by thermal framework.
>>>>>>
>>>>> is there any real request for this?
>>>> Yes, Qualcomm server platforms adds these description strings.
>>>>>
>>>>> _STR is a generic control method for all the ACPI devices.
>>>>> Thus I'm wondering, if really needed, should we expose this in
>>>>> acpi
>>>>> bus
>>>>> instead?
>>>> AFAIK, adding a _STR to any package was not explicitly allowed by
>>>> the
>>>> spec.
>>>> Updates in APCI 6.2 made it legal to add an _STR object to
>>>> thermal
>>>> zone
>>>> specifically, so added this support only to thermal zone.
>>>>
>>> I see that _STR is stated explicitly in 11.4.14, ACPI spec 6.2, but
>>> according to section 6.1.10, "The _STR object evaluates to a
>>> Unicode
>>> string that describes the device or thermal zone. "
>>> _STR is still a generic control method that can exist in any other
>>> device scope.
>>>
>>> so to me, this is a optional but generic feature for all the ACPI
>>> devices, and we don't have a solid reason that it should be part of
>>> thermal sysfs I/F, thus a better solution to me is to expose this
>>> as an
>>> attribute of ACPI device, and we can link to the ACPI device from
>>> thermal sysfs I/F in userspace.
>>>
>>> what do you think, Rafael?
>> Since you have a ->get_desc method, I don't have a big problem with
>> the approach here.
>>
>> I'm not particularly liking the "<not supported>" thing returned if
>> _STR is not present, though.
I will change the implementation such that if _STR object was not found then
thermal_get_desc would return -ENXIO (or should it be different errno?).

> No, actually I mean adding a new sysfs attribute under ACPI device
> node, just like path/hid/status/adr, etc.
Sorry Rui, I didn't read your earlier comment correctly. Thermal zone's _STR is
useful in couple of scenarios(even if ACPI device containing the thermal_zone
had a _STR object):
- When we have more than 1 thermal sensors/zones under a device then this will
allow us to differentiate them
- When we have some thermal sensors that doesn't have ACPI device associated
with it. For example: a shared L3 cache, an abstract region on SoC. In these cases
we can add a thermal zone object in an appropriate place in dsdt and the
associated _STR will allow us to provide a user friendly name/description.
> Of course the attribute should be optional, depends on if the _STR
> control methods exist or not.
>
> thanks,
> rui
>> Thanks,
>> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

Thanks for your feedback!

--
Regards,
Prashanth

