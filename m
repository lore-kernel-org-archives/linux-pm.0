From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Wed, 16 Nov 2016 13:53:32 +0100
Message-ID: <CAJZ5v0hqdjGJ8v+k-Nkp_bx-fj_yTD5WoMeVfkmqBuTwCjRoyA@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com>
 <90faea7d-65b6-590a-83f1-24fcdffa0569@nvidia.com> <CAPDyKFr4S3tM7KL2hfwJ3R4e5z1-Zd99aMhMSgVq4XzkrUUdow@mail.gmail.com>
 <fd7c8f40-2a9f-b71c-bd11-43ee657441ae@nvidia.com> <63670abf-1d58-a7e3-6927-0c815d44d8a1@nvidia.com>
 <d961715d-820a-dd63-e3a9-c908ce465582@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d961715d-820a-dd63-e3a9-c908ce465582-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 16, 2016 at 11:48 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Kevin, Ulf,
>
> On 03/11/16 14:20, Jon Hunter wrote:
>>
>> On 11/10/16 10:15, Jon Hunter wrote:
>>
>> ...
>>
>>>>>> Second, another way of seeing this is: Depending on the current
>>>>>> runtime selected configuration you need to re-configure the PM domain
>>>>>> topology - but the device would still remain in the same PM domain.
>>>>>>
>>>>>> In other words, you would need to remove/add subdomain(s) depending on
>>>>>> the selected configuration. Would that better reflect the HW?
>>>>>
>>>>> I am not 100% sure I follow what you are saying, but ultimately, I would
>>>>> like to get to ...
>>>>>
>>>>>         usb@70090000 {
>>>>>                 compatible = "nvidia,tegra210-xusb";
>>>>>                 ...
>>>>>                 power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>>>>>         };
>>>>
>>>> So, is this really is a proper description of the HW? Isn't it so,
>>>> that the usb device always resides in one and the same PM domain?
>>>
>>> I guess technically, the usbhost controller resides in one partition and
>>> the super-speed logic in another. So could the usbhost domain be the
>>> primary? Possibly, but the device cannot be probed without both enabled.
>>>
>>>> Now, depending on the selected speed mode (superspeed) additional
>>>> logic may needs to be powered on and configured for the usb device to
>>>> work?
>>>> Perhaps, one could consider those additional logics as a master/parent
>>>> PM domain for the usb device's PM domain?
>>>>
>>>> Or this is not how the HW works? :-)
>>>
>>> It might be possible for this case, but to be honest, the more I think
>>> about this, I do wonder if we need to be able to make the framework a
>>> lot more flexible for devices that need multiple power-domains. In other
>>> words, for devices that use multiple domains allow them to control them
>>> similarly to what we do for regulators or clocks. So if there is more
>>> than one defined, then the genpd core will not bind the device to the
>>> pm-domain and let the driver handle it. This way if you do need more
>>> granular control of the pm-domains in the driver you can do whatever you
>>> need to.
>>>
>>> I know that Rajendra (CC'ed) was looking into whether he had a need to
>>> control multiple power-domains individually from within the context of a
>>> single device driver.
>>
>> So Rajendra commented to say that he does not see a need for individual
>> control of power-domains for now, but a need for specifying multiple.
>>
>> One simple option would be to allow users to specify multiple and have
>> the genpd core effectively ignore such devices and leave it to the
>> driver to configure manually. I have been able to do this for XUSB by
>> dynamically adding power-domains to the device.
>>
>> Let me know if you have any more thoughts on how we can do this.
>
> Any more thoughts on this? Seems that there are a few others that would
> be interested in supporting multiple domains for a device.

There is a design limitation to that, however.

The PM domain concept really is about intercepting the flow of PM
callbacks for a device in order to carry out additional operations,
not covered by the bus type or driver.  That's why there is only one
set of PM domain callbacks per device and I don't quite see how and
why it would be useful to add more of them in there.

Thanks,
Rafael
