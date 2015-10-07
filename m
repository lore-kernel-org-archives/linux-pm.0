From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Wed, 7 Oct 2015 22:53:43 +0530
Message-ID: <20151007172343.GE4557@linux>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36207 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbbJGRXs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 13:23:48 -0400
Received: by pablk4 with SMTP id lk4so27024346pab.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 10:23:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 01-10-15, 15:25, Srinivas Pandruvada wrote:
> Currently scaling_available_frequencies displays list of available
> frequencies which can be used to set max/min or current scaling frequency.
> 
> >cat scaling_available_frequencies
> 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> 1300000 1100000 1000000 900000 800000 600000 500000
> 
> Here traditionally it is assumed that only 2301000 is a turbo frequency,
> which is purely opportunistic, anything else user can request and may
> get it.
> But because of configurable thermal design power implementation in several
> Intel CPUs, the opportunistic frequency start can be any frequency in this
> range. For example it can be 2300000 or any lower value.
> This change adds an optional new attribute called "base_frequency",
> which displays the max non-turbo frequency (base frequency). For example:
> >cat base_frequency
> 2200000
> This will allow user to choose a certain frequency which is not
> opportunistic.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Look for scaling_boost_frequencies_show() and see if you can reuse it.

-- 
viresh
