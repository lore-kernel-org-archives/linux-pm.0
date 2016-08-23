From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v1 3/3] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
Date: Tue, 23 Aug 2016 17:29:16 +0800
Message-ID: <4eab5b34-58f8-30bb-1a2c-0b0d6b3e2b2c@rock-chips.com>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <20160819133636.GA26913@rob-hp-laptop>
 <c853c8fd-285a-603d-b294-750cdbf7f200@rock-chips.com>
 <3008348.gWNc8j0KGA@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3008348.gWNc8j0KGA@diego>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tim.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, ulysses.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lin.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org



在 2016/8/23 17:03, Heiko Stübner 写道:
> Hi Finley,
>
> Am Dienstag, 23. August 2016, 12:10:27 schrieb Finley Xiao:
>> 在 2016/8/19 21:36, Rob Herring 写道:
>>> On Tue, Aug 16, 2016 at 10:38:59AM +0800, Finlye Xiao wrote:
>>>> From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>>
>>>> This patch supports adjusting opp's voltage according to leakage
>>>>
>>>> Signed-off-by: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>> ---
>>>>
>>>>    .../devicetree/bindings/power/rockchip-cpu-avs.txt |  37 +++
>>>>    drivers/power/avs/Kconfig                          |   8 +
>>>>    drivers/power/avs/Makefile                         |   1 +
>>>>    drivers/power/avs/rockchip-cpu-avs.c               | 314
>>>>    +++++++++++++++++++++ 4 files changed, 360 insertions(+)
>>>>    create mode 100644
>>>>    Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt create
>>>>    mode 100644 drivers/power/avs/rockchip-cpu-avs.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
>>>> b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt new file
>>>> mode 100644
>>>> index 0000000..90f6b08
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
>>>> @@ -0,0 +1,37 @@
>>>> +Rockchip cpu avs device tree bindings
>>>> +-------------------------------------
>>>> +
>>>> +Under the same frequency, the operating voltage tends to decrease with
>>>> +increasing leakage. so it is necessary to adjust opp's voltage according
>>>> +to leakage for power.
>>>> +
>>>> +
>>>> +Required properties:
>>>> +- compatible: Should be one of the following.
>>>> +  - "rockchip,rk3399-cpu-avs" - for RK3399 SoCs.
>>>> +- leakage-volt-<name>: Named leakage-volt property. At runtime, the
>>>> +  platform can find a cpu's cluster_id according to it's cpu_id and
>>>> match
>>>> +  leakage-volt-<name> property. The property is an array of 3-tuples
>>>> +  items, and each item consists of leakage and voltage like
>>>> +  <min-leakage-mA max-leakage-mA vol-uV>.
>>>> +	min-leakage: minimum leakage in mA.
>>>> +	max-leakage: maximum leakage in mA.
>>>> +	vol: voltage in microvolt.
>>> How do you determine these values? When do they vary?
>> How do you determine these values?
>>
>> run antutu-benchmark
>> leakage     freq 	min_volt
>> 30mA 	    1608MHz 	1025mV
>> 40mA 	    1608MHz 	1000mV
>> 50mA 	    1608MHz 	975mV
>>
>>   From the table, we see the min_volt decrease with increasing leakage.
>> So we can set the default opp-microvolt 1025mV for 1608MHz,
>> and add an leakage_volt_cluster0 property as follows.
>> leakage_volt_cluster0 = <
>> 		/*  min(mA)   max(mA)    volt(uV)*/
>> 		    0         40        0
>> 		    41        50        (-25000)
>> 		    51        254       (-50000)
>>
>>> ;
>> If the leakage is between 41mA and 50mA，the opp-microvolt will subtract
>> 25mV。 If the leakage is between 41mA and 50mA，the opp-microvolt will
>> subtract 50mV。
>>
>> When do they vary?
>>
>>   From the code,
>> cpufreq_online
>> --cpufreq_driver->init(policy);  /* add new opp table */
>> --blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>> CPUFREQ_START, policy);
>> --cpufreq_init_policy
>> ----cpufreq_set_policy
>> --------__cpufreq_governor(policy, CPUFREQ_GOV_START);
>>
>> The cpu's opp table is added in the init function(cpufreq_init)，and I will
>> register a cpufreq notifier, once the first cpu of cluster is onlined,
>> my notifer will be called, and if the event is CPUFREQ_START，it will modify
>> the opp-microvolt according to leakage_volt_cluster0.
> I think what Rob was asking with "when do they vary" is, are these leakage
> values the same for each and every rk3399 soc or are they determined
> separately for each board-type using the rk3399.

Oh, sorry, I misunderstood.
They are the same for every rk3399 soc.

>
>
>
>
>

-- 
Finley


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
