From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable
 for synchronization
Date: Tue, 8 Dec 2015 22:04:02 +0530
Message-ID: <20151208163402.GL3692@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <1843141.WbisoTkq1u@vostro.rjw.lan>
 <20151208145658.GG3692@ubuntu>
 <5332935.yle75kNJGs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36474 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965221AbbLHQeH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 11:34:07 -0500
Received: by pacdm15 with SMTP id dm15so14386669pac.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 08:34:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5332935.yle75kNJGs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On 08-12-15, 17:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: governor: Use lockless timer function
> 
> It is possible to get rid of the timer_lock spinlock used by the
> governor timer function for synchronization, but a couple of races
> need to be avoided.
> 
> The first race is between multiple dbs_timer_handler() instances
> that may be running in parallel with each other on different
> CPUs.  Namely, one of them has to queue up the work item, but it
> cannot be queued up more than once.  To achieve that,
> atomic_inc_return() can be used on the skip_work field of
> struct cpu_common_dbs_info.
> 
> The second race is between an already running dbs_timer_handler()
> and gov_cancel_work().  In that case the dbs_timer_handler() might
> not notice the skip_work incrementation in gov_cancel_work() and
> it might queue up its work item after gov_cancel_work() had
> returned (and that work item would corrupt skip_work going
> forward).  To prevent that from happening, gov_cancel_work()
> can be made wait for the timer function to complete (on all CPUs)
> right after skip_work has been incremented.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   49 ++++++++++++++++---------------------
>  drivers/cpufreq/cpufreq_governor.h |    9 +-----
>  2 files changed, 24 insertions(+), 34 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
