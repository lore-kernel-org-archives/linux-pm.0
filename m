From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 3/5] thermal: tsens: Move 8996 get_temp() to common
 code for reuse
Date: Tue, 12 Jun 2018 12:43:02 -0700
Message-ID: <20180612194302.GP14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
[..]
>  static const struct tsens_ops ops_8996 = {
>  	.init		= init_common,
> -	.get_temp	= get_temp_8996,
> +	.get_temp	= get_temp_tsens_v2,
>  };
>  
>  const struct tsens_data data_8996 = {
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
[..]
> +int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)

I like the function name, but it's not really common for tsens, it's
just common for tsens v2. Also as patch 4 shows we end up adding a set
of essentially empty platform specific files for referencing this
function.

I would suggest that you instead rename tsens-8996.c to tsens-v2.c,
rename ops_8996 to ops_v2 and either add new tsens_data for each
platform or simply rename that too to data_v2 which we point to from
tsens_table.


I think we should take it once step further and add "qcom,tsens-v2" as a
valid compatible in tsens_table and make the dts do:

	comaptible = "qcom,msm8996-tsens", "qcom,tsens-v2";

and
	compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";

Regards,
Bjorn
