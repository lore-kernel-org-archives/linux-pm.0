From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/11] cpufreq: Clean up default and fallback governor
 setup
Date: Thu, 4 Feb 2016 10:33:07 +0530
Message-ID: <20160204050307.GT3469@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <8241294.RLKfcoktTC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33961 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcBDFDK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 00:03:10 -0500
Received: by mail-pf0-f179.google.com with SMTP id o185so31514843pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 21:03:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8241294.RLKfcoktTC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 04-02-16, 00:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The preprocessor magic used for setting the default cpufreq governor
> (and for using the performance governor as a fallback one for that
> matter) is really nasty, so replace it with __weak functions and
> overrides.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c              |   37 ++++++++++++++++++---------------
>  drivers/cpufreq/cpufreq_conservative.c |   10 +++++---
>  drivers/cpufreq/cpufreq_ondemand.c     |   34 ++++++++++++++++--------------
>  drivers/cpufreq/cpufreq_performance.c  |   18 ++++++++++++----
>  drivers/cpufreq/cpufreq_powersave.c    |   10 +++++---
>  drivers/cpufreq/cpufreq_userspace.c    |   10 +++++---
>  include/linux/cpufreq.h                |   25 +---------------------
>  7 files changed, 73 insertions(+), 71 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
