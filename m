From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] PM / OPP: add non-OF versions of
 dev_pm_opp_{cpumask_,}remove_table
Date: Fri, 29 Apr 2016 10:22:09 +0100
Message-ID: <572327C1.4000604@arm.com>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
 <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
 <20160429040721.GV2915@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160429040721.GV2915@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 29/04/16 05:07, Viresh Kumar wrote:
> On 28-04-16, 18:07, Sudeep Holla wrote:
>> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
>> index 433b60092972..e59b9e7c31ba 100644
>> --- a/drivers/base/power/opp/core.c
>> +++ b/drivers/base/power/opp/core.c

[...]

>>   {
>>   	struct opp_table *opp_table;
>>   	struct dev_pm_opp *opp, *tmp;
>> @@ -1884,7 +1885,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>>   	if (list_is_singular(&opp_table->dev_list)) {
>>   		/* Free static OPPs */
>>   		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
>> -			if (!opp->dynamic)
>> +			if (!opp->dynamic || (opp->dynamic && remove_dyn))
>
> Well, that's a funny one :)
>
> The second conditional statement doesn't require opp->dynamic, as that is
> guaranteed to be true, as the first condition failed.
>
> So this should be:
>
> if (remove_all || !opp->dynamic)
>

Yes, initially I thought we may need to support a mix where both static
entries from DT and dynamic entries will be present and this function
must remove the latter only. But I soon realized that it's not required
and also will get ugly. However I forgot to change this part :(

>>   				_opp_remove(opp_table, opp, true);
>>   		}
>>   	} else {
>> @@ -1894,6 +1895,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>>   unlock:
>>   	mutex_unlock(&opp_table_lock);
>>   }
>> +
>> +/**
>> + * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
>
> No, this isn't the OF specific function.
>

Sorry, copy-paste disease :) esp. for documenting.

-- 
Regards,
Sudeep
