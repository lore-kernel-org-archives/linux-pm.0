From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/10] cpufreq: governor: Avoid passing dbs_data
 pointers around unnecessarily
Date: Fri, 5 Feb 2016 12:39:17 +0530
Message-ID: <20160205070917.GF21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2409601.HbxMdSfn4m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34367 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcBEHJU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 02:09:20 -0500
Received: by mail-pa0-f43.google.com with SMTP id uo6so30062548pac.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 23:09:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2409601.HbxMdSfn4m@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 05-02-16, 03:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Do not pass struct dbs_data pointers to the family of functions
> implementing governor operations in cpufreq_governor.c as they can
> take that pointer from policy->governor by themselves.
> 
> The cpufreq_governor_init() case is slightly more complicated, since
> policy->governor may be NULL when it is invoked, but then it can reach
> the pointer in question via its cdata argument just fine.
> 
> While at it, rework cpufreq_governor_dbs() to avoid a pointless
> policy_governor check in the CPUFREQ_GOV_POLICY_INIT case.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   68 ++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 41 deletions(-)

Took some time to review, but it looks nice cleanup :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
