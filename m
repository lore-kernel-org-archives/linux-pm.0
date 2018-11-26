From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: imx6q: save one condition block for normal
 case of nvmem read
Date: Mon, 26 Nov 2018 11:35:05 +0530
Message-ID: <20181126060505.vgu4serogh4brjpm@vireshk-i7>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
 <1543200853-10029-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543200853-10029-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 26-11-18, 02:59, Anson Huang wrote:
> Put return value checks of calling imx6ul_opp_check_speed_grading()
> into one block to save one condition block for normal case.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 8cb9683..9fedf62 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -405,9 +405,10 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	if (of_machine_is_compatible("fsl,imx6ul") ||
>  	    of_machine_is_compatible("fsl,imx6ull")) {
>  		ret = imx6ul_opp_check_speed_grading(cpu_dev);
> -		if (ret == -EPROBE_DEFER)
> -			return ret;
>  		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +
>  			dev_err(cpu_dev, "failed to read ocotp: %d\n",
>  				ret);
>  			return ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
