From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 07/14] cpufreq: Don't allow updating inactive-policies
 from sysfs
Date: Sat, 16 May 2015 07:31:46 +0530
Message-ID: <20150516020146.GD4600@linux>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
 <6ad4377106496d9d148005c902602c66eb307930.1431065963.git.viresh.kumar@linaro.org>
 <2674706.qWzjVNUKcn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36631 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992522AbbEPCBv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 22:01:51 -0400
Received: by igbpi8 with SMTP id pi8so11663160igb.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2015 19:01:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2674706.qWzjVNUKcn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 16-05-15, 03:10, Rafael J. Wysocki wrote:
> The dash after "inactive" in the subject is not necessary IMO.

Okay

> On Friday, May 08, 2015 11:53:50 AM Viresh Kumar wrote:
> > +	/*
> > +	 * Policy might not be active currently, and so we shouldn't try
> > +	 * updating any values here. policy->cpus is cleared for inactive policy
> > +	 * and so cpufreq_cpu_get_raw() should fail.
> 
> These comments don't really clarify things.  It'd be better to say something
> like "Updating inactive policies is invalid, so avoid doing that."

Okay..

> > +	 */
> > +	if (unlikely(policy_is_inactive(policy))) {
> > +		ret = -EPERM;
> 
> This doesn't seem to be the appropriate error code to return here.
> 
> -EBUSY or -EAGAIN would be better IMO.

Okay

-- 
viresh
