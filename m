From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Change confusing struct field and
 variable names
Date: Thu, 28 Apr 2016 07:46:31 +0530
Message-ID: <20160428021631.GU4225@vireshk-i7>
References: <2024653.a0XKPA0FXA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34815 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbcD1CQg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 22:16:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id y69so27571679pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 19:16:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2024653.a0XKPA0FXA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>

On 28-04-16, 01:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The name of the prev_cpu_wall field in struct cpu_dbs_info is
> confusing, because it doesn't represent wall time, but the previous
> update time as returned by get_cpu_idle_time() (that may be the
> current value of jiffies_64 in some cases, for example).
> 
> Moreover, the names of some related variables in dbs_update() take
> that confusion further.
> 
> Rename all of those things to make their names reflect the purpose
> more accurately.  While at it, drop unnecessary parens from one of
> the updated expressions.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   22 +++++++++++-----------
>  drivers/cpufreq/cpufreq_governor.h |    2 +-
>  2 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
