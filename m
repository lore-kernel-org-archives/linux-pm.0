From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data
 pointer
Date: Thu, 4 Feb 2016 11:06:14 +0530
Message-ID: <20160204053614.GV3469@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1876466.AY9fn15fDn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35829 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcBDFgS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 00:36:18 -0500
Received: by mail-pf0-f172.google.com with SMTP id 65so32508481pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 21:36:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1876466.AY9fn15fDn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 04-02-16, 00:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the ondemand and conservative governors cannot use per-policy
> tunables (CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set in the cpufreq
> driver), all policy objects point to the same single dbs_data object.
> Additionally, that object is pointed to by a global pointer hidden in
> the governor's data structures.
> 
> There is no reason for that pointer to be buried in those
> data structures, though, so make it explicitly global.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -22,6 +22,9 @@
>  
>  #include "cpufreq_governor.h"
>  
> +struct dbs_data *global_dbs_data;
> +EXPORT_SYMBOL_GPL(global_dbs_data);

Oh man, please save me from Rafael's Rant :)

I think, this is simply wrong.

Believe me its very difficult for me to say this to you :). You are
way better than me, and I am sure that I haven't understood cupfreq
after so many years :)

Consider a two policy system, who is stopping us from setting ondemand
for one of them and conservative for the other one ? And so, we will
have two gdbs_data ..

Sorry for the noise, if I am being utterly stupid :(

-- 
viresh
