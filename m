From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 00/11] Clean up Tegra20 cpufreq driver
Date: Fri, 18 May 2018 11:18:03 +0300
Message-ID: <9c4a31e5-4f32-c951-6d9e-82798d6500bf@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
 <33210093.0R9M0pnSOk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <33210093.0R9M0pnSOk@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18.05.2018 10:30, Rafael J. Wysocki wrote:
> On Thursday, May 17, 2018 8:00:45 PM CEST Dmitry Osipenko wrote:
>> Hello,
>>
>> Recently Peter Geis (who is working on Tegra30 cpufreq driver) asked me how
>> tegra20-cpufreq driver is getting loaded. After taking a look at the code
>> it became apparent that the drivers code has been rusted a tad and so this
>> series is intended to refresh the drivers code by disallowing module to be
>> loaded on non-Tegra20 machines, by cleaning whitespaces in the code, removing
>> dead EMC code and in the end by allowing tegra20-cpufreq to be built as a
>> loadable module.
>>
>> Please review, thanks.
>>
>> Dmitry Osipenko (11):
>>   cpufreq: tegra20: Change module description
>>   cpufreq: tegra20: Clean up whitespaces in the code
>>   cpufreq: tegra20: Remove EMC clock usage
>>   cpufreq: tegra20: Release clocks properly
>>   cpufreq: tegra20: Clean up included headers
>>   cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
>>   cpufreq: tegra20: Check if this is Tegra20 machine
>>   cpufreq: tegra20: Remove unneeded variable initialization
>>   cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
>>   cpufreq: tegra20: Wrap cpufreq into platform driver
>>   ARM: tegra: Create platform device for tegra20-cpufreq driver
>>
>>  arch/arm/mach-tegra/tegra.c       |   4 +
>>  drivers/cpufreq/Kconfig.arm       |   2 +-
>>  drivers/cpufreq/tegra20-cpufreq.c | 172 +++++++++++++++++-------------
>>  3 files changed, 101 insertions(+), 77 deletions(-)
>>
>>
> 
> It looks like Viresh has ACKed the majority of the patches in this series,
> but there are a few where he had comments.
> 
> Please fix up these and resend the entire series with the Acked-by tags from
> Viresh added where applicable.

Sure, I'll address the Viresh's review comments in the v2 that I'll probably
prepare and send out later today. I'll also add another minor-cleanup patch to
the series that removes unnecessary brackets in the code.

Thierry / Jon, please let me if there is anything you disagree-with in the
series as I'd like to avoid re-sending multiple times.

Thanks.
