From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 11/11] ARM: tegra: Create platform device for
 tegra20-cpufreq driver
Date: Fri, 18 May 2018 12:30:21 +0300
Message-ID: <1ca8f874-40da-05b4-0b76-116164c85137@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-12-digetx@gmail.com> <20180518091352.GK14500@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518091352.GK14500@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18.05.2018 12:13, Thierry Reding wrote:
> On Thu, May 17, 2018 at 09:00:56PM +0300, Dmitry Osipenko wrote:
>> Tegra20-cpufreq driver require a platform device in order to be loaded,
>> instantiate a simple platform device for the driver during of the machines
>> late initialization.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/tegra.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>> index 02e712d2ea30..f9587be48235 100644
>> --- a/arch/arm/mach-tegra/tegra.c
>> +++ b/arch/arm/mach-tegra/tegra.c
>> @@ -97,6 +97,10 @@ static void __init tegra_dt_init_late(void)
>>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>>  	    of_machine_is_compatible("compal,paz00"))
>>  		tegra_paz00_wifikill_init();
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>> +	    of_machine_is_compatible("nvidia,tegra20"))
>> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>>  }
>>  
>>  static const char * const tegra_dt_board_compat[] = {
> 
> Tegra124 has a CPU frequency driver that is similar to this and it
> contains code that will instantiate the platform device from the CPU
> frequency driver's module_init function.
> 
> I think the primary reason for doing that was to not tie the code to
> 32-bit ARM, even though it never runs on anything but that, so it's
> slightly over-engineered.

The tegra124-cpufreq driver likely to be broken in regards to the module loading
as platform_device_register_simple() seem to be allowed invoked only from the
kernel itself.

Having platform_device_register_simple in the kernels module leads to a such
errors on the module loading:

# section 5 reloc 7 sym 'memset': relocation 10 out of range (0xbf805030 ->
0xc088c481)

Initially I wanted to make tegra124-cpufreq a module_platform_driver, but
decided to postpone that, as the driver is shared with ARM64 Tegra132 which
doesn't have machine-init code. Maybe we could move the devices instantiation to
something common like driver/soc/tegra/devices.c later.

> I don't mind either way, and it's easy enough to change this to
> something else later on if we want. I'll pick this up into the Tegra
> tree.
Okay, thanks.
