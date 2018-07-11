From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v6 5/7] thermal: tsens: Add generic support for TSENS v2
 IP
Date: Wed, 11 Jul 2018 09:40:45 -0700
Message-ID: <20180711164045.GD545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> SDM845 uses v2 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function defined as part of ops_generic_v2.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-v2.c | 6 +++++-
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 34ba6c7..f40150f 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
>  	.get_temp	= get_temp_tsens_v2,
>  };
>  
> +const struct tsens_data data_tsens_v2 = {
> +	.ops            = &ops_generic_v2,
> +};
> +
> +/* Kept around for backward compatibility with old msm8996.dtsi */
>  const struct tsens_data data_8996 = {
>  	.num_sensors	= 13,
>  	.ops		= &ops_generic_v2,
>  };
> -
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 3440166c..a2c9bfa 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8996-tsens",
>  		.data = &data_8996,
> +	}, {
> +		.compatible = "qcom,tsens-v2",
> +		.data = &data_tsens_v2,
>  	},
>  	{}
>  };
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index d785b37..14331eb 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -88,6 +88,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
>  int init_common(struct tsens_device *);
>  int get_temp_common(struct tsens_device *, int, int *);
>  
> -extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
> +/* TSENS v1 targets */
> +extern const struct tsens_data data_8916, data_8974, data_8960;
> +/* TSENS v2 targets */
> +extern const struct tsens_data data_8996, data_tsens_v2;
>  
>  #endif /* __QCOM_TSENS_H__ */
> -- 
> 2.7.4
> 
