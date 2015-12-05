From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Sat, 05 Dec 2015 03:14:19 +0100
Message-ID: <2132445.kEr4nQIvso@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <10439879.00aCyM9quW@vostro.rjw.lan> <20151204061101.GA3430@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56341 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751149AbbLEBo1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 20:44:27 -0500
In-Reply-To: <20151204061101.GA3430@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

On Friday, December 04, 2015 11:41:01 AM Viresh Kumar wrote:
> On 04-12-15, 02:18, Rafael J. Wysocki wrote:
> > > +	shared->skip_work--;
> > 
> > Is there any reason for incrementing and decrementing this instead of setting
> > it to either 0 or 1 (or maybe either 'true' or 'false' for that matter)?
> > 
> > If my reading of the patch is correct, it can only be either 0 or 1 anyway, right?
> 
> No. It can be 0, 1 or 2.
> 
> If the timer handler is running on any CPU, we increment skip_work, so
> its value is 1. If at the same time, we try to stop the governor, we
> increment it again and its value is 2 now.
> 
> Once timer-handler finishes, it decrements it and its value become 1.
> Which guarantees that no other timer handler starts executing at this
> point of time and we can safely do gov_cancel_timers(). And once we
> are sure that we don't have any work/timer left, we make it 0 (as we
> aren't sure of the current value, which can be 0 (if the timer handler
> wasn't running when we stopped the governor) or 1 (if the timer
> handler was running while stopping the governor)).
> 
> Hope this clarifies it.

Well, almost, but not quite yet, because now the question is what prevents
gov_cancel_work() from racing with dbs_work_handler().

If you can guarantee that they'll never run in parallel with each other,
you probably don't need the whole counter dance.  Otherwise, dbs_work_handler()
should decrement the counter under the spinlock after all I suppose.

Thanks,
Rafael

