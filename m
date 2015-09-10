From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Thu, 10 Sep 2015 06:52:22 +0530
Message-ID: <20150910012222.GN5266@linux>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
 <11470100.cEo24Tpcgr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36081 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbIJBW2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 21:22:28 -0400
Received: by padhk3 with SMTP id hk3so25943430pad.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 18:22:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11470100.cEo24Tpcgr@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On 10-09-15, 03:41, Rafael J. Wysocki wrote:
> I see one.  That unfortunately is the acpi-cpufreq driver, but it still is one.

Hmm..

> Well, cpufreq_generic_get() does _get_raw(), so I suppose acpi-cpufreq may
> do that too?

Yeah, it can.

> > need to get the policy back and so do
> > cpufreq_cpu_get(cpu) on the cpu passed as argument to ->get().
> > 
> > It would be better if we pass them 'policy' directly and drivers can use
> > policy->cpu if that's all they need.
> 
> Passing a pointer and dereferencing it is generally less efficient than passing
> a number.  Before the patch the core has to do the dereference before calling
> ->get, so it likely doesn't matter here, but the code churn from this change
> is quite substantial and the benefit from it is in the noise IMO.

Hmm.. Actually almost every other callback (bios_limit() is another
one), passes the policy to the driver, and I thought always passing
the policy will make it more symmetrical. And the expectation that the
cpufreq drivers wouldn't need to use policy from the ->get() callback
would be wrong. Even if there are only few users today. One is the
acpi-cpufreq driver and others are the ones, that are using
cpufreq_generic_get() :)

> Overall, we need to talk about the design aspect of cpufreq, because there
> are much more significant issues in it than things like this one.

I agree.

-- 
viresh
