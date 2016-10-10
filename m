From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Mon, 10 Oct 2016 16:04:29 +0200
Message-ID: <CAPDyKFr4S3tM7KL2hfwJ3R4e5z1-Zd99aMhMSgVq4XzkrUUdow@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com> <90faea7d-65b6-590a-83f1-24fcdffa0569@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <90faea7d-65b6-590a-83f1-24fcdffa0569-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10 October 2016 at 13:18, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 06/10/16 13:22, Ulf Hansson wrote:
>> On 20 September 2016 at 12:28, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>>> controllers) is partitioned across 3 PM domains which are:
>>> - XUSBA: Superspeed logic (for USB 3.0)
>>> - XUSBB: Device controller
>>> - XUSBC: Host controller
>>>
>>> These power domains are not nested and can be powered-up and down
>>> independently of one another. In practice different scenarios require
>>> different combinations of the power domains, for example:
>>> - Superspeed host: XUSBA and XUSBC
>>> - Superspeed device: XUSBA and XUSBB
>>>
>>> Although it could be possible to logically nest both the XUSBB and XUSBC
>>> domains under the XUSBA, superspeed may not always be used/required and
>>> so this would keep it on unnecessarily.
>>>
>>> Given that Tegra uses device-tree for describing the hardware, it would
>>> be ideal that the device-tree 'power-domains' property for generic PM
>>> domains could be extended to allow more than one PM domain to be
>>> specified. For example, define the following the Tegra210 xHCI device ...
>>>
>>>         usb@70090000 {
>>>                 compatible = "nvidia,tegra210-xusb";
>>>                 ...
>>>                 power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>>>         };
>>>
>>> This RFC extends the generic PM domain framework to allow a device to
>>> define more than one PM domain in the device-tree 'power-domains'
>>> property.
>>
>> First, I don't really like extending the internal logic of genpd to
>> deal with multiple PM domains per device. *If* this really is needed,
>> I think we should try to extend the struct device to cover this, then
>> make genpd to use it somehow.
>
> I had looked at that initially but it was looking quite complex because
> of the various structures (dev_pm_domain in the device structure,
> pm_domain_data in pm_subsys_data, etc). This implementation is quite

I didn't care much about the complexity, more trying to understand how
the HW actually works. :-)

> simple and less intrusive. However, if there is a lot of interest in
> this and it does appear to be, I would agree that having the device
> structure handle this would be best.
>
>> Second, another way of seeing this is: Depending on the current
>> runtime selected configuration you need to re-configure the PM domain
>> topology - but the device would still remain in the same PM domain.
>>
>> In other words, you would need to remove/add subdomain(s) depending on
>> the selected configuration. Would that better reflect the HW?
>
> I am not 100% sure I follow what you are saying, but ultimately, I would
> like to get to ...
>
>         usb@70090000 {
>                 compatible = "nvidia,tegra210-xusb";
>                 ...
>                 power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>         };

So, is this really is a proper description of the HW? Isn't it so,
that the usb device always resides in one and the same PM domain?

Now, depending on the selected speed mode (superspeed) additional
logic may needs to be powered on and configured for the usb device to
work?
Perhaps, one could consider those additional logics as a master/parent
PM domain for the usb device's PM domain?

Or this is not how the HW works? :-)

Kind regards
Uffe
