From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: prevent lockup on reading
 scaling_available_frequencies
Date: Wed, 7 Oct 2015 22:33:04 +0530
Message-ID: <20151007170304.GD4557@linux>
References: <1443738182-4077-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1443738182-4077-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20151007124508.GG902@linux>
 <1444234737.3514.17.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34537 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbbJGRDJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 13:03:09 -0400
Received: by padhy16 with SMTP id hy16so26622944pad.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 10:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444234737.3514.17.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 07-10-15, 09:18, Srinivas Pandruvada wrote:
> freq_table is allocated in init() callbacks and freed on exit()
> callback. But I don't see any driver changing policy->freq_table to NULL
> or setting value to policy->freq_table to their allocated freq_table .
 
That's what I am asking for.

> I see policy->freq_table is only assigned value in function
> cpufreq_table_validate_and_show, as part of the core API.

Its just an helper written to reduce code redundancy..

> So I think we
> should set to NULL after clients freed the freq_table as part of core
> function.

Not really. If we want to do the opposite, then we should initiate
policy->freq_table = NULL, right from exit(), as its done as part of
init() first.

> Otherwise we need to modify every client cpufreq driver and assign
> policy->freq_table=NULL on .exit().  Since they don't assign value to
> this policy->freq_table in first place, they shouldn't change this.

They did set it in the first place, with help of a helper routine
though.

But I do understand the code redundancy we are about to create. So,
maybe we can do this in the core as a special case.

But then you missed another location where exit() was called.

> Also I don't know why we need to keep the sysfs entry cpufreq after
> offline. There are other values, which we can read without crash, but
> may not be valid. We may delete this sysfs entry. But may be some
> cpufreq driver cares about this even after offline. If we can delete
> this entry, it can be part of cleanup of cpufreq subsystem.

Go thought the mail threads where that support is added, it was indeed
useful.

-- 
viresh
