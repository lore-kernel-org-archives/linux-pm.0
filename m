From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Tue, 22 Nov 2016 14:28:46 +0000
Message-ID: <d49837a4-a49d-f152-4242-632f42879b27@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com>
 <90faea7d-65b6-590a-83f1-24fcdffa0569@nvidia.com>
 <CAPDyKFr4S3tM7KL2hfwJ3R4e5z1-Zd99aMhMSgVq4XzkrUUdow@mail.gmail.com>
 <fd7c8f40-2a9f-b71c-bd11-43ee657441ae@nvidia.com>
 <63670abf-1d58-a7e3-6927-0c815d44d8a1@nvidia.com>
 <d961715d-820a-dd63-e3a9-c908ce465582@nvidia.com>
 <CAJZ5v0hqdjGJ8v+k-Nkp_bx-fj_yTD5WoMeVfkmqBuTwCjRoyA@mail.gmail.com>
 <d9a4c1cd-6682-663d-e30d-cc85f665cf64@nvidia.com>
 <CAPDyKFq0iVHEhwVbFZNQAMSw-W8YHk5Qc2EA2NSWkMux5SEnmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq0iVHEhwVbFZNQAMSw-W8YHk5Qc2EA2NSWkMux5SEnmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


On 22/11/16 13:31, Ulf Hansson wrote:
> On 22 November 2016 at 12:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 16/11/16 12:53, Rafael J. Wysocki wrote:

...

>>> There is a design limitation to that, however.
>>>
>>> The PM domain concept really is about intercepting the flow of PM
>>> callbacks for a device in order to carry out additional operations,
>>> not covered by the bus type or driver.  That's why there is only one
>>> set of PM domain callbacks per device and I don't quite see how and
>>> why it would be useful to add more of them in there.
>>
>> Sorry for the delay.
>>
>> We do, however, support the nesting of power-domains to allow more than
>> one power-domain to be controlled for a device. For the current
>> implementations that use nested power-domains, I am not sure if the
>> power-domains are truly nested or just describing a relationship between
>> power-domains.
>>
>> Nesting power-domains could also work for the Tegra XHCI device.
>> However, I don't wish to statically nest the power-domains in
>> device-tree where they are defined so they are always nested, because
>> this may not be always necessary. However, I would rather the client of
>> the power-domains specify which power-domains they require and
>> dynamically nested the power-domains at runtime. This is slightly
>> different to what I proposed in this RFC, but it is not really beyond
>> the bounds of what we support today IMO. What is missing is a means to
>> do this dynamically and not statically.
> 
> Hmm, going back to the original post for this thread.
> 
> This more or less sounds very similar as the case for when Rajendra
> described the problem for the video decode block in msm8996, except
> that in this case you already have couple of different struct devices
> available that for you could deploy runtime PM.

In this case there is only one device, so ...

> Then, wouldn't it be possible to assign a parent/child relationship
> for these devices, each device has its own corresponding PM domain -
> instead of having to dynamically nest PM domains.

... no that will not work in this case unless we create some sort of
dummy parent device but I was hoping to avoid that.

> Runtime PM will help to make sure parent devices are always active
> when child devices also are active.
> 
>>
>> By the way, I am not sure if you are suggesting that for devices that
>> may need multiple power-domains we should architect the driver
>> differently and split it up in some way such that we have a power-domain
>> per device. But for the case of the Tegra XHCI it is quite complex
>> because the driver loads firmware which runs on a micro-controller and
>> we need to manage the various power-domains that are used.
> 
> Again, if it's possible to model the topology by using parent/child
> devices, and deploy runtime PM for them, then we shouldn't need more
> than one PM domain per device. I am not sure that works here though,
> but just and idea.

It is really not too different from how we nest power-domains today. In
fact I can manually nest them and add them to the device in the driver
with the existing genpd APIs. However, I don't have a meaningful way to
describe the power-domains that are used by the device in DT because
there is more than one.

Cheers
Jon

-- 
nvpublic
