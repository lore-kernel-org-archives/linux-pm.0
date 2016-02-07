From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3 v4] cpufreq: governor: Replace timers with
 utilization update callbacks
Date: Sun, 7 Feb 2016 14:50:19 +0530
Message-ID: <20160207092019.GB6112@vireshk>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2546395.Be1INkvQBN@vostro.rjw.lan>
 <1486401.1RcnnVKZNP@vostro.rjw.lan>
 <2848076.UWJmIl2O1K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36012 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbcBGJUW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 04:20:22 -0500
Received: by mail-pf0-f182.google.com with SMTP id n128so92862387pfn.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 01:20:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2848076.UWJmIl2O1K@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 06-02-16, 04:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using a per-CPU deferrable timer for queuing up governor
> work items, register a utilization update callback that will be
> invoked from the scheduler on utilization changes.
> 
> The sampling rate is still the same as what was used for the
> deferrable timers and the added irq_work overhead should be offset by
> the eliminated timers overhead, so in theory the functional impact of
> this patch should not be significant.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Updated after the recent discussion with Viresh.
> 
> Changes from v3:
> - The completion used for irq_work synchronization replaced with irq_work_sync()
>   in gov_cancel_work().
> - update_sampling_rate() now modifies shared->sample_delay_ns for all CPUs
>   where it matters directly with a big fat comment explaining why this is
>   actually OK.
> - The above means the time_stamp field in struct cpu_common_dbs_info is not
>   necessary any more, so it is dropped.
> - A build error for !CONFIG_SMP is addressed (hopefully effectively).
> 
> This version was lightly tested on an x86 laptop.

Awesome work Rafael, this looks really good now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
