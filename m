From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/7] cpufreq: Do not update related_cpus on every policy
 activation
Date: Mon, 27 Jul 2015 20:26:50 +0530
Message-ID: <20150727145650.GG18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <3102455.P3lingtaHD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35595 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbG0O4y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:56:54 -0400
Received: by pdrg1 with SMTP id g1so53384700pdr.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 07:56:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3102455.P3lingtaHD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 16:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The related_cpus mask includes CPUs whose cpufreq_cpu_data per-CPU
> pointers have been set to the given policy.  Since those pointers
> are only set at the policy creation time and unset when the policy
> is deleted, the related_cpus should not be updated between those
> two operations.
> 
> For this reason, avoid updating it whenever the first of the
> "related" CPUs goes online.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
