From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] acpi-cpufreq: introduce base_frequency
Date: Tue, 1 Mar 2016 08:03:24 +0530
Message-ID: <20160301023324.GB16437@vireshk-i7>
References: <1456791009-950-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34399 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcCACd2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 21:33:28 -0500
Received: by mail-pa0-f41.google.com with SMTP id fy10so102575052pac.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 18:33:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456791009-950-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On 29-02-16, 16:10, Srinivas Pandruvada wrote:
> This patchset introduces base_frequency attribute to cpufreq sysfs
> only for acpi-cpufreq.
> 
> No change but sending code and document patch together.

Perhaps Rafael asked you to fold it into the first patch, which meant that we
should have had a single patch for both of these things.

But its still okay, as these are part of the same set at least.

But, you again failed to convey version information, etc.

> Srinivas Pandruvada (2):
>   cpufreq: acpi_cpufreq: base frequency attribute support
>   Documentation: cpufreq: Additional interface for acpi-cpufreq
> 
>  Documentation/cpu-freq/acpi-cpufreq-addition.txt | 20 +++++++++++++
>  drivers/cpufreq/acpi-cpufreq.c                   | 36 ++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/cpu-freq/acpi-cpufreq-addition.txt
> 
> -- 
> 2.5.0

-- 
viresh
