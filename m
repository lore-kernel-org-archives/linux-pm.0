From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data
 protection
Date: Fri, 5 Feb 2016 08:29:48 +0530
Message-ID: <20160205025948.GE3068@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1529283.0IedZktI9q@vostro.rjw.lan>
 <20160204050954.GU3469@vireshk>
 <CAJZ5v0hWj4JgCh76Fg48ex3Svv7BUHR=9+RoA728R9aYU+12Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33667 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcBEC7w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 21:59:52 -0500
Received: by mail-pf0-f181.google.com with SMTP id w123so60852717pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 18:59:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWj4JgCh76Fg48ex3Svv7BUHR=9+RoA728R9aYU+12Pw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 04-02-16, 17:46, Rafael J. Wysocki wrote:
> On Thu, Feb 4, 2016 at 6:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 04-02-16, 00:16, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Every governor relying on the common code in cpufreq_governor.c
> >> has to provide its own mutex in struct common_dbs_data.  However,
> >> those mutexes are never used at the same time
> >
> > Why do you think so? I thought they can always be used in parallel.
> >
> > Consider 2 or more policies, one can have ondemand as the governor,
> > whereas other one can have conservative.
> >
> > If CPUs go online/offline or if governors are switching in parallel,
> > then cpufreq_governor_dbs() can very much run in parallel for ondemand
> > and conservative.
> >
> > Or am I missing something here ?
> 
> Well, so perhaps the changelog is inaccurate.
> 
> However, what's wrong with using a single mutex then?

You are killing the possibility of running the code faster. Consider
this:
- A 16 policy system with N CPUs in every policy (IBM has something
  similar only :) )..
- 4 policies using ondemand, 4 using conservative, 4 using powersave
  and 4 with performance.
- Now if we try to change governors for all of them in parallel, only
  one will be done at a time and others have to wait for this
  BIG-kernel lock.
- Ideally the lock shouldn't have been in cdata itself, but dbs_data
  only. But there was a specific race because of which we were
  required to move it to a higher level, i.e. cdata. And so we killed
  the possibility of parallelism of multiple governors of same type
  (ofcourse only of update-sampling-rate and cpufreq_governor_dbs()..

So, it makes thing much slower..

-- 
viresh
