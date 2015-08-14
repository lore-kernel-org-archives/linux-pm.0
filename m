From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 14 Aug 2015 11:59:31 -0700
Message-ID: <7hlhdditm4.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
	<7hoaicmeuh.fsf@deeprootsystems.com>
	<20150812204326.GM52339@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36165 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbbHNS7d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 14:59:33 -0400
Received: by pdco4 with SMTP id o4so34192908pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 11:59:33 -0700 (PDT)
In-Reply-To: <20150812204326.GM52339@linaro.org> (Lina Iyer's message of "Wed,
	12 Aug 2015 14:43:26 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Lina Iyer <lina.iyer@linaro.org> writes:

> On Wed, Aug 12 2015 at 14:28 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> Enable runtime PM for CPU devices. Do a runtime get of the CPU device
>>> when the CPU is hotplugged in and a runtime put of the CPU device when
>>> the CPU is hotplugged off. When all the CPUs in a domain are hotplugged
>>> off, the domain may also be powered off and cluster_pm_enter/exit()
>>> notifications are be sent out.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>
>>How does the runtiem PM usage with hotplug work with the runtime PM
>>usage in idle?
>>
>>IIUC, when a CPU is hotplugged in, it will always have a usecount of at
>>least 1, right?  and if it's not idle, it will have done a _get() so it
>>will have a usecount of at least 2.   So I'm not quite seeing how the
>>usecount will ever go to zero in idle and allow the domain to power_off.
>>
> When the CPU is online and running, it would have a ref count of 1. Then
> cpuidle would do a _put and the ref count would go to 0 and when coming
> out of idle, cpuidle would get a _get and the ref count will be back at
> 1. Ref count is not incremented when cpuidle is initialized on the CPU.
> So whenever the CPU is running, it would have a ref count of 1.

Ah, OK, that was the part I was missing.

Thanks,

Kevin
