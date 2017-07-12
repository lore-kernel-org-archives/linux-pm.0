From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix ratio setting for min_perf_pct
Date: Wed, 12 Jul 2017 23:32:40 +0200
Message-ID: <1625006.WEackrXuKT@aspire.rjw.lan>
References: <1499729032-22038-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60067 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753300AbdGLVkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 17:40:23 -0400
In-Reply-To: <1499729032-22038-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org

On Monday, July 10, 2017 04:23:52 PM Srinivas Pandruvada wrote:
> When the minimum performance limit percentage is set to power-up default,
> it is possible that minimum performance ratio is set to one more than the
> desired.
> 
> During set_policy() callback the minimum ratio is calculated by applying
> global.min_perf_pct to the turbo_ratio and rounding up. But the power-up
> default global.min_perf_pct is already rounded up to next percent in the
> function min_perf_pct_min(). So this will result in two round up
> operations. So for the default min_perf_pct, one of the rounding up is
> not required.
> 
> It is better to remove rounding up in min_perf_pct_min() as this matches
> the displayed min_perf_pct prior to the
> commit c5a2ee7dde89 ("cpufreq: intel_pstate: Active mode P-state limits
> rework") in the kernel version 4,12. For example on a platform with
> max turbo ratio of 37 and minimum ratio of 10, the min_perf_pct resulted
> in 28 with the above commit. Before this commit it was 27 and same after
> this change.
> 
> Fixes: 1a4fe38add8b ("cpufreq: intel_pstate: Remove max/min fractions to
> limit performance")
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied, thanks!
