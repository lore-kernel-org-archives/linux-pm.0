From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
Date: Wed, 21 Nov 2018 11:01:07 +0530
Message-ID: <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 11/21/2018 10:46 AM, Viresh Kumar wrote:
> On 21-11-18, 10:33, Rajendra Nayak wrote:
>> Hi Viresh,
>>
>> On 11/5/2018 12:06 PM, Viresh Kumar wrote:
>>> This commit updates genpd core to start propagating performance state
>>> updates to master domains that have their set_performance_state()
>>> callback set.
>>>
>>> A genpd handles two type of performance states now. The first one is the
>>> performance state requirement put on the genpd by the devices and
>>> sub-domains under it, which is already represented by
>>> genpd->performance_state. The second type, introduced in this commit, is
>>> the performance state requirement(s) put by the genpd on its master
>>> domain(s). There is a separate value required for each master that the
>>> genpd has and so a new field is added to the struct gpd_link
>>> (link->performance_state), which represents the link between a genpd and
>>> its master. The struct gpd_link also got another field
>>> prev_performance_state, which is used by genpd core as a temporary
>>> variable during transitions.
>>>
>>> We need to propagate setting performance state while powering-on a genpd
>>> as well, as we ignore performance state requirements from sub-domains
>>> which are powered-off. For this reason _genpd_power_on() also received
>>> the additional parameter, depth, which is used for hierarchical locking
>>> within genpd.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>    drivers/base/power/domain.c | 107 +++++++++++++++++++++++++++++-------
>>>    include/linux/pm_domain.h   |   4 ++
>>>    2 files changed, 92 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 6d2e9b3406f1..81e02c5f753f 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -239,28 +239,86 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>>>    static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>>>    #endif
>>> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>>> +					   unsigned int state, int depth);
>>> +
>>>    static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>>> -					unsigned int state)
>>> +					unsigned int state, int depth)
>>>    {
>>> +	struct generic_pm_domain *master;
>>> +	struct gpd_link *link;
>>> +	unsigned int mstate;
>>>    	int ret;
>>>    	if (!genpd_status_on(genpd))
>>>    		goto out;
>>
>> This check here would mean we only propogate performance state
>> to masters if the genpd is ON?
> 
> Yeah, isn't that what should we do anyway? It is similar to clk-enable
> etc. Why increase the reference count if the device isn't enabled and
> isn't using the clock ?

I would think this is analogous to a driver calling clk_set_rate() first and
then a clk_enable(), which is certainly valid.
So my question is, if calling a dev_pm_genpd_set_performance_state()
and then runtime enabling the device would work (and take care of propagating the performance
state). In my testing I found it does not.

> 
> Also you can see that I have updated the genpd power-on code to start
> propagation to make sure we don't miss anything.
> 
