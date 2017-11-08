From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] ARM64 / cpuidle: Use new cpuidle macro for entering
 retention state
Date: Wed, 8 Nov 2017 14:27:28 +0000
Message-ID: <16086b6c-6f34-35e8-bc19-705380e5b767@arm.com>
References: <1510076133-18139-1-git-send-email-pprakash@codeaurora.org>
 <1510076133-18139-3-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33788 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbdKHO1c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Nov 2017 09:27:32 -0500
In-Reply-To: <1510076133-18139-3-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com



On 07/11/17 17:35, Prashanth Prakash wrote:
> CPU_PM_CPU_IDLE_ENTER_RETENTION skips calling cpu_pm_enter() and
> cpu_pm_exit(). By not calling cpu_pm functions in idle entry/exit
> paths we can reduce the latency involved in entering and exiting
> the low power idle state.
> 
> On ARM64 based Qualcomm server platform we measured below overhead
> for calling cpu_pm_enter and cpu_pm_exit for retention states.
> 
> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
> 	Average overhead of cpu_pm_enter - 1.2us
> 	Average overhead of cpu_pm_exit  - 3.1us
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  arch/arm64/kernel/cpuidle.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index fd69108..f2d1381 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -47,6 +47,8 @@ int arm_cpuidle_suspend(int index)
>  
>  #include <acpi/processor.h>
>  
> +#define ARM64_LPI_IS_RETENTION_STATE(arch_flags) (!(arch_flags))
> +

Ideally we could cater both ACPI LPI and DT using PSCI parameters. No ?
Just thinking it out loud as I see no reason to restrict this just to
ACPI LPIs.

-- 
Regards,
Sudeep
