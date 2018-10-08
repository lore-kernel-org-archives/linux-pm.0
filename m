From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Date: Mon, 8 Oct 2018 11:34:23 +0530
Message-ID: <20181008060423.cz5qrxfoz2seo2e3@vireshk-i7>
References: <1538961000-2109-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538961000-2109-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On 08-10-18, 09:10, Anson Huang wrote:
> On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> the ocotp clock needs to be enabled first. Add support for reading
> OCOTP through the nvmem API, and keep the old method there to
> support old dtb.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V2:
> 	Add put node when reading ocotp register done.
>  drivers/cpufreq/imx6q-cpufreq.c | 53 ++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index b2ff423..38b67f8 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/pm_opp.h>
> @@ -290,20 +291,33 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
>  #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
>  #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
>  
> -static void imx6ul_opp_check_speed_grading(struct device *dev)
> +static int imx6ul_opp_check_speed_grading(struct device *dev)
>  {
> -	struct device_node *np;
> -	void __iomem *base;
>  	u32 val;
> +	int ret = 0;
>  
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> -	if (!np)
> -		return;
> +	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
> +		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
> +		if (ret)
> +			return ret;
> +	} else {
> +		struct device_node *np;
> +		void __iomem *base;
> +
> +		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> +		if (!np)
> +			return -ENOENT;
> +
> +		base = of_iomap(np, 0);

You could have done of_node_put(np); right here and remove the below two calls
to the same.

> +		if (!base) {
> +			dev_err(dev, "failed to map ocotp\n");
> +			of_node_put(np);
> +			return -EFAULT;
> +		}
>  
> -	base = of_iomap(np, 0);
> -	if (!base) {
> -		dev_err(dev, "failed to map ocotp\n");
> -		goto put_node;
> +		val = readl_relaxed(base + OCOTP_CFG3);
> +		iounmap(base);
> +		of_node_put(np);
>  	}

-- 
viresh
