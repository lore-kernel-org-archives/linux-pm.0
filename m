From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add zynqmp to the cpufreq dt platdev
Date: Thu, 13 Jul 2017 14:49:53 +0530
Message-ID: <20170713091953.GE352@vireshk-i7>
References: <3a2d9e482adc907a03a55c99aa1583cc2618077c.1499937548.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a2d9e482adc907a03a55c99aa1583cc2618077c.1499937548.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 13-07-17, 11:19, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add zynqmp to the cpufreq dt platform device.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 1c262923fe58..2eb40d46d357 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -94,6 +94,7 @@
>  	{ .compatible = "ti,omap5", },
>  
>  	{ .compatible = "xlnx,zynq-7000", },
> +	{ .compatible = "xlnx,zynqmp", },
>  
>  	{ .compatible = "zte,zx296718", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
