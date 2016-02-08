From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 11/13] cpufreq: governor: Keep list of policy_dbs
 within dbs_data
Date: Mon, 8 Feb 2016 14:21:47 +0100
Message-ID: <CAJZ5v0gWhXEcwowPW1O00-7R-Ru4+2DdoRmdYQ-4nLKDf0wyUw@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<b260aaa932e50d6f00eaa3d8f2422a29e061286b.1454931189.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35550 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcBHNVt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:21:49 -0500
In-Reply-To: <b260aaa932e50d6f00eaa3d8f2422a29e061286b.1454931189.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> An instance of 'struct dbs_data' can support multiple 'struct
> policy_dbs_info' instances. To traverse all policy_dbs supported by a
> dbs_data, create a list of policy_dbs within dbs_data.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Good idea overall, I like this.

> ---
>  drivers/cpufreq/cpufreq_governor.c | 12 ++++++++++++
>  drivers/cpufreq/cpufreq_governor.h |  7 ++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index ee3c2d92da53..e267acc67067 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -489,6 +489,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>                 dbs_data->usage_count++;
>                 policy_dbs->dbs_data = dbs_data;
>                 policy->governor_data = policy_dbs;
> +
> +               mutex_lock(&dbs_data->mutex);
> +               list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
> +               mutex_unlock(&dbs_data->mutex);

The previous statements should be under the mutex too IMO, at least
the usage count incrementation in case two instances of this happen at
the same time.

That can't happen now, but if we want to get rid of dbs_data_mutex
going forward, having it under the mutex will be actually useful.

> +
>                 return 0;
>         }
>
> @@ -500,8 +505,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>
>         dbs_data->usage_count = 1;
>         dbs_data->gov = gov;
> +       INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
>         mutex_init(&dbs_data->mutex);
>
> +       list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);

That line should go to where policy_dbs->dbs_data is set so it is
clear that they go together.  And I'd set the usage count to 1 in
there too for consistency.

> +
>         ret = gov->init(dbs_data, !policy->governor->initialized);
>         if (ret)
>                 goto free_policy_dbs_info;
> @@ -554,6 +562,10 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
>         struct policy_dbs_info *policy_dbs = policy->governor_data;
>         struct dbs_data *dbs_data = policy_dbs->dbs_data;
>
> +       mutex_lock(&dbs_data->mutex);
> +       list_del(&policy_dbs->list);
> +       mutex_unlock(&dbs_data->mutex);
> +

Same here.  I'd do the decrementation of the counter under the mutex
along with the removal from the list.  They are related in any case
("one user goes away") and will be useful for dbs_data_mutex
elimination.

>         if (!--dbs_data->usage_count) {
>                 kobject_put(&dbs_data->kobj);
>
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index ced34ba5a18d..b740633c2fbe 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -74,7 +74,11 @@ struct dbs_data {
>         unsigned int up_threshold;
>
>         struct kobject kobj;
> -       /* Protect concurrent updates to governor tunables from sysfs */
> +       struct list_head policy_dbs_list;
> +       /*
> +        * Protect concurrent updates to governor tunables from sysfs and
> +        * policy_dbs_list.
> +        */

And if the counter is modified under the mutex, it should be mentioned
in this comment.

Maybe keep the counter close to the list and the mutex in the
structure definition too?

>         struct mutex mutex;
>  };
>
> @@ -132,6 +136,7 @@ struct policy_dbs_info {
>         struct work_struct work;
>         /* dbs_data may be shared between multiple policy objects */
>         struct dbs_data *dbs_data;
> +       struct list_head list;
>  };
>
>  static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
> --

Thanks,
Rafael
