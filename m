From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 35/35] cpufreq: tegra: use cpufreq_table_validate_and_show()
Date: Thu, 08 Aug 2013 09:44:29 -0600
Message-ID: <5203BCDD.40809@wwwdotorg.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org> <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 08/08/2013 07:48 AM, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Assuming the new function simply does what the two removed lines do,
this looks fine to me.

>  static int tegra_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	cpufreq_frequency_table_cpuinfo(policy, freq_table);

This doesn't seem to be mentioned in the commit description. I assume
this is simply dead/useless code removal?

