From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/7] cpufreq: Pass CPU number to cpufreq_policy_alloc()
Date: Mon, 27 Jul 2015 20:28:14 +0530
Message-ID: <20150727145814.GH18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1673228.0qyRKCRMJQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33787 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbG0O6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:58:19 -0400
Received: by padck2 with SMTP id ck2so52877663pad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 07:58:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1673228.0qyRKCRMJQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 16:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Change cpufreq_policy_alloc() to take a CPU number instead of a CPU
> device pointer as its argument, as it is the only function called by
> cpufreq_add_dev() taking a device pointer argument at this point.
> 
> That will allow us to split the CPU online part from cpufreq_add_dev()
> more cleanly going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
