From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v10 02/10] qcom: scm: Add SCM warmboot support for quad
 core SoCs
Date: Wed, 26 Nov 2014 11:48:24 -0800
Message-ID: <54762E88.50300@codeaurora.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org> <1416593037-27527-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416593037-27527-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> @@ -37,3 +54,17 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
>   			&cmd, sizeof(cmd), NULL, 0);
>   }
>   EXPORT_SYMBOL(scm_set_boot_addr);
> +
> +int scm_set_warm_boot_addr(void *entry, int cpu)
> +{
> +	int ret;
> +
> +	if (entry == scm_flags[cpu].entry)
> +		return 0;

Is the entry going to be different at some point? I wonder why we can't 
just call this function once when the SPM device probes to setup the 
entry point to cpu_resume()?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
