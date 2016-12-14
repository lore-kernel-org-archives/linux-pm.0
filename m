From: Peter Rosin <peda@axentia.se>
Subject: Re: bq24735 charger and ac-detect
Date: Wed, 14 Dec 2016 22:22:54 +0100
Message-ID: <84ede737-9e4c-b0ba-5a37-a96a7e86c3ec@axentia.se>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
 <20161214142502.su4auesnlqmgxspv@earth>
 <20161214145951.uuoijetzat2bxmbv@earth>
 <ecd18356-6b7a-1a98-f16d-9bb97caa9c00@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:2944
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752925AbcLNViK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 16:38:10 -0500
In-Reply-To: <ecd18356-6b7a-1a98-f16d-9bb97caa9c00@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Sebastian Reichel <sre@kernel.org>, linux-tegra@vger.kernel.org
Cc: linux-pm@vger.kernel.org

On 2016-12-14 18:54, Jon Hunter wrote:
> 
> On 14/12/16 14:59, Sebastian Reichel wrote:
>> * PGP Signed by an unknown key
>>
>> Hi,
>>
>> Ok, Darbha Sriharsha's mail address no longer works, so I Cc'd
>> linux-tegra instead. Maybe some of the people there have the
>> schematics for one of the Tegra boards using the bq24735 and/or
>> could check if charger presence detection actually works on
>> those boards with current mainline kernel.
>>
>> -- Sebastian
>>
>> On Wed, Dec 14, 2016 at 03:25:02PM +0100, Sebastian Reichel wrote:
>>> Hi Peter,
>>>
>>> On Mon, Dec 12, 2016 at 12:12:47AM +0100, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> I'm wondering about the dt bindings for the bq24735 charger. Specifically
>>>> the ac-detect property. The bindings say:
>>>
>>> I don't have a device with bq24735 and the driver has been added
>>> before I was the maintainer of the power-supply subsystem.
>>>
>>>>  - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapter
>>>>    presence. This is a Host GPIO that is configured as an input and
>>>>    connected to the bq24735.
>>>>
>>>> The only way I can make sense of that is if this is the pin on the bq24735
>>>> that is named ACOK.
>>>
>>> Yes. I would expect the same.
> 
> I just checked the schematic and it is indeed the ACOK.

Good to know, thanks!

>>>> But that pin is active high, and the code has this:
> 
> Yes I see the same in the TI datasheet.
> 
>>>> static bool bq24735_charger_is_present(struct bq24735 *charger)
>>>> {
>>>> 	if (charger->status_gpio)
>>>> 		return !gpiod_get_value_cansleep(charger->status_gpio);
>>>> ...
>>>>
>>>>
>>>> (status_gpio is what holds the gpio_desc of ac-detect)
>>>>
>>>> In other words, the code seems to want a signal that is effectively
>>>> active low (the code negates the signal and thus returns "present"
>>>> when the signal is zero). The existing dts users all have active high
>>>> in their bindings, so it's not like they say active low to work around
>>>> the negation in the code...
> 
> Hmmm ... looking closer at the schematics I see a power-MOSFET in the
> path of the ACOK to the Tegra and it looks like this could be inverting
> the signal! Seems this was not caught when the code was submitted. This
> should have been described in the device-tree somewhere :-(

That's what I suspected...

Ok, I expect the ship has sailed and that it's too late to actually fix
this up with active-low in various Tegra dts files and removing the negation
in the code, without causing ripples and regressions? Because that would
be the clean fix!

One other thing to possibly do is add a new binding that is not negated,
and perhaps named after the pin in the data-sheet, i.e. ti,acok-gpios,
and deprecate ti,ac-detect-gpios. But that's no fun as it leaves a bunch of
compat code that wastes space and some lucky person has to maintain it.

Perhaps the best thing to do is to just re-document ti,ac-detect-gpios
to be the inverse of what is currently described, i.e. to be AC absence
instead of AC presence? But that feels like giving up and it isn't really
nice from a device-tree point of view either, but I guess those points are
fairly accademic? Or are there any non-Linux users of this binding? How are
these things handled when they pop up elsewhere?

Cheers,
peda

