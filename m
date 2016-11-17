From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC][PATCH] cpufreq: intel_pstate: Support of energy
 performance hint using HWP
Date: Thu, 17 Nov 2016 12:19:54 +0530
Message-ID: <20161117064954.GD4894@vireshk-i7>
References: <1479250783-74336-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1479250783-74336-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34179 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940520AbcKQGt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 01:49:58 -0500
Received: by mail-pg0-f51.google.com with SMTP id x23so85632584pgx.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2016 22:49:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1479250783-74336-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, morten.rasmussen@arm.com, Juri.Lelli@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Srinivas,

I don't think other platforms need it for now and so it is fine to
add these to the driver itself.

On 15-11-16, 14:59, Srinivas Pandruvada wrote:
> +static ssize_t show_energy_performance_available_preferences(

Maybe a personal preference, but I would have broken the line after
ssize_t instead of where you have done it.

> +				struct cpufreq_policy *policy, char *buf)
> +{
> +static struct freq_attr *hwp_cpufreq_attrs[] = {
> +	&energy_performance_preference,
> +	&energy_performance_available_preferences,
> +	NULL,
> +};

What about adding these to intel_pstate_attr_group instead ?

-- 
viresh
