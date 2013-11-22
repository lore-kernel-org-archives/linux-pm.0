From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] PM / Clocks: fix pm_clk_resume/suspend if CONFIG_PM_RUNTIME is set
Date: Fri, 22 Nov 2013 10:43:49 -0800
Message-ID: <87ppps6zve.fsf@linaro.org>
References: <1384954307-27094-1-git-send-email-grygorii.strashko@ti.com>
	<528D0296.1070001@codeaurora.org> <528D082C.3040405@ti.com>
	<528D1327.7080205@codeaurora.org> <528D1784.8080704@ti.com>
	<528D1C49.3020301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:57360 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab3KVSnx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2013 13:43:53 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so1670004pbb.37
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2013 10:43:52 -0800 (PST)
In-Reply-To: <528D1C49.3020301@ti.com> (Santosh Shilimkar's message of "Wed,
	20 Nov 2013 15:32:09 -0500")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

>>> It looks like even if you just remove the locks here, the PM core is
>>> free to call this function with irqs disabled if pm_runtime_irq_safe()
>>> has been called on the device. Perhaps runtime PM can only do the
>>> clk_enable()/clk_disable() part and the clk_unprepare()/clk_prepare()
>>> calls should happen in the system suspend callbacks?
>> 
>> Even don't know what to say :( On Keystone clk_unprepare()/clk_prepare() are NOPs.
>> But clk_prepare() has to be called at least once before clk_enable() :((
>> So, solution with suspend/resume will not fix current problem :( unfortunately.
>> 
>> FYI, Now pm_clk_suspend/pm_clk_resume are called from arch/arm/mach-keystone/pm_domain.c
>> (also similar solution is used by Davinci, but issue has not been detected because
>> PM runtime hasn't been used by Davinci IP drivers before)
>> 
> One way to deal with this is to have clk_unprepare()/clk_prepare()
> called from dev_pm_domain ops before calling pm_clk_[suspend/resume]() if we
> can't have that as part of runtime code.

That doesn't solve the irq_safe problem that Stephen pointed out without
being very careful.  Basically, if you have _any_ potentially sleeping
calls in this path, you can never allow devices to use
pm_runtime_irq_safe().

Also, I don't like having the clk_enable in the PM core but the
clk_prepare in the platform-specific pm_domain.  That seems prone for
platforms to get wrong.

I'll need to think about this a little more before having any idea what
to do here.

Kevin






