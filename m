From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 2/2] ARM64 / cpuidle: Use new cpuidle macro for
 entering retention state
Date: Tue, 2 Jan 2018 11:42:39 +0000
Message-ID: <e1e34569-538d-75f2-34fb-2feb75692ea7@arm.com>
References: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
 <1510765910-23739-3-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37622 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbeABLmn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jan 2018 06:42:43 -0500
In-Reply-To: <1510765910-23739-3-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com



On 15/11/17 17:11, Prashanth Prakash wrote:
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

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
