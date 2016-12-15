From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: bq24735 charger and ac-detect
Date: Thu, 15 Dec 2016 16:10:54 +0000
Message-ID: <4a01ae9a-9184-63f3-ecb9-4e5a6e2375e2@nvidia.com>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
 <20161214142502.su4auesnlqmgxspv@earth>
 <20161214145951.uuoijetzat2bxmbv@earth>
 <ecd18356-6b7a-1a98-f16d-9bb97caa9c00@nvidia.com>
 <84ede737-9e4c-b0ba-5a37-a96a7e86c3ec@axentia.se>
 <21e09552-96b9-fb72-60be-7a4b9347b761@nvidia.com>
 <bfc89f2f-fbcb-2a04-e679-832fef1f0948@axentia.se>
 <721122dd-dda8-1830-9224-40b5ed79e463@nvidia.com>
 <1316ab3d-8a75-6a03-e1d0-7dee55f2c90f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316ab3d-8a75-6a03-e1d0-7dee55f2c90f-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 15/12/16 15:34, Peter Rosin wrote:
> On 2016-12-15 15:04, Jon Hunter wrote:
>>
>> On 15/12/16 12:04, Peter Rosin wrote:
>>
>> ...
>>
>>>>                               The only other option is to add another
>>>> property called something like 'ti,ac-detect-override-pol' to specify
>>>> the polarity you want.
>>>
>>> How is that helping? It's no different that just saying active-low for
>>> boards that do not invert ACOK (which is what I currently do in my dts,
>>> but I hate doing it since it doesn't match dt docs and is therefore just
>>> wrong).
>>
>> By providing a means for the user to specify the polarity for their
>> board. Of course the documentation would need to be updated as well. I
>> think all solutions will be ugly if we need to preserve compatibility.
>>
>>>> To be honest, I am not sure how this type of thing is normally handled.
>>>> So probably best to put together a patch with whatever option you feel
>>>> best and explain why this is needed and see what the dev-tree folks say.
>>>
>>> I suspect that at the end of the day documentation is less important than
>>> regressions. But if there are more than one implementation of the same
>>> spec and Linux is not following it, it's kind of harsh to change the spec
>>> to match Linux. I doubt that there are any other users in this case though,
>>> but what do I know?
>>>
>>> I'll send a patch re-documenting ti,ac-detect-gpios to specify AC absence
>>> instead of AC presence, let's see what the dt people thinks...
>>
>> Fine with me and of course that works for Tegra, but how does that
>> ultimately help you? How do you tell the driver to use active-high
>> instead of the default which is not active-low?
> 
> Oh, you didn't know that gpiod_set_value/gpiod_get_value takes care of
> active high/low automatically. That explains the disconnect.

Ah I see. Yes I see that now in the gpiod_get_value().

Thanks!
Jon

-- 
nvpublic
