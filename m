From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH 1/4] cpufreq: governor: support scheduler cpufreq
 callbacks on remote CPUs
Date: Fri, 6 May 2016 13:53:07 -0700
Message-ID: <20160506205307.GB15729@sky.smuckle.net>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
 <20160429103816.GC2927@vireshk-i7>
 <1811208.ius7TXdi4I@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35657 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbcEFUxM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 16:53:12 -0400
Received: by mail-pf0-f181.google.com with SMTP id 77so53223462pfv.2
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2016 13:53:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1811208.ius7TXdi4I@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Fri, Apr 29, 2016 at 01:21:24PM +0200, Rafael J. Wysocki wrote:
> On Friday, April 29, 2016 04:08:16 PM Viresh Kumar wrote:
...
> > Any clue, why we don't have a non-SMP version of irq_work_queue_on(), Which can
> > simply call irq_work_queue() ?
> 
> Because nobody else needs it?
> 
> But I agree that it would be nicer to add the stub to irq_work.h.

I had wondered the same myself and figured there had to be a good reason why it didn't exist.

But if not, and it's preferred to add it, I'll go ahead and so.
