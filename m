From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 3/5] clk: add support for clocks provided by SCP(System
 Control Processor)
Date: Fri, 05 Jun 2015 18:10:13 +0100
Message-ID: <5571D7F5.1030405@arm.com>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com> <1432720398-5701-4-git-send-email-sudeep.holla@arm.com> <20150604202009.GI676@codeaurora.org> <55716DA4.2090003@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55716DA4.2090003@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 05/06/15 10:36, Sudeep Holla wrote:
>
>
> On 04/06/15 21:20, Stephen Boyd wrote:
>> On 05/27, Sudeep Holla wrote:

[...]

>>> +
>>> +static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
>>> +					  unsigned long parent_rate)
>>> +{
>>> +	struct scpi_clk *clk = to_scpi_clk(hw);
>>> +
>>> +	return scpi_ops->clk_get_val(clk->id);
>>> +}
>>> +
>>> +static long scpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>>> +				unsigned long *parent_rate)
>>> +{
>>> +	struct scpi_clk *clk = to_scpi_clk(hw);
>>> +
>>> +	if (WARN_ON(clk->rate_min && rate < clk->rate_min))
>>> +		rate = clk->rate_min;
>>> +	if (WARN_ON(clk->rate_max && rate > clk->rate_max))
>>> +		rate = clk->rate_max;
>>> +
>>> +	return rate;
>>> +}
>>
>> Hm.. this seems really generic. It might be better to support a
>> way to tell the framework to limit the min/max rate that's
>> accepted for a clk. That could be done later though.
>>
>
> True, framework have some boundary checks in place. I will check if
> I can use it with minimum changes to the core. If not, we can take this
> up later as you suggested.
>

I found that the framework already provides clk_set_rate_range for this
purpose. Sorry for missing this earlier(seems like that's added quite
recently in v4.0). I think I still need to retain round_rate as the core
framework insists.

Regards,
Sudeep
