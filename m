From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: qcom-hw: Register an Energy Model
Date: Wed, 6 Feb 2019 10:22:51 +0530
Message-ID: <20190206045251.23p4imsqlropssxl@vireshk-i7>
References: <20190205175225.25923-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205175225.25923-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Quentin Perret <quentin.perret@arm.com>, Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-19, 09:52, Matthias Kaehlcke wrote:
> Try and register an Energy Model from qcom-cpufreq-hw to allow
> interested sub-systems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4c..a16b9dca7ea3b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -205,6 +205,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
>  	policy->fast_switch_possible = true;
>  
>  	return 0;

Applied both. Thanks.

-- 
viresh
