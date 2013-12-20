From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 2/2] cpufreq: imx6q: add of_init_opp_table
Date: Fri, 20 Dec 2013 14:06:05 +0800
Message-ID: <20131220060603.GO7172@S2101-09.ap.freescale.net>
References: <1387512929-7304-1-git-send-email-john.tobias.ph@gmail.com>
 <1387512929-7304-2-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1387512929-7304-2-git-send-email-john.tobias.ph@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, b20788@freescale.com, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 08:15:29PM -0800, John Tobias wrote:
> Add a routine check to see if the platform supplied the OPP table.
> Incase there's not OPP table exist, it will try to get it.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 4b3f18e..f261a88 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -187,12 +187,25 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_node;
>  	}
>  
> -	/* We expect an OPP table supplied by platform */
> +	/* We expect an OPP table supplied by platform.
> +	 * Just, incase the platform did not supply the OPP
> +	 * table, it will try to get it.
> +	 */

	/*
	 * Multi-lines comment
	 */

>  	num = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (num < 0) {
> -		ret = num;
> -		dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> -		goto put_node;
> +		ret = of_init_opp_table(cpu_dev);
> +		if (ret < 0) {
> +			dev_err(cpu_dev, "failed to init OPP table\n");

It should be good to print the error code, i.e. 'ret', here.

> +			ret = -ENODEV;

There is no need to make up an error code, and just return what you get
from of_init_opp_table().

Shawn

> +			goto put_node;
> +		}
> +
> +		num = dev_pm_opp_get_opp_count(cpu_dev);
> +		if (num < 0) {
> +			ret = num;
> +			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> +			goto put_node;
> +		}
>  	}
>  
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> -- 
> 1.8.3.2
> 
