From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 1/3] cpufreq: Add new attribute "base_frequency"
Date: Mon, 7 Sep 2015 11:36:48 +0530
Message-ID: <20150907060648.GE26760@linux>
References: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36088 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbIGGG6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 02:06:58 -0400
Received: by padhk3 with SMTP id hk3so1867798pad.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2015 23:06:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 04-09-15, 10:19, Srinivas Pandruvada wrote:
> Currently scaling_available_frequencies displays list of available
> frequencies which can be used to set max/min or current scaling
> frequency. But because of configurable thermal design power implementation
> in several Intel CPUs, this is not a guaranteed frequency or a P state,
> which user can request. After a limit all frequencies (P states) may be
> purely in opportunistic performance range. For example
> 
> >cat scaling_available_frequencies
> 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> 1300000 1100000 1000000 900000 800000 600000 500000
> 
> Here traditionally it is assumed that only 2301000 is a turbo frequency,
> anything else user can request. But that is not true. Based on the
> config TDP level, this turbo (boost) start can be much below. For
> example it can be 2300000 or any other value.
> 
> This change adds an optional new attribute called "base_frequency",
> which displays the max non-turbo frequency (base frequency). For example:
> >cat base_frequency
> 2200000

This is something very much acpi-cpufreq driver's specific and I don't
really see other platform needing it. So, I would rather add this only
for acpi-cpufreq driver, if at all it is required.

-- 
viresh
