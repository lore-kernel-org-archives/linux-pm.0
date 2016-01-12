From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Tue, 12 Jan 2016 14:57:52 +0530
Message-ID: <20160112092752.GV1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
 <20160111220708.GK6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35168 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934674AbcALJ14 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 04:27:56 -0500
Received: by mail-pf0-f174.google.com with SMTP id 65so60063456pff.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 01:27:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160111220708.GK6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 23:07, Peter Zijlstra wrote:
> On Mon, Jan 11, 2016 at 05:35:45PM +0000, Juri Lelli wrote:
> > +/**
> > + * Iterate over governors
> > + *
> > + * cpufreq_governor_list is protected by cpufreq_governor_mutex.
> > + */
> > +static LIST_HEAD(cpufreq_governor_list);
> > +static DEFINE_MUTEX(cpufreq_governor_mutex);
> > +#define for_each_governor(__governor)				\
> > +	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> 
> So you could stuff the lockdep_assert_held() you later add intididually
> into the for_each_governor macro, impossible to forget that way.

How exactly? I couldn't see how it can be done in a neat and clean
way.

-- 
viresh
