From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC v3 04/12] ARM: cpuidle: Add runtime PM support for CPUs
Date: Fri, 4 Mar 2016 10:03:35 -0800
Message-ID: <20160304180335.GA16665@codeaurora.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
 <1456866931-37851-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456866931-37851-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 03/01, Lina Iyer wrote:
> @@ -46,12 +49,20 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>  	ret = cpu_pm_enter();
>  	if (!ret) {
>  		/*
> +		 * Call runtime PM suspend on our device
> +		 * Notify RCU to pay attention to critical sections
> +		 * called from within runtime PM.
> +		 */

I was thinking something more along the lines of 

		/*
		 * RCU is idle at this point but runtime PM uses
		 * tracepoints which use RCU so we must resume RCU
		 * while we use runtime PM here.
		 */

> +		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
