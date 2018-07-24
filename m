From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end
 of_device_id array
Date: Tue, 24 Jul 2018 09:13:35 +0530
Message-ID: <20180724034335.v76tfqk2imlyf2eg@vireshk-i7>
References: <20180723123429.20040-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723123429.20040-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: ilia.lin@gmail.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-07-18, 20:34, YueHaibing wrote:
> Make sure of_device_id tables are NULL terminated
> Found by coccinelle spatch "misc/of_table.cocci"
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389ac..efc9a7a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
>  static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
> +	{}
>  };
>  
>  /*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
