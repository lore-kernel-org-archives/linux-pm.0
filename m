From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 0/2] Kryo CPU scaling driver
Date: Wed, 23 May 2018 14:54:41 +0100
Message-ID: <b4c28b51-ecd5-649b-e8fa-e5ce1bbb3139@arm.com>
References: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org



On 23/05/18 13:38, Ilia Lin wrote:
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
> https://patchwork.kernel.org/patch/10420809/
> 

IIUC, this depends on "CPU scaling support for msm8996" [1] for
the functionality though the change is independent ?

-- 
Regards,
Sudeep

[1] https://www.spinics.net/lists/arm-kernel/msg654978.html
