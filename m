From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Thu, 23 Jul 2015 11:39:38 +0530
Message-ID: <20150723060938.GD5322@linux>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
 <20150722131539.GU7557@n2100.arm.linux.org.uk>
 <CAJZ5v0jGPHq0P90pTbWGSnydgCQ5TcSxQ-KFuRjZ=qT6gNp_cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34343 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbbGWGJn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 02:09:43 -0400
Received: by pacan13 with SMTP id an13so153422164pac.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 23:09:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jGPHq0P90pTbWGSnydgCQ5TcSxQ-KFuRjZ=qT6gNp_cg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 22-07-15, 18:42, Rafael J. Wysocki wrote:
> > 3. what happens when 'policy' is NULL at the point when the first (few) CPUs
> >    are added - how do the symlinks get created later if/when policy becomes
> >    non-NULL (can it?)
> 
> Yes, it can, and we have a design issue here that bothers me a bit.

I replied to Russell with a NO here as the first CPU should have
created the policy. BUT...

> Namley, we need a driver's ->init callback to populate policy->cpus
> for us, but this is not the only thing it is doing, so the concern is
> that it may not be able to deal with CPUs that aren't online.

... the first few CPUs could have been offline and so we might not
have tried to add the policy at all.. Need to fix that for sure.

> I was thinking about an additional driver callback that would *only*
> populate a mask of CPUs that should use the same policy as the given
> one.

Why so ? Drivers today are required to set policy->cpus with all CPUs
that should be managed by that policy. i.e. all online+offline. So,
actually ->init() fills policy->cpus with the value of
policy->related_cpus.

Yes, I thought earlier to change that by setting policy->related_cpus
from drivers, instead of policy->cpus and wasn't sure if I should do
that :)

> We'd be able to call that from cpufreq_add_dev() for offline
> CPUs too and this way the policy object could be created for the first
> CPU using the policy that is registered instead of being added for the
> first CPU using that policy that becomes online (which happens today).

Creating policy for offline CPUs doesn't look that great to me.

What we can do to fix the problem in hand, is to update a global mask
of CPUs (with policy == NULL) which were offline when
cpufreq_add_dev() was called for them. And when we create the policy,
we can add links for all such CPUs.

-- 
viresh
