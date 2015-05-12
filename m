From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 01/14] cpufreq: Create for_each_{in}active_policy()
Date: Tue, 12 May 2015 11:34:17 +0530
Message-ID: <20150512060417.GD32300@linux>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
 <79f880aba9ad5159e070f2ca172139cb2c254430.1431065963.git.viresh.kumar@linaro.org>
 <5045046.BY2j8T62rF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36431 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbELGEW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 02:04:22 -0400
Received: by pabsx10 with SMTP id sx10so133968860pab.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 23:04:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5045046.BY2j8T62rF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 08-05-15, 23:46, Rafael J. Wysocki wrote:
> On Friday, May 08, 2015 11:53:44 AM Viresh Kumar wrote:

> > +#define __for_each_active_policy(__policy, __temp, __active)		\
> > +	for (__temp = NULL, __policy = next_policy(NULL, __active);	\
> > +	     &__policy->policy_list != &cpufreq_policy_list ||		\
> > +	     ((__policy = __temp) && 0);				\
> > +	     __temp = __policy, __policy = next_policy(__policy, __active))
> 
> can be rewritten as:
> 
> #define __for_each_active_policy(__policy, __active)		\
> 	for (__policy = first_policy(__active);	__policy;	\
> 	     __policy = next_policy(__policy, __active))
> 
> and you don't need to explain what it does even.  Of course, next_policy()
> has to return 'false' when it can't find anything suitable, but that shouldn't
> be too difficult to arrange I suppose?
> 
> Or if you need __temp because the object pointed to by __policy can go away,
> you can follow the design of list_for_each_entry_safe() here.

I wasn't using __temp to be safe, but to make sure that the loop
points to a 'active' policy at the end. But that isn't required
anymore as the only call site that required this, is fixed in a better
way:

c75de0ac0756 ("cpufreq: Schedule work for the first-online CPU on resume")
