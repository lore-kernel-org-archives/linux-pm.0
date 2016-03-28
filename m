From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/7][Resend] cpufreq: sched: Helpers to add and remove
 update_util hooks
Date: Mon, 28 Mar 2016 11:01:26 +0530
Message-ID: <20160328053126.GG32495@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <4984400.nsZvPb32HI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35364 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbcC1Fba (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 01:31:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id td3so89808728pab.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Mar 2016 22:31:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4984400.nsZvPb32HI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 22-03-16, 02:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the single helper for adding and removing cpufreq utilization
> update hooks, cpufreq_set_update_util_data(), with a pair of helpers,
> cpufreq_add_update_util_hook() and cpufreq_remove_update_util_hook(),
> and modify the users of cpufreq_set_update_util_data() accordingly.
> 
> With the new helpers, the code using them doesn't need to worry
> about the internals of struct update_util_data and in particular
> it doesn't need to worry about populating the func field in it
> properly upfront.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
