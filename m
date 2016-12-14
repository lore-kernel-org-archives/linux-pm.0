From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: bq24735 charger and ac-detect
Date: Wed, 14 Dec 2016 17:54:10 +0000
Message-ID: <ecd18356-6b7a-1a98-f16d-9bb97caa9c00@nvidia.com>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
 <20161214142502.su4auesnlqmgxspv@earth>
 <20161214145951.uuoijetzat2bxmbv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214145951.uuoijetzat2bxmbv@earth>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 14/12/16 14:59, Sebastian Reichel wrote:
> * PGP Signed by an unknown key
> 
> Hi,
> 
> Ok, Darbha Sriharsha's mail address no longer works, so I Cc'd
> linux-tegra instead. Maybe some of the people there have the
> schematics for one of the Tegra boards using the bq24735 and/or
> could check if charger presence detection actually works on
> those boards with current mainline kernel.
> 
> -- Sebastian
> 
> On Wed, Dec 14, 2016 at 03:25:02PM +0100, Sebastian Reichel wrote:
>> Hi Peter,
>>
>> On Mon, Dec 12, 2016 at 12:12:47AM +0100, Peter Rosin wrote:
>>> Hi!
>>>
>>> I'm wondering about the dt bindings for the bq24735 charger. Specifically
>>> the ac-detect property. The bindings say:
>>
>> I don't have a device with bq24735 and the driver has been added
>> before I was the maintainer of the power-supply subsystem.
>>
>>>  - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapter
>>>    presence. This is a Host GPIO that is configured as an input and
>>>    connected to the bq24735.
>>>
>>> The only way I can make sense of that is if this is the pin on the bq24735
>>> that is named ACOK.
>>
>> Yes. I would expect the same.

I just checked the schematic and it is indeed the ACOK.

>>> But that pin is active high, and the code has this:

Yes I see the same in the TI datasheet.

>>> static bool bq24735_charger_is_present(struct bq24735 *charger)
>>> {
>>> 	if (charger->status_gpio)
>>> 		return !gpiod_get_value_cansleep(charger->status_gpio);
>>> ...
>>>
>>>
>>> (status_gpio is what holds the gpio_desc of ac-detect)
>>>
>>> In other words, the code seems to want a signal that is effectively
>>> active low (the code negates the signal and thus returns "present"
>>> when the signal is zero). The existing dts users all have active high
>>> in their bindings, so it's not like they say active low to work around
>>> the negation in the code...
>>>
>>> This just makes no sense to me and I'm wondering what I'm missing and
>>> what pin is really meant to be fed to ac-detect???
>>>
>>> Yes, there is a pin on the bq24735 that is named ACDET which seems like
>>> a good match, but that is a signal that is entering the bq24735. And it
>>> is also active high, at least the way I read it so the problem persists...

Hmmm ... looking closer at the schematics I see a power-MOSFET in the
path of the ACOK to the Tegra and it looks like this could be inverting
the signal! Seems this was not caught when the code was submitted. This
should have been described in the device-tree somewhere :-(

Jon

-- 
nvpublic
