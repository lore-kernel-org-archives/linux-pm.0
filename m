From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Don't create empty /sys/devices/system/cpu/cpufreq
 directory
Date: Sun, 19 May 2013 20:43:31 +0200
Message-ID: <51991D53.7020806@gmail.com>
References: <8bf03cb4a42864802800188fde78adf9b498455f.1368789952.git.viresh.kumar@linaro.org> <1b08f7e4657818e4a00ea7ebb137998223834dd5.1368789952.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1b08f7e4657818e4a00ea7ebb137998223834dd5.1368789952.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, robin.randhawa@arm.com, linux-pm@vger.kernel.org, patches@linaro.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linaro-kernel@lists.linaro.org, Steve.Bannister@arm.com, arvind.chauhan@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 05/17/2013 01:26 PM, Viresh Kumar wrote:
> When we don't have any file in cpu/cpufreq directory we shouldn't create it.
> Specially with the introduction of per-policy governor instance patchset, even
> governors are moved to cpu/cpu*/cpufreq/governor-name directory and so this
> directory is just not required.
> 
> Lets have it only when required.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
[...]
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e3d7112..2e18b3d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -678,9 +678,6 @@ static struct attribute *default_attrs[] = {
>  	NULL
>  };
>  
> -struct kobject *cpufreq_global_kobject;
> -EXPORT_SYMBOL(cpufreq_global_kobject);
> -
>  #define to_policy(k) container_of(k, struct cpufreq_policy, kobj)
>  #define to_attr(a) container_of(a, struct freq_attr, attr)
>  
> @@ -751,6 +748,49 @@ static struct kobj_type ktype_cpufreq = {
>  	.release	= cpufreq_sysfs_release,
>  };
>  
> +struct kobject *cpufreq_global_kobject;
> +EXPORT_SYMBOL(cpufreq_global_kobject);
> +
> +static int cpufreq_global_kobject_usage;
> +
> +int get_cpufreq_global_kobject(void)
> +{
> +	if (!cpufreq_global_kobject_usage++)
> +		return kobject_add(cpufreq_global_kobject,
> +				&cpu_subsys.dev_root->kobj, "%s", "cpufreq");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(get_cpufreq_global_kobject);
> +
> +void put_cpufreq_global_kobject(void)
> +{
> +	if (!--cpufreq_global_kobject_usage)
> +		kobject_del(cpufreq_global_kobject);
> +}
> +EXPORT_SYMBOL(put_cpufreq_global_kobject);

Global symbol names should begin with a sensible prefix; in this case,
it looks like cpufreq_get_global_kobject and cpufreq_put_global_kobject
would be more appropriate names.

Regards,
Francesco
