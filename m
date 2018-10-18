From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
Date: Thu, 18 Oct 2018 11:45:02 +0200
Message-ID: <ff7cd793-e186-9f38-5e9e-f77cccc749bf@linaro.org>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, mingo@kernel.org
Cc: thara.gopinath@linaro.org, linux-kernel@vger.kernel.org, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, javi.merino@kernel.org, edubezval@gmail.com, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 18/10/2018 11:35, Daniel Lezcano wrote:
> It was suggested to set the scene for the PM components in the
> scheduler code organization in the recent discussion about making the
> scheduler aware of the capacity capping from the thermal framework.
> 
> Move the cpufreq files into its own directory as suggested at:
> 
> https://lkml.org/lkml/2018/10/18/353
> https://lkml.org/lkml/2018/10/18/408
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/Makefile                                   | 3 +--
>  kernel/sched/{cpufreq.c => cpufreq/core.c}              | 2 +-
>  kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} | 2 +-


I forget to git add the cpufreq/Makefile, resending.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
