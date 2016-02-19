From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 10/12] cpufreq: governor: Relocate definitions of
 tuners structures
Date: Fri, 19 Feb 2016 08:06:53 +0530
Message-ID: <20160219023653.GC16983@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1878988.D1d202zxB7@vostro.rjw.lan>
 <20160218060916.GP2610@vireshk-i7>
 <2038639.HMBFOxnpuP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36855 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948422AbcBSChI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 21:37:08 -0500
Received: by mail-pf0-f172.google.com with SMTP id e127so42435053pfe.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 18:37:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2038639.HMBFOxnpuP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 18:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: governor: Relocate definitions of tuners structures
> 
> Move the definitions of struct od_dbs_tuners and struct cs_dbs_tuners
> from the common governor header to the ondemand and conservative
> governor code, respectively, as they don't need to be in the common
> header any more.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This had to be update because of the update of [8/12] it depends on.
> 
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    5 +++++
>  drivers/cpufreq/cpufreq_governor.h     |   10 ----------
>  drivers/cpufreq/cpufreq_ondemand.h     |    4 ++++
>  3 files changed, 9 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
