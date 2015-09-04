From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 20:57:10 +0300
Message-ID: <55E9DB76.3080904@ti.com>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
 <20150904091735.GC21084@n2100.arm.linux.org.uk>
 <20150904092716.GD21084@n2100.arm.linux.org.uk>
 <20150904151202.GA876@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35968 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbbIDR6A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 13:58:00 -0400
In-Reply-To: <20150904151202.GA876@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

Hi Lina,

On 09/04/2015 06:12 PM, Lina Iyer wrote:
> On Fri, Sep 04 2015 at 03:27 -0600, Russell King - ARM Linux wrote:
>> On Fri, Sep 04, 2015 at 10:17:35AM +0100, Russell King - ARM Linux wrote:
>>> On Thu, Sep 03, 2015 at 01:58:34PM -0600, Lina Iyer wrote:
>>> > @@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
>>> >      local_irq_enable();
>>> >      local_fiq_enable();
>>> >
>>> > +    /* We are running, enable runtime PM for the CPU. */
>>> > +    cpu_dev = get_cpu_device(cpu);
>>> > +    if (cpu_dev)
>>> > +        pm_runtime_get_sync(cpu_dev);
>>> > +
>>>
>>> Please no.  This is fragile.
>>>
>>> pm_runtime_get_sync() can sleep, and this path is used when the system
>>> is fully up and running.  Locks may be held, which cause this to sleep.
>>> However, we're calling it from a context where we can't sleep - which
>>> is the general rule for any part of system initialisation where we
>>> have not entered the idle thread yet (the idle thread is what we run
>>> when sleeping.)
>>>
> More explanation below.
> 
> Another patch (3/7) in this series defines CPU devices as IRQ safe and
> therefore the dev->power.lock would be spinlock'd before calling the
> rest of the PM runtime code and the domain. The CPU PM domain would also
> be an IRQ safe domain (patch 2/7 makes the genpd framework usable in IRQ
> safe context).

There is one "small" problem with such approach :(

- It's incompatible with -RT kernel, because PM runtime can't be used
in atomic context on -RT. As result, CPU's hotplug will be broken
(CPUIdle will be broken also, but CPU hotplug is more important at least for me:).

Also, as for me, PM runtime + genpd is a little bit heavy-weight things
to be used for CPUIdle and It could affect on states with small wake-up latencies.

[...]

-- 
regards,
-grygorii
