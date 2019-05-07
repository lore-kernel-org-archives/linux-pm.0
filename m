From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Date: Tue, 7 May 2019 11:23:27 +0530
Message-ID: <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
References: <20190505080736.27970-1-ping.bai@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190505080736.27970-1-ping.bai@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jacky Bai <ping.bai@nxp.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 05-05-19, 08:02, Jacky Bai wrote:
> Previous goto only handled the node reference, the opp table,
> regulator & clk resource also need to be free before error return.
> 
> Fixes: ddb64c5db3c (cpufreq: imx6q: fix possible object reference leak).

This should have been.

Fixes: ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")

Auto configure it with following in .gitconfig

[pretty]
	fixes = Fixes: %h (\"%s\")
	onelin = commit %h (\"%s\")

and then:

git log --pretty=fixes ddb64c5db3c

will generate it by itself.

> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 3e17560b1efe..1d4ecefaabc6 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -383,23 +383,22 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_reg;
>  	}
>  
> +	/* Because we have added the OPPs here, we must free them */
> +	free_opp = true;
> +
>  	if (of_machine_is_compatible("fsl,imx6ul") ||
>  	    of_machine_is_compatible("fsl,imx6ull")) {
>  		ret = imx6ul_opp_check_speed_grading(cpu_dev);
>  		if (ret) {
> -			if (ret == -EPROBE_DEFER)
> -				goto put_node;
> -
> -			dev_err(cpu_dev, "failed to read ocotp: %d\n",
> -				ret);
> -			goto put_node;
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(cpu_dev, "failed to read ocotp: %d\n",
> +					ret);
> +			goto out_free_opp;
>  		}
>  	} else {
>  		imx6q_opp_check_speed_grading(cpu_dev);
>  	}
>  
> -	/* Because we have added the OPPs here, we must free them */
> -	free_opp = true;
>  	num = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (num < 0) {
>  		ret = num;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: This needs to go in 5.2 itself, can you queue it directly ?

-- 
viresh
