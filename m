From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: constify attribute_group
 structures.
Date: Mon, 3 Jul 2017 14:30:45 +0530
Message-ID: <20170703090045.GD3532@vireshk-i7>
References: <229e26ffc410cf4908c55ca0cb13906fd4bf4cf5.1499068985.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <229e26ffc410cf4908c55ca0cb13906fd4bf4cf5.1499068985.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03-07-17, 13:40, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   15197	   2552	     40	  17789	   457d	drivers/cpufreq/intel_pstate.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   15261	   2488	     40	  17789	   457d	drivers/cpufreq/intel_pstate.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b7de5bd..4323f94 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1212,7 +1212,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
>  	NULL
>  };
>  
> -static struct attribute_group intel_pstate_attr_group = {
> +static const struct attribute_group intel_pstate_attr_group = {
>  	.attrs = intel_pstate_attributes,
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
