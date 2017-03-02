From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Thu, 02 Mar 2017 09:00:49 +0530
Message-ID: <58B791E9.4000505@codeaurora.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org> <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org> <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop> <20170228065711.GD19417@vireshk-i7> <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w@mail.gmail.com> <CAPDyKFo5TjTa-hTzNp5KCpozU87L22piCXaSjWMTr4xVkgP+Pg@mail.gmail.com> <CAL_Jsq+7DGX_1U99cc3rhk8zzSj6iKe3kpijp7KTz90xXA_V9g@mail.gmail.com> <58B669DD.5010309@codeaurora.org> <CAL_JsqLJ_QYZza4=DobUStWpQ7V-H2dF_2d=25XR+x-eWfszEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLJ_QYZza4=DobUStWpQ7V-H2dF_2d=25XR+x-eWfszEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org


On 03/02/2017 04:43 AM, Rob Herring wrote:
> On Wed, Mar 1, 2017 at 12:27 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>>
>> On 02/28/2017 09:22 PM, Rob Herring wrote:
>>> On Tue, Feb 28, 2017 at 9:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> [...]
>>>>
>>>>>>                                     ---> Parent domain-2 (Contains Perfomance states)
>>>>>>                                     |
>>>>>>                                     |
>>>>>> C.) DeviceX  --->  Parent-domain-1  |
>>>>>>                                     |
>>>>>>                                     |
>>>>>>                                     ---> Parent domain-3 (Contains Perfomance states)
>>>>>
>>>>> I'm a bit confused. How does a domain have 2 parent domains?
>>>>
>>>> This comes from the early design of the generic PM domain, thus I
>>>> assume we have some HW with such complex PM topology. However, I don't
>>>> know if it is actually being used.
>>>>
>>>> Moreover, the corresponding DT bindings for "power-domains" parents,
>>>> can easily be extended to cover more than one parent. See more in
>>>> Documentation/devicetree/bindings/power/power_domain.txt
>>>
>>> I could easily see device having 2 power domains. For example a cpu
>>> may have separate domains for RAM/caches and logic. And nesting of
>>
>> yet the bindings for power-domains (for consumer devices) only allows for
>> one powerdomain to be associated with a device.
> 
> There's nothing in the binding only allowing that. If that was true,
> then #powerdomain-cells would be pointless

Is't #powerdomain-cells a powerdomain provider property? and used to
specify if a powerdomain provider supports providing 1 or many powerdomains?
I was talking about the power domain consumer property.
Looking at Documentation/devicetree/bindings/power/power_domain.txt..

==PM domain consumers==

Required properties:
 - power-domains : A phandle and PM domain specifier as defined by bindings of
                   the power controller specified by phandle.

It clearly says 'A phandle'. If there was a way to specify multiple power-domains
for a consumer device should it not be saying a list of phandles? Like we do for
clocks and regulators?

> as the property size would
> tell you the number of cells. Now it may be that we simply don't have
> any cases with more than 1. Hopefully that's not because bindings are
> working around PM domain limitations/requirements.
> 
> Rob
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
