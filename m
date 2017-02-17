From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V2 4/6] PM / domain: Register for PM QOS performance notifier
Date: Fri, 17 Feb 2017 15:54:58 -0800
Message-ID: <m27f4o4bl9.fsf@baylibre.com>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
        <cover.1486611268.git.viresh.kumar@linaro.org>
        <a973289cb908a391533a4b940af671beb2e8ace4.1486611268.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36415 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdBRADT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 19:03:19 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so16648818pfu.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 16:03:18 -0800 (PST)
In-Reply-To: <a973289cb908a391533a4b940af671beb2e8ace4.1486611268.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Thu, 9 Feb 2017 09:11:50 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Some platforms have the capability to configure the performance state of
> their Power Domains. The performance levels are represented by positive
> integer values, a lower value represents lower performance state.
>
> This patch registers the power domain framework for PM QOS performance
> notifier in order to manage performance state of power domains.

It seems to me it doesm't just register, but actually keeps track of the
performance_state by always tracking the max.

> This also allows the power domain drivers to implement a
> ->set_performance_state() callback, which will be called by the power
> domain core from the notifier routine.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h   |  5 +++
>  2 files changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a73d79670a64..1158a07f92de 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -367,6 +367,88 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +static void update_domain_performance_state(struct generic_pm_domain *genpd,
> +					    int depth)
> +{
> +	struct generic_pm_domain_data *pd_data;
> +	struct generic_pm_domain *subdomain;
> +	struct pm_domain_data *pdd;
> +	unsigned int state = 0;
> +	struct gpd_link *link;
> +
> +	/* Traverse all devices within the domain */
> +	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +		pd_data = to_gpd_data(pdd);
> +
> +		if (pd_data->performance_state > state)
> +			state = pd_data->performance_state;
> +	}

This seems to only update the state if it's bigger.  Maybe I'm missing
something here, but it seems like won't be able to lower the
performance_state after it's been raised?

> +	/* Traverse all subdomains within the domain */
> +	list_for_each_entry(link, &genpd->master_links, master_node) {
> +		subdomain = link->slave;
> +
> +		if (subdomain->performance_state > state)
> +			state = subdomain->performance_state;
> +	}

So subdomains are always assumed to influence the performance_state of
the parent domains?  Is that always the case?  I suspect this should be
probably be a reasonable default assumption, but maybe controlled with a
flag.

> +	if (genpd->performance_state == state)
> +		return;
> +
> +	genpd->performance_state = state;
> +
> +	if (genpd->set_performance_state) {
> +		genpd->set_performance_state(genpd, state);
> +		return;
> +	}

So is zero not a valid performance_state?  That doesn't seem quite right
to me, but either way, it should be documented.

> +	/* Propagate only if this domain has a single parent */

Why?  This limitation should be explained in the cover letter and
changelog.  I would also expect some sort of WARN here since this could
otherwise be a rather silent failures.

[...]

Kevin
