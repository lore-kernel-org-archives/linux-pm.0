From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/12] cpufreq: governor: Relocate definitions of tuners
 structures
Date: Thu, 18 Feb 2016 11:39:16 +0530
Message-ID: <20160218060916.GP2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1878988.D1d202zxB7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32840 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbcBRGJ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 01:09:29 -0500
Received: by mail-pa0-f47.google.com with SMTP id fl4so24958067pad.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 22:09:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1878988.D1d202zxB7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
>  drivers/cpufreq/cpufreq_conservative.c |    5 +++++
>  drivers/cpufreq/cpufreq_governor.h     |   10 ----------
>  drivers/cpufreq/cpufreq_ondemand.c     |    4 ++++
>  3 files changed, 9 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
