From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Sat, 4 Nov 2017 10:19:44 -0700
Message-ID: <7091cb38-e55b-fa20-114e-bd77950ea912@gmail.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <da808465-dc64-6c33-0be6-e038e0f84bce@gmail.com>
 <20171103173353.GJ28152@atomide.com> <2452741.VnAOAIxsj2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:54688 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbdKDRTu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2017 13:19:50 -0400
In-Reply-To: <2452741.VnAOAIxsj2@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Lindgren <tony@atomide.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ckeepax@opensource.wolfsonmicro.com, swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org



On 11/04/2017 05:25 AM, Rafael J. Wysocki wrote:
> On Friday, November 3, 2017 6:33:53 PM CET Tony Lindgren wrote:
>> * Florian Fainelli <f.fainelli@gmail.com> [171103 17:04]:
>>> On 11/03/2017 09:11 AM, Tony Lindgren wrote:
>>> The pinctrl provider is losing its state, hence these two patches.
>>
>> OK
>>
>>>> Anyways, the context lost flag should be managed in the PM core for
>>>> the device, so adding linux-pm and Rafael to Cc.
>>>
>>> I don't think it's that simple but sure, why not.
>>
>> Just having bool context_lost in struct dev_pm_info would probably
>> be enough to allow drivers to deal with it. This flag could then
>> be set for a device by power domain related code that knows if
>> context got lost.
> 
> Something like: if the driver sees "context_lost" set, it should restore
> the context to the device from memory?

That is what is being proposed here, except that the actual mechanism
where this matters needs to be in the core pinctrl code, otherwise the
state (context) is not restored due to a check that attempts not to
(re)apply a previous state.

> 
> But the it would also need to save the context beforehand, so why not to
> restore it unconditionally on resume?

That's what my original attempts did here:

https://patchwork.kernel.org/patch/9598969/

but Linus rightfully requested this to be done differently, hence this
attempt now to solve it in a slightly more flexible way based on DT
properties.
-- 
Florian
