From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: governor: CPUFREQ_GOV_POLICY_EXIT never
 fails
Date: Fri, 13 May 2016 08:43:48 +0530
Message-ID: <20160513031348.GA3415@vireshk-i7>
References: <4540082.RMPf3KxPDh@vostro.rjw.lan>
 <10942818.DP54y8SPGY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33066 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbcEMDNw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 23:13:52 -0400
Received: by mail-pf0-f176.google.com with SMTP id 206so37536563pfu.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 20:13:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <10942818.DP54y8SPGY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12-05-16, 15:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> None of the cpufreq governors currently in the tree will ever fail
> an invocation of the ->governor() callback with the event argument
> equal to CPUFREQ_GOV_POLICY_EXIT (unless invoked with incorrect
> arguments which doesn't matter anyway) and it wouldn't really
> make sense to fail it, because the caller won't be able to handle
> that failure in a meaningful way.
> 
> Accordingly, rearrange the code in the core to make it clear that
> this call never fails.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
