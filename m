From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH V2 00/14] cpufreq: stats: cleanups
Date: Fri, 02 Jan 2015 08:08:14 -0500
Message-ID: <54A6983E.9090102@redhat.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37308 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbbABNI2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Jan 2015 08:08:28 -0500
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org



On 01/02/2015 12:46 AM, Viresh Kumar wrote:
> This is a resend of cpufreq stats cleanups I had for sometime. Few issues were
> reported from Fenguang's bot and are all fixed now and are stable..
> 
> V1->V2:
> - Reviewed-by Prarit
> - Replaced lock with mutex as we may sleep from within critical region and so a
>   new patch "cpufreq: stats: replace spinlock with mutex".
> 

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.

> Pushed here:
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/stats/cleanups
> 
> Viresh Kumar (14):
>   cpufreq: stats: don't break strings into multiple lines
>   cpufreq: stats: return -EEXIST when stats are already allocated
>   cpufreq: stats: don't check for freq table while freeing stats
>   cpufreq: stats: pass 'stat' to cpufreq_stats_update()
>   cpufreq: stats: get rid of per-cpu cpufreq_stats_table
>   cpufreq: Remove (now) unused 'last_cpu' from struct cpufreq_policy
>   cpufreq: stats: remove cpufreq_stats_update_policy_cpu()
>   cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
>   cpufreq: stats: create sysfs group once we are ready
>   cpufreq: stats: don't update stats from show_trans_table()
>   cpufreq: stats: don't update stats on false notifiers
>   cpufreq: stats: replace spinlock with mutex
>   cpufreq: stats: Fix locking
>   cpufreq: stats: call cpufreq_stats_update() with locks held
> 
>  drivers/cpufreq/cpufreq.c       |   6 --
>  drivers/cpufreq/cpufreq_stats.c | 148 ++++++++++++++++++----------------------
>  include/linux/cpufreq.h         |  10 +--
>  3 files changed, 73 insertions(+), 91 deletions(-)
> 
