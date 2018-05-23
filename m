From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
Date: Wed, 23 May 2018 12:30:39 +0300
Message-ID: <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
References: <20180522211420.2006-1-digetx@gmail.com>
 <20180523055817.subrv6oeckfecpcp@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523055817.subrv6oeckfecpcp@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23.05.2018 08:58, Viresh Kumar wrote:
> On 23-05-18, 00:14, Dmitry Osipenko wrote:
>> Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
>> clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
>> PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
>> on the driver probe.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> CPUFreq maintainers,
>>
>> Please take into account that this patch is made on top of my recent
>> series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
>> reviewed, but seems not applied yet. Let me know if you prefer to re-spin
>> the [0], including this patch into the series.
>>
>> [0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321
> 
> This is already picked by Rafael and is sitting in pm/bleeding-edge
> branch. Should get merged into linux-next in a day or two.

Neat, thank you for letting me know.

>>  drivers/cpufreq/tegra20-cpufreq.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>> index 05f57dcd5215..ca5229265b60 100644
>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>> @@ -176,6 +176,14 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  		goto put_pll_x;
>>  	}
>>  
>> +	err = clk_prepare_enable(cpufreq->pll_x_clk);
>> +	if (err)
>> +		goto put_pll_p;
>> +
>> +	err = clk_prepare_enable(cpufreq->pll_p_clk);
>> +	if (err)
>> +		goto disable_pll_x;
>> +
>>  	cpufreq->dev = &pdev->dev;
>>  	cpufreq->driver.get = cpufreq_generic_get;
>>  	cpufreq->driver.attr = cpufreq_generic_attr;
>> @@ -192,12 +200,16 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  
>>  	err = cpufreq_register_driver(&cpufreq->driver);
>>  	if (err)
>> -		goto put_pll_p;
>> +		goto disable_pll_p;
>>  
>>  	platform_set_drvdata(pdev, cpufreq);
>>  
>>  	return 0;
>>  
>> +disable_pll_p:
>> +	clk_disable_unprepare(cpufreq->pll_p_clk);
>> +disable_pll_x:
>> +	clk_disable_unprepare(cpufreq->pll_x_clk);
>>  put_pll_p:
>>  	clk_put(cpufreq->pll_p_clk);
>>  put_pll_x:
>> @@ -214,6 +226,8 @@ static int tegra20_cpufreq_remove(struct platform_device *pdev)
>>  
>>  	cpufreq_unregister_driver(&cpufreq->driver);
>>  
>> +	clk_disable_unprepare(cpufreq->pll_p_clk);
>> +	clk_disable_unprepare(cpufreq->pll_x_clk);
>>  	clk_put(cpufreq->pll_p_clk);
>>  	clk_put(cpufreq->pll_x_clk);
>>  	clk_put(cpufreq->cpu_clk);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
