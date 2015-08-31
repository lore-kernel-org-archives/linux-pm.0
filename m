From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx: use the managed interfaces for resources
 allocation
Date: Mon, 31 Aug 2015 14:36:16 +0530
Message-ID: <20150831090616.GC5215@linux>
References: <1441040730-16391-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441040730-16391-1-git-send-email-b51503@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bai Ping <b51503@freescale.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01-09-15, 01:05, Bai Ping wrote:
> Replace the clk_get() and regulator_get() with the managed interfaces
> then the error path can be simplified.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++------------------------------
>  1 file changed, 13 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 380a90d..1439f93 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -174,25 +174,25 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	arm_clk = clk_get(cpu_dev, "arm");
> -	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> -	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> -	step_clk = clk_get(cpu_dev, "step");
> -	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> +	arm_clk = devm_clk_get(cpu_dev, "arm");

Because the driver is getting attached to pdev (or pdev->dev), these
resources will not be freed eventually as what you are binding them to
is cpu_dev.

So, this patch is completely wrong.

-- 
viresh
