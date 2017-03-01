From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Wed, 01 Mar 2017 11:57:41 +0530
Message-ID: <58B669DD.5010309@codeaurora.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org> <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org> <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop> <20170228065711.GD19417@vireshk-i7> <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w@mail.gmail.com> <CAPDyKFo5TjTa-hTzNp5KCpozU87L22piCXaSjWMTr4xVkgP+Pg@mail.gmail.com> <CAL_Jsq+7DGX_1U99cc3rhk8zzSj6iKe3kpijp7KTz90xXA_V9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdCAHug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 02:50:36 -0500
In-Reply-To: <CAL_Jsq+7DGX_1U99cc3rhk8zzSj6iKe3kpijp7KTz90xXA_V9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>



On 02/28/2017 09:22 PM, Rob Herring wrote:
> On Tue, Feb 28, 2017 at 9:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>>>                                     ---> Parent domain-2 (Contains Perfomance states)
>>>>                                     |
>>>>                                     |
>>>> C.) DeviceX  --->  Parent-domain-1  |
>>>>                                     |
>>>>                                     |
>>>>                                     ---> Parent domain-3 (Contains Perfomance states)
>>>
>>> I'm a bit confused. How does a domain have 2 parent domains?
>>
>> This comes from the early design of the generic PM domain, thus I
>> assume we have some HW with such complex PM topology. However, I don't
>> know if it is actually being used.
>>
>> Moreover, the corresponding DT bindings for "power-domains" parents,
>> can easily be extended to cover more than one parent. See more in
>> Documentation/devicetree/bindings/power/power_domain.txt
> 
> I could easily see device having 2 power domains. For example a cpu
> may have separate domains for RAM/caches and logic. And nesting of

yet the bindings for power-domains (for consumer devices) only allows for
one powerdomain to be associated with a device.

> power domains is certainly common, but a power domain being contained
> in 2 different parents? I don't even see how that is possible in the
> physical design. Now if we're mixing PM and power domains again and
> the cpu device is pointing to the cpu PM domain which contains 2 power
> domains, then certainly that is possible.
> 
> Rob
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
