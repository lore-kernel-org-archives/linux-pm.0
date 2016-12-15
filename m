From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: bq24735 charger and ac-detect
Date: Thu, 15 Dec 2016 13:04:41 +0100
Message-ID: <bfc89f2f-fbcb-2a04-e679-832fef1f0948@axentia.se>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
 <20161214142502.su4auesnlqmgxspv@earth>
 <20161214145951.uuoijetzat2bxmbv@earth>
 <ecd18356-6b7a-1a98-f16d-9bb97caa9c00@nvidia.com>
 <84ede737-9e4c-b0ba-5a37-a96a7e86c3ec@axentia.se>
 <21e09552-96b9-fb72-60be-7a4b9347b761@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21e09552-96b9-fb72-60be-7a4b9347b761-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 2016-12-15 11:45, Jon Hunter wrote:
> 
> On 14/12/16 21:22, Peter Rosin wrote:
>> On 2016-12-14 18:54, Jon Hunter wrote:
> 
> ...
> 
>>> Hmmm ... looking closer at the schematics I see a power-MOSFET in the
>>> path of the ACOK to the Tegra and it looks like this could be inverting
>>> the signal! Seems this was not caught when the code was submitted. This
>>> should have been described in the device-tree somewhere :-(
>>
>> That's what I suspected...
>>
>> Ok, I expect the ship has sailed and that it's too late to actually fix
>> this up with active-low in various Tegra dts files and removing the negation
>> in the code, without causing ripples and regressions? Because that would
>> be the clean fix!
> 
> Yes, unfortunately it has sailed as we cannot break compatibility AFAIK.
> However, that said, I am not 100% certain for cases where there is a bug
> like this.
> 
> I did double check this morning and verified that the gpio is low when
> the charger is connected and so it is inverted.

Thanks!

>> One other thing to possibly do is add a new binding that is not negated,
>> and perhaps named after the pin in the data-sheet, i.e. ti,acok-gpios,
>> and deprecate ti,ac-detect-gpios. But that's no fun as it leaves a bunch of
>> compat code that wastes space and some lucky person has to maintain it.
>>
>> Perhaps the best thing to do is to just re-document ti,ac-detect-gpios
>> to be the inverse of what is currently described, i.e. to be AC absence
>> instead of AC presence? But that feels like giving up and it isn't really
>> nice from a device-tree point of view either, but I guess those points are
>> fairly accademic? Or are there any non-Linux users of this binding? How are
>> these things handled when they pop up elsewhere?
> 
> I guess that ideally the polarity should have been specified correctly
> by the gpio property, but even this looks wrong for Tegra as it is
> GPIO_ACTIVE_HIGH and not LOW.

It's exactly this GPIO_ACTIVE_HIGH that is wrong. It should have been
active low since the signal is active high from the charger, but inverted
on its way to the gpio pin, so from the gpio point of view the signal
is active-low.

What a mess, the only thing that is right is the bindings. It says that the
gpio is active when AC is present, which makes perfect sense and matches the
name of the property.

Then all the Tegra dts users violate that and say active-high when in fact
the signal is inverted on the path to the pin, so should have been active-low.

Then the driver code "saves the day" for the Tegra users by reversing the
inversion in the signal-path, but that is of course only helping Tegra and
and others not following the dt specification.

>                               The only other option is to add another
> property called something like 'ti,ac-detect-override-pol' to specify
> the polarity you want.

How is that helping? It's no different that just saying active-low for
boards that do not invert ACOK (which is what I currently do in my dts,
but I hate doing it since it doesn't match dt docs and is therefore just
wrong).

> To be honest, I am not sure how this type of thing is normally handled.
> So probably best to put together a patch with whatever option you feel
> best and explain why this is needed and see what the dev-tree folks say.

I suspect that at the end of the day documentation is less important than
regressions. But if there are more than one implementation of the same
spec and Linux is not following it, it's kind of harsh to change the spec
to match Linux. I doubt that there are any other users in this case though,
but what do I know?

I'll send a patch re-documenting ti,ac-detect-gpios to specify AC absence
instead of AC presence, let's see what the dt people thinks...

Cheers,
peda
