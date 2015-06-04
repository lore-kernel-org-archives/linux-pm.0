From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 4 Jun 2015 12:43:59 +0530
Message-ID: <20150604071359.GA743@linux>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
 <556FDEA8.6090801@linux.vnet.ibm.com>
 <556FEB4B.1010601@linux.vnet.ibm.com>
 <20150604061128.GF11325@linux>
 <556FF201.8080100@linux.vnet.ibm.com>
 <20150604064202.GI11325@linux>
 <556FF893.3070007@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36239 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbFDHOF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 03:14:05 -0400
Received: by pdjm12 with SMTP id m12so24753620pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 00:14:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556FF893.3070007@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 04-06-15, 12:34, Preeti U Murthy wrote:
> My point is do we really need to treat them as separate problems ?

Yes.

> Will not serializing sequence of events help solve both issues ?

That's not the point. Even if it solves the problem, it may not be the
right approach. There are two problems here:
- One lies in cpufreq.c or in policies domain.
- Other one is about governor. Governor code shouldn't rely of
  cpufreq.c locking to guarantee that access to its structures isn't
  racy.

And the way you proposed to solve it (yes the original idea was from
one of my earlier patches) is not the right way to do it.

For example, cpufreq_set_policy() shouldn't care about how the
governor code is placed. It should just do enough to get rid of racy
code belonging to that policy.

But with our other approach, we are trying to stop the governor to be
used by anyone else in the kernel. Who the hell is that 'policy' to
decide who can access the governor ?

That's why I divided it up, so that we don't come to it again. I
haven't learnt these things earlier, and wrote messy locking code
earlier. But after looking/working on core code like timers etc, I
understood the importance of right design and proper partitioning of
responsibilities.

> When we know the problem, why not fix it proper, rather than breaking it
> up ?

What are we breaking here ?

> > This patch is trying to solve only the first problem.
> > "
> > 
> > I NEVER claimed that I solved all the issues.
> 
> That is true. My intention was to point out explicitly what still
> remains to be solved. It is true that you have mentioned that the
> problem in the cpufreq core is about sequencing of events. I intended to
> highlight what it was.

Okay, that should be the next target we have to fix after applying
these patches.

> I would have restrained from pointing it out had the issues that I am
> seeing waned a wee bit, but it has not, which is why I did not see value
> in having the third patch as a stand alone patch, with more going in as
> series.

Its solving what it is intended to solve. But we need more patches
over it to fix problems outside the scope of governors.

-- 
viresh
