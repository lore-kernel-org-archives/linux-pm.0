From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Discussion] Performance levels of power domains
Date: Fri, 28 Oct 2016 09:52:51 +0100
Message-ID: <b87ccdfe-e9f6-d3d4-236a-1eea7f25ac5b@arm.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <af9ab13a-6f77-5abe-e17f-c7dd6efa6d7e@arm.com>
 <20161026111642.GM9162@vireshk-i7>
 <c11971ea-59aa-690a-95a3-d645ebb0074a@arm.com>
 <20161028002202.GM26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbcJ1Iwz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Oct 2016 04:52:55 -0400
In-Reply-To: <20161028002202.GM26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>



On 28/10/16 01:22, Stephen Boyd wrote:
> On 10/26, Sudeep Holla wrote:
>>
>>
>> On 26/10/16 12:16, Viresh Kumar wrote:
>>> On 26-10-16, 12:09, Sudeep Holla wrote:
>>
>> [...]
>>
>>>> I am mainly interested as there are efforts to standardize these
>>>> communication with M3 and there's WIP protocol development[1]. It would
>>>> be good to see if this user-case is also considered.
>>>
>>> What do you mean by that ?
>>
>> Basically I wanted to know more details so that such system are also
>> considered(I agree it may not have any impact on the protocol at all,
>> but still good to consider them) when designing this new SCMI protocol.
>>
>
> There are a couple different wire protocols used to communicate
> with the RPM on these platforms. The first one is at
> drivers/mfd/qcom_rpm.c, and the second one is at
> drivers/soc/qcom/smd-rpm.c. Bjorn upstreamed these drivers based
> on the codeaurora sources.
>

Thanks for information Stephen, I will have a look.

-- 
Regards,
Sudeep
