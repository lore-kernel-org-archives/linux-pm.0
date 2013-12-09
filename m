From: bilhuang <bilhuang@nvidia.com>
Subject: Re: [PATCH v3 1/2] cpufreq: tegra: Call tegra_cpufreq_init() specifically
 in machine code
Date: Mon, 9 Dec 2013 16:41:14 +0800
Message-ID: <52A5822A.9030807@nvidia.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com> <1386229462-3474-2-git-send-email-bilhuang@nvidia.com> <52A10431.6070306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52A10431.6070306@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/06/2013 06:54 AM, Stephen Warren wrote:
> On 12/05/2013 12:44 AM, Bill Huang wrote:
>> Move the call from module_init to Tegra machine codes so it won't be
>> called in a multi-platform kernel running on non-Tegra SoCs.
>
>> diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
>
> It might be better to create <linux/tegra-cpufreq.h> for the interface
> to the cpufreq driver; tegra-soc.h is for the interface to core Tegra
> code *from* other drivers.
Thanks, will do.
>
>> +#ifdef CONFIG_ARM_TEGRA_CPUFREQ
>> +int tegra_cpufreq_init(void);
>> +#else
>> +static inline int tegra_cpufreq_init(void)
>> +{
>> +	return -EINVAL;
>> +}
>> +#endif
>
> Probably best to "return 0" from the !CONFIG_ARM_TEGRA_CPUFREQ case; the
> whole point is to isolate callers from having to care whether
> CONFIG_ARM_TEGRA_CPUFREQ is enabled, and making the function act like it
> worked OK is part of that isolation.
>
OK thanks.
