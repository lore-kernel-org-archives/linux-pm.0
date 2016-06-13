From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: Do not use transition
 notifications
Date: Mon, 13 Jun 2016 20:58:34 +0530
Message-ID: <20160613152834.GZ27439@vireshk-i7>
References: <2899343.d3UcWvo4TA@vostro.rjw.lan>
 <20160613110851.GT27439@vireshk-i7>
 <4018929.eixPj0erQd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4018929.eixPj0erQd@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 13-06-16, 15:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] cpufreq: conservative: Do not use transition notifications
> 
> The conservative governor registers a transition notifier so it
> can update its internal requested_freq value if it falls out of the
> policy->min...policy->max range, but requested_freq is not really
> necessary.
> 
> That value is used to track the frequency requested by the governor
> previously, but policy->cur can be used instead of it and then the
> governor will not have to worry about updating the tracked value when
> the current frequency changes independently (for example, as a result
> of min or max changes).
> 
> Accodringly, drop requested_freq from struct cs_policy_dbs_info
> and modify cs_dbs_timer() to use policy->cur instead of it.
> While at it, notice that __cpufreq_driver_target() clamps its
> target_freq argument between policy->min and policy->max, so
> the callers of it don't have to do that and make additional
> changes in cs_dbs_timer() in accordance with that.
> 
> After these changes the transition notifier used by the conservative
> governor is not necessary any more, so drop it, which also makes it
> possible to drop the struct cs_governor definition and simplify the
> code accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |  103 ++++++---------------------------
>  1 file changed, 21 insertions(+), 82 deletions(-)
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

> -static struct cs_governor cs_gov = {
> -	.dbs_gov = {
> -		.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -		.kobj_type = { .default_attrs = cs_attributes },
> -		.gov_dbs_timer = cs_dbs_timer,
> -		.alloc = cs_alloc,
> -		.free = cs_free,
> -		.init = cs_init,
> -		.exit = cs_exit,
> -		.start = cs_start,
> -	},
> +static struct dbs_governor cs_governor = {
> +	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> +	.kobj_type = { .default_attrs = cs_attributes },
> +	.gov_dbs_timer = cs_dbs_timer,
> +	.alloc = cs_alloc,
> +	.free = cs_free,
> +	.init = cs_init,
> +	.exit = cs_exit,
> +	.start = cs_start,
>  };

Though, I am not sure why this change was required :)

-- 
viresh
