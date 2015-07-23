From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 08/13] clk: qcom: gdsc: Add GDSCs in msm8916 GCC
Date: Wed, 22 Jul 2015 18:07:00 -0700
Message-ID: <55B03E34.1070508@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-9-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437549069-29655-9-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 07/22/2015 12:11 AM, Rajendra Nayak wrote:
> @@ -2562,6 +2563,47 @@ static struct clk_branch gcc_venus0_vcodec0_clk = {
>   	},
>   };
>   
> +static struct gdsc venus_gdsc = {
> +	.gdscr = 0x4c018,
> +	.pd = {
> +		.name = "venus",
> +	},
> +	.pwrsts = PWRDM_OFF_ON,
> +};
> +
> +static struct gdsc mdss_gdsc = {
> +	.gdscr = 0x4d078,
> +	.pd = {
> +		.name = "mdss",
> +	},
> +	.pwrsts = PWRDM_OFF_ON,
> +};
> +
> +static struct gdsc jpeg_gdsc = {
> +	.gdscr = 0x5701c,
> +	.pd = {
> +		.name = "jpeg",
> +	},
> +	.pwrsts = PWRDM_OFF_ON,
> +};
> +
> +static struct gdsc vfe_gdsc = {
> +	.gdscr = 0x58034,
> +	.pd = {
> +		.name = "vfe",
> +	},
> +	.pwrsts = PWRDM_OFF_ON,

Is this supposed to tbe PWRSTS_OFF_ON?

> +};
> +
> +static struct gdsc oxili_gdsc = {
> +	.gdscr = 0x5901c,
> +	.pd = {
> +		.name = "oxili",
> +	},
> +	.root_con_id = "gfx3d_clk_src",
> +	.pwrsts = PWRDM_OFF_ON,
> +};
> +


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
