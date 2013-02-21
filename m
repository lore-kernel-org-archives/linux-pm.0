From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 3/4] cpufreq: Add Kconfig option to enable/disable have_multiple_policies
Date: Fri, 22 Feb 2013 00:53:20 +0100
Message-ID: <2852709.b79tkCt2uQ@vostro.rjw.lan>
References: <cover.1360568193.git.viresh.kumar@linaro.org> <0289db340545c87d8e4aac7184dd91177eeb9a43.1360568193.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <0289db340545c87d8e4aac7184dd91177eeb9a43.1360568193.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Monday, February 11, 2013 01:20:02 PM Viresh Kumar wrote:
> have_multiple_policies is required by platforms having multiple clock-domains
> for cpus, i.e. supporting multiple policies for cpus. This patch adds in a
> Kconfig option for enabling execution of this code.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 3 +++
>  include/linux/cpufreq.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index cbcb21e..e6e6939 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -23,6 +23,9 @@ config CPU_FREQ_TABLE
>  config CPU_FREQ_GOV_COMMON
>  	bool
>  
> +config CPU_FREQ_HAVE_MULTIPLE_POLICIES
> +	bool
> +

So I suppose some architectures will select this, right?

What architecture they are?

>  config CPU_FREQ_STAT
>  	tristate "CPU frequency translation statistics"
>  	select CPU_FREQ_TABLE
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c5ac9a5..0d84bfa 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -107,11 +107,13 @@ struct cpufreq_policy {
>  	unsigned int		policy; /* see above */
>  	struct cpufreq_governor	*governor; /* see below */
>  	void			*governor_data;
> +#ifdef CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES
>  	/* This should be set by init() of platforms having multiple
>  	 * clock-domains, i.e.  supporting multiple policies. With this sysfs
>  	 * directories of governor would be created in cpu/cpu<num>/cpufreq/
>  	 * directory */
>  	bool			have_multiple_policies;
> +#endif

I'm not really sure I like this. ->

>  	struct work_struct	update; /* if update_policy() needs to be
>  					 * called, but you're in IRQ context */
> @@ -142,9 +144,11 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
>  static inline struct kobject *
>  get_governor_parent_kobj(struct cpufreq_policy *policy)
>  {
> +#ifdef CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES
>  	if (policy->have_multiple_policies)
>  		return &policy->kobj;
>  	else
> +#endif
>  		return cpufreq_global_kobject;

-> I wonder why don't you arrange things so that policy->kobj is always
returned, but it points to cpufreq_global_kobject in case there's only one
(i.e. make policy->kobj a pointer)?

>  }

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
