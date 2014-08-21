From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: Handling commit change logs
Date: Thu, 21 Aug 2014 12:49:55 +0200
Message-ID: <53F5CED3.2040107@denx.de>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi> <1408419205-10048-14-git-send-email-tuomas.tynkkynen@iki.fi> <CAKohpokQOALPH13Ykz4nTBOby8J1X6_F30LNKz=gsC4wN3=3vg@mail.gmail.com> <53F3A900.8010805@nvidia.com> <CAKohponcZv9-MFNUQFxC_49-+P6QOhdjxsnYAyL3i4sXdCBYrw@mail.gmail.com> <CABxcv=ncm3Y7Ecfymro6TOuP=d10OV5--8n=dYmHyj6zi8hwEw@mail.gmail.com> <53F4FED4.7060408@suse.de> <53F50554.3050505@wwwdotorg.org> <CAOh2x=mO1r76fkvruvBLaL144G8fHgDPMwhKVCxv4HW8FRUE_Q@mail.gmail.com> <53F58DFD.900@denx.de> <CABxcv=kJixq0WW5YEX-LvBfU-e9_0pkPw5JeHFOWz8h-_eSjyg@mail.gmail.com>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=kJixq0WW5YEX-LvBfU-e9_0pkPw5JeHFOWz8h-_eSjyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tuomas Tynkkynen <tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber-l3A5Bk7waGM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Javier,

Am 21.08.2014 12:35, schrieb Javier Martinez Canillas:
> Hello Heiko,
>
> On Thu, Aug 21, 2014 at 8:13 AM, Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>  wrote:
>> Hello Viresh,
>>
>> Am 21.08.2014 06:26, schrieb Viresh Kumar:
>>
>>> On Thu, Aug 21, 2014 at 2:00 AM, Stephen Warren<swarren@wwwdotorg.o=
rg>
>>> wrote:
>>>>
>>>> On 08/20/2014 02:02 PM, Andreas F=C3=A4rber wrote:
>>>>>
>>>>> Am 20.08.2014 17:39, schrieb Javier Martinez Canillas:
>>>>>>
>>>>>> If this not the correct workflow and you have a better way to ma=
nage
>>>>>> this, I would love to know about it.
>>>
>>>
>>> Oh yes, this was certainly useful. I was missing this (mis)feature =
:)
>>
>>
>> maybe patman from u-boot is also interesting for you, see:
>>
>> http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Dtools/patman/README;=
h=3D5fb508b80df10d3b11d95eea95a141ce3d0ef578;hb=3D67ee22b0681305ba1099c=
508eecade996abc1c65
>>
>
> Very interesting and seems to match my workflow as well so I'll take =
a
> look, thanks for sharing!

You are welcome!

bye,
Heiko
--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
