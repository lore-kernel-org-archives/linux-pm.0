From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] cpufreq: User/admin documentation update and consolidation
Date: Wed, 22 Feb 2017 01:50:45 +0100
Message-ID: <8913428.RXS4e600Af@aspire.rjw.lan>
References: <6949552.t0rZsBY3Lp@aspire.rjw.lan> <4488503.27M9KJWnWE@aspire.rjw.lan> <20170221050010.GW21911@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60649 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753661AbdBVAzu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 19:55:50 -0500
In-Reply-To: <20170221050010.GW21911@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>

On Tuesday, February 21, 2017 10:30:10 AM Viresh Kumar wrote:
> On 20-02-17, 14:58, Rafael J. Wysocki wrote:
> > Yes, it is called for new and inactive policies.
> > 
> > For new policies it has to populate policy->cpus (because otherwise the core
> > doesn't know what CPUs should be there), which quite arguably doesn't have
> > to (or even doesn't need to) be done for inactive policies (because they already
> > have policy->real_cpus and policy->related_cpus populated).
>  
> > I would even argue that ->init() should not update policy->cpus for inactive
> > (but not new) policies.
> 
> I agree, but I am not aware of any platforms that we have today which
> does any similar checks in ->init(). And I wouldn't encourage drivers
> to have such special handling at all. Why make it complex?

Well, IMO we should not invoke the same callback in two different cases and
then do tricks in the core to make one of them work.  That's just too [edited]
ugly.

At least it doesn't help to understand the code flow.

> The way you have written it earlier suggests that the drivers should
> check if the policy is active or not (by looking at related_cpus mask)
> and set the cpus mask only for new policies. I was just worried that
> new driver authors will actually try to write special code in init()
> for that and if we really want that to be the case.

That would not be a bug IMO.  Some of them could just check related_cpus
and do nothing if it is set I suppose?

Anyway, this isn't a driver API document, so the description is not super-precise.

Thanks,
Rafael
