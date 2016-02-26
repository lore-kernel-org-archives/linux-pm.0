From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Simplify the cpufreq_for_each_valid_entry()
Date: Fri, 26 Feb 2016 08:02:24 +0530
Message-ID: <20160226023224.GD2639@vireshk-i7>
References: <1966438.kvLUD13Eaz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35981 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBZCcZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 21:32:25 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so42476675pab.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Feb 2016 18:32:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1966438.kvLUD13Eaz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26-02-16, 00:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> That macro uses an internal static inline function that is first
> totally unnecessary and second hard to read, so simplify it and
> get rid of that monster.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/cpufreq.h |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -534,16 +534,6 @@ static inline void dev_pm_opp_free_cpufr
>  }
>  #endif
>  
> -static inline bool cpufreq_next_valid(struct cpufreq_frequency_table **pos)
> -{
> -	while ((*pos)->frequency != CPUFREQ_TABLE_END)
> -		if ((*pos)->frequency != CPUFREQ_ENTRY_INVALID)
> -			return true;
> -		else
> -			(*pos)++;
> -	return false;
> -}
> -
>  /*
>   * cpufreq_for_each_entry -	iterate over a cpufreq_frequency_table
>   * @pos:	the cpufreq_frequency_table * to use as a loop cursor.
> @@ -560,8 +550,11 @@ static inline bool cpufreq_next_valid(st
>   * @table:      the cpufreq_frequency_table * to iterate over.
>   */
>  
> -#define cpufreq_for_each_valid_entry(pos, table)	\
> -	for (pos = table; cpufreq_next_valid(&pos); pos++)
> +#define cpufreq_for_each_valid_entry(pos, table)			\
> +	for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)	\
> +		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
> +			continue;					\
> +		else
>  
>  int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>  				    struct cpufreq_frequency_table *table);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
