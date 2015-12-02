From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: use last policy after online
Date: Wed, 2 Dec 2015 08:23:32 +0530
Message-ID: <20151202025332.GH4459@ubuntu>
References: <1449017534-6127-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33767 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbbLBCxg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 21:53:36 -0500
Received: by pabfh17 with SMTP id fh17so26035354pab.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2015 18:53:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449017534-6127-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 01-12-15, 16:52, Srinivas Pandruvada wrote:
> For cpufreq drivers which use setpolicy interface, after offline->online
> the policy is set to default. This can be reproduced by setting the
> default policy of intel_pstate or longrun to ondemand and then change to
> "performance". After offline and online, the setpolicy will be called with
> the policy=ondemand.
> For drivers using governors this condition is handled by storing
> last_governor, during offline and restoring during online. The same should
> be done for drivers using setpolicy interface. Storing last_policy during
> offline and restoring during online.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 14 ++++++++++----
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)

Okay, the problem looks real. But I think it should be solved a bit
differently.

Try partly reverting the below commit, so that we can use user_policy
instead.

88dc43849587 ("cpufreq: remove redundant 'policy' field from
user_policy")

-- 
viresh
