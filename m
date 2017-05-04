From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Thu, 4 May 2017 09:44:50 +0100
Message-ID: <b1c74af3-1943-51ff-0bc9-009ca6c7f217@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <CAJZ5v0gMzN_zfC_2nnRtYFyFon3-_mnioQhNbDP0wsr91RnagA@mail.gmail.com>
 <ffe13074-9113-0a20-0fa6-76d0209dadfc@nvidia.com>
 <1832647.f77WMLkdQb@aspire.rjw.lan>
 <CAPDyKFokVKZfRAsEAB6ihx1FxW4JjarionyOwCATr3s+QW4aMg@mail.gmail.com>
 <b4e8fd34-e2f0-165d-aa22-32ba43a8dbed@nvidia.com>
 <CAPDyKFo-hfwbrY+AEMt0=fMshiT-BWvYDvGkKGqquTdowUvWHw@mail.gmail.com>
 <107242f1-de90-b8bb-bc2c-feaf014485aa@nvidia.com>
 <CAPDyKFqeAWoy-vfN89j8Yv1HTMpNqwcVk3XrTQoXH5JNrQ9Maw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10706 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbdEDIo5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 04:44:57 -0400
In-Reply-To: <CAPDyKFqeAWoy-vfN89j8Yv1HTMpNqwcVk3XrTQoXH5JNrQ9Maw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>


On 03/05/17 18:12, Ulf Hansson wrote:
> [...]
> 
>>>>
>>>>> What is missing, is how a call to pm_runtime_get_sync() by a driver,
>>>>> can inform the ->start() callback about what exact power resource(s)
>>>>> it shall turn on, because it may not always be all of them. Similar
>>>>> problem exists for pm_runtime_put().
>>>>
>>>> Yes that is missing too, but I still don't see how you bind a device to
>>>> more than one power-domain :-(
>>>
>>> I think this is what Rafael wanted us avoid (because of the complexity
>>> involved). Instead the suggestion is to deal with this on top of the
>>> existing PM domain structure, as "power resources" instead. Unless I
>>> missed his point. :-)
>>>
>>> Then *my* point is: To be able to implement that, still only allowing
>>> one PM domain per device, we would anyway need a new layer in-between
>>> the PM domain (genpd) and the driver controlling the device. Simply
>>> because these two entities, needs to be able to exchange information
>>> about which "power resources" that shall be turned off/on, when the
>>> driver do pm_runtime_get|put().
>>
>> Right, but isn't this similar to what I was suggesting above in my
>> previous email?
> 
> Perhaps it was, apologize for my ignorance in that case.

No problem, sometimes email is not the clearest medium (or maybe it is
just the author/me who struggles ;-)

> Then, isn't that quite what you already started hacking on in $subject
> series? What's the new thing in your previous reply?

Well this series just adds new APIs, but does not partition the
framework into the two layers we discussed. So it seems we should
partition the code into layers first, then add these new APIs.

> However, I was under the impression that Rafael preferred another way
> - but again I might have missed his point.
> 
>>
>> I was proposing to have such a lower-layer by splitting the existing
>> genpd framework so the drivers would have the option of calling the
>> lower-level power control functions to look-up pm-domains and control
>> them directly from their rpm callbacks (if they need to). Same as we do
>> for clocks. This way you would not need to mess with the genpd ->start()
>> callback and leave it to the driver to handle itself as it knows what
>> needs to be done. This assumes that the device is never bound to the
>> pm-domain by the genpd core.
> 
> Yes, agree! To me this is the only solution what would really work.

I agree! :-)

> Perhaps Rafael can confirm that he is fine with a solution like this?

Yes and Rafael, please can you also elaborate on what you meant by
"allow genpd to use either a list of power resources or the on/off
callbacks provided by itself to cover different use cases"?

I would like to understand exactly what you meant by allowing genpd to
use a list of power resources (ie. how you envisioned we could achieve
this).

Cheers
Jon

-- 
nvpublic
