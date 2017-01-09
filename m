From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/12] PM / OPP: Add 'struct kref' to OPP table
Date: Mon, 9 Jan 2017 15:36:27 -0800
Message-ID: <20170109233627.GU17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <3f23949c92492ea74a7a55cd04bcd41a37592ed5.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f23949c92492ea74a7a55cd04bcd41a37592ed5.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 12/07, Viresh Kumar wrote:
> @@ -894,8 +895,36 @@ static void _kfree_device_rcu(struct rcu_head *head)
>  	kfree_rcu(opp_table, rcu_head);
>  }
>  
> -static void _free_opp_table(struct opp_table *opp_table)
> +void _get_opp_table_kref(struct opp_table *opp_table)
>  {
> +	kref_get(&opp_table->kref);
> +}
> +
> +struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
> +{
> +	struct opp_table *opp_table;
> +
> +	/* Hold our table modification lock here */
> +	mutex_lock(&opp_table_lock);
> +
> +	opp_table = _find_opp_table(dev);
> +	if (!IS_ERR(opp_table)) {
> +		_get_opp_table_kref(opp_table);

It seems odd to have _get_opp_table_kref() take a pointer to
increment a kref on. It would be better to have _find_opp_table()
return the pointer with the reference already taken so that we
don't have to update callers with reference grabbing calls.
Typically if a function returns a reference counted pointer the
reference counting has already been done.

> +		goto unlock;
> +	}
> +
> +	opp_table = _allocate_opp_table(dev);
> +
> +unlock:
> +	mutex_unlock(&opp_table_lock);
> +
> +	return opp_table;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
> +
> +static void _opp_table_kref_release_unlocked(struct kref *kref)
> +{
> +	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
>  	struct opp_device *opp_dev;
>  
>  	/* Release clk */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
