From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] cpufreq: e_powersaver: Use struct_size() in kzalloc()
Date: Thu, 24 Jan 2019 11:33:52 -0600
Message-ID: <cc4d5cb2-8e37-2b97-240b-96d712373ed2@embeddedor.com>
References: <20190107173343.GA4258@embeddedor>
 <20190108050056.quckhd2d5ah4ywax@vireshk-i7>
 <1645829.9I2fkU6ktd@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1645829.9I2fkU6ktd@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 1/24/19 4:34 AM, Rafael J. Wysocki wrote:
> On Tuesday, January 8, 2019 6:00:56 AM CET Viresh Kumar wrote:
>> On 07-01-19, 11:33, Gustavo A. R. Silva wrote:
>>> One of the more common cases of allocation size calculations is finding the
>>> size of a structure that has a zero-sized array at the end, along with memory
>>> for some number of elements for that array. For example:
>>>
>>> struct foo {
>>>     int stuff;
>>>     void *entry[];
>>> };
>>>
>>> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>>>
>>> Instead of leaving these open-coded and prone to type mistakes, we can now
>>> use the new struct_size() helper:
>>>
>>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>>
>>> This code was detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/cpufreq/e_powersaver.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
>>> index 60bea302abbe..2d3ef208dd70 100644
>>> --- a/drivers/cpufreq/e_powersaver.c
>>> +++ b/drivers/cpufreq/e_powersaver.c
>>> @@ -323,9 +323,8 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>>>  		states = 2;
>>>  
>>>  	/* Allocate private data and frequency table for current cpu */
>>> -	centaur = kzalloc(sizeof(*centaur)
>>> -		    + (states + 1) * sizeof(struct cpufreq_frequency_table),
>>> -		    GFP_KERNEL);
>>> +	centaur = kzalloc(struct_size(centaur, freq_table, states + 1),
>>> +			  GFP_KERNEL);
>>>  	if (!centaur)
>>>  		return -ENOMEM;
>>>  	eps_cpu[0] = centaur;
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Patch applied, thanks!
> 

Thank you both, Viresh and Rafael.

--
Gustavo
