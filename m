From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
Date: Thu, 8 Sep 2016 13:04:17 -0500
Message-ID: <57D1A821.3010904@ti.com>
References: <20160819235653.26355-1-nm@ti.com>
 <20160819235653.26355-4-nm@ti.com>
 <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
 <57C0D2C9.1030801@ti.com> <57C5E1DA.2040405@ti.com>
 <CAPDyKFqszM48nXnnA9D8iCp34k-ZmNvOkHPCc=Fya4nJA7PvBQ@mail.gmail.com>
 <57CF26DB.4020807@ti.com> <7h4m5rv9kz.fsf@baylibre.com>
 <CAPDyKFo0Cb90BbY7ra6VDjb5frC5=VtmE3V6tDK=VosfPmod7Q@mail.gmail.com>
 <m2mvjinvfw.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:50386 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753256AbcIHSFD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Sep 2016 14:05:03 -0400
In-Reply-To: <m2mvjinvfw.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>

Hi,
On 09/08/2016 12:38 PM, Kevin Hilman wrote:
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
>
> Kevin
>

I am first trying to leverage the dev_attach/detach and start/stop 
callbacks that Ulf suggested without creating a single genpd per device 
and it looks like it will work for us. I appreciate the alternative 
suggestions but I agree we'd like to leverage as much of the existing 
genpd framework as we can and avoid going down the omap_device style 
implementation path.

Regards,
Dave
