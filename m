From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix EXYNOS drivers selection
Date: Mon, 12 Aug 2013 11:09:51 +0530
Message-ID: <CAKohpomiafT1nYx0O4fvEr1qyo6Zd81a+1W+-FsQRgQOEKya+w@mail.gmail.com>
References: <2522264.d7vsK7QKUi@amdc1032>
	<76454119.W9pKpoo1U1@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <76454119.W9pKpoo1U1@amdc1227>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 9 August 2013 21:20, Tomasz Figa <t.figa@samsung.com> wrote:
> On Friday 09 of August 2013 14:04:55 Bartlomiej Zolnierkiewicz wrote:
>> * remove superfluous pr_debug() call from exynos_cpufreq_init()
>>   (init errors are always logged anyway)
>> * add dummy per-SoC type init functions to exynos-cpufreq.h
>> * make per-SoC type cpufreq config options selectable
>> * make CONFIG_ARM_EXYNOS_CPUFREQ config option invisible to user and
>>   automatically enable it when needed
>>
>> This patch fixes following issues:
>> * EXYNOS per-SoC type cpufreq support (i.e. exynos4210-cpufreq.c) being
>>   always built if given SoC support was enabled (i.e. CPU_EXYNOS4210),
>>   even if common EXYNOS cpufreq support was disabled
>> * inability to select cpufreq for each SoC type separately (it could
>>   be only enabled/disabled for all SoCs for which support was enabled)
>> * EXYNOS5440 cpufreq support was always enabled when EXYNOS5440
>>   support was enabled and couldn't be disabled
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm      |   36
>> ++++++++++++++++++++++++------------ drivers/cpufreq/exynos-cpufreq.c |
>>   1 -
>>  drivers/cpufreq/exynos-cpufreq.h |   21 +++++++++++++++++++++
>>  3 files changed, 45 insertions(+), 13 deletions(-)

> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Applied. Thanks!!
