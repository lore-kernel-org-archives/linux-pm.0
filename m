From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v3 0/3] cpufreq: avoid redundant driver calls in schedutil
Date: Thu, 14 Jul 2016 11:00:14 -0700
Message-ID: <20160714180014.GG27987@graphite.smuckle.net>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <57876337.6090409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36782 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcGNSAT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 14:00:19 -0400
Received: by mail-pa0-f51.google.com with SMTP id pp5so24056442pac.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2016 11:00:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57876337.6090409@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pingbo Wen <pingbo.wen@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Thu, Jul 14, 2016 at 06:02:31PM +0800, Pingbo Wen wrote:
> > Steve Muckle (3):
> >   cpufreq: add cpufreq_driver_resolve_freq()
> >   cpufreq: schedutil: map raw required frequency to driver frequency
> 
> Tested the first two patches on db410c, only waking up irq_work 53
> times, while previous was 257 times(79% decrease) in Android home idle
> for 5 minutes.

Thanks Pingbo. My experience measuring the number of calls into the acpi
cpufreq fast switch path was similar. An arbitrary system workload I
chose showed a ~75% reduction in calls.

thanks,
Steve
