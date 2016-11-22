From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Tue, 22 Nov 2016 18:41:09 +0000
Message-ID: <f54b4912-bfdd-aa2c-6f04-e09ed4207af6@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com>
 <90faea7d-65b6-590a-83f1-24fcdffa0569@nvidia.com>
 <CAPDyKFr4S3tM7KL2hfwJ3R4e5z1-Zd99aMhMSgVq4XzkrUUdow@mail.gmail.com>
 <fd7c8f40-2a9f-b71c-bd11-43ee657441ae@nvidia.com>
 <63670abf-1d58-a7e3-6927-0c815d44d8a1@nvidia.com>
 <d961715d-820a-dd63-e3a9-c908ce465582@nvidia.com>
 <CAJZ5v0hqdjGJ8v+k-Nkp_bx-fj_yTD5WoMeVfkmqBuTwCjRoyA@mail.gmail.com>
 <d9a4c1cd-6682-663d-e30d-cc85f665cf64@nvidia.com>
 <m2lgwbxtea.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14472 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934155AbcKVSls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 13:41:48 -0500
In-Reply-To: <m2lgwbxtea.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>


On 22/11/16 18:26, Kevin Hilman wrote:
> Jon Hunter <jonathanh@nvidia.com> writes:
> 
>> On 16/11/16 12:53, Rafael J. Wysocki wrote:
>>> On Wed, Nov 16, 2016 at 11:48 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>> Hi Kevin, Ulf,
>>>>
>>>> On 03/11/16 14:20, Jon Hunter wrote:
>>>>>
>>>>> On 11/10/16 10:15, Jon Hunter wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>>>> Second, another way of seeing this is: Depending on the current
>>>>>>>>> runtime selected configuration you need to re-configure the PM domain
>>>>>>>>> topology - but the device would still remain in the same PM domain.
>>>>>>>>>
>>>>>>>>> In other words, you would need to remove/add subdomain(s) depending on
>>>>>>>>> the selected configuration. Would that better reflect the HW?
>>>>>>>>
>>>>>>>> I am not 100% sure I follow what you are saying, but ultimately, I would
>>>>>>>> like to get to ...
>>>>>>>>
>>>>>>>>         usb@70090000 {
>>>>>>>>                 compatible = "nvidia,tegra210-xusb";
>>>>>>>>                 ...
>>>>>>>>                 power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>>>>>>>>         };
>>>>>>>
>>>>>>> So, is this really is a proper description of the HW? Isn't it so,
>>>>>>> that the usb device always resides in one and the same PM domain?
>>>>>>
>>>>>> I guess technically, the usbhost controller resides in one partition and
>>>>>> the super-speed logic in another. So could the usbhost domain be the
>>>>>> primary? Possibly, but the device cannot be probed without both enabled.
>>>>>>
>>>>>>> Now, depending on the selected speed mode (superspeed) additional
>>>>>>> logic may needs to be powered on and configured for the usb device to
>>>>>>> work?
>>>>>>> Perhaps, one could consider those additional logics as a master/parent
>>>>>>> PM domain for the usb device's PM domain?
>>>>>>>
>>>>>>> Or this is not how the HW works? :-)
>>>>>>
>>>>>> It might be possible for this case, but to be honest, the more I think
>>>>>> about this, I do wonder if we need to be able to make the framework a
>>>>>> lot more flexible for devices that need multiple power-domains. In other
>>>>>> words, for devices that use multiple domains allow them to control them
>>>>>> similarly to what we do for regulators or clocks. So if there is more
>>>>>> than one defined, then the genpd core will not bind the device to the
>>>>>> pm-domain and let the driver handle it. This way if you do need more
>>>>>> granular control of the pm-domains in the driver you can do whatever you
>>>>>> need to.
>>>>>>
>>>>>> I know that Rajendra (CC'ed) was looking into whether he had a need to
>>>>>> control multiple power-domains individually from within the context of a
>>>>>> single device driver.
>>>>>
>>>>> So Rajendra commented to say that he does not see a need for individual
>>>>> control of power-domains for now, but a need for specifying multiple.
>>>>>
>>>>> One simple option would be to allow users to specify multiple and have
>>>>> the genpd core effectively ignore such devices and leave it to the
>>>>> driver to configure manually. I have been able to do this for XUSB by
>>>>> dynamically adding power-domains to the device.
>>>>>
>>>>> Let me know if you have any more thoughts on how we can do this.
>>>>
>>>> Any more thoughts on this? Seems that there are a few others that would
>>>> be interested in supporting multiple domains for a device.
>>>
>>> There is a design limitation to that, however.
>>>
>>> The PM domain concept really is about intercepting the flow of PM
>>> callbacks for a device in order to carry out additional operations,
>>> not covered by the bus type or driver.  That's why there is only one
>>> set of PM domain callbacks per device and I don't quite see how and
>>> why it would be useful to add more of them in there.
> 
> @Rafael: Re: why it would be useful...
> 
> Many ARM SoCs have devices that have independent power rails for the
> memory and the logic of an IP block.  For example, while powering off
> the logic you could keep the memory at a retention voltage, so you'd
> want to treat those power domains separately.
> 
> Today, in order to model this, you'd have to create another (dummy)
> device, just for the memory and put it in its own domain so the two
> could be controlled separately.
> 
>> Sorry for the delay.
>>
>> We do, however, support the nesting of power-domains to allow more than
>> one power-domain to be controlled for a device. For the current
>> implementations that use nested power-domains, I am not sure if the
>> power-domains are truly nested or just describing a relationship between
>> power-domains.
> 
> @Jon: Do you think the nesting could work to handle the above case too?

Difficult to say without all the details, for example do we need to
worry about the order in which they are power-up/down?

>> Nesting power-domains could also work for the Tegra XHCI device.
>> However, I don't wish to statically nest the power-domains in
>> device-tree where they are defined so they are always nested, because
>> this may not be always necessary.
> 
> And, that's not describing the hardware very accurately either, IIUC

Right, but in DT may be I would have something like ...

	dev-xyz {
		compatible ="blah blah";
		...
		power-domains = <&domain-a>, <&domain-b>;
	};

... which should describe the h/w, but it could just be implemented so
that to make this work b would be nested under a. We would have to turn
them on in sequence any way and so nesting here would be ok. The only
problem would be then if you have another device ...

	dev-abc {
		compatible ="blah blah";
		...
		power-domains = <&domain-b>, <&domain-c>;
	};

... which would mean c is nested under a and b. So may be for the
generic case this is no good either.

>> However, I would rather the client of
>> the power-domains specify which power-domains they require and
>> dynamically nested the power-domains at runtime. This is slightly
>> different to what I proposed in this RFC, but it is not really beyond
>> the bounds of what we support today IMO. What is missing is a means to
>> do this dynamically and not statically.
>>
>> By the way, I am not sure if you are suggesting that for devices that
>> may need multiple power-domains we should architect the driver
>> differently and split it up in some way such that we have a power-domain
>> per device. But for the case of the Tegra XHCI it is quite complex
>> because the driver loads firmware which runs on a micro-controller and
>> we need to manage the various power-domains that are used.
> 
> IMO, constructing a network of new struct devices just to workaround
> limitations in the framework doesn't sound quite right either.

I agree.

Cheers
Jon

-- 
nvpublic
