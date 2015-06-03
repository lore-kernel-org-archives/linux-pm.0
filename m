From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC/PATCH 4/6] OPP: Allow notifiers to call dev_pm_opp_get_{voltage,freq}
 RCU-free
Date: Wed, 03 Jun 2015 15:43:34 -0700
Message-ID: <556F8316.2000109@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org> <1433209679-31389-5-git-send-email-sboyd@codeaurora.org> <556D2369.2000603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <556D2369.2000603@samsung.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 06/01/2015 08:30 PM, Krzysztof Kozlowski wrote:
> On 02.06.2015 10:47, Stephen Boyd wrote:
>> We pass the dev_pm_opp structure to OPP notifiers but the users
>> of the notifier need to surround calls to dev_pm_opp_get_*() with
>> RCU read locks to avoid lockdep warnings. The notifier is already
>> called with the dev_opp's srcu lock held, so it should be safe to
>> assume the devm_pm_opp structure is already protected inside the
>> notifier. Update the lockdep check for this.
>>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> This is probably wrong, but it's what I had to hack up
>> to be able to use the OPP functions from within the notifier
>> to figure out the new values of the OPP without having to take
>> an RCU read lock.
>>
>>   drivers/base/power/opp.c | 19 +++++++++++--------
>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>> index b997a7eabcd4..6d75022c6a0e 100644
>> --- a/drivers/base/power/opp.c
>> +++ b/drivers/base/power/opp.c
>> @@ -108,9 +108,10 @@ static LIST_HEAD(dev_opp_list);
>>   /* Lock to allow exclusive modification to the device and opp lists */
>>   static DEFINE_MUTEX(dev_opp_list_lock);
>>   
>> -#define opp_rcu_lockdep_assert()					\
>> +#define opp_rcu_lockdep_assert(s)					\
>>   do {									\
>>   	rcu_lockdep_assert(rcu_read_lock_held() ||			\
>> +				(s && srcu_read_lock_held(s)) || 	\
>>   				lockdep_is_held(&dev_opp_list_lock),	\
>>   			   "Missing rcu_read_lock() or "		\
>>   			   "dev_opp_list_lock protection");		\
>> @@ -169,9 +170,10 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>>   	struct dev_pm_opp *tmp_opp;
>>   	unsigned long v = 0;
>>   
>> -	opp_rcu_lockdep_assert();
>> +	opp_rcu_lockdep_assert(&opp->dev_opp->srcu_head.srcu);
>>   
>> -	tmp_opp = rcu_dereference(opp);
>> +	tmp_opp = srcu_dereference_check(opp, &opp->dev_opp->srcu_head.srcu,
>> +					 rcu_read_lock_held());
> It looks strange. The notifier's SRCU is part of device_opp but here we
> want to protect the dev_pm_opp.
>
> Because of this difference I am not sure that it is safe having around
> this a srcu_read_lock() from notifiers instead of rcu_read_lock().
>
>

Yeah I'm not sure, and I'll have to spend more time to figure out what's 
going on, hence the RFC. Does it make sense to allow the notifiers to 
call these functions without rcu_read_lock() though? It certainly looks 
strange to call rcu_read_lock() with a pointer that is handed to the 
notifier.

It also seems that rcu_dereference() will take care of calling 
rcu_read_lock_held() for us so having an opp_rcu_lockdep_assert() here 
is redundant.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
