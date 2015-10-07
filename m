From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 0/2] crash on reading cpufreq sysfs
Date: Thu, 08 Oct 2015 00:50:33 +0200
Message-ID: <1543959.r5bbusBA6I@vostro.rjw.lan>
References: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64926 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754229AbbJGWWD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 18:22:03 -0400
In-Reply-To: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Wednesday, October 07, 2015 01:50:42 PM Srinivas Pandruvada wrote:
> Fixes for crash on reading cpufreq sysfs for offline cpus
> 
> v1
> Fix commit discription on Patch 1/2. Included Acks from Viresh.
> It has both patches, even though only one patch has change.
> 
> v0
> two patches: one for acp-cpufreq and one for cpufreq core
> 
> Srinivas Pandruvada (2):
>   cpufreq: acpi_cpufreq: prevent crash on reading freqdomain_cpus
>   cpufreq: prevent lockup on reading scaling_available_frequencies

Both applied, but they look like -stable material to me.

What kernel versions are they applicable too (and in what kernels
are they needed)?

Thanks,
Rafael

