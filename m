From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v5 1/1] cpufreq: tegra: Re-model Tegra20 cpufreq driver
Date: Thu, 19 Dec 2013 12:33:35 -0700
Message-ID: <52B34A0F.5080901@wwwdotorg.org>
References: <1387451926-21373-1-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1387451926-21373-1-git-send-email-bilhuang@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Bill Huang <bilhuang@nvidia.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/19/2013 04:18 AM, Bill Huang wrote:
> Re-model Tegra20 cpufreq driver as below.
> 
> * Rename tegra-cpufreq.c to tegra20-cpufreq.c since this file supports
>   only Tegra20.
> * Add probe function so defer probe can be used when we're going to
>   support DVFS.
> * Create a fake cpufreq platform device with its name being
>   "${root_compatible}-cpufreq" so SoC cpufreq driver can bind to it
>   accordingly.

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>

It should be fine to merge the arch/arm/mach-tegra/ changes in this
patch through the cpufreq tree, since I don't think they'll conflict at
all with anything in other trees this kernel cycle.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c

> -#define NUM_CPUS	2
> +#define MAX_CPUS	2

Nit: Given this driver is explicitly for a 2-CPU SoC, I don't think
there's any need to s/NUM/MAX/ here. But I don't care that much.

