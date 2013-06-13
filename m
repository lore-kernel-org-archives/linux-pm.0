From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/11] cpufreq: tegra: select CPU_FREQ_TABLE for ARCH_TEGRA
Date: Thu, 13 Jun 2013 21:16:05 +0530
Message-ID: <CAKohpokNPR5aZ=WnOeZZD9RCY98_eS1-=dohzVBwyoAwP4ackg@mail.gmail.com>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
	<881257c10f24b5ca8721b561726bac8887dc922e.1371022830.git.viresh.kumar@linaro.org>
	<51B898B6.8070103@wwwdotorg.org>
	<CAKohponC5pKABTi=t64ZXrHxi-Y6cbvAXtjY=_aMkka4s-MCiQ@mail.gmail.com>
	<51B9E8BB.9020104@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51B9E8BB.9020104@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 13 June 2013 21:13, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/12/2013 10:24 PM, Viresh Kumar wrote:
>> On 12 June 2013 21:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 06/12/2013 02:15 AM, Viresh Kumar wrote:
>>>> ARCH_TEGRA selects ARCH_HAS_CPUFREQ, so CPUFREQ will be enabled for all variants
>>>> of TEGRA. CPUFreq driver for tegra is enabled if ARCH_TEGRA is selected. Driver
>>>> uses APIs from freq_table.c and so we must select CPU_FREQ_TABLE for ARCH_TEGRA.
>>>>
>>>> This also removes select CPU_FREQ_TABLE from individual tegra variants.
>>>
>>> I guess the real issue here is that drivers/cpufreq/tegra-cpufreq.c gets
>>> built based on ARCH_TEGRA, which doesn't depend on nor select CPU_FREQ
>>> itself, so:
>>>
>>>         select CPU_FREQ_TABLE if CPU_FREQ
>>>
>>> ... isn't guaranteed to fire.
>>>
>>> The correct solution seems to be:
>>>
>>> * Add CONFIG_ARM_TEGRA_CPUFREQ to drivers/cpufreq/Kconfig.arm.
>>> * Make that Kconfig option selct CPU_FREQ_TABLE.
>>> * Make that Kconfig option be def_bool ARCH_TEGRA.
>>> * Modify drivers/cpufreq/Makefile to build tegra-cpufreq.c based on that.
>>> * Remove all the cpufreq-related stuff from arch/arm/mach-tegra/Kconfig.
>>>
>>> That way, tegra-cpufreq.c can't be built if !CPU_FREQ, and Tegra's
>>> cpufreq works the same way as all the other cpufreq drivers.
>>
>> Hmmm. check this out (attached too for you to test):
>
> This certainly generates the correct .config when I "make
> tegra_defconfig" after applying it, and a build after disabling CPU_FREQ
> links OK, so,

Yeah, I also compile tested it.

> Tested-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> (I assume this patch would go through the cpufreq tree?)

Yes. Via my ARM cpufreq tree.
