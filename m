From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Mon, 13 Mar 2017 14:27:59 +0000
Message-ID: <161ee6b9-7a76-c7b4-3cb4-06259fef4898@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com>
 <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com>
 <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
 <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com>
 <CAMuHMdVfkD935iJdsmTLA4HTsqXW1M21TxJfGZTmXqSPwQqY8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12191 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753580AbdCMO3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 10:29:02 -0400
In-Reply-To: <CAMuHMdVfkD935iJdsmTLA4HTsqXW1M21TxJfGZTmXqSPwQqY8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>

Hi Geert,

On 13/03/17 14:19, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Mon, Mar 13, 2017 at 3:09 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 13/03/17 11:45, Ulf Hansson wrote:
>>> +Björn
>>>
>>> On 13 March 2017 at 10:37, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>> Looks like there is still some interest/needs in/for this. Any thoughts
>>>> on how we can move this forward?
>>>
>>> At the Linaro Connect last week, I was talking to Björn, Rajendra and
>>> Stephen more about these related issues.
>>>
>>> It definitely seems like we need to progress with this somehow,
>>> meaning we need a solution for being able to associate a device with
>>> more than one PM domain. In that context, I don't think genpd based on
>>> its current design, is a good fit to solve the problem.
>>>
>>> Instead I think we need something entirely new (perhaps some code can
>>> be borrowed from genpd), which is more similar to the clock/regulator
>>> framework. In other words, what you also were suggesting in a earlier
>>> reply.
>>> In this way, the driver/subsystem gains full flexibility of managing
>>> its device's PM domains, which seems like the best future-proof
>>> solution.
>>
>> I agree, I think that that would give us the most flexibility to handle
>> whatever scenario. However, I was thinking that we could still use the
>> genpd core to register pm-domains with and control. My thought was to
>> allow devices to have a bindings with multiple pm-domains ...
>>
>>         dev-xyz {
>>                 ...
>>                 power-domains = <&domain-a>, <&domain-b>;
>>         };
>>
>> Then in the genpd core we do having something like ...
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index e697dec9d25b..d1ae6ddf4903 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2026,6 +2026,15 @@ int genpd_dev_pm_attach(struct device *dev)
>>                                                 "samsung,power-domain", 0);
>>                 if (!pd_args.np)
>>                         return -ENOENT;
>> +       } else if (ret > 1) {
>> +               /*
>> +                * If there are more than one PM domain defined for a device,
>> +                * then these need to be manually controlled by the device
>> +                * driver because the genpd core cannot bind a device with
> 
> Which device driver?
> The driver for the device that belongs to multiple PM domains?

Yes, exactly. So maybe I would need to say ... "manually controlled by
the driver for *this* device ..."

Jon

-- 
nvpublic
