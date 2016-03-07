From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V6 00/10] Add generic PM domain support for Tegra
Date: Mon, 7 Mar 2016 13:32:32 +0000
Message-ID: <56DD82F0.2070504@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <20160302153556.GB21035@ulmo.nvidia.com> <7h7fhk3c4o.fsf@baylibre.com>
 <CAJZ5v0juBvU9f61RQRDaHg9B2H=rccNOfT1fXGDRkbpxh-sx=g@mail.gmail.com>
 <7h7fhkxn1r.fsf@baylibre.com> <56D8246E.5090909@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5852 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbcCGNci (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 08:32:38 -0500
In-Reply-To: <56D8246E.5090909@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


On 03/03/16 11:47, Jon Hunter wrote:
> 
> On 03/03/16 03:22, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>>> On Wed, Mar 2, 2016 at 8:36 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>>> Thierry Reding <thierry.reding@gmail.com> writes:
>>>>
>>>>> On Fri, Feb 26, 2016 at 03:48:34PM +0000, Jon Hunter wrote:
>>>>>> Adds generic PM domain support for Tegra SoCs but this series only
>>>>>> enables support for it on Tegra 64-bit devices. There is no reason why
>>>>>> this cannot be enable for Tegra 32-bit devices, but to keep the patch
>>>>>> series to a minimum only 64-bit devices are enabled so far.
>>>>>>
>>>>>> This series has been boot tested on Tegra210 as well as various 32-bit
>>>>>> Tegra platforms.
>>>>
>>>> [...]
>>>>
>>>>>> Jon Hunter (10):
>>>>>>   PM / Domains: Fix removal of a subdomain
>>>>>>   PM / Domains: Add function to get the last domain added
>>>>>>   PM / Domains: Add function to remove a pm-domain
>>>>>
>>>>> Ulf, Kevin, Rafael,
>>>>>
>>>>> It's too late to take these patches through the Tegra tree for v4.6, but
>>>>> if Jon can get the above three patches ready before the merge window,
>>>>> would you be willing to pick them up into your trees for v4.6?
>>>>
>>>> It's a bit late in the cycle, but since one is a fix and the other two
>>>> add functions that aren't (yet) used, I think it would be fine to get
>>>> them in for v4.6.  But, the final decision is with Rafael.
>>>>
>>>>> Doing so
>>>>> might make it easier to deal with the dependencies. The prerequisites
>>>>> would already be in Linus' tree when I apply the Tegra bits for v4.7.
>>>>
>>>> Yeah, makes sense.
>>>>
>>>>> I don't mind taking all of it through the Tegra tree for v4.7, though. I
>>>>> can provide a stable branch with the PM / Domains patches for you to
>>>>> pull in, in case there are any conflicts.
>>>>
>>>> I think it makes the most sense for these prereqs to merge through
>>>> linux-pm.  Let's see what Rafael thinks about the timing.
>>>
>>> The timing is fine by me.
>>>
>>> Do you want me to apply [1-3/10] from this series, then?
>>
>> Jon has some minor tweaks to do, so he'll respin and then you can take
>> them.
>>
>> Jon, feel free to add:
>>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>>
>> For those as well.  I thought I responded, but looks like I didn't.
> 
> I am preparing a V7 that I will send out today/tomorrow (latest). I am
> going to drop the removal parts for now and send that out separately as
> an RFC because it is bigger than I have expected.

Rafael,

By the way, I posted the genpd fixes separately here [0][1].

Cheers
Jon

[0] http://marc.info/?l=linux-pm&m=145708892606515&w=2
[1] http://marc.info/?l=linux-pm&m=145708892606516&w=2
