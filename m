From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait condition
Date: Tue, 2 Aug 2016 03:37:02 +0200
Message-ID: <CAJZ5v0hJL0qL6nYCWzyN4O0cqzjKCC0pprfo0tD8MZCtEj1==A@mail.gmail.com>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <3009663.9YcxTKseiO@vostro.rjw.lan>
 <20160802012209.GB9332@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33157 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596AbcHBBj1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 21:39:27 -0400
In-Reply-To: <20160802012209.GB9332@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 2, 2016 at 3:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Mon, Aug 01, 2016 at 01:37:23AM +0200, Rafael J. Wysocki wrote:
> ...
>> For this purpose, define a new cpufreq_update_util() flag
>> UUF_IO and modify enqueue_task_fair() to pass that flag to
>> cpufreq_update_util() in the in_iowait case.  That generally
>> requires cpufreq_update_util() to be called directly from there,
>> because update_load_avg() is not likely to be invoked in that
>> case.
>
> I didn't follow why the cpufreq hook won't likely be called if
> in_iowait is set? AFAICS update_load_avg() gets called in the second loop
> and calls update_cfs_rq_load_avg (triggers the hook).

In practice it turns out that in the majority of cases when in_iowait
is set the second loop will not run.

Thanks,
Rafael
