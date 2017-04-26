From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V4 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Wed, 26 Apr 2017 11:41:35 +0100
Message-ID: <ead65416-4833-6f36-81bd-c1673bb71514@arm.com>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998400AbdDZKlj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Apr 2017 06:41:39 -0400
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

Hi Viresh,

I went through the v4 code and it looks good to me.
Feel free to add for the v4 series
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you Viresh!

Regards,
Lukasz


On 25/04/17 11:27, Viresh Kumar wrote:
> Hi Guys,
>
> The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> high thermal states for a platform. But it wasn't glued really well with
> cpufreq core. For example clipped-cpus is copied from the policy
> structure and its much better to use the policy->cpus (or related_cpus)
> fields directly as they may have got updated. Not that things were
> broken before this series, but they can be optimized a bit more.
>
> This series tries to improve interactions between cpufreq core and
> cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> driver.
>
> I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards (haven't
> tested the power specific bits).
>
> Lukasz from ARM has been very generous in testing and finding out few
> bugs in the earlier versions and getting those fixed.  He has
> successfully tested the new version on his ARM big LITTLE Juno board.
>
> Pushed here as well:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cooling
>
> V3->V4:
> - The pointer to policy in the cpufreq notifier will have a different
>   address and so that address can't be used for comparison. Compare
>   policy->cpu instead.
> - max_level field was used for the newly created power-freq table, but
>   few places I have used < max_level instead of <= max_level and that
>   caused the trouble.
> - Added Tested-by from Lukasz.
>
> V2->V3:
> - Additional check to guarantee that policy is valid.
> - Initialize freq-table and cpufreq_cdev->policy fields before they are
>   used by the power-cooling functionality.
> - Thanks Lukasz for testing out and suggesting these changes.
>
> V1->V2:
> - Name cpufreq cooling dev as cpufreq_cdev everywhere (Eduardo).
>
> --
> viresh
>
> Viresh Kumar (17):
>   thermal: cpu_cooling: Avoid accessing potentially freed structures
>   thermal: cpu_cooling: rearrange globals
>   thermal: cpu_cooling: Name cpufreq cooling devices as cpufreq_cdev
>   thermal: cpu_cooling: replace cool_dev with cdev
>   thermal: cpu_cooling: remove cpufreq_cooling_get_level()
>   thermal: cpu_cooling: get rid of a variable in cpufreq_set_cur_state()
>   thermal: cpu_cooling: use cpufreq_policy to register cooling device
>   cpufreq: create cpufreq_table_count_valid_entries()
>   thermal: cpu_cooling: store cpufreq policy
>   thermal: cpu_cooling: OPPs are registered for all CPUs
>   thermal: cpu_cooling: get rid of 'allowed_cpus'
>   thermal: cpu_cooling: merge frequency and power tables
>   thermal: cpu_cooling: create structure for idle time stats
>   thermal: cpu_cooling: get_level() can't fail
>   thermal: cpu_cooling: don't store cpu_dev in cpufreq_cdev
>   thermal: cpu_cooling: 'freq' can't be zero in cpufreq_state2power()
>   thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device
>
>  drivers/cpufreq/arm_big_little.c                   |   2 +-
>  drivers/cpufreq/cpufreq-dt.c                       |   2 +-
>  drivers/cpufreq/cpufreq_stats.c                    |  13 +-
>  drivers/cpufreq/dbx500-cpufreq.c                   |   2 +-
>  drivers/cpufreq/mt8173-cpufreq.c                   |   4 +-
>  drivers/cpufreq/qoriq-cpufreq.c                    |   3 +-
>  drivers/thermal/cpu_cooling.c                      | 606 +++++++++------------
>  drivers/thermal/imx_thermal.c                      |  22 +-
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  22 +-
>  include/linux/cpu_cooling.h                        |  32 +-
>  include/linux/cpufreq.h                            |  14 +
>  11 files changed, 315 insertions(+), 407 deletions(-)
>
