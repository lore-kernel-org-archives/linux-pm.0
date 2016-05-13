From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: governor: CPUFREQ_GOV_STOP never fails
Date: Fri, 13 May 2016 08:44:16 +0530
Message-ID: <20160513031416.GB3415@vireshk-i7>
References: <4540082.RMPf3KxPDh@vostro.rjw.lan>
 <2034165.RqMO62khMb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33564 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbcEMDOT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 23:14:19 -0400
Received: by mail-pa0-f45.google.com with SMTP id xk12so36116276pac.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 20:14:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2034165.RqMO62khMb@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12-05-16, 15:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> None of the cpufreq governors currently in the tree will ever fail
> an invocation of the ->governor() callback with the event argument
> equal to CPUFREQ_GOV_STOP (unless invoked with incorrect arguments
> which doesn't matter anyway) and it is rather difficult to imagine
> a valid reason for such a failure.
> 
> Accordingly, rearrange the code in the core to make it clear that
> this call never fails.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   40 +++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 29 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
