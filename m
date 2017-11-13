From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/2] ARM64 / cpuidle: Use new cpuidle macro for
 entering retention state
Date: Mon, 13 Nov 2017 12:33:38 +0000
Message-ID: <0b4b13d3-2415-33df-f02b-1c94df4331ea@arm.com>
References: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
 <1510187922-8218-3-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752526AbdKMMdm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Nov 2017 07:33:42 -0500
In-Reply-To: <1510187922-8218-3-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com



On 09/11/17 00:38, Prashanth Prakash wrote:
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

This is fine, but just to be safer, is it better to check for all
flags to be set as we can't/don't support any partial retention modes.

Just curious, how is retention handled on mobile parts. I guess mainline
is not important on those parts, but add a note in the commit message
that we can make it ACPI agnostic and PSCI param dependent if needed.

-- 
Regards,
Sudeep
