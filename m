From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with
 multiple domains
Date: Mon, 10 Oct 2016 12:24:15 +0100
Message-ID: <6fce02ca-281a-08bd-304a-77829d35c7e1@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
 <7hlgy0frlb.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7hlgy0frlb.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 07/10/16 10:14, Kevin Hilman wrote:
> Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> writes:
> 
>> Some devices may require more than one PM domain to operate and this is
>> not currently by the PM domain framework. Furthermore, the current Linux
>> 'device' structure only allows devices to be associated with a single PM
>> domain and so cannot easily be associated with more than one. To allow
>> devices to be associated with more than one PM domain, if multiple
>> domains are defined for a given device (eg. via device-tree), then:
>> 1. Create a new PM domain for this device. The name of the new PM domain
>>    created matches the device name for which it was created for.
>> 2. Register the new PM domain as a sub-domain for all PM domains
>>    required by the device.
>> 3. Attach the device to the new PM domain.
> 
> Did you look at what might be involved to extend struct device to hace a
> list of pm_domains?  Like Ulf, I'm a bit unsettled by this
> implementation that has to work around the basic limitation in the
> driver model.

I had but it was going to be a much bigger and intrusive change. So I
went with this as a initial idea to see if others also had a need for
it. I am happy to start looking at extended the device struct if this is
the preferred path and I would agree that would make most sense.

> Having devices in multitple domains is needed for SoCs I'm familiar with
> also, so is a needed feature.

Ok great.

> I think removing the struct device limitation and corresponding
> assumptions in the driver and PM core is a prerequisite for this
> feature.
> 
> Doing that will lead to several questions about how to handle runtime PM
> operations (e.g. which of the multiple PM domains should the one to call
> the drivers runtime PM hooks when a device changes runtime PM state?)

Right. My initial thought would be that at least for device-tree based
configuration, that the order in which the pm-domains are defined in DT
would determine the order in which the pm-domains are power-on/off.

> Anyways, even with the potential complexities, I think attempting this
> is the right way forward.

Ok. I will start having a think about this but will probably not get
back to this for a few weeks.

Cheers
Jon

-- 
nvpublic
