From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 09/10] thermal: exynos: remove redundant pdata checks
 from exynos_tmu_control()
Date: Thu, 15 May 2014 11:03:08 -0400
Message-ID: <20140515150308.GC27690@developer>
References: <1399288539-1793-1-git-send-email-b.zolnierkie@samsung.com>
 <1399288539-1793-10-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399288539-1793-10-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Bartlomiej,

On Mon, May 05, 2014 at 01:15:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
> pdata->reference_voltage and pdata->gain are always defined
> to non-zero values so remove the redundant checks from
> exynos_tmu_control().
> 

In all existing SoCs? 
Should this be considered to any upcoming SoCs?

> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index a8d9524..45d7c6f 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -215,15 +215,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
>  	if (pdata->test_mux)
>  		con |= (pdata->test_mux << reg->test_mux_addr_shift);
>  
> -	if (pdata->reference_voltage) {
> -		con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
> -		con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
> -	}
> +	con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
> +	con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
>  
> -	if (pdata->gain) {
> -		con &= ~(reg->buf_slope_sel_mask << reg->buf_slope_sel_shift);
> -		con |= (pdata->gain << reg->buf_slope_sel_shift);
> -	}
> +	con &= ~(reg->buf_slope_sel_mask << reg->buf_slope_sel_shift);
> +	con |= (pdata->gain << reg->buf_slope_sel_shift);

The way it is put, looks like gain and reference_voltage are mandatory
pdata fields. Should these checks be moved to initialization phase?

>  
>  	if (pdata->noise_cancel_mode) {
>  		con &= ~(reg->therm_trip_mode_mask <<
> -- 
> 1.8.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
