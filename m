From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: mediatek: Register an Energy Model
Date: Thu, 7 Feb 2019 10:06:10 +0530
Message-ID: <20190207043610.dy5nf5e3vujtmzgn@vireshk-i7>
References: <20190206185004.54779-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206185004.54779-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Quentin Perret <quentin.perret@arm.com>, Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 06-02-19, 10:50, Matthias Kaehlcke wrote:
> Try and register an Energy Model from mediatek-cpufreq to allow
> interested subsystems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - register the EM after setting the cpumask
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d398181..5250df762814e 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -465,6 +465,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = info;
>  	policy->clk = info->cpu_clk;
>  
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
>  	return 0;
>  }

Applied it after rebasing over the change in cpufreq/arm/linux-next
branch. Thanks.

-- 
viresh
