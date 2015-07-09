From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add ->get_rate() driver callback
Date: Thu, 9 Jul 2015 10:29:02 +0530
Message-ID: <20150709045902.GI1805@linux>
References: <fb44111fa7a762924661ad48a70985d597229bc4.1436351759.git.viresh.kumar@linaro.org>
 <1879392.TC0RceaKlH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33484 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbGIE7H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 00:59:07 -0400
Received: by pacws9 with SMTP id ws9so145255033pac.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 21:59:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1879392.TC0RceaKlH@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 09-07-15, 01:41, Rafael J. Wysocki wrote:
> On Wednesday, July 08, 2015 04:07:32 PM Viresh Kumar wrote:
> > CPUFreq drivers today support a ->get(cpu) callback, which returns
> > current rate of a CPU. The problem with ->get() is that it takes a cpu
> > number as parameter and this unnecessarily makes things complex.
> > 
> > Firstly the core gets the cpu number by doing operation 'policy->cpu' on
> > the policy and then many drivers need to get the policy back and so do
> > cpufreq_cpu_get(cpu) on the passed cpu.
> > 
> > As cpufreq core works on policies, it would be better if we pass them
> > 'policy' directly and drivers can use policy->cpu if that's all they
> > need.
> > 
> > Hence, this patch adds in another callback, ->get_rate() which does
> > exactly the same work as ->get(), just that we pass 'policy' as
> > parameter instead of 'cpu'.
> > 
> > The plan is to migrate all drivers to this new callback and remove
> > ->get() after that.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Hi Rafael,
> > 
> > I hope you are fine with this stuff :), once you approve I will get
> > other patches to migrate existing drivers to this interface.
> 
> I'm generally fine with it, but please target it at 4.4 at the earliest.

Sure, but I was a bit curious on why 4.4 and not 4.3 ? as we are still
at 4.2-rc1 today, and these patches can be done fairly quickly.

-- 
viresh
