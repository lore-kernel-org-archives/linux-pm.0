From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 0/2] crash on reading cpufreq sysfs
Date: Wed, 07 Oct 2015 16:50:00 -0700
Message-ID: <1444261800.7437.7.camel@spandruv-desk3.jf.intel.com>
References: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1543959.r5bbusBA6I@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55591 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbJGXwQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 19:52:16 -0400
In-Reply-To: <1543959.r5bbusBA6I@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Thu, 2015-10-08 at 00:50 +0200, Rafael J. Wysocki wrote:
> On Wednesday, October 07, 2015 01:50:42 PM Srinivas Pandruvada wrote:
> > Fixes for crash on reading cpufreq sysfs for offline cpus
> > 
> > v1
> > Fix commit discription on Patch 1/2. Included Acks from Viresh.
> > It has both patches, even though only one patch has change.
> > 
> > v0
> > two patches: one for acp-cpufreq and one for cpufreq core
> > 
> > Srinivas Pandruvada (2):
> >   cpufreq: acpi_cpufreq: prevent crash on reading freqdomain_cpus
> >   cpufreq: prevent lockup on reading scaling_available_frequencies
> 
> Both applied, but they look like -stable material to me.
> 
I tested in 4.1 kernels, since on offline, cpufreq folder is not
available there is no issue.
For 4.2 kernels the I didn't see crash fixed by cpufreq core patch (cat
scaling_available_frequencies), but the "cat freqdomain_cpus" still
causes crash. So we need to apply cpufreq:acpi-cpufreq patch only. So
one patch is applicable for stable tree.

Thanks,
Srinivas


> What kernel versions are they applicable too (and in what kernels
> are they needed)?
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


