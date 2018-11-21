From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date: Wed, 21 Nov 2018 11:48:19 +0530
Message-ID: <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
 <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 11/21/2018 11:36 AM, Viresh Kumar wrote:
> On 21-11-18, 10:47, Viresh Kumar wrote:
>> On 21-11-18, 10:34, Rajendra Nayak wrote:
>>>
>>>
>>> On 11/5/2018 12:06 PM, Viresh Kumar wrote:
>>>> Introduce a new helper dev_pm_opp_xlate_performance_state() which will
>>>> be used to translate from pstate of a device to another one.
>>>>
>>>> Initially this will be used by genpd to find pstate of a master domain
>>>> using its sub-domain's pstate.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>    drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/pm_opp.h |  7 ++++++
>>>>    2 files changed, 56 insertions(+)
>>>>
>>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>>> index 0eaa954b3f6c..010a4268e8dd 100644
>>>> --- a/drivers/opp/core.c
>>>> +++ b/drivers/opp/core.c
>>>> @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
>>>>    		dev_err(virt_dev, "Failed to find required device entry\n");
>>>>    }
>>>> +/**
>>>> + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
>>>> + * @src_table: OPP table which has dst_table as one of its required OPP table.
>>>
>>> So I have a case where the src_table and dst_table are shared/same. Can you explain how would
>>> it work in such a case?
>>
>> Can you give the example, as I am finding some issues with such shared
>> tables. Though the code may work just fine btw.
> 
> I may have found the problem you are facing here. Please try this diff
> and tell me if you hitting it, check this in dmesg.

Yes, I do seem to be hitting this.

> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 3740822b4197..6c45774306b0 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -225,6 +225,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>   free_required_tables:
>          _opp_table_free_required_tables(opp_table);
>   put_np:
> +       dev_err(dev, "Failed to allocate required OPP tables\n");
>          of_node_put(np);
>   }
> 
> 
