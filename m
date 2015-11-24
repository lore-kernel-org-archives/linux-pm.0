From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH RFC 17/27] drivers: cpu-pd: Record CPUs that are part of
 the domain
Date: Tue, 24 Nov 2015 13:00:45 -0800
Message-ID: <20151124210043.GD25963@codeaurora.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On 11/17, Lina Iyer wrote:
> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
> index 9758b8d..617ce54 100644
> --- a/drivers/base/power/cpu-pd.c
> +++ b/drivers/base/power/cpu-pd.c
> @@ -18,6 +18,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>

What's this added for?

>  #include <linux/rculist.h>
>  #include <linux/slab.h>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
