From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 35/35] cpufreq: tegra: use cpufreq_table_validate_and_show()
Date: Thu, 8 Aug 2013 21:37:43 +0530
Message-ID: <CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
	<568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
	<5203BCDD.40809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5203BCDD.40809@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 8 August 2013 21:14, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/08/2013 07:48 AM, Viresh Kumar wrote:
>> Lets use cpufreq_table_validate_and_show() instead of calling
>> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
>
> Assuming the new function simply does what the two removed lines do,
> this looks fine to me.

http://lkml.org/lkml/2013/8/8/266

>>  static int tegra_cpu_exit(struct cpufreq_policy *policy)
>>  {
>> -     cpufreq_frequency_table_cpuinfo(policy, freq_table);
>
> This doesn't seem to be mentioned in the commit description. I assume
> this is simply dead/useless code removal?

Its useless and the correct routine isn't called at all :) .. I will add that
additional patch and send it to you and will get this change out of this
commit.
