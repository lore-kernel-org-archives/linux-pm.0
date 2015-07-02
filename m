From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Thu, 02 Jul 2015 09:07:14 -0700
Message-ID: <559561B2.8010902@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org> <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org> <55949037.80305@codeaurora.org> <20150702063820.GE31684@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36210 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbbGBQHR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 12:07:17 -0400
In-Reply-To: <20150702063820.GE31684@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 07/01/2015 11:38 PM, Viresh Kumar wrote:
> On 01-07-15, 18:13, Stephen Boyd wrote:
>> On 06/15/2015 04:57 AM, Viresh Kumar wrote:
>>> ---
>>>  drivers/base/power/opp.c | 238 ++++++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 213 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>>> index 2ac48ff9c1ef..3198c3e77224 100644
>>> --- a/drivers/base/power/opp.c
>>> +++ b/drivers/base/power/opp.c
>>> @@ -49,12 +49,17 @@
>>>   *		are protected by the dev_opp_list_lock for integrity.
>>>   *		IMPORTANT: the opp nodes should be maintained in increasing
>>>   *		order.
>>> - * @dynamic:	not-created from static DT entries.
>>>   * @available:	true/false - marks if this OPP as available or not
>>> + * @dynamic:	not-created from static DT entries.
>> Why move dynamic?
> To match its position, as it is present in the struct below. Yes it
> could have been done in a separate patch, but its also fine to fix
> such silly mistakes in another patch :)
>
>

Oh I thought kernel-doc didn't care what order things were documented
in, so moving it around doesn't really help unless someone cares that
they match the struct ordering.

>>> +
>>> +	new_opp->np = np;
>>> +	new_opp->dynamic = false;
>>> +	new_opp->available = true;
>>> +
>>> +	/*
>>> +	 * TODO: Support multiple regulators
>>> +	 *
>>> +	 * read opp-microvolt array
>>> +	 */
>>> +	ret = of_property_count_u32_elems(np, "opp-microvolt");
>>> +	if (ret == 1 || ret == 3) {
>>> +		/* There can be one or three elements here */
>>> +		ret = of_property_read_u32_array(np, "opp-microvolt",
>>> +						 (u32 *)&new_opp->u_volt, ret);
>> It seems fragile to rely on the struct packing here. Maybe the same
>> comment in the struct should be copied here, and possibly some better
>> way of doing this so the code can't be subtly broken?
> Any example of how things will break? Aren't these guaranteed to be
> present at 3 consecutive 32 bit positions ?

I'm mostly worried about someone jumbling fields in the struct. Maybe
I'm too paranoid... Maybe we can have some sort of BUILD_BUG_ON() check
here?

BUILD_BUG_ON(offsetof(struct dev_pm_opp, u_volt_max) - offsetof(struct
dev_pm_opp, u_volt) != sizeof(u32) * 3);

Have you tried compiling that on 64-bit? sizeof(unsigned long) !=
sizeof(u32).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

