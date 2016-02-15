From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/9] cpufreq: governor: Move rate_mult to struct
 policy_dbs
Date: Mon, 15 Feb 2016 14:26:29 +0530
Message-ID: <20160215085629.GO6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <2464597.suxGYOfmRx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36047 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcBOI4h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 03:56:37 -0500
Received: by mail-pf0-f181.google.com with SMTP id e127so84344736pfe.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 00:56:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2464597.suxGYOfmRx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>

On 15-02-16, 02:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The rate_mult field in struct od_cpu_dbs_info_s is used by the code
> shared with the conservative governor and to access it that code
> has to do an ugly governor type check.  However, first of all it
> is ever only used for policy->cpu, so it is per-policy rather than
> per-CPU and second, it is initialized to 1 by cpufreq_governor_start(),
> so if the conservative governor never modifies it, it will have no
> effect on the results of any computations.
> 
> For these reasons, move rate_mult to struct policy_dbs_info (as a
> common field).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   25 +++++++++----------------
>  drivers/cpufreq/cpufreq_governor.h |    3 ++-
>  drivers/cpufreq/cpufreq_ondemand.c |   23 +++++++++++++++--------
>  3 files changed, 26 insertions(+), 25 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
