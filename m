From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Support asymmetric idle definition
Date: Tue, 13 Jun 2017 10:46:00 +0100
Message-ID: <1ce6e228-39cf-a8be-ff65-a5fdf5e78605@arm.com>
References: <20170612155441.GE2261@mai>
 <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
 <1497282910-19085-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497282910-19085-2-git-send-email-daniel.lezcano@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Leo Yan <leo.yan@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 12/06/17 16:55, Daniel Lezcano wrote:
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
> Tested on:
>  - 96boards: Hikey 620
>  - 96boards: Hikey 960
>  - 96boards: dragonboard410c
>  - Mediatek 8173
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Sorry for the delay, as I mentioned earlier I would like to add the
minimum change to avoid this on platforms that don't require this. But
that can be done later, I will try to come up with simple solution when
I get time. Though I am not 100% happy ;), I am fine with this change
for now:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
