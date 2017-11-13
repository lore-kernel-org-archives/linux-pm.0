From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] cpuidle: Add new macro to enter a retention idle
 state
Date: Mon, 13 Nov 2017 12:27:45 +0000
Message-ID: <77e32511-839c-5a73-cebf-b4c588af0ebd@arm.com>
References: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
 <1510187922-8218-2-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbdKMM1t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Nov 2017 07:27:49 -0500
In-Reply-To: <1510187922-8218-2-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.comSudeep Holla <sudeep.holla@arm.com>



On 09/11/17 00:38, Prashanth Prakash wrote:
> If a CPU is entering a low power idle state where it doesn't lose any
> context, then there is no need to call cpu_pm_enter()/cpu_pm_exit().
> Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
> drivers when they are entering retention state. By not calling
> cpu_pm_enter and cpu_pm_exit we reduce the latency involved in
> entering and exiting the retention idle states.
> 
> On ARM64 based Qualcomm Server Platform we measured below overhead for
> for calling cpu_pm_enter and cpu_pm_exit for retention states.
> 
> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
>         Average overhead of cpu_pm_enter - 1.2us
>         Average overhead of cpu_pm_exit  - 3.1us
> 

Just add a description to inform that if retention is enabled,
it's assumed to be full retention(IOW no state needs to be
saved/restored) and hence the CPU PM notifiers are not called.
We may need to change this in case we need to support partial
retention states in future.

Other than that,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
