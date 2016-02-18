From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/12] cpufreq: governor: Add a ->start callback for
 governors
Date: Thu, 18 Feb 2016 11:06:39 +0530
Message-ID: <20160218053639.GI2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <2775883.CEf9mEMdYv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34972 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424699AbcBRFgw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 00:36:52 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so25070431pac.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 21:36:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2775883.CEf9mEMdYv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To avoid having to check the governor type explicitly in the common
> code in order to initialize data structures specific to the governor
> type properly, add a ->start callback to struct dbs_governor and
> use it to initialize those data structures for the ondemand and
> conservative governors.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    9 +++++++++
>  drivers/cpufreq/cpufreq_governor.c     |   16 ++--------------
>  drivers/cpufreq/cpufreq_governor.h     |    1 +
>  drivers/cpufreq/cpufreq_ondemand.c     |   10 ++++++++++
>  4 files changed, 22 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
