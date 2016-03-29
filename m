From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V8 10/14] thermal: tegra: handle clocks in one function
Date: Mon, 28 Mar 2016 20:09:03 -0700
Message-ID: <20160329030902.GB2315@localhost.localdomain>
References: <1458118706-29993-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458118706-29993-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 16, 2016 at 04:58:26PM +0800, Wei Ni wrote:
> Handle clock enable/disable codes in one funcion

WARNING: 'funcion' may be misspelled - perhaps 'function'?
#48: 
Handle clock enable/disable codes in one funcion


> soctherm_clk_enable(), so that the codes are more clear.
> 
> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/thermal/tegra/soctherm.c | 51 ++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 67e4a094b430..f60106884ac4 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -428,6 +428,39 @@ static void soctherm_debug_init(struct platform_device *pdev)
>  static inline void soctherm_debug_init(struct platform_device *pdev) {}
>  #endif
>  
> +static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
> +{
> +	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
> +	int err;
> +
> +	if (tegra->clock_soctherm == NULL || tegra->clock_tsensor == NULL)

CHECK: Comparison to NULL could be written "!tegra->clock_soctherm"
#69: FILE: drivers/thermal/tegra/soctherm.c:436:
+	if (tegra->clock_soctherm == NULL || tegra->clock_tsensor ==
NULL)

CHECK: Comparison to NULL could be written "!tegra->clock_tsensor"
#69: FILE: drivers/thermal/tegra/soctherm.c:436:
+	if (tegra->clock_soctherm == NULL || tegra->clock_tsensor ==
NULL)



> +		return -EINVAL;
> +
> +	reset_control_assert(tegra->reset);
> +
> +	if (enable) {
> +		err = clk_prepare_enable(tegra->clock_soctherm);
> +		if (err) {
> +			reset_control_deassert(tegra->reset);
> +			return err;
> +		}
> +
> +		err = clk_prepare_enable(tegra->clock_tsensor);
> +		if (err) {
> +			clk_disable_unprepare(tegra->clock_soctherm);
> +			reset_control_deassert(tegra->reset);
> +			return err;
> +		}
> +	} else {
> +		clk_disable_unprepare(tegra->clock_tsensor);
> +		clk_disable_unprepare(tegra->clock_soctherm);
> +	}
> +
> +	reset_control_deassert(tegra->reset);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id tegra_soctherm_of_match[] = {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -496,20 +529,10 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->clock_soctherm);
>  	}
>  
> -	reset_control_assert(tegra->reset);
> -
> -	err = clk_prepare_enable(tegra->clock_soctherm);
> +	err = soctherm_clk_enable(pdev, true);
>  	if (err)
>  		return err;
>  
> -	err = clk_prepare_enable(tegra->clock_tsensor);
> -	if (err) {
> -		clk_disable_unprepare(tegra->clock_soctherm);
> -		return err;
> -	}
> -
> -	reset_control_deassert(tegra->reset);
> -
>  	/* Initialize raw sensors */
>  
>  	tegra->calib = devm_kzalloc(&pdev->dev,
> @@ -579,8 +602,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  	return 0;
>  
>  disable_clocks:
> -	clk_disable_unprepare(tegra->clock_tsensor);
> -	clk_disable_unprepare(tegra->clock_soctherm);
> +	soctherm_clk_enable(pdev, false);
>  
>  	return err;
>  }
> @@ -591,8 +613,7 @@ static int tegra_soctherm_remove(struct platform_device *pdev)
>  
>  	debugfs_remove_recursive(tegra->debugfs_dir);
>  
> -	clk_disable_unprepare(tegra->clock_tsensor);
> -	clk_disable_unprepare(tegra->clock_soctherm);
> +	soctherm_clk_enable(pdev, false);
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 
