From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH RFC 07/27] PM / Domains: Read domain residency from DT
Date: Tue, 24 Nov 2015 12:41:24 -0800
Message-ID: <20151124204124.GB25963@codeaurora.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447799871-56374-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On 11/17, Lina Iyer wrote:
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index ecfaf44..d71da29 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -67,6 +67,13 @@ have the following properties -
>  		If omitted, this is assumed to be equal to:
>  			entry-latency-us + exit-latency-us
>  
> +	- residency-us:
> +		Usage: Optional
> +		Value type: <prop-encoded-array>

Is it an array or just a single u32? Some example would be good
to add.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
