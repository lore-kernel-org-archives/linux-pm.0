From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date: Wed, 21 Nov 2018 10:34:54 +0530
Message-ID: <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> be used to translate from pstate of a device to another one.
> 
> Initially this will be used by genpd to find pstate of a master domain
> using its sub-domain's pstate.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pm_opp.h |  7 ++++++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0eaa954b3f6c..010a4268e8dd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
>   		dev_err(virt_dev, "Failed to find required device entry\n");
>   }
>   
> +/**
> + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> + * @src_table: OPP table which has dst_table as one of its required OPP table.

So I have a case where the src_table and dst_table are shared/same. Can you explain how would
it work in such a case?

> + * @dst_table: Required OPP table of the src_table.
> + * @pstate: Current performance state of the src_table.
> + *
> + * This Returns pstate of the OPP (present in @dst_table) pointed out by the
> + * "required-opps" property of the OPP (present in @src_table) which has
> + * performance state set to @pstate.
> + *
> + * Return: Positive performance state on success, otherwise 0 on errors.
> + */
> +unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
> +						struct opp_table *dst_table,
> +						unsigned int pstate)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned int dest_pstate = 0;
> +	int i;
> +
> +	for (i = 0; i < src_table->required_opp_count; i++) {
> +		if (src_table->required_opp_tables[i] == dst_table)
> +			break;
> +	}
> +
> +	if (unlikely(i == src_table->required_opp_count)) {
> +		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> +		       __func__, src_table, dst_table);
> +		return 0;
> +	}
> +
> +	mutex_lock(&src_table->lock);
> +
> +	list_for_each_entry(opp, &src_table->opp_list, node) {
> +		if (opp->pstate == pstate) {
> +			dest_pstate = opp->required_opps[i]->pstate;
> +			goto unlock;
> +		}
> +	}
> +
> +	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> +	       dst_table);
> +
> +unlock:
> +	mutex_unlock(&src_table->lock);
> +
> +	return dest_pstate;
> +}
> +
>   /**
>    * dev_pm_opp_add()  - Add an OPP table from a table definitions
>    * @dev:	device for which we do this operation
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 2b2c3fd985ab..5a64a81a1789 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
>   void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>   struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
>   void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
> +unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>   int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>   int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>   int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
>   }
>   
>   static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
> +
> +static inline unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
> +{
> +	return 0;
> +}
> +
>   static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   {
>   	return -ENOTSUPP;
> 
