From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] cpu: expose pm_qos_resume_latency for each cpu
Date: Wed, 11 Jan 2017 19:40:54 +0100
Message-ID: <CAJZ5v0hG6UgKDObTaOWy08EhY9uZh9o4=pRW_zjSAbY4c_u5Vw@mail.gmail.com>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
 <1483630187-29622-3-git-send-email-alex.shi@linaro.org> <20170111080927.GA6689@kroah.com>
 <3344ad77-62db-830f-94db-f4bdd7257478@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35670 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbdAKSkz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 13:40:55 -0500
In-Reply-To: <3344ad77-62db-830f-94db-f4bdd7257478@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Jan 11, 2017 at 3:33 PM, Alex Shi <alex.shi@linaro.org> wrote:
>
>>> >  #include "base.h"
>>> >
>>> > @@ -376,6 +377,9 @@ int register_cpu(struct cpu *cpu, int num)
>>> >
>>> >    per_cpu(cpu_sys_devices, num) = &cpu->dev;
>>> >    register_cpu_under_node(num, cpu_to_node(num));
>>> > +#ifdef CONFIG_CPU_IDLE_GOV_MENU
>>> > +  dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
>>> > +#endif
>> No way to do this without the #ifdef?  That's really not recommended for
>> .c code :(
>>
>
> Hi Greg,
>
> Thanks for comments!
>
> The function dev_pm_qos_expose_latency_limit() is null if no CONFIG_PM.
> So when CONFIG_PM enabled, may we could consider the cpu idle is also
> wanted. In this assumption the #ifdef could be removed. If user want to
> use this feature, she/he should understand the feature only work on menu
> gov only currently. So consider this, I guess we could remove this
> #ifdef. :)

But instead of putting the #ifdef into the function body, you can use
a wrapper function defined to be empty for CONFIG_PM unset.

Thanks,
Rafael
