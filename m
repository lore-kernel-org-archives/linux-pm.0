From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/9] cpufreq: governor: Simplify gov_cancel_work()
 slightly
Date: Mon, 15 Feb 2016 11:10:35 +0530
Message-ID: <20160215054035.GB6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <1696919.WxyrSFSFde@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33878 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcBOFko (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 00:40:44 -0500
Received: by mail-pa0-f51.google.com with SMTP id fy10so40593304pac.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2016 21:40:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1696919.WxyrSFSFde@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>

On 15-02-16, 02:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The atomic work counter incrementation in gov_cancel_work() is not
> necessary any more, because work items won't be queued up after
> gov_clear_update_util() anyway, so drop it along with the comment
> about how it may be missed by the gov_clear_update_util().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new version of https://patchwork.kernel.org/patch/8291021/ .
> 
> Changes from the previous version:
> - Rebase.
> 
> ---
>  drivers/cpufreq/cpufreq_governor.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -300,13 +300,6 @@ static void gov_cancel_work(struct cpufr
>  {
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  
> -	/* Tell dbs_update_util_handler() to skip queuing up work items. */
> -	atomic_inc(&policy_dbs->work_count);
> -	/*
> -	 * If dbs_update_util_handler() is already running, it may not notice
> -	 * the incremented work_count, so wait for it to complete to prevent its
> -	 * work item from being queued up after the cancel_work_sync() below.
> -	 */
>  	gov_clear_update_util(policy_dbs->policy);
>  	irq_work_sync(&policy_dbs->irq_work);
>  	cancel_work_sync(&policy_dbs->work);
> @@ -369,7 +362,6 @@ static void dbs_update_util_handler(stru
>  	 * The work may not be allowed to be queued up right now.
>  	 * Possible reasons:
>  	 * - Work has already been queued up or is in progress.
> -	 * - The governor is being stopped.
>  	 * - It is too early (too little time from the previous sample).
>  	 */
>  	if (atomic_inc_return(&policy_dbs->work_count) == 1) {


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
