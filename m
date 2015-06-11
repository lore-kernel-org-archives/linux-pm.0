From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for
 cpu domain
Date: Thu, 11 Jun 2015 08:56:49 -0600
Message-ID: <20150611145649.GC1103@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <7hmw07meh6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34369 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbbFKO4t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 10:56:49 -0400
Received: by payr10 with SMTP id r10so5308830pay.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 07:56:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hmw07meh6.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On Wed, Jun 10 2015 at 15:38 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Generally cpus are grouped under a power domain in a SoC. When all cpus
>> in the domain are in their power off state, the cpu domain can also be
>> powered off.
>
>How does this relate to a cluster, and why aren't you using that terminolgy?
>
>> Genpd provides the framework for defining cpus as devices
>> that are part of a cpu domain.
>>
>> Introduce support for defining and adding a generic power domain for the
>> cpus based on the DT specification of power domain providers and
>> consumers.  SoC's that have the cpu domain defined in their DT, can
>> setup a genpd with a name and the power_on/power_off callbacks. Calling
>> pm_cpu_domain_init() will register the genpd and attach the cpus for
>> this domain with the genpd.
>>
>> CPU_PM notifications for are used to pm_runtime_get_sync() and
>> pm_runtime_put_sync() for each cpu.  When all cpus are powered off, the
>> last cpu going down would call the genpd->power_off(). Correspondingly,
>> the first cpu up would call the genpd->power_on() callback before
>> resuming from idle.
>
>Other patches also mention this genpd being useful to gate power to
>non-CPU peripherals on the same power rail.  How are those devices to be
>added?
>
I am not investigating DT nodes to figure out which node is a consumer
for this domain provider. That could be a good way to do it, but
practically speaking, there may be platform dependencies and specifics
that may need to be met, before the device can be added to the CPU
genpd.

So that is not generalized here. I didn't see a better way to do that,
generically. Do you have ideas on that?

The platform is the owner of the genpd and therefore can add those
non-cpu devices to the genpd as and when appropritate.

In this regard, I also have a question, who initializes the genpd. My
assumption is that CPUs will get probed before most other devices and
therefore the domain provider could be initialized by this file. But, I
could be wrong here.




>Without seeing the DTs and the init code that might call
>pm_cpu_domain_init(), it's hard for me to see how this is intended to be
>used.  Could you also include a patch that shows how this is initialized
>and the DT additions?  Ideally, it should also show how a non-CPU device
>would be included.
>
I am sorry, you are right. This is better explained with the patches for
platform driver. I will add them in the next spin. I thought the
examples provided in the cover letter is pretty close to the genpd
related changes that I made in my platform coder. But I agree, it doesnt
give the complete picture.

Thanks,
Lina
