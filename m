From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: acpi_cpufreq: base frequency attribute
 support
Date: Fri, 4 Mar 2016 10:54:14 +0530
Message-ID: <20160304052414.GD2891@vireshk-i7>
References: <1457032157-11490-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33764 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbcCDFYZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 00:24:25 -0500
Received: by mail-pa0-f42.google.com with SMTP id fl4so28339532pad.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 21:24:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457032157-11490-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On 03-03-16, 11:09, Srinivas Pandruvada wrote:
> Currently scaling_available_frequencies displays list of available
> frequencies which can be used to set max/min or current scaling frequency.
> 
> $ cat scaling_available_frequencies
> 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> 1300000 1100000 1000000 900000 800000 600000 500000
> 
> Here traditionally it is assumed that only 2301000 is a turbo frequency,
> which is purely opportunistic, anything else user can request and may
> get it.
> 
> But because of configurable thermal design power implementation in several
> Intel CPUs, the opportunistic frequency start can be any frequency in this
> range. For example it can be 2300000 or any lower value.
> This change adds an optional new attribute called "base_frequency",
> which displays the max non-turbo frequency (base frequency). For example:
> 
> $ cat base_frequency
> 2200000
> 
> This will allow user to choose a certain frequency which is not
> opportunistic.
> 
> To be fair, other than the concept, the code is essentially copied
> from responses from Rafael in mailing list.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> 
> v5
> - Rebased on the top of
> "cpufreq: acpi: Allow new dynamics attributes to be added to acpi_cpufreq_attr"
> - Remove loop for finding next empty slot in acpi_cpufreq_attr
> - Code change suggested by Rafael

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
