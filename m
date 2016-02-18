From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/12] cpufreq: governor: Move per-CPU data to the common
 code
Date: Thu, 18 Feb 2016 11:38:21 +0530
Message-ID: <20160218060821.GO2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <4441299.INuf21BhVZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4441299.INuf21BhVZ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-02-16, 02:31, Rafael J. Wysocki wrote:
> @@ -464,21 +455,24 @@ static void od_set_powersave_bias(unsign
>  
>  	get_online_cpus();
>  	for_each_online_cpu(cpu) {
> +		struct cpufreq_policy *policy;
>  		struct policy_dbs_info *policy_dbs;
> +		struct dbs_data *dbs_data;
> +		struct od_dbs_tuners *od_tuners;
>  
>  		if (cpumask_test_cpu(cpu, &done))
>  			continue;
>  
> -		policy_dbs = per_cpu(od_cpu_dbs_info, cpu).cdbs.policy_dbs;
> +		policy = cpufreq_cpu_get_raw(cpu);

This is surely racy, as this might get called while governors are
getting exchanged. But this is racy today as well.

We should be using the list of policies present with the governors
here, with dbs_data->lock or something like that.


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
