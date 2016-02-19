From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 12/12] cpufreq: governor: Narrow down the
 dbs_data_mutex coverage
Date: Fri, 19 Feb 2016 08:08:14 +0530
Message-ID: <20160219023814.GD16983@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <8616971.q0P8tF6lFz@vostro.rjw.lan>
 <20160218062040.GR2610@vireshk-i7>
 <2559441.qfMQ0Nj7fb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34007 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947901AbcBSCi2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 21:38:28 -0500
Received: by mail-pa0-f49.google.com with SMTP id fy10so41683854pac.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 18:38:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2559441.qfMQ0Nj7fb@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 18:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: governor: Narrow down the dbs_data_mutex coverage
> 
> Since cpufreq_governor_dbs() is now always called with policy->rwsem
> held, it cannot be executed twice in parallel for the same policy.
> Thus it is not necessary to hold dbs_data_mutex around the invocations
> of cpufreq_governor_start/stop/limits() from it as those functions
> never modify any data that can be shared between different policies.
> 
> However, cpufreq_governor_dbs() may be executed twice in parallal
> for different policies using the same gov->gdbs_data object and
> dbs_data_mutex is still necessary to protect that object against
> concurrent updates.
> 
> For this reason, narrow down the dbs_data_mutex locking to
> cpufreq_governor_init/exit() where it is needed and rename the
> mutex to gov_dbs_data_mutex to reflect its purpose.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   46 ++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
