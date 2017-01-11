From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 2/3] cpu: expose pm_qos_resume_latency for each cpu
Date: Wed, 11 Jan 2017 22:33:56 +0800
Message-ID: <3344ad77-62db-830f-94db-f4bdd7257478@linaro.org>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
 <1483630187-29622-3-git-send-email-alex.shi@linaro.org>
 <20170111080927.GA6689@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35456 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbdAKOek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 09:34:40 -0500
Received: by mail-pf0-f176.google.com with SMTP id f144so53366382pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2017 06:34:03 -0800 (PST)
In-Reply-To: <20170111080927.GA6689@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


>> >  #include "base.h"
>> >  
>> > @@ -376,6 +377,9 @@ int register_cpu(struct cpu *cpu, int num)
>> >  
>> >  	per_cpu(cpu_sys_devices, num) = &cpu->dev;
>> >  	register_cpu_under_node(num, cpu_to_node(num));
>> > +#ifdef CONFIG_CPU_IDLE_GOV_MENU
>> > +	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
>> > +#endif
> No way to do this without the #ifdef?  That's really not recommended for
> .c code :(
> 

Hi Greg,

Thanks for comments!

The function dev_pm_qos_expose_latency_limit() is null if no CONFIG_PM.
So when CONFIG_PM enabled, may we could consider the cpu idle is also
wanted. In this assumption the #ifdef could be removed. If user want to
use this feature, she/he should understand the feature only work on menu
gov only currently. So consider this, I guess we could remove this
#ifdef. :)

Any different concerns on this?

Regards
Alex

BTW,
Although I did try this patch on other platform, but it clearly other
multi core system, like x86 could also get the same benefit.
