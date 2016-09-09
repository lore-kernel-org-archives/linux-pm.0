From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
Date: Fri, 9 Sep 2016 10:34:38 +0200
Message-ID: <CAPDyKFqYy7UOzW5d5JKO=YWoUN8QcX086iBMoWZu4MCtJh-vgA@mail.gmail.com>
References: <20160819235653.26355-1-nm@ti.com> <20160819235653.26355-4-nm@ti.com>
 <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
 <57C0D2C9.1030801@ti.com> <57C5E1DA.2040405@ti.com> <CAPDyKFqszM48nXnnA9D8iCp34k-ZmNvOkHPCc=Fya4nJA7PvBQ@mail.gmail.com>
 <57CF26DB.4020807@ti.com> <7h4m5rv9kz.fsf@baylibre.com> <CAPDyKFo0Cb90BbY7ra6VDjb5frC5=VtmE3V6tDK=VosfPmod7Q@mail.gmail.com>
 <m2mvjinvfw.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m2mvjinvfw.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 8 September 2016 at 19:38, Kevin Hilman <khilman@baylibre.com> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> [...]
>>
>>>
>>> One more idea...
>>>
>>> Since you don't really have a domain (a group of devices), what you
>>> really have is each device having an independent power switch, so as Ulf
>>> suggested, what you really need is for all the devices to share the same
>>> set of runtime PM callbacks that call SCI.  The only difference is the
>>> unique ID.
>>>
>>> Rather than using all of genpd, you could also just use a pm_domain
>>> which is what genpd is built on top of (and also omap_device, which
>>> you're probably familiar with also.)
>>
>> Even if this would work as well, the downside would be that you need
>> to re-invent the parts related to the DT parsing, the probing/removal
>> and attaching/detaching of the device to the PM domain.
>>
>> You probably don't want to go there... :-)
>
> All you'd need to read from DT would be the device-specific ID for
> TI-SCI, and that could be done at bind time with a notifier.  The, in
> that same notifier, if a TI-SCI ID exists, it would get added to the
> pm_domain.
>
> Anyways, your original proposal is much preferred if it can work.  I'm
> just throwing out another option because I really don't like one genpd
> per device.

Okay, then we are in full agreement!

BTW, I have just been trying to convince other people working on
Rockchip SoCs, to also avoid using one genpd per device. Feel free to
join those discussions [1] as well. :-)

Kind regards
Uffe

[1]
https://lkml.org/lkml/2016/9/1/377
