From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Wed, 09 Dec 2015 23:06:05 +0100
Message-ID: <1517731.pZjrRh9Im6@vostro.rjw.lan>
References: <96a8e6745e6335efb537dccafbc213286fdf9ad5.1449209505.git.viresh.kumar@linaro.org> <3250190a623b11f8479c0c9e144d867b8cf7b305.1449626558.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63009 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750980AbbLIVgH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 16:36:07 -0500
In-Reply-To: <3250190a623b11f8479c0c9e144d867b8cf7b305.1449626558.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, open list <linux-kernel@vger.kernel.org>

On Wednesday, December 09, 2015 07:34:42 AM Viresh Kumar wrote:
> cpufreq governors evaluate load at sampling rate and based on that they
> update frequency for a group of CPUs belonging to the same cpufreq
> policy.
> 
> This is required to be done in a single thread for all policy->cpus, but
> because we don't want to wakeup idle CPUs to do just that, we use
> deferrable work for this. If we would have used a single delayed
> deferrable work for the entire policy, there were chances that the CPU
> required to run the handler can be in idle and we might end up not
> changing the frequency for the entire group with load variations.
> 
> And so we were forced to keep per-cpu works, and only the one that
> expires first need to do the real work and others are rescheduled for
> next sampling time.
> 
> We have been using the more complex solution until now, where we used a
> delayed deferrable work for this, which is a combination of a timer and
> a work.
> 
> This could be made lightweight by keeping per-cpu deferred timers with a
> single work item, which is scheduled by the first timer that expires.
> 
> This patch does just that and here are important changes:
> - The timer handler will run in irq context and so we need to use a
>   spin_lock instead of the timer_mutex. And so a separate timer_lock is
>   created. This also makes the use of the mutex and lock quite clear, as
>   we know what exactly they are protecting.
> - A new field 'skip_work' is added to track when the timer handlers can
>   queue a work. More comments present in code.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

OK, replaced the one in my tree with this one, thanks!

BTW, can you please add an extra From: line to the bodies of your patch
messages?

For some unknown reason Patchwork or your mailer or the combination of the
two mangles your name for me and I have to fix it up manually in every patch
from you which is a !@#$%^&*() pain.

Thanks,
Rafael

