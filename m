From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 17 Oct 2013 00:52:40 +0200
Message-ID: <2716826.jtNDRqEJYG@vostro.rjw.lan>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1381931563-16785-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1381931563-16785-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 16, 2013 02:52:39 PM Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Currently clk_get_sys is used with cpu-cluster.<n> as the device id
> which is incorrect. It should be connection/consumer ID instead.
> 
> It is possible to specify input clock in the cpu device node along
> with the optional clock-name. clk_get_sys can't handle that.
> 
> This patch replaces clk_get_sys with clk_get to extend support for
> clocks specified in the device tree cpu node.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I've queued up this one for 3.13, for the rest of the series I need ACKs
from the people in the CC list.

Thanks!

> ---
>  drivers/cpufreq/arm_big_little.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index 3549f07..501a091 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -127,7 +127,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
>  	}
>  
>  	name[12] = cluster + '0';
> -	clk[cluster] = clk_get_sys(name, NULL);
> +	clk[cluster] = clk_get(cpu_dev, name);
>  	if (!IS_ERR(clk[cluster])) {
>  		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
>  				__func__, clk[cluster], freq_table[cluster],
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
