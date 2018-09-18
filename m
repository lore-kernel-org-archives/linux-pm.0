From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 07/16] thermal: tsens: Pass register offsets as
 private data
Date: Tue, 18 Sep 2018 12:34:48 -0700
Message-ID: <20180918193448.GA1367@tuxbook-pro>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <dccdcf386d8d5298a77ec31cde699852cc4409c5.1536744310.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dccdcf386d8d5298a77ec31cde699852cc4409c5.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 12 Sep 02:52 PDT 2018, Amit Kucheria wrote:
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 9a8e8f7b4ae1..f1ec9bbe4717 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -144,6 +144,9 @@ static int tsens_probe(struct platform_device *pdev)
>  		else
>  			tmdev->sensor[i].hw_id = i;
>  	}
> +	for (i = 0; i < REG_ARRAY_SIZE; i++) {
> +		tmdev->reg_offsets[i] = data->reg_offsets[i];
> +	}

Unnecessary {}

>  
>  	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
>  		return -EINVAL;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index b9c4bcf255fa..7b7feee5dc46 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -48,15 +48,23 @@ struct tsens_ops {
>  	int (*get_trend)(struct tsens_device *, int, enum thermal_trend *);
>  };
>  
> +enum reg_list {
> +	SROT_CTRL_OFFSET,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
>  /**
>   * struct tsens_data - tsens instance specific data
>   * @num_sensors: Max number of sensors supported by platform
>   * @ops: operations the tsens instance supports
>   * @hw_ids: Subset of sensors ids supported by platform, if not the first n
> + * @reg_offsets: Register offsets for commonly used registers

Order doesn't match struct.

>   */
>  struct tsens_data {
>  	const u32		num_sensors;
>  	const struct tsens_ops	*ops;
> +	const u16		reg_offsets[REG_ARRAY_SIZE];
>  	unsigned int		*hw_ids;
>  };

Except of that you have my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
