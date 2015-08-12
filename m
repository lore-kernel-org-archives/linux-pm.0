From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
Date: Wed, 12 Aug 2015 14:43:26 -0600
Message-ID: <20150812204326.GM52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
 <7hoaicmeuh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33002 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbHLUnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 16:43:03 -0400
Received: by pdrh1 with SMTP id h1so11069710pdr.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 13:43:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hoaicmeuh.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Wed, Aug 12 2015 at 14:28 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Enable runtime PM for CPU devices. Do a runtime get of the CPU device
>> when the CPU is hotplugged in and a runtime put of the CPU device when
>> the CPU is hotplugged off. When all the CPUs in a domain are hotplugged
>> off, the domain may also be powered off and cluster_pm_enter/exit()
>> notifications are be sent out.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
>How does the runtiem PM usage with hotplug work with the runtime PM
>usage in idle?
>
>IIUC, when a CPU is hotplugged in, it will always have a usecount of at
>least 1, right?  and if it's not idle, it will have done a _get() so it
>will have a usecount of at least 2.   So I'm not quite seeing how the
>usecount will ever go to zero in idle and allow the domain to power_off.
>
When the CPU is online and running, it would have a ref count of 1. Then
cpuidle would do a _put and the ref count would go to 0 and when coming
out of idle, cpuidle would get a _get and the ref count will be back at
1. Ref count is not incremented when cpuidle is initialized on the CPU.
So whenever the CPU is running, it would have a ref count of 1.

As of today, atleast my understanding is hotplug does not go back into
cpuidle, so the ref count would go to 0 when the core is hotplugged off.
This may change, if the CPU hotplug is routed to cpuidle.

Am I wrong in my understanding?

Thanks,
Lina
