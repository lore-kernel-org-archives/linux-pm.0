From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add rk3328 compatible to use generic
 cpufreq driver
Date: Fri, 4 Aug 2017 10:40:41 +0530
Message-ID: <20170804051041.GB28857@vireshk-i7>
References: <1501811551-39168-1-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501811551-39168-1-git-send-email-finley.xiao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: heiko@sntech.de, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jay.xu@rock-chips.com, huangtao@rock-chips.coms, tony.xie@rock-chips.com, cl@rock-chips.com
List-Id: linux-pm@vger.kernel.org

On 04-08-17, 09:52, Finley Xiao wrote:
> This patch adds the rk3328 compatible string for supporting
> the generic cpufreq driver on RK3328.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 096aea7..13c0c47 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -76,6 +76,7 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "rockchip,rk3188", },
>  	{ .compatible = "rockchip,rk3228", },
>  	{ .compatible = "rockchip,rk3288", },
> +	{ .compatible = "rockchip,rk3328", },
>  	{ .compatible = "rockchip,rk3366", },
>  	{ .compatible = "rockchip,rk3368", },
>  	{ .compatible = "rockchip,rk3399", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
