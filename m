From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Cpufreq: Remove fossil comment in the cpufreq_governor_dbs()
Date: Fri, 15 Nov 2013 14:13:26 +0530
Message-ID: <CAKohpokgkho_7P47cvxszUXq=qeWH6Yo4j8QcyHrBu0u8e8P9Q@mail.gmail.com>
References: <1384494841-28581-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1384494841-28581-1-git-send-email-tianyu.lan@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 November 2013 11:24, Lan Tianyu <tianyu.lan@intel.com> wrote:
> The related code has been changed and the comment is out of data.
> So remove it.
>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 0806c31..e6be635 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -328,10 +328,6 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>                                              dbs_data->cdata->gov_dbs_timer);
>                 }
>
> -               /*
> -                * conservative does not implement micro like ondemand
> -                * governor, thus we are bound to jiffes/HZ
> -                */
>                 if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
>                         cs_dbs_info->down_skip = 0;
>                         cs_dbs_info->enable = 1;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
