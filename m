From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix false return check from "regulator_set_voltage"
Date: Sat, 12 Oct 2013 08:51:22 +0530
Message-ID: <CAKohpokPpyZNN=aH=u8kxDjiQrsE2mwu=0MN6pkWfuXLu9cZKw@mail.gmail.com>
References: <1381331617-14703-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1381331617-14703-1-git-send-email-badarkhe.manish@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, kgene.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

On 09/10/2013, Manish Badarkhe <badarkhe.manish@gmail.com> wrote:
> Currently, code checks false return value from "regulator_set_voltage"
> to show failure message. Modify the code to check proper return
> value from "regulator_set_voltage".
>
> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
> ---
> Based on master branch of linux-mainline.
>
> :100644 100644 0fac344... 1537f32... M	drivers/cpufreq/exynos-cpufreq.c
>  drivers/cpufreq/exynos-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/exynos-cpufreq.c
> b/drivers/cpufreq/exynos-cpufreq.c
> index 0fac344..1537f32 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -141,7 +141,7 @@ post_notify:
>  	if ((freqs.new < freqs.old) ||
>  	   ((freqs.new > freqs.old) && safe_arm_volt)) {
>  		/* down the voltage after frequency change */
> -		regulator_set_voltage(arm_regulator, arm_volt,
> +		ret = regulator_set_voltage(arm_regulator, arm_volt,
>  				arm_volt);
>  		if (ret) {
>  			pr_err("%s: failed to set cpu voltage to %d\n",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
