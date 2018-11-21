From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
Date: Wed, 21 Nov 2018 12:21:18 +0530
Message-ID: <bd5b94fb-ed9a-7745-a0cd-cfc3b81d676f@codeaurora.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
 <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
 <5efc76bb-7732-52b6-4684-82b35ad52343@codeaurora.org>
 <20181121063646.37bha3vomxvzazzn@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121063646.37bha3vomxvzazzn@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 11/21/2018 12:06 PM, Viresh Kumar wrote:
> On 21-11-18, 11:12, Rajendra Nayak wrote:
>> And the reason for that seems to be that we update the genpd status to GPD_STATE_ACTIVE
>> *after* we try to set the performance state, so we always hit this check which bails out
>> thinking the genpd is not ON.
> 
> Thanks for looking at it. Here is the (untested) fix, please try it
> out.

Thanks, yes, this does seem to work.

> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 84c13695af65..92be4a224b45 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -250,9 +250,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>          unsigned int mstate;
>          int ret;
>   
> -       if (!genpd_status_on(genpd))
> -               goto out;
> -
>          /* Propagate to masters of genpd */
>          list_for_each_entry(link, &genpd->slave_links, slave_node) {
>                  master = link->master;
> @@ -286,7 +283,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>          if (ret)
>                  goto err;
>   
> -out:
>          genpd->performance_state = state;
>          return 0;
>   
> @@ -361,6 +357,11 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>                  return 0;
>   
>   update_state:
> +       if (!genpd_status_on(genpd)) {
> +               genpd->performance_state = state;
> +               return 0;
> +       }
> +
>          return _genpd_set_performance_state(genpd, state, depth);
>   }
> 
