From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: governor: Get rid of governor events
Date: Mon, 16 May 2016 10:24:52 +0530
Message-ID: <20160516045452.GO9296@vireshk-i7>
References: <10707470.yIcqGAzuFY@vostro.rjw.lan>
 <2126576.ycyxhAHC04@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35658 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcEPEy4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2016 00:54:56 -0400
Received: by mail-pf0-f172.google.com with SMTP id 77so63098828pfv.2
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2016 21:54:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2126576.ycyxhAHC04@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 14-05-16, 01:02, Rafael J. Wysocki wrote:
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> -int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event)
> -{
> -	if (event == CPUFREQ_GOV_POLICY_INIT) {
> -		return cpufreq_governor_init(policy);
> -	} else if (policy->governor_data) {

So, we aren't checking this anymore.

I am not sure (right now) if this will be a problem.

-- 
viresh
