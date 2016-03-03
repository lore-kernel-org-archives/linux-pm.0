From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] cpufreq: governor: New data type for management part
 of dbs_data
Date: Thu, 3 Mar 2016 11:23:59 +0530
Message-ID: <20160303055359.GI2891@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <3567040.O8oI5B24Ng@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34164 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbcCCFyR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 00:54:17 -0500
Received: by mail-pf0-f182.google.com with SMTP id 4so8542678pfd.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 21:54:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3567040.O8oI5B24Ng@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On 02-03-16, 03:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In addition to fields representing governor tunables, struct dbs_data
> contains some fields needed for the management of objects of that
> type.  As it turns out, that part of struct dbs_data may be shared
> with (future) governors that won't use the common code used by
> "ondemand" and "conservative", so move it to a separate struct type
> and modify the code using struct dbs_data to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |   15 +++--
>  drivers/cpufreq/cpufreq_governor.c     |   90 ++++++++++++++++++++-------------
>  drivers/cpufreq/cpufreq_governor.h     |   36 +++++++------
>  drivers/cpufreq/cpufreq_ondemand.c     |   19 ++++--
>  4 files changed, 97 insertions(+), 63 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -41,6 +41,13 @@
>  /* Ondemand Sampling types */
>  enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
>  
> +struct gov_tunables {
> +	struct kobject kobj;
> +	struct list_head policy_list;
> +	struct mutex update_lock;
> +	int usage_count;
> +};

Everything else looks fine, but I don't think that you have named it
properly. Every thing else present in struct dbs_data are tunables,
but not this. And so gov_tunables doesn't suit at all here..

-- 
viresh
