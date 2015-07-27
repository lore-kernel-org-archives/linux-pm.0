From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/7] cpufreq: Drop unused dev argument from two functions
Date: Mon, 27 Jul 2015 20:23:38 +0530
Message-ID: <20150727145338.GF18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1650994.NqTPmayJcx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34182 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbbG0Oxn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:53:43 -0400
Received: by pacan13 with SMTP id an13so53829869pac.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 07:53:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1650994.NqTPmayJcx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 16:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The dev argument of cpufreq_add_policy_cpu() and
> cpufreq_add_dev_interface() is not used by any of them,
> so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
