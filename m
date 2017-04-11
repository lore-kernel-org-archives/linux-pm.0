From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v2 1/3] cpufreq: Add Tegra186 cpufreq driver
Date: Tue, 11 Apr 2017 09:37:28 +0300
Message-ID: <ce29c6b7-2942-0054-d014-7b262da6fb6d@kapsi.fi>
References: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
 <20170411063548.GD3670@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170411063548.GD3670@vireshk-i7>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/11/2017 09:35 AM, Viresh Kumar wrote:
> On 04-04-17, 16:43, Mikko Perttunen wrote:
>> Add a new cpufreq driver for Tegra186 (and likely later).
>> The CPUs are organized into two clusters, Denver and A57,
>> with two and four cores respectively. CPU frequency can be
>> adjusted by writing the desired rate divisor and a voltage
>> hint to a special per-core register.
>>
>> The frequency of each core can be set individually; however,
>> this is just a hint as all CPUs in a cluster will run at
>> the maximum rate of non-idle CPUs in the cluster.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>> v2:
>> - Many cosmetic / restructuring changes
>> - Only one aperture read from DT now, with a new
>>   structure containing the offset among other details
>>   per cluster.
>> - Don't enable the driver by default.
>>
>>  drivers/cpufreq/Kconfig.arm        |   6 +
>>  drivers/cpufreq/Makefile           |   1 +
>>  drivers/cpufreq/tegra186-cpufreq.c | 275 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 282 insertions(+)
>>  create mode 100644 drivers/cpufreq/tegra186-cpufreq.c
>
> For all three patches.
>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>

Thanks!

Mikko
