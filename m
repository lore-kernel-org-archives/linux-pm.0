From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing
 policy->governor_data
Date: Wed, 27 Jan 2016 10:18:51 +0000
Message-ID: <20160127101851.GM10898@e106622-lin>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org>
 <20160126095751.GJ10898@e106622-lin>
 <20160127031003.GH3322@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51364 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbcA0KSQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Jan 2016 05:18:16 -0500
Content-Disposition: inline
In-Reply-To: <20160127031003.GH3322@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 27/01/16 08:40, Viresh Kumar wrote:
> On 26-01-16, 09:57, Juri Lelli wrote:
> > This patch fixes the crash I was seeing.
> > 
> > Tested-by: Juri Lelli <juri.lelli@arm.com>
> 
> Thanks.
> 
> > However, it exposes another problem (running the concurrent lockdep test
> 
> It exposes? How can this patch expose the below crash. AFAIR, you
> reported that you are getting below crash on plain mainline on TC2,
> i.e. for drivers with policy-per-governor set.
> 

Oh, simply because, without the NULL ref fix, I couldn't actually run
the test. Sorry if I was not clear.

> The reason is obvious, as the governor's sysfs directory is present
> cpus/cpuX/cpufreq/ instead of cpus/cpufreq/, which used to be the case
> without the flag. And this forces the show()/store() present in
> cpufreq.c to be called which also take policy->rwsem.
> 
> > that you merged in your tests). After the test is finished there is
> > always at least one task spinning. Do you think it might be related to
> > the race we are already discussing in the thread related to my cleanups
> > patches? This is what I see:
> 
> So this is what you reported earlier, right?
> 

Yep, same thing.

> > [   38.843648] other info that might help us debug this:
> > [   38.843648]
> > [   38.867627] Chain exists of:
> >   s_active#41 --> &policy->rwsem --> od_dbs_cdata.mutex
> > 
> > [   38.891693]  Possible unsafe locking scenario:
> > [   38.891693]
> 
> Will elaborate it a bit here..
> - CPU0 is calling governor's EXIT()
> - CPU1 is reading a governor file from sysfs
> 
> > [   38.909419]        CPU0                    CPU1
> > [   38.922978]        ----                    ----
> 
> Following needs to be added here..
> 
>                    EXIT-governor                read/write governor file
> 
>                                                 lock(s_active#41);
> 
> > [   38.936535]   lock(od_dbs_cdata.mutex);
> > [   38.948146]                                lock(&policy->rwsem);
> > [   38.966168]                                lock(od_dbs_cdata.mutex);
> > [   38.985219]   lock(s_active#41);
> > [   38.994923]
> > [   38.994923]  *** DEADLOCK ***
> 
> > Now, you already pointed me at a possible fix. I'm going to test that
> > (even if I have questions about that patch :)) and see if it makes this
> > go away. 
> 
> @Rafael: Juri is talking about this patch:
> 
> http://www.linux-arm.org/git?p=linux-jl.git;a=commit;h=d3eb02ed23732de2c8671377316a190c38b8fe93
> 

Right. Thanks for pointing Rafael to it.

> Juri, I thought it will fix it earlier (when I wrote it), but it never
> did on x86 (while I dropped the rwsem-drop-code around EXIT as well).
> 
> And I never came back to it and so never sent it upstream.
> 

kbuild robot didn't report anything bad yet. I'll run some more tests on
my x86 box anyway.

Best,

- Juri
