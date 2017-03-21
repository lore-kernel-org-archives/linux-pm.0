From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 03/15] extcon: cht-wc: Add Intel Cherry Trail Whiskey Cove
 PMIC extcon driver
Date: Tue, 21 Mar 2017 14:21:44 +0900
Message-ID: <58D0B868.6060602@samsung.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <CGME20170317095544epcas5p42dd4115627c9cf9de3911b433024ac93@epcas5p4.samsung.com>
 <20170317095527.10487-4-hdegoede@redhat.com> <58CF3183.4090101@samsung.com>
 <1490014841.19767.106.camel@linux.intel.com> <58D0A3E8.6090609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <58D0A3E8.6090609@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017년 03월 21일 12:54, Chanwoo Choi wrote:
> On 2017년 03월 20일 22:00, Andy Shevchenko wrote:
>> On Mon, 2017-03-20 at 10:33 +0900, Chanwoo Choi wrote:
>>> On 2017년 03월 17일 18:55, Hans de Goede wrote:
>>
>>>> +static const struct platform_device_id cht_wc_extcon_table[] = {
>>>> +	{ .name = "cht_wcove_pwrsrc" },
>>>
>>> You use the 'cht_wc' word instead of 'cht_wcove_pwrsrc'.
>>> So, To maintain the consistency, you better to use the 'cht-wc' as the
>>> name.
>>> - I prefer to use '-' instead of '_' in the name.
>>> 	.name ="cht-wc"
>>
>> I would keep as Hans did for the sake of consistency among all Whiskey
>> Cove device drivers (and predecessors like Crystal Cove).
> 
> The 'wcove' short word is not used in this patch.
> If the author want to use the 'wcove', I recommend that
> you should use the 'wcove' instead of 'wc' in this patch.
> 
> And, I think that  'pwrsrc' is not ambiguous.

I'm sorry. I used the wrong word. I mean that 'pwrsrc' is not correct.

> Hans might use the 'pwrsrc' as the 'Power Source'.
> But, this driver is not power source. Instead,
> this driver supports the detection of external connector.
> 
> I think 'power source' means the power supply instead of detector.
> 
>>
>> I understand your point from extcon subsystem view, but PMICs like
>> Whiskey Cove are multi-functional devices, and thus naming across them
>> (same prefix in use to be precise) is better idea.
>>
>>>
>>>> +	{},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(platform, cht_wc_extcon_table);
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
