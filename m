From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v12 0/2] Kryo CPU scaling driver
Date: Thu, 24 May 2018 14:32:23 +0530
Message-ID: <20180524090223.qwyugcxde4wznzno@vireshk-i7>
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-05-18, 11:57, Ilia Lin wrote:
> [v12]
>  * Addressed comments from Sudeep and Viresh about the single init
> 
> [v11]
>  * Addressed comment from Russel about device_node reference
>  * Addressed comment from Sudeep about the late_initcall
>  * Transformed init into probe to take care of deferals
> 
> [v10]
>  * Split the series into domains
>  * Addressed comments from Viresh and Sudeep about logical CPU numbering.
> 
> The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
> The driver reads eFuse information and chooses the required OPP subset
> by passing the OPP supported-hw parameter.
> 
> The series depends on the series from Viresh:
> https://patchwork.kernel.org/patch/10418139/
> 
> The previous spin was here:
> https://patchwork.kernel.org/patch/10421143/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
