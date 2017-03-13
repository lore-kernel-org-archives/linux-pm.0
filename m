From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Mon, 13 Mar 2017 12:45:24 +0100
Message-ID: <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com> <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

+Bj=C3=B6rn

On 13 March 2017 at 10:37, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Rafael, Kevin, Ulf,
>
> Looks like there is still some interest/needs in/for this. Any thoughts
> on how we can move this forward?

At the Linaro Connect last week, I was talking to Bj=C3=B6rn, Rajendra and
Stephen more about these related issues.

It definitely seems like we need to progress with this somehow,
meaning we need a solution for being able to associate a device with
more than one PM domain. In that context, I don't think genpd based on
its current design, is a good fit to solve the problem.

Instead I think we need something entirely new (perhaps some code can
be borrowed from genpd), which is more similar to the clock/regulator
framework. In other words, what you also were suggesting in a earlier
reply.
In this way, the driver/subsystem gains full flexibility of managing
its device's PM domains, which seems like the best future-proof
solution.

Kind regards
Uffe

>
> Cheers
> Jon
>
> On 28/02/17 15:29, Geert Uytterhoeven wrote:
>> Hi Jon,
>>
>> On Tue, Feb 28, 2017 at 4:18 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote=
:
>>> On 20/09/16 11:28, Jon Hunter wrote:
>>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>>>> controllers) is partitioned across 3 PM domains which are:
>>>> - XUSBA: Superspeed logic (for USB 3.0)
>>>> - XUSBB: Device controller
>>>> - XUSBC: Host controller
>>>>
>>>> These power domains are not nested and can be powered-up and down
>>>> independently of one another. In practice different scenarios require
>>>> different combinations of the power domains, for example:
>>>> - Superspeed host: XUSBA and XUSBC
>>>> - Superspeed device: XUSBA and XUSBB
>>>>
>>>> Although it could be possible to logically nest both the XUSBB and XUS=
BC
>>>> domains under the XUSBA, superspeed may not always be used/required an=
d
>>>> so this would keep it on unnecessarily.
>>>>
>>>> Given that Tegra uses device-tree for describing the hardware, it woul=
d
>>>> be ideal that the device-tree 'power-domains' property for generic PM
>>>> domains could be extended to allow more than one PM domain to be
>>>> specified. For example, define the following the Tegra210 xHCI device =
...
>>>>
>>>>       usb@70090000 {
>>>>               compatible =3D "nvidia,tegra210-xusb";
>>>>               ...
>>>>               power-domains =3D <&pd_xusbhost>, <&pd_xusbss>;
>>>>       };
>>>>
>>>> This RFC extends the generic PM domain framework to allow a device to
>>>> define more than one PM domain in the device-tree 'power-domains'
>>>> property.
>>>
>>> I wanted to kick this thread again now in the new year and see if there
>>> is still some interest in pursuing this?
>>>
>>> There is still very much a need from a Tegra perspective. I have put al=
l
>>> those who responded on TO.
>>>
>>> I know that a lot of time has passed since we discuss this and so if yo=
u
>>> are scratching your head wondering what I am harping on about,
>>> essentially with this RFC I was looking for a way to support devices
>>> that require multiple power domains where the domains do not have a
>>> parent-child relationship and so not are nested in anyway.
>>>
>>> If you need me to elaborate on the need for this, I am happy to do this=
.
>>> My take away from when we discussed this last year, was that there was =
a
>>> need for this.
>>
>> It definitely makes sense to me, as the "power-domains" DT binding is no=
t
>> limited to plain "power areas", but may refer to clock domains, too
>> (cfr. the Linux "PM Domain" notion).
>>
>> For my (Renesas) use case, we have devices that are part of both a power
>> area and a clock domain. Currently this is handled by the power area dri=
ver
>> calling into the clock driver.
>>
>> Thanks!
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m=
68k.org
>>
>> In personal conversations with technical people, I call myself a hacker.=
 But
>> when I'm talking to journalists I just say "programmer" or something lik=
e that.
>>                                 -- Linus Torvalds
>>
>
> --
> nvpublic
