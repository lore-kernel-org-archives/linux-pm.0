From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Mon, 10 Aug 2015 17:31:23 -0700
Message-ID: <55C9425B.4060207@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org> <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org> <20150810192336.GC9678@codeaurora.org> <20150811002342.GD5766@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46599 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbbHKAbZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 20:31:25 -0400
In-Reply-To: <20150811002342.GD5766@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10/2015 05:23 PM, Viresh Kumar wrote:
> On 10-08-15, 12:23, Stephen Boyd wrote:
>>
>>> ---
>>>   drivers/base/power/opp.c | 21 ++++++++++-----------
>>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>>> index 1daaa1a418a2..c9747fb192b1 100644
>>> --- a/drivers/base/power/opp.c
>>> +++ b/drivers/base/power/opp.c
>>> @@ -1295,20 +1295,19 @@ static int _of_init_opp_table_v2(struct device *dev,
>>>   	if (WARN_ON(!count))
>>>   		goto out;
>>>   
>>> -	if (!ret) {
>>> -		if (!dev_opp) {
>>> -			dev_opp = _find_device_opp(dev);
>>> -			if (WARN_ON(!dev_opp))
>>> -				goto out;
>>> -		}
>>> -
>>> -		dev_opp->np = opp_np;
>>> -		dev_opp->shared_opp = of_property_read_bool(opp_np,
>>> -							    "opp-shared");
>>> -	} else {
>>> +	if (ret) {
>>>   		of_free_opp_table(dev);
>>> +		goto out;
>>>   	}
>>>   
>>> +	dev_opp = _find_device_opp(dev);
>>> +	if (WARN_ON(!dev_opp))
>>> +		goto out;
>> Doesn't ret = 0 in this case?
> Because ret is already 0, juse see the above if (ret) check.

So ret is 0. I thought it was an error path, but I guess this is a 
warning path and we return 0 still?

>
>> Why not drop the goto and just
>> return some error code. Same for the goto out up above.
> Actually yes, because we don't do anything special in goto now. But it
> required more (unrelated) code changes, plus I didn't wanted to break
> the 'return from single place' rule for this function, in case we
> really need to free some resource or undo some work from the goto
> place.
>
> But if you suggest/insist, then I will do it in a separate patch.

I am not insisting anything. But another patch to get rid of the goto 
sounds fine.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

