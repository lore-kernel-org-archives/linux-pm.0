From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/12] cpufreq: governor: Drop unused governor callback
 and data fields
Date: Thu, 18 Feb 2016 11:07:41 +0530
Message-ID: <20160218053741.GJ2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <2775883.U0xits96un@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36345 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424979AbcBRFhy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 00:37:54 -0500
Received: by mail-pf0-f171.google.com with SMTP id e127so24844644pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 21:37:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2775883.U0xits96un@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After some previous changes, the ->get_cpu_dbs_info_s governor
> callback and the "governor" field in struct dbs_governor (whose
> value represents the governor type) are not used any more, so
> drop them.
> 
> Also drop the unused gov_ops field from struct dbs_governor.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    2 --
>  drivers/cpufreq/cpufreq_governor.h     |   15 +--------------
>  drivers/cpufreq/cpufreq_ondemand.c     |    3 ---
>  3 files changed, 1 insertion(+), 19 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
