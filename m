From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2] ARM: cpuidle: Support asymmetric idle definition
Date: Fri, 2 Jun 2017 10:20:09 +0100
Message-ID: <3ec88de3-7d18-0ea6-bc27-e98084f2b6f6@arm.com>
References: <1496317188-15272-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdFBJUN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Jun 2017 05:20:13 -0400
In-Reply-To: <1496317188-15272-1-git-send-email-daniel.lezcano@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>



On 01/06/17 12:39, Daniel Lezcano wrote:
> Some hardware have clusters with different idle states. The current code does
> not support this and fails as it expects all the idle states to be identical.
> 
> Because of this, the Mediatek mtk8173 had to create the same idle state for a
> big.Little system and now the Hisilicon 960 is facing the same situation.
> 
> Solve this by simply assuming the multiple driver will be needed for all the
> platforms using the ARM generic cpuidle driver which makes sense because of the
> different topologies we can support with a single kernel for ARM32 or ARM64.
> 
> Every CPU has its own driver, so every single CPU can specify in the DT the
> idle states.
> 
> This simple approach allows to support the future dynamIQ system, current SMP
> and HMP.
> 
> It is unoptimal from a memory point of view for a system with a large number of
> CPUs but nowadays there is no such system with a cpuidle driver on ARM.
>

While I agree this may be simple solution, but just not necessary for
systems with symmetric idle states especially one with large number of
CPUs. I don't like to see 96 CPU Idle driver on say ThunderX. So we
*must* have some basic distinction done here.

IMO, we can't punish a large SMP systems just because they don't have
asymmetric idle states.

-- 
Regards,
Sudeep
