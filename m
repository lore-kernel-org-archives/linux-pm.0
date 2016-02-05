From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 7/10] cpufreq: governor: Drop the gov pointer from
 struct dbs_data
Date: Fri, 5 Feb 2016 13:58:45 +0530
Message-ID: <20160205082845.GJ21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <1822486.GZrV4YiqWF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33804 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcBEI2s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 03:28:48 -0500
Received: by mail-pa0-f52.google.com with SMTP id uo6so31149288pac.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2016 00:28:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1822486.GZrV4YiqWF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 05-02-16, 03:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since it is possible to obtain a pointer to struct dbs_governor
> from a pointer to the struct governor embedded in it with the help
> of container_of(), the additional gov pointer in struct dbs_data
> isn't really necessary.
> 
> Drop that pointer and make the code using it reach the dbs_governor
> object via policy->governor.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c |    2 -
>  drivers/cpufreq/cpufreq_conservative.c |    2 -
>  drivers/cpufreq/cpufreq_governor.c     |   63 +++++++++++++++------------------
>  drivers/cpufreq/cpufreq_governor.h     |    8 +++-
>  drivers/cpufreq/cpufreq_ondemand.c     |    2 -
>  5 files changed, 39 insertions(+), 38 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
