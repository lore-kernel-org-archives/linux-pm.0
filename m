From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Wed, 22 Jul 2015 12:42:40 +0530
Message-ID: <20150722071240.GD30970@linux>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
 <CAJZ5v0hXkEbRqd1ZWGABxbofQ+Y8yjn_JknVUXPGKy=kkE=Xhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34617 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbbGVHMp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 03:12:45 -0400
Received: by pacan13 with SMTP id an13so135207244pac.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 00:12:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXkEbRqd1ZWGABxbofQ+Y8yjn_JknVUXPGKy=kkE=Xhw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 22-07-15, 01:15, Rafael J. Wysocki wrote:
> So the problem is that the cpu_is_offline(cpu) check in
> cpufreq_add_dev() matches two distinct cases: (1) the CPU was not
> present before and it is just being hot-added and (2) the CPU is
> initially offline, but present, and this is the first time its device
> is registered.  In the first case we can expect that the CPU will
> become online shortly (although that is not guaranteed too), but in
> the second case that very well may not happen.

Yeah.

> We need to be able to distinguish between those two cases and your
> patch does that, but I'm not sure if this really is the most
> straightforward way to do it.

Maybe yeah. I will take another look into that after considering
Russell's input.

> I'm also unsure why you're changing the removal code paths.  Is there
> any particular failure scenario you're concerned about?

The same issue is present here too. The problem was that cpu_offline()
check was getting hit for a CPU that is present in related_cpus mask.
While allocating/freeing the policy, we create links for all
related_cpus and the cpu_offline() check was adding/removing the link
again.

-- 
viresh
