From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 0/2] Avoid calling cpu_pm functions for retention idle
 states
Date: Tue, 2 Jan 2018 14:04:07 +0000
Message-ID: <20180102140406.kjso7mgizlp6aj4b@armageddon.cambridge.arm.com>
References: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbeABOEL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jan 2018 09:04:11 -0500
Content-Disposition: inline
In-Reply-To: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com

On Wed, Nov 15, 2017 at 10:11:48AM -0700, Prashanth Prakash wrote:
> CPU_PM_CPU_IDLE_ENTER() treats all idle states whose idx != 0 as a
> state that loses some context, but we can have deeper idle states that
> doesn't lose any software context. If a CPU is entering such a low power
> idle state where it retains the context, then there is no need to call
> cpu_pm_enter()/cpu_pm_exit().
> 
> Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
> drivers when they are entering retention state. By not calling cpu_pm_enter
> and cpu_pm_exit we reduce the latency involved in entering and exiting
> the retention states.
> 
> On ARM64 based Qualcomm server platform we measured below overhead for
> for calling cpu_pm_enter and cpu_pm_exit for retention states.
> 
> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
> Overhead of cpu_pm_enter - 1.2us(Average), 6.5us(Max)
> Overhead of cpu_pm_exit  - 3.1us(Average), 11.1us(Max)

I queued the patches in the arm64 tree for 4.16. Thanks.

-- 
Catalin
