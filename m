From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform
 driver
Date: Fri, 18 May 2018 12:19:16 +0300
Message-ID: <4ed2535c-651a-2bb1-c9bc-0550bca3d292@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-11-digetx@gmail.com> <20180518090755.GJ14500@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518090755.GJ14500@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18.05.2018 12:07, Thierry Reding wrote:
> On Thu, May 17, 2018 at 09:00:55PM +0300, Dmitry Osipenko wrote:
>> Currently tegra20-cpufreq kernel module isn't getting autoloaded because
>> there is no device associated with the module, this is one of two patches
>> that resolves the module autoloading. This patch adds a module alias that
>> will associate the tegra20-cpufreq kernel module with the platform device,
>> other patch will instantiate the actual platform device. And now it makes
>> sense to wrap cpufreq driver into a platform driver for consistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/tegra20-cpufreq.c | 116 +++++++++++++++++++-----------
>>  1 file changed, 73 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>> index c0a7b5a78aa6..f9d02a28df9e 100644
>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>> @@ -19,7 +19,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/module.h>
>> -#include <linux/of.h>
>> +#include <linux/platform_device.h>
>>  
>>  static struct cpufreq_frequency_table freq_table[] = {
>>  	{ .frequency = 216000 },
>> @@ -33,15 +33,19 @@ static struct cpufreq_frequency_table freq_table[] = {
>>  	{ .frequency = CPUFREQ_TABLE_END },
>>  };
>>  
>> -static struct clk *cpu_clk;
>> -static struct clk *pll_x_clk;
>> -static struct clk *pll_p_clk;
>> -static bool pll_x_prepared;
>> +struct tegra20_cpufreq_data {
> 
> Nit: I'm not a big fan of _data suffixes because they are completely
> redundant. Any data structure by definition hosts data, so I'd just drop
> that.

Okay, I'll drop it in v2.

> [...]
>> @@ -152,55 +161,76 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
>>  	.suspend		= cpufreq_generic_suspend,
>>  };
>>  
>> -static int __init tegra_cpufreq_init(void)
>> +static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  {
>> +	struct tegra20_cpufreq_data *data;
>>  	int err;
>>  
>> -	if (!of_machine_is_compatible("nvidia,tegra20"))
>> -		return -ENODEV;
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>>  
>> -	cpu_clk = clk_get_sys(NULL, "cclk");
>> -	if (IS_ERR(cpu_clk))
>> -		return PTR_ERR(cpu_clk);
>> +	data->cpu_clk = clk_get_sys(NULL, "cclk");
>> +	if (IS_ERR(data->cpu_clk))
>> +		return PTR_ERR(data->cpu_clk);
>>  
>> -	pll_x_clk = clk_get_sys(NULL, "pll_x");
>> -	if (IS_ERR(pll_x_clk)) {
>> -		err = PTR_ERR(pll_x_clk);
>> +	data->pll_x_clk = clk_get_sys(NULL, "pll_x");
>> +	if (IS_ERR(data->pll_x_clk)) {
>> +		err = PTR_ERR(data->pll_x_clk);
>>  		goto put_cpu;
>>  	}
>>  
>> -	pll_p_clk = clk_get_sys(NULL, "pll_p");
>> -	if (IS_ERR(pll_p_clk)) {
>> -		err = PTR_ERR(pll_p_clk);
>> +	data->pll_p_clk = clk_get_sys(NULL, "pll_p");
>> +	if (IS_ERR(data->pll_p_clk)) {
>> +		err = PTR_ERR(data->pll_p_clk);
>>  		goto put_pll_x;
>>  	}
>>  
>> +	data->dev = &pdev->dev;
>> +
>> +	tegra_cpufreq_driver.driver_data = data;
> 
> Couldn't this be embedded into struct tegra20_cpufreq_data? Moving
> everything but this into a per-device data structure seems half-baked.

That's a good suggestions, thank you.
